our %configuration;
our %parameters;

our $startS;
our $endS;
our $startN;
our $endN;

# number of mirrors
my $nmirrors = $parameters{"nmirrors"} ;

# All dimensions in cm

# PMTS parameters
# PMTs are tubes
my @x0   = ();
my @y0   = ();
my @rad  = (); # radius
my @tilt = (); # Tilt angle of the PMT in the segment ref. system
my @len  = (); # length of PMT tube

my @segtheta  = ();


sub calculatePMTPars
{
	for(my $n=0; $n<$nmirrors ; $n++)
	{
		my $s = $n + 1;
		
		$x0[$n]   = $parameters{"ltcc.pmt.s$s"."_pmt0x"};
		$y0[$n]   = $parameters{"ltcc.pmt.s$s"."_pmt0y"};
		$rad[$n]  = $parameters{"ltcc.pmt.s$s"."_radius"};
		$tilt[$n] = $parameters{"ltcc.wc.s$s"."_angle"};
		
		# 90 - theta of center of ltcc. segment
		$segtheta[$n] = 90 - $parameters{"ltcc.s$s"."_theta"};
		
		$len[$n] = 1;  # Harcoding length here
	}
}

sub build_pmts
{
	for(my $n=$startN; $n<$endN; $n++)
	{
		for(my $s=$startS; $s<=$endS; $s++)
		{
			my %detector = init_det();
			$detector{"name"}        = "pmt_s$s"."right_$n";
			$detector{"mother"}      = "segment_pmt_s$s"."$n";
			#$detector{"mother"}      = "root";
			$detector{"description"} = "PMT right $n";
			$detector{"pos"}         = "$x0[$n-1]*cm $y0[$n-1]*cm 0*mm";
			$detector{"rotation"}    = "90*deg -$tilt[$n-1]*deg 0*deg";
			$detector{"color"}       = "992200";
			$detector{"type"}        = "Tube";
			$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm $len[$n-1]*cm 0*deg 360*deg";
			$detector{"material"}    = "LTCCPMTGlass";
			$detector{"style"}       = 1;
			$detector{"sensitivity"} = "ltcc";
			$detector{"hit_type"}    = "ltcc";
			$detector{"identifiers"} = "sector manual 1 side manual 1 segment manual $n";
			print_det(\%configuration, \%detector);
			
			%detector = init_det();
			$detector{"name"}        = "pmt_s$s"."left_$n";
			$detector{"mother"}      = "segment_pmt_s$s"."$n";
			#$detector{"mother"}      = "root";
			$detector{"description"} = "PMT right $n";
			$detector{"pos"}         = "-$x0[$n-1]*cm $y0[$n-1]*cm 0*mm";
			$detector{"rotation"}    = "90*deg $tilt[$n-1]*deg 0*deg";
			$detector{"color"}       = "992200";
			$detector{"type"}        = "Tube";
			$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm $len[$n-1]*cm 0*deg 360*deg";
			$detector{"material"}    = "LTCCPMTGlass";
			$detector{"style"}       = 1;
			$detector{"sensitivity"} = "ltcc";
			$detector{"hit_type"}    = "ltcc";
			$detector{"identifiers"} = "sector manual 1 side manual 2 segment manual $n";
			print_det(\%configuration, \%detector);
		}
		
		# Building the box that contains the pmts (left and right)
		# Starts 1mm above x11
		my $segment_box_length    = $x0[$n-1]  + $rad[$n-1] + 2;
		my $segment_box_thickness = 2*$rad[$n-1] + 2;
		my $segment_box_height    = $y0[$n-1]  + $rad[$n-1] + 2;
		%detector = init_det();
		$detector{"name"}        = "segment_pmt_box_$n";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Light Threshold Cerenkov Counter Segment Box $n";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$segment_box_length*cm $segment_box_height*cm $segment_box_thickness*cm";
		$detector{"material"}    = "Component";
		print_det(\%configuration, \%detector);
  
  
		#  # Box to subract from  segment box
		#  # Starts 1mm below
		my $s_segment_box_length    = $segment_box_length    + 0.2;
		my $s_segment_box_thickness = $segment_box_thickness + 0.2;
		my $s_segment_box_height    = $segment_box_height   ;
		my $yshift = $segment_box_thickness;      # Should be enough to encompass all mirrrors
		
		my %detector = init_det();
		$detector{"name"}        = "segment_pmt_subtract_box_$n";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Light Threshold Cerenkov Counter Segment Box to Subtract $n";
		$detector{"pos"}         = "0*cm -$yshift*cm 0*mm";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$s_segment_box_length*cm $s_segment_box_height*cm $s_segment_box_thickness*cm";
		$detector{"material"}    = "Component";
		print_det(\%configuration, \%detector);
		
		for(my $s=$startS; $s<=$endS; $s++)
		{
			my %detector = init_det();
			$detector{"name"}        = "segment_pmt_s$s"."$n";
			$detector{"mother"}      = "ltccS$s";
			$detector{"description"} = "Light Threshold Cerenkov Counter PMT segment $n";
			#$detector{"mother"}      = "root";
			#$detector{"rotation"}    = "0*deg 0*deg 0*deg";
			$detector{"rotation"}    = "-$segtheta[$n-1]*deg 0*deg 0*deg";
			$detector{"color"}       = "00ff11";
			$detector{"type"}        = "Operation: segment_pmt_box_$n - segment_pmt_subtract_box_$n";
			$detector{"dimensions"}  = "0";
			$detector{"material"}    = "C4F10";
			$detector{"visible"}     = 0;
			print_det(\%configuration, \%detector);
		}
	}
}






sub buildPmts
{
	calculatePMTPars();
	build_pmts();
}



1;












