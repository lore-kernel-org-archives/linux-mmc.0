Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2C12AAFD
	for <linux-mmc@vger.kernel.org>; Sat,  6 Jul 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720286128; cv=none; b=u8R3oHD2pu9HYOKV+olyTBbf6LD9qQTOnqf6B3ZGXh0gjnd2I7m8ecclZQIIXWlIA+cAFcJoGp5NJg6K+7qvLEzzZEEV1bNqMG2X3rJ5/7sIipdkHvjV1zFYihGhBaIkYo6jgEXliCd/bY4sSU0p7KyAPopcu4GEE5j+BpSxNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720286128; c=relaxed/simple;
	bh=WTWTZO4ytugpj2xtRGk/LAH113KuSse4PcL+wRaKOlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BfG3s69TxVojyns8Zr4UmCDPe+MctYvOia3CZ1aHT3rdDgfPDQHQpHeD9u/H6IJGF0tiMJY9Tt4t86N+krrroWhgKfnc681wM1DORs4TRRvG12Tbi1nClQtewRlRd/BkhnsMxjYt4iMMCKlyzWMEFF76iaVszU/Kr9vt+3so7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WidDsEYY; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WidDsEYY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720286126; x=1751822126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WTWTZO4ytugpj2xtRGk/LAH113KuSse4PcL+wRaKOlw=;
  b=WidDsEYYNvxUx7fJGmUMw8iyDKSeUMDe6RgdpzEOdWw2Y63/6VD4r/Zb
   rnOpuWk7ZZSAQ+VR/gJivI5XSCzkbcdmmJ02I0Q19z82OD2iFhJrstM2G
   evdNFlP1jl+vtL4uu+KT8Yi4ZMwDIdoZVucfd8KfQuHuk9p9qxPeyxJTe
   zVcZNtgWC6sczY11/wS4SI1O77c6nzesW+Z5Aem6+Z//9dZ6hsOCOkqyz
   xRbhdGL1y4xeV5TvfQszBM4vOBsU8bxeswZQrDZzPTMswlD6H4XaWhx/y
   L8UYdfkq50lzBvKTOWkX29l8AXaj4DGmyTVeJ63I8tBImbw/sEdNbIOxf
   A==;
X-CSE-ConnectionGUID: K5ztgBnhSJqZ7vxt2+UbXQ==
X-CSE-MsgGUID: o1Gy9XH7Q8qGik8yPKE5GQ==
X-IronPort-AV: E=Sophos;i="6.09,187,1716220800"; 
   d="scan'208";a="20242900"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2024 01:15:19 +0800
IronPort-SDR: 66896f28_ci6q9w6pFmQq2GsHdhD8vjmfyGDIfTYAZ+gsCCkThWQoqkd
 1ERbApJZtFxdsmpKSOn/2FfYoRHIsSWsFbDLmhQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2024 09:22:00 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2024 10:15:17 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc-utils: Make functions static for local scope enforcement
Date: Sat,  6 Jul 2024 20:14:12 +0300
Message-Id: <20240706171412.1613019-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run Sparse and fix its warnings.  Apparently, running make C=1 is rarely
done, so make running sparse default.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 3rdparty/hmac_sha/sha2.c |  18 ++---
 Makefile                 |   5 +-
 lsmmc.c                  | 146 ++++-----------------------------------
 mmc.c                    |  18 ++---
 mmc_cmds.c               |  28 ++++----
 5 files changed, 49 insertions(+), 166 deletions(-)

diff --git a/3rdparty/hmac_sha/sha2.c b/3rdparty/hmac_sha/sha2.c
index 337b414..9fcafb7 100644
--- a/3rdparty/hmac_sha/sha2.c
+++ b/3rdparty/hmac_sha/sha2.c
@@ -131,27 +131,27 @@
     wv[h] = t1 + t2;                                        \
 }
 
-uint32 sha224_h0[8] =
+static uint32 sha224_h0[8] =
             {0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
              0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4};
 
