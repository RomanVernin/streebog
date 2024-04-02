streebog_PATH = $(PWD)/src
INCDIR += $(INCDIR_PREFIX) $(streebog_PATH)


streebog_FILES  += $(streebog_PATH)/streebog_top.sv
streebog_FILES  += $(streebog_PATH)/sub_bytes.sv
streebog_FILES  += $(streebog_PATH)/sbox.sv
streebog_FILES  += $(streebog_PATH)/p_permutation.sv
streebog_FILES  += $(streebog_PATH)/l_transformation.sv
streebog_FILES  += $(streebog_PATH)/lpsx_precalc.sv
streebog_FILES  += $(streebog_PATH)/lpsx.sv
streebog_FILES  += $(streebog_PATH)/g_function.sv
streebog_FILES  += $(streebog_PATH)/sc.sv
