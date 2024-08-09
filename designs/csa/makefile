PROJ_NAME ?=decrypt
DEBUG ?=y

ifeq ($(DEBUG),y)
VFLAGS=-DDEBUG
else
VFLAGS=
endif

all:$(PROJ_NAME)

key_perm:
	iverilog -S $(VFLAGS) -tnull $@.v

key_schedule:
	iverilog -S $(VFLAGS) -tnull $@.v key_perm.v

block_decypher:
	iverilog -S $(VFLAGS) -tnull $@.v block_perm.v block_sbox.v

stream_cypher:
	iverilog -S $(VFLAGS) -tnull $@.v sbox1.v sbox2.v sbox3.v sbox4.v sbox5.v sbox6.v sbox7.v sboxes.v stream_iteration.v stream_byte.v stream_8bytes.v

decrypt:
	iverilog -S $(VFLAGS) -tnull $@.v  key_schedule.v key_perm.v stream_cypher.v block_decypher.v block_perm.v block_sbox.v sbox1.v sbox2.v sbox3.v sbox4.v sbox5.v sbox6.v sbox7.v sboxes.v stream_iteration.v stream_byte.v stream_8bytes.v

clean:
 	
