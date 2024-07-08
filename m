Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502680635
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jul 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441462; cv=none; b=NXgFUCjJvZVyJDSkmHR4fZg1PsWN4CLkWFUVGP2Ktp3lD+nLpc3XKycXQW8L5KqTtP7E+9Ox0GFWjZAPUrpIbJVo7LliwGMN/IYzAAIATxkd8RHP7NXzb8cS/TDqfJoyDYEf5iA8SqWh4ityGRC15ABfMK6PemDUzXnxYMElDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441462; c=relaxed/simple;
	bh=rTsd+He7ZAvxn9/3DQ8Rs6Mikp2hDYtimI0lR3BxQww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iciLInJEjZsP46XNoduAU7zyBlWr71DJxoIVwQTuxMBXBXbqDXn9/xCiDUNJWfn+qHIP338pgT2tbklunNsot23GZ0Ji3hkr7kTk+CzFT29Q5MaAFsnpchap5Ud5fx+PJoTy8s6RLa+bmQtYOlmXPCTQpCOlykofqq38S0L4Tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HEjxKiIB; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEjxKiIB"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0365588ab8so3452234276.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2024 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441459; x=1721046259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/n/EIDpasroOWU4n+I4ptFw2waZeX/Ifyt6KA+NqaTc=;
        b=HEjxKiIBgj0EV3v1Yz4a7fyQeETXZVeGDaRmEDbt6gmCFegsZCwOhTh+J/LaBzIdw6
         qeZEFJLrwsuRlBapoXzM3lFIa/42nLA8fsfpUvPvUnutfkllMIS7MGBXXGbVSCuBHK9R
         of7GSQUjNV+Pv5Ra6hhNqKLVYNCdzgHma1GXXIY7Ev6f/rjt0xRyg8b0F/6b1g2jMw0U
         ueqQKI3hjxRpGF9dBM6ZGeJjHdTl8q6hHub3oYJyjoifFmyFtuTBcs5Y09emyexrc7Az
         EC3u8AOLD/aspDpk9IQU5MnOlywZAC4uqUjFjx7CejGlT8T37dih80CtgkbRB8/k+bpD
         W/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441459; x=1721046259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n/EIDpasroOWU4n+I4ptFw2waZeX/Ifyt6KA+NqaTc=;
        b=K+VH6ndYIQvmOvzs39QQCtuyM2KGm7JaIs3cNoaMFkFOea/yzufQNaa0dFSler2O3W
         tnXVYO0aF7dDhsMKYemWLrN491ezrIZRm4byKb0nOknGZooAsOfBfkSMxAe4vYX7e1uS
         hulVMja80k64vwFlx7BzIJrW0UpIlyB8XwkfZE89ZTZsrRGj3hFcD7T5qi6Te+oPEqWf
         CT9BkWrObpJMRj16OhO4jJtmbDS78Rhnp3XmlHuavUJ7gZ4b9bWnwbjGpd64FDGoBIfw
         BTu5YLQNQJsJi/+WssX6cM8IiOFPYN/+D9sCSR19YHD4sCTnaYCzAUhnsZX71vQmNrlG
         nIAg==
X-Gm-Message-State: AOJu0Yy1EaPbYC6mOsSLN+Yh6AHlcXVJdYt2b7FzHl+1JJEMXk+grVg3
	XyzMFYCvV0TSqWJvi3ygdZVA2l8Ue4n8mWZ/S4GDs/iv1D98nXC/UOiCzaBzyQDKC5SKEaqUsMo
	E6oJh/A6kD3+A7Vri8J1ZLho+rtty00/txsOoJGJM7jNZNmAF
X-Google-Smtp-Source: AGHT+IE27+iR/W6jTSH3XpUx7pBfC4jzb51pq5Y28lRVi9PUa7Rfv0dueMCecNCI80TINB6lHmv/1cjP2pLmYBNrroM=
X-Received: by 2002:a25:84cb:0:b0:e03:562c:7e92 with SMTP id
 3f1490d57ef6-e03c199219amr10636226276.24.1720441458994; Mon, 08 Jul 2024
 05:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706171412.1613019-1-avri.altman@wdc.com>