-uint32 sha256_h0[8] =
+static uint32 sha256_h0[8] =
             {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
              0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
 
-uint64 sha384_h0[8] =
+static uint64 sha384_h0[8] =
             {0xcbbb9d5dc1059ed8ULL, 0x629a292a367cd507ULL,
              0x9159015a3070dd17ULL, 0x152fecd8f70e5939ULL,
              0x67332667ffc00b31ULL, 0x8eb44a8768581511ULL,
              0xdb0c2e0d64f98fa7ULL, 0x47b5481dbefa4fa4ULL};
 
-uint64 sha512_h0[8] =
+static uint64 sha512_h0[8] =
             {0x6a09e667f3bcc908ULL, 0xbb67ae8584caa73bULL,
              0x3c6ef372fe94f82bULL, 0xa54ff53a5f1d36f1ULL,
              0x510e527fade682d1ULL, 0x9b05688c2b3e6c1fULL,
              0x1f83d9abfb41bd6bULL, 0x5be0cd19137e2179ULL};
 
-uint32 sha256_k[64] =
+static uint32 sha256_k[64] =
             {0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
              0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
              0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
@@ -169,7 +169,7 @@ uint32 sha256_k[64] =
              0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
              0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};
 
-uint64 sha512_k[80] =
+static uint64 sha512_k[80] =
             {0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL,
              0xb5c0fbcfec4d3b2fULL, 0xe9b5dba58189dbbcULL,
              0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
@@ -213,7 +213,7 @@ uint64 sha512_k[80] =
 
 /* SHA-256 functions */
 
-void sha256_transf(sha256_ctx *ctx, const unsigned char *message,
+static void sha256_transf(sha256_ctx *ctx, const unsigned char *message,
                    unsigned int block_nb)
 {
     uint32 w[64];
@@ -429,8 +429,8 @@ void sha256_final(sha256_ctx *ctx, unsigned char *digest)
 
 /* SHA-512 functions */
 
-void sha512_transf(sha512_ctx *ctx, const unsigned char *message,
-                   unsigned int block_nb)
+static void sha512_transf(sha512_ctx *ctx, const unsigned char *message,
+			  unsigned int block_nb)
 {
     uint64 w[80];
     uint64 wv[8];
diff --git a/Makefile b/Makefile
index a890833..6b60557 100644
--- a/Makefile
+++ b/Makefile
@@ -25,9 +25,10 @@ mandir = /usr/share/man
 
 progs = mmc
 
-# make C=1 to enable sparse
+# make C=1 to enable sparse - default
+C ?= 1
 ifdef C
-	check = sparse $(CHECKFLAGS)
+	check = sparse $(CHECKFLAGS) $(AM_CFLAGS)
 endif
 
 all: $(progs)
diff --git a/lsmmc.c b/lsmmc.c
index 9596722..7e0ea23 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -47,6 +47,7 @@
 #include <unistd.h>
 
 #include "mmc.h"
+#include "mmc_cmds.h"
 
 #define MASKTOBIT0(high)	\
 	((high >= 0) ? ((1ull << ((high) + 1ull)) - 1ull) : 0ull)
@@ -231,7 +232,7 @@ static struct ids_database mmc_database[] = {
 };
 
 /* Command line parsing functions */
-void usage(void)
+static void usage(void)
 {
 	printf("Usage: print mmc [-h] [-v] <device path ...>\n");
 	printf("\n");
@@ -240,7 +241,7 @@ void usage(void)
 	printf("\t-v\tEnable verbose mode.\n");
 }
 
-int parse_opts(int argc, char **argv, struct config *config)
+static int parse_opts(int argc, char **argv, struct config *config)
 {
 	int c;
 
@@ -302,7 +303,7 @@ static char *get_manufacturer(struct config *config, unsigned int manid)
 }
 
 /* MMC/SD file parsing functions */
-char *read_file(char *name)
+static char *read_file(char *name)
 {
 	char line[4096];
 	char *preparsed, *start = line;
@@ -352,7 +353,7 @@ char *read_file(char *name)
 }
 
 /* Hexadecimal string parsing functions */
-char *to_binstr(char *hexstr)
+static char *to_binstr(char *hexstr)
 {
 	char *bindigits[] = {
 		"0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
@@ -386,7 +387,7 @@ char *to_binstr(char *hexstr)
 	return binstr;
 }
 
-void bin_to_unsigned(unsigned int *u, char *binstr, int width)
+static void bin_to_unsigned(unsigned int *u, char *binstr, int width)
 {
 	*u = 0;
 	assert(width <= 32);
@@ -400,7 +401,7 @@ void bin_to_unsigned(unsigned int *u, char *binstr, int width)
 	}
 }
 
-void bin_to_ascii(char *a, char *binstr, int width)
+static void bin_to_ascii(char *a, char *binstr, int width)
 {
 	assert(width % 8 == 0);
 	*a = '\0';
@@ -419,7 +420,7 @@ void bin_to_ascii(char *a, char *binstr, int width)
 	}
 }
 
-void parse_bin(char *hexstr, char *fmt, ...)
+static void parse_bin(char *hexstr, char *fmt, ...)
 {
 	va_list args;
 	char *origstr;
@@ -470,7 +471,7 @@ void parse_bin(char *hexstr, char *fmt, ...)
 }
 
 /* MMC/SD information parsing functions */
-void print_sd_cid(struct config *config, char *cid)
+static void print_sd_cid(struct config *config, char *cid)
 {
 	static const char *months[] = {
 		"jan", "feb", "mar", "apr", "may", "jun",
@@ -528,7 +529,7 @@ void print_sd_cid(struct config *config, char *cid)
 	}
 }
 
-void print_mmc_cid(struct config *config, char *cid)
+static void print_mmc_cid(struct config *config, char *cid)
 {
 	static const char *months[] = {
 		"jan", "feb", "mar", "apr", "may", "jun",
@@ -602,7 +603,7 @@ void print_mmc_cid(struct config *config, char *cid)
 	}
 }
 
-void print_sd_csd(struct config *config, char *csd)
+static void print_sd_csd(struct config *config, char *csd)
 {
 	unsigned int csd_structure;
 	unsigned int taac_timevalue;
@@ -1941,128 +1942,7 @@ static void print_mmc_csd(struct config *config, char *csd)
 	}
 }
 
-char *speed_class_speed(unsigned char id, bool ddr)
-{
-	if (ddr) {
-		switch (id) {
-		case 0x00: return "<4.8MB/s";
-		case 0x08: return " 4.8MB/s";
-		case 0x0a: return " 6.0MB/s";
-		case 0x0f: return " 9.0MB/s";
-		case 0x14: return "12.0MB/s";
-		case 0x1e: return "18.0MB/s";
-		case 0x28: return "24.0MB/s";
-		case 0x32: return "30.0MB/s";
-		case 0x3c: return "36.0MB/s";
-		case 0x46: return "42.0MB/s";
-		case 0x50: return "48.0MB/s";
-		case 0x64: return "60.0MB/s";
-		case 0x78: return "72.0MB/s";
-		case 0x8c: return "84.0MB/s";
-		case 0xa0: return "96.0MB/s";
-		default: return "??.?MB/s";
-		}
-	} else {
-		switch (id) {
-		case 0x00: return "<2.4MB/s";
-		case 0x08: return " 2.4MB/s";
-		case 0x0a: return " 3.0MB/s";
-		case 0x0f: return " 4.5MB/s";
-		case 0x14: return " 6.0MB/s";
-		case 0x1e: return " 9.0MB/s";
-		case 0x28: return "12.0MB/s";
-		case 0x32: return "15.0MB/s";
-		case 0x3c: return "18.0MB/s";
-		case 0x46: return "21.0MB/s";
-		case 0x50: return "24.0MB/s";
-		case 0x64: return "30.0MB/s";
-		case 0x78: return "36.0MB/s";
-		case 0x8c: return "42.0MB/s";
-		case 0xa0: return "48.0MB/s";
-		default: return "??.?MB/s";
-		}
-	}
-}
-
-char speed_class_name(unsigned char id)
-{
-	switch (id) {
-	case 0x00: return '?';
-	case 0x08: return 'A';
-	case 0x0a: return 'B';
-	case 0x0f: return 'C';
-	case 0x14: return 'D';
-	case 0x1e: return 'E';
-	case 0x28: return 'F';
-	case 0x32: return 'G';
-	case 0x3c: return 'H';
-	case 0x46: return 'J';
-	case 0x50: return 'K';
-	case 0x64: return 'M';
-	case 0x78: return 'O';
-	case 0x8c: return 'R';
-	case 0xa0: return 'T';
-	default: return '?';
-	}
-}
-
-char *power_class_consumption(unsigned int id, bool volt360)
-{
-	if (volt360) {
-		switch (id) {
-		case 0x0: return "100-200mA";
-		case 0x1: return "120-220mA";
-		case 0x2: return "150-250mA";
-		case 0x3: return "180-280mA";
-		case 0x4: return "200-300mA";
-		case 0x5: return "220-320mA";
-		case 0x6: return "250-350mA";
-		case 0x7: return "300-400mA";
-		case 0x8: return "350-450mA";
-		case 0x9: return "400-500mA";
-		case 0xa: return "450-550mA";
-		default: return "reserved";
-		}
-	} else {
-		switch (id) {
-		case 0x0: return "65-130mA";
-		case 0x1: return "70-140mA";
-		case 0x2: return "80-160mA";
-		case 0x3: return "90-180mA";
-		case 0x4: return "100-200mA";
-		case 0x5: return "120-220mA";
-		case 0x6: return "140-240mA";
-		case 0x7: return "160-260mA";
-		case 0x8: return "180-280mA";
-		case 0x9: return "200-300mA";
-		case 0xa: return "250-350mA";
-		default: return "reserved";
-		}
-	}
-}
-
-char *sleep_consumption(unsigned int id)
-{
-	switch (id) {
-	case 0x00: return "not defined";
-	case 0x01: return "2uA";
-	case 0x02: return "4uA";
-	case 0x03: return "8uA";
-	case 0x04: return "16uA";
-	case 0x05: return "32uA";
-	case 0x06: return "64uA";
-	case 0x07: return "128uA";
-	case 0x08: return "0.256mA";
-	case 0x09: return "0.512mA";
-	case 0x0a: return "1.024mA";
-	case 0x0b: return "2.048mA";
-	case 0x0c: return "4.096mA";
-	case 0x0d: return "8.192mA";
-	default: return "reserved";
-	}
-}
-
-void print_sd_scr(struct config *config, char *scr)
+static void print_sd_scr(struct config *config, char *scr)
 {
 	unsigned int scr_structure;
 	unsigned int sd_spec;
@@ -2203,7 +2083,7 @@ void print_sd_scr(struct config *config, char *scr)
 	}
 }
 
-int process_dir(struct config *config, enum REG_TYPE reg)
+static int process_dir(struct config *config, enum REG_TYPE reg)
 {
 	char *type = NULL;
 	char *reg_content = NULL;
diff --git a/mmc.c b/mmc.c
index bc8f74e..2c5b9b5 100644
--- a/mmc.c
+++ b/mmc.c
@@ -272,7 +272,7 @@ static struct Command commands[] = {
 	  "4. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.\n",
 	  NULL
 	},
-	{ 0, 0, 0, 0 }
+	{ NULL, 0, NULL, NULL }
 };
 
 static char *get_prgname(char *programname)
@@ -324,10 +324,10 @@ static void help(char *np)
 
 static int split_command(char *cmd, char ***commands)
 {
-	int	c, l;
-	char	*p, *s;
+	int c, l;
+	char *p, *s;
 
-	for( *commands = 0, l = c = 0, p = s = cmd ; ; p++, l++ ){
+	for (*commands = NULL, l = c = 0, p = s = cmd ; ; p++, l++) {
 		if ( *p && *p != ' ' )
 			continue;
 
@@ -340,7 +340,7 @@ static int split_command(char *cmd, char ***commands)
 		if( !*p ) break;
 	}
 
-	(*commands)[c] = 0;
+	(*commands)[c] = NULL;
 	return c;
 }
 
@@ -444,7 +444,7 @@ static int parse_args(int argc, char **argv,
 		      int *nargs_, char **cmd_, char ***args_ )
 {
 	struct Command	*cp;
-	struct Command	*matchcmd=0;
+	struct Command	*matchcmd = NULL;
 	char		*prgname = get_prgname(argv[0]);
 	int		i=0, helprequested=0;
 
@@ -535,9 +535,9 @@ static int parse_args(int argc, char **argv,
 }
 int main(int ac, char **av )
 {
-	char		*cmd=0, **args=0;
-	int		nargs=0, r;
-	CommandFunction func=0;
+	char *cmd = NULL, **args = NULL;
+	int nargs = 0, r;
+	CommandFunction func = NULL;
 
 	r = parse_args(ac, av, &func, &nargs, &cmd, &args);
 	if( r <= 0 ){
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 936e0c5..3b1bcf4 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -63,7 +63,7 @@ static inline __u32 per_byte_htole32(__u8 *arr)
 	return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
 }
 
-int read_extcsd(int fd, __u8 *ext_csd)
+static int read_extcsd(int fd, __u8 *ext_csd)
 {
 	int ret = 0;
 	struct mmc_ioc_cmd idata;
@@ -93,7 +93,8 @@ static void fill_switch_cmd(struct mmc_ioc_cmd *cmd, __u8 index, __u8 value)
 	cmd->flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 }
 
-int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
+static int
+write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
 {
 	int ret = 0;
 	struct mmc_ioc_cmd idata = {};
@@ -110,7 +111,7 @@ int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
 	return ret;
 }
 
-int send_status(int fd, __u32 *response)
+static int send_status(int fd, __u32 *response)
 {
 	int ret = 0;
 	struct mmc_ioc_cmd idata;
@@ -744,7 +745,7 @@ int do_boot_bus_conditions_set(int nargs, char **argv)
 	return ret;
 }
 
-int do_hwreset(int value, int nargs, char **argv)
+static int do_hwreset(int value, int nargs, char **argv)
 {
 	__u8 ext_csd[512];
 	int fd, ret;
@@ -972,7 +973,7 @@ out_free:
 	return ret;
 }
 
-unsigned int get_sector_count(__u8 *ext_csd)
+static unsigned int get_sector_count(__u8 *ext_csd)
 {
 	return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
 	(ext_csd[EXT_CSD_SEC_COUNT_2] << 16) |
@@ -980,7 +981,7 @@ unsigned int get_sector_count(__u8 *ext_csd)
 	ext_csd[EXT_CSD_SEC_COUNT_0];
 }
 
-int is_blockaddresed(__u8 *ext_csd)
+static int is_blockaddresed(__u8 *ext_csd)
 {
 	unsigned int sectors = get_sector_count(ext_csd);
 
@@ -988,18 +989,19 @@ int is_blockaddresed(__u8 *ext_csd)
 	return (sectors > (2u * 1024 * 1024 * 1024) / 512);
 }
 
-unsigned int get_hc_wp_grp_size(__u8 *ext_csd)
+static unsigned int get_hc_wp_grp_size(__u8 *ext_csd)
 {
 	return ext_csd[221];
 }
 
-unsigned int get_hc_erase_grp_size(__u8 *ext_csd)
+static unsigned int get_hc_erase_grp_size(__u8 *ext_csd)
 {
 	return ext_csd[224];
 }
 
-int set_partitioning_setting_completed(int dry_run, const char * const device,
-		int fd)
+static int
+set_partitioning_setting_completed(int dry_run, const char *const device,
+				   int fd)
 {
 	int ret;
 
@@ -1047,7 +1049,7 @@ int set_partitioning_setting_completed(int dry_run, const char * const device,
 	return 0;
 }
 
-int check_enhanced_area_total_limit(const char * const device, int fd)
+static int check_enhanced_area_total_limit(const char *const device, int fd)
 {
 	__u8 ext_csd[512];
 	__u32 regl;
@@ -2267,7 +2269,7 @@ int do_rpmb_write_key(int nargs, char **argv)
 	return ret;
 }
 
-int rpmb_read_counter(int dev_fd, unsigned int *cnt)
+static int rpmb_read_counter(int dev_fd, unsigned int *cnt)
 {
 	int ret;
 	struct rpmb_frame frame_in = {
@@ -2589,7 +2591,7 @@ int do_rpmb_write_block(int nargs, char **argv)
 	return ret;
 }
 
-int do_cache_ctrl(int value, int nargs, char **argv)
+static int do_cache_ctrl(int value, int nargs, char **argv)
 {
 	__u8 ext_csd[512];
 	int fd, ret;
-- 
2.25.1

