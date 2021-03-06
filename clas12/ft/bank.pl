use strict;
use warnings;

our %configuration;

# Variable Type is two chars.
# The first char:
#  R for raw integrated variables
#  D for dgt integrated variables
#  S for raw step by step variables
#  M for digitized multi-hit variables
#  V for voltage(time) variables
#
# The second char:
# i for integers
# d for doubles

# The ft banks id are:
#
# Tracker (trk):
# Tracker (hodo):
# Tracker (cal):

sub define_trk_bank
{
	# uploading the hit definition
	my $bankId   = 700;
	my $bankname = "ftm";
	
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
    insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "layer",        2, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "strip",        3, "Di", "strip number");
	insert_bank_variable(\%configuration, $bankname, "adc",          4, "Di", "adc");
	insert_bank_variable(\%configuration, $bankname, "tdc",          5, "Di", "tdc");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}

sub define_hodo_bank
{
	# uploading the hit definition
	my $bankId = 800;
	my $bankname = "ft_hodo";
	
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "layer",        2, "Di", "layer number");
    insert_bank_variable(\%configuration, $bankname, "component",    3, "Di", "component number");
	insert_bank_variable(\%configuration, $bankname, "adc",          4, "Di", "adc");
	insert_bank_variable(\%configuration, $bankname, "tdc",          5, "Di", "tdc");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}


sub define_cal_bank
{
	# uploading the hit definition
	my $bankId = 900;
	my $bankname = "ft_cal";
	
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "layer",        2, "Di", "layer number");
    insert_bank_variable(\%configuration, $bankname, "component",    3, "Di", "component number");
	insert_bank_variable(\%configuration, $bankname, "adc",          4, "Di", "adc");
	insert_bank_variable(\%configuration, $bankname, "tdc",          5, "Di", "tdc");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}


sub define_banks
{
	define_trk_bank();
	define_hodo_bank();
	define_cal_bank();
}

1;