In-Reply-To: <20240706171412.1613019-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 14:23:43 +0200
Message-ID: <CAPDyKFqs=DMppBc=Za+35ET9OFPJkm0FOF3VJs6+sRdh4C2XYQ@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Make functions static for local scope enforcement
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jul 2024 at 19:15, Avri Altman <avri.altman@wdc.com> wrote:
>
> Run Sparse and fix its warnings.  Apparently, running make C=1 is rarely
> done, so make running sparse default.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  3rdparty/hmac_sha/sha2.c |  18 ++---
>  Makefile                 |   5 +-
>  lsmmc.c                  | 146 ++++-----------------------------------
>  mmc.c                    |  18 ++---
>  mmc_cmds.c               |  28 ++++----
>  5 files changed, 49 insertions(+), 166 deletions(-)
>
> diff --git a/3rdparty/hmac_sha/sha2.c b/3rdparty/hmac_sha/sha2.c
> index 337b414..9fcafb7 100644
> --- a/3rdparty/hmac_sha/sha2.c
> +++ b/3rdparty/hmac_sha/sha2.c
> @@ -131,27 +131,27 @@
>      wv[h] = t1 + t2;                                        \
>  }
>
> -uint32 sha224_h0[8] =
> +static uint32 sha224_h0[8] =
>              {0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
>               0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4};
>
> -uint32 sha256_h0[8] =
> +static uint32 sha256_h0[8] =
>              {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
>               0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
>
> -uint64 sha384_h0[8] =
> +static uint64 sha384_h0[8] =
>              {0xcbbb9d5dc1059ed8ULL, 0x629a292a367cd507ULL,
>               0x9159015a3070dd17ULL, 0x152fecd8f70e5939ULL,
>               0x67332667ffc00b31ULL, 0x8eb44a8768581511ULL,
>               0xdb0c2e0d64f98fa7ULL, 0x47b5481dbefa4fa4ULL};
>
> -uint64 sha512_h0[8] =
> +static uint64 sha512_h0[8] =
>              {0x6a09e667f3bcc908ULL, 0xbb67ae8584caa73bULL,
>               0x3c6ef372fe94f82bULL, 0xa54ff53a5f1d36f1ULL,
>               0x510e527fade682d1ULL, 0x9b05688c2b3e6c1fULL,
>               0x1f83d9abfb41bd6bULL, 0x5be0cd19137e2179ULL};
>
> -uint32 sha256_k[64] =
> +static uint32 sha256_k[64] =
>              {0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
>               0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
>               0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
> @@ -169,7 +169,7 @@ uint32 sha256_k[64] =
>               0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
>               0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};
>
> -uint64 sha512_k[80] =
> +static uint64 sha512_k[80] =
>              {0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL,
>               0xb5c0fbcfec4d3b2fULL, 0xe9b5dba58189dbbcULL,
>               0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
> @@ -213,7 +213,7 @@ uint64 sha512_k[80] =
>
>  /* SHA-256 functions */
>
> -void sha256_transf(sha256_ctx *ctx, const unsigned char *message,
> +static void sha256_transf(sha256_ctx *ctx, const unsigned char *message,
>                     unsigned int block_nb)
>  {
>      uint32 w[64];
> @@ -429,8 +429,8 @@ void sha256_final(sha256_ctx *ctx, unsigned char *digest)
>
>  /* SHA-512 functions */
>
> -void sha512_transf(sha512_ctx *ctx, const unsigned char *message,
> -                   unsigned int block_nb)
> +static void sha512_transf(sha512_ctx *ctx, const unsigned char *message,
> +                         unsigned int block_nb)
>  {
>      uint64 w[80];
>      uint64 wv[8];
> diff --git a/Makefile b/Makefile
> index a890833..6b60557 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -25,9 +25,10 @@ mandir = /usr/share/man
>
>  progs = mmc
>
> -# make C=1 to enable sparse
> +# make C=1 to enable sparse - default
> +C ?= 1
>  ifdef C
> -       check = sparse $(CHECKFLAGS)
> +       check = sparse $(CHECKFLAGS) $(AM_CFLAGS)
>  endif
>
>  all: $(progs)
> diff --git a/lsmmc.c b/lsmmc.c
> index 9596722..7e0ea23 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -47,6 +47,7 @@
>  #include <unistd.h>
>
>  #include "mmc.h"
> +#include "mmc_cmds.h"
>
>  #define MASKTOBIT0(high)       \
>         ((high >= 0) ? ((1ull << ((high) + 1ull)) - 1ull) : 0ull)
> @@ -231,7 +232,7 @@ static struct ids_database mmc_database[] = {
>  };
>
>  /* Command line parsing functions */
> -void usage(void)
> +static void usage(void)
>  {
>         printf("Usage: print mmc [-h] [-v] <device path ...>\n");
>         printf("\n");
> @@ -240,7 +241,7 @@ void usage(void)
>         printf("\t-v\tEnable verbose mode.\n");
>  }
>
> -int parse_opts(int argc, char **argv, struct config *config)
> +static int parse_opts(int argc, char **argv, struct config *config)
>  {
>         int c;
>
> @@ -302,7 +303,7 @@ static char *get_manufacturer(struct config *config, unsigned int manid)
>  }
>
>  /* MMC/SD file parsing functions */
> -char *read_file(char *name)
> +static char *read_file(char *name)
>  {
>         char line[4096];
>         char *preparsed, *start = line;
> @@ -352,7 +353,7 @@ char *read_file(char *name)
>  }
>
>  /* Hexadecimal string parsing functions */
> -char *to_binstr(char *hexstr)
> +static char *to_binstr(char *hexstr)
>  {
>         char *bindigits[] = {
>                 "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
> @@ -386,7 +387,7 @@ char *to_binstr(char *hexstr)
>         return binstr;
>  }
>
> -void bin_to_unsigned(unsigned int *u, char *binstr, int width)
> +static void bin_to_unsigned(unsigned int *u, char *binstr, int width)
>  {
>         *u = 0;
>         assert(width <= 32);
> @@ -400,7 +401,7 @@ void bin_to_unsigned(unsigned int *u, char *binstr, int width)
>         }
>  }
>
> -void bin_to_ascii(char *a, char *binstr, int width)
> +static void bin_to_ascii(char *a, char *binstr, int width)
>  {
>         assert(width % 8 == 0);
>         *a = '\0';
> @@ -419,7 +420,7 @@ void bin_to_ascii(char *a, char *binstr, int width)
>         }
>  }
>
> -void parse_bin(char *hexstr, char *fmt, ...)
> +static void parse_bin(char *hexstr, char *fmt, ...)
>  {
>         va_list args;
>         char *origstr;
> @@ -470,7 +471,7 @@ void parse_bin(char *hexstr, char *fmt, ...)
>  }
>
>  /* MMC/SD information parsing functions */
> -void print_sd_cid(struct config *config, char *cid)
> +static void print_sd_cid(struct config *config, char *cid)
>  {
>         static const char *months[] = {
>                 "jan", "feb", "mar", "apr", "may", "jun",
> @@ -528,7 +529,7 @@ void print_sd_cid(struct config *config, char *cid)
>         }
>  }
>
> -void print_mmc_cid(struct config *config, char *cid)
> +static void print_mmc_cid(struct config *config, char *cid)
>  {
>         static const char *months[] = {
>                 "jan", "feb", "mar", "apr", "may", "jun",
> @@ -602,7 +603,7 @@ void print_mmc_cid(struct config *config, char *cid)
>         }
>  }
>
> -void print_sd_csd(struct config *config, char *csd)
> +static void print_sd_csd(struct config *config, char *csd)
>  {
>         unsigned int csd_structure;
>         unsigned int taac_timevalue;
> @@ -1941,128 +1942,7 @@ static void print_mmc_csd(struct config *config, char *csd)
>         }
>  }
>
> -char *speed_class_speed(unsigned char id, bool ddr)
> -{
> -       if (ddr) {
> -               switch (id) {
> -               case 0x00: return "<4.8MB/s";
> -               case 0x08: return " 4.8MB/s";
> -               case 0x0a: return " 6.0MB/s";
> -               case 0x0f: return " 9.0MB/s";
> -               case 0x14: return "12.0MB/s";
> -               case 0x1e: return "18.0MB/s";
> -               case 0x28: return "24.0MB/s";
> -               case 0x32: return "30.0MB/s";
> -               case 0x3c: return "36.0MB/s";
> -               case 0x46: return "42.0MB/s";
> -               case 0x50: return "48.0MB/s";
> -               case 0x64: return "60.0MB/s";
> -               case 0x78: return "72.0MB/s";
> -               case 0x8c: return "84.0MB/s";
> -               case 0xa0: return "96.0MB/s";
> -               default: return "??.?MB/s";
> -               }
> -       } else {
> -               switch (id) {
> -               case 0x00: return "<2.4MB/s";
> -               case 0x08: return " 2.4MB/s";
> -               case 0x0a: return " 3.0MB/s";
> -               case 0x0f: return " 4.5MB/s";
> -               case 0x14: return " 6.0MB/s";
> -               case 0x1e: return " 9.0MB/s";
> -               case 0x28: return "12.0MB/s";
> -               case 0x32: return "15.0MB/s";
> -               case 0x3c: return "18.0MB/s";
> -               case 0x46: return "21.0MB/s";
> -               case 0x50: return "24.0MB/s";
> -               case 0x64: return "30.0MB/s";
> -               case 0x78: return "36.0MB/s";
> -               case 0x8c: return "42.0MB/s";
> -               case 0xa0: return "48.0MB/s";
> -               default: return "??.?MB/s";
> -               }
> -       }
> -}
> -
> -char speed_class_name(unsigned char id)
> -{
> -       switch (id) {
> -       case 0x00: return '?';
> -       case 0x08: return 'A';
> -       case 0x0a: return 'B';
> -       case 0x0f: return 'C';
> -       case 0x14: return 'D';
> -       case 0x1e: return 'E';
> -       case 0x28: return 'F';
> -       case 0x32: return 'G';
> -       case 0x3c: return 'H';
> -       case 0x46: return 'J';
> -       case 0x50: return 'K';
> -       case 0x64: return 'M';
> -       case 0x78: return 'O';
> -       case 0x8c: return 'R';
> -       case 0xa0: return 'T';
> -       default: return '?';
> -       }
> -}
> -
> -char *power_class_consumption(unsigned int id, bool volt360)
> -{
> -       if (volt360) {
> -               switch (id) {
> -               case 0x0: return "100-200mA";
> -               case 0x1: return "120-220mA";
> -               case 0x2: return "150-250mA";
> -               case 0x3: return "180-280mA";
> -               case 0x4: return "200-300mA";
> -               case 0x5: return "220-320mA";
> -               case 0x6: return "250-350mA";
> -               case 0x7: return "300-400mA";
> -               case 0x8: return "350-450mA";
> -               case 0x9: return "400-500mA";
> -               case 0xa: return "450-550mA";
> -               default: return "reserved";
> -               }
> -       } else {
> -               switch (id) {
> -               case 0x0: return "65-130mA";
> -               case 0x1: return "70-140mA";
> -               case 0x2: return "80-160mA";
> -               case 0x3: return "90-180mA";
> -               case 0x4: return "100-200mA";
> -               case 0x5: return "120-220mA";
> -               case 0x6: return "140-240mA";
> -               case 0x7: return "160-260mA";
> -               case 0x8: return "180-280mA";
> -               case 0x9: return "200-300mA";
> -               case 0xa: return "250-350mA";
> -               default: return "reserved";
> -               }
> -       }
> -}
> -
> -char *sleep_consumption(unsigned int id)
> -{
> -       switch (id) {
> -       case 0x00: return "not defined";
> -       case 0x01: return "2uA";
> -       case 0x02: return "4uA";
> -       case 0x03: return "8uA";
> -       case 0x04: return "16uA";
> -       case 0x05: return "32uA";
> -       case 0x06: return "64uA";
> -       case 0x07: return "128uA";
> -       case 0x08: return "0.256mA";
> -       case 0x09: return "0.512mA";
> -       case 0x0a: return "1.024mA";
> -       case 0x0b: return "2.048mA";
> -       case 0x0c: return "4.096mA";
> -       case 0x0d: return "8.192mA";
> -       default: return "reserved";
> -       }
> -}
> -
> -void print_sd_scr(struct config *config, char *scr)
> +static void print_sd_scr(struct config *config, char *scr)
>  {
>         unsigned int scr_structure;
>         unsigned int sd_spec;
> @@ -2203,7 +2083,7 @@ void print_sd_scr(struct config *config, char *scr)
>         }
>  }
>
> -int process_dir(struct config *config, enum REG_TYPE reg)
> +static int process_dir(struct config *config, enum REG_TYPE reg)
>  {
>         char *type = NULL;
>         char *reg_content = NULL;
> diff --git a/mmc.c b/mmc.c
> index bc8f74e..2c5b9b5 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -272,7 +272,7 @@ static struct Command commands[] = {
>           "4. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.\n",
>           NULL
>         },
> -       { 0, 0, 0, 0 }
> +       { NULL, 0, NULL, NULL }
>  };
>
>  static char *get_prgname(char *programname)
> @@ -324,10 +324,10 @@ static void help(char *np)
>
>  static int split_command(char *cmd, char ***commands)
>  {
> -       int     c, l;
> -       char    *p, *s;
> +       int c, l;
> +       char *p, *s;
>
> -       for( *commands = 0, l = c = 0, p = s = cmd ; ; p++, l++ ){
> +       for (*commands = NULL, l = c = 0, p = s = cmd ; ; p++, l++) {
>                 if ( *p && *p != ' ' )
>                         continue;
>
> @@ -340,7 +340,7 @@ static int split_command(char *cmd, char ***commands)
>                 if( !*p ) break;
>         }
>
> -       (*commands)[c] = 0;
> +       (*commands)[c] = NULL;
>         return c;
>  }
>
> @@ -444,7 +444,7 @@ static int parse_args(int argc, char **argv,
>                       int *nargs_, char **cmd_, char ***args_ )
>  {
>         struct Command  *cp;
> -       struct Command  *matchcmd=0;
> +       struct Command  *matchcmd = NULL;
>         char            *prgname = get_prgname(argv[0]);
>         int             i=0, helprequested=0;
>
> @@ -535,9 +535,9 @@ static int parse_args(int argc, char **argv,
>  }
>  int main(int ac, char **av )
>  {
> -       char            *cmd=0, **args=0;
> -       int             nargs=0, r;
> -       CommandFunction func=0;
> +       char *cmd = NULL, **args = NULL;
> +       int nargs = 0, r;
> +       CommandFunction func = NULL;
>
>         r = parse_args(ac, av, &func, &nargs, &cmd, &args);
>         if( r <= 0 ){
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 936e0c5..3b1bcf4 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -63,7 +63,7 @@ static inline __u32 per_byte_htole32(__u8 *arr)
>         return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
>  }
>
> -int read_extcsd(int fd, __u8 *ext_csd)
> +static int read_extcsd(int fd, __u8 *ext_csd)
>  {
>         int ret = 0;
>         struct mmc_ioc_cmd idata;
> @@ -93,7 +93,8 @@ static void fill_switch_cmd(struct mmc_ioc_cmd *cmd, __u8 index, __u8 value)
>         cmd->flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>  }
>
> -int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
> +static int
> +write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
>  {
>         int ret = 0;
>         struct mmc_ioc_cmd idata = {};
> @@ -110,7 +111,7 @@ int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
>         return ret;
>  }
>
> -int send_status(int fd, __u32 *response)
> +static int send_status(int fd, __u32 *response)
>  {
>         int ret = 0;
>         struct mmc_ioc_cmd idata;
> @@ -744,7 +745,7 @@ int do_boot_bus_conditions_set(int nargs, char **argv)
>         return ret;
>  }
>
> -int do_hwreset(int value, int nargs, char **argv)
> +static int do_hwreset(int value, int nargs, char **argv)
>  {
>         __u8 ext_csd[512];
>         int fd, ret;
> @@ -972,7 +973,7 @@ out_free:
>         return ret;
>  }
>
> -unsigned int get_sector_count(__u8 *ext_csd)
> +static unsigned int get_sector_count(__u8 *ext_csd)
>  {
>         return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
>         (ext_csd[EXT_CSD_SEC_COUNT_2] << 16) |
> @@ -980,7 +981,7 @@ unsigned int get_sector_count(__u8 *ext_csd)
>         ext_csd[EXT_CSD_SEC_COUNT_0];
>  }
>
> -int is_blockaddresed(__u8 *ext_csd)
> +static int is_blockaddresed(__u8 *ext_csd)
>  {
>         unsigned int sectors = get_sector_count(ext_csd);
>
> @@ -988,18 +989,19 @@ int is_blockaddresed(__u8 *ext_csd)
>         return (sectors > (2u * 1024 * 1024 * 1024) / 512);
>  }
>
> -unsigned int get_hc_wp_grp_size(__u8 *ext_csd)
> +static unsigned int get_hc_wp_grp_size(__u8 *ext_csd)
>  {
>         return ext_csd[221];
>  }
>
> -unsigned int get_hc_erase_grp_size(__u8 *ext_csd)
> +static unsigned int get_hc_erase_grp_size(__u8 *ext_csd)
>  {
>         return ext_csd[224];
>  }
>
> -int set_partitioning_setting_completed(int dry_run, const char * const device,
> -               int fd)
> +static int
> +set_partitioning_setting_completed(int dry_run, const char *const device,
> +                                  int fd)
>  {
>         int ret;
>
> @@ -1047,7 +1049,7 @@ int set_partitioning_setting_completed(int dry_run, const char * const device,
>         return 0;
>  }
>
> -int check_enhanced_area_total_limit(const char * const device, int fd)
> +static int check_enhanced_area_total_limit(const char *const device, int fd)
>  {
>         __u8 ext_csd[512];
>         __u32 regl;
> @@ -2267,7 +2269,7 @@ int do_rpmb_write_key(int nargs, char **argv)
>         return ret;
>  }
>
> -int rpmb_read_counter(int dev_fd, unsigned int *cnt)
> +static int rpmb_read_counter(int dev_fd, unsigned int *cnt)
>  {
>         int ret;
>         struct rpmb_frame frame_in = {
> @@ -2589,7 +2591,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>         return ret;
>  }
>
> -int do_cache_ctrl(int value, int nargs, char **argv)
> +static int do_cache_ctrl(int value, int nargs, char **argv)
>  {
>         __u8 ext_csd[512];
>         int fd, ret;
> --
> 2.25.1
>
