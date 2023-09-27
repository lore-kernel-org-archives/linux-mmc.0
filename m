Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F72E810CE
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 11:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjI0LDg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 07:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0LDf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 07:03:35 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B949E194
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 04:03:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f4db9e11eso101820177b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812613; x=1696417413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1A8KIuG0w9PnY6605p7pdY8UWj6j73YqQHshFjfXic=;
        b=v99lvNSpnp1s5+wYYn400o047gpot/xGFNvZq0AHhDsonJLYHxpAB9Wc12UPYa/k0L
         Rvh0oy++O9MEWlAxKBnUF3I3Dp6Q23lfkrrDR260Gcvs2FUWN85mtIyZ0nq4kOej9oh2
         jENtnY34rup1oAKt7LF10TMdAj4vQ/VsrDn0CsO86IHE+LxzSZJgbgoJcqbpevJalTsb
         oXh3oNLMjzr4eMlwB71CHZvqQSAGWFkqOL8V/A6QQasNSdl6KNOFwAdO9ma5XsM4zrZ9
         Z1iLNQc9QYdH9x3C75mTaEnFR8XQ6FUWtk7eyyINc9rtFfgkymNo9UlSl8B/sl0h5Jw+
         FyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812613; x=1696417413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1A8KIuG0w9PnY6605p7pdY8UWj6j73YqQHshFjfXic=;
        b=dKoZPi4xGB4iX0I/7JlDbol3TasyMwKC8MUtA+aKK8VhqGx7yk77SXMN9vlEYjuMaD
         9Z97Y5/58gHWmiJNlZoK+RZJaji8vehNqNV2hzOFGT0iPX26HdEVO7tEOUt8XLri2u0R
         CNWsrdCySU4IYvkI1QjIJiZio/kaxCumQ/Q7M3ZhbxtOXfR3DX/JcsYtd2BzpcsjaNTV
         /Y1hXVbmflO47EcH7jI/4t+BEOzPca0hxgbYntFJu/7Ay4RarV2F+MEHMcd7pq3cjlEG
         bKz/JvCmPkQvwwHhONEu5Yz9plv8UIZ3Uq84h2A5U6F1az5rPcx3u1CoNBCPX9hMjeo7
         fTlw==
X-Gm-Message-State: AOJu0YwB/hweqAc48FIVPZkP8A/9wUI8wg+bTlwvOdi5zDJ6QdZ1ejwK
        POwpM3i8XxAmp+vlIIzMDXcgkOy5iVqeH7WbwlKnJG2+MpSnJlwtdjY=
X-Google-Smtp-Source: AGHT+IEuM5n8gjaUd9Q5Zk9xEgNQI5HOoyvAwuD/R607rUYoVZjbg3P6MuJaZznJM4M+2zEnnnA/vIiCBTGWFlv0xZA=
X-Received: by 2002:a25:aa4b:0:b0:d81:4307:4b1e with SMTP id
 s69-20020a25aa4b000000b00d8143074b1emr1652126ybi.33.1695812612825; Wed, 27
 Sep 2023 04:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230926100006.1789276-1-avri.altman@wdc.com> <20230926100006.1789276-3-avri.altman@wdc.com>
In-Reply-To: <20230926100006.1789276-3-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 13:02:57 +0200
Message-ID: <CAPDyKFoe0TnGkeU+3abnVhLqnY8LNm7UBP20f+Cf2wMocR90EA@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc-utils: lsmmc: Simplify prinitng manufacturer name
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Sept 2023 at 12:02, Avri Altman <avri.altman@wdc.com> wrote:
>
> We used to have this odd way of printing the manufacturer name. To that
> end we cached the entire database beforehand which is completely
> useless.
>
> While at it, get rid of some more redundant code.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

I tried building this for arm64 but get the following errors/warnings:

lsmmc.c: In function =E2=80=98get_manufacturer=E2=80=99:
lsmmc.c:56:38: error: division =E2=80=98sizeof (struct ids_database *) /
sizeof (struct ids_database)=E2=80=99 does not compute the number of array
elements [-Werror=3Dsizeof-pointer-div]
   56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
      |                                      ^
lsmmc.c:287:25: note: in expansion of macro =E2=80=98ARRAY_SIZE=E2=80=99
  287 |  unsigned int ids_cnt =3D ARRAY_SIZE(db);
      |                         ^~~~~~~~~~
lsmmc.c:286:23: note: first =E2=80=98sizeof=E2=80=99 operand was declared h=
ere
  286 |  struct ids_database *db =3D config->bus =3D=3D MMC ? mmc_database =
:
sd_database;
      |                       ^~
cc1: all warnings being treated as errors
make: *** [Makefile:38: lsmmc.o] Error 1

Can you have a look?

Kind regards
Uffe

> ---
>  lsmmc.c | 150 ++++++++++++++------------------------------------------
>  1 file changed, 37 insertions(+), 113 deletions(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 85779bb..7e3165a 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -53,16 +53,19 @@
>  #define MASK(high, low)                (MASKTOBIT0(high) & ~MASKTOBIT0(l=
ow - 1))
>  #define BITS(value, high, low) (((value) & MASK((high), (low))) >> (low)=
)
>  #define IDS_MAX                        256
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +
> +enum bus_type {
> +       MMC =3D 1,
> +       SD,
> +};
>
>  struct config {
>         char *idsfile;
>         char *dir;
>         bool verbose;
> -       int interfaces;
> -       char **interface;
> -       char **mmc_ids;
> -       char **sd_ids;
>
> +       enum bus_type bus;
>         char *type;
>         char *cid;
>         char *csd;
> @@ -78,189 +81,157 @@ enum REG_TYPE {
>  };
>
>  struct ids_database {
> -       char *type;
>         int id;
>         char *manufacturer;
>  };
>
> -struct ids_database database[] =3D {
> +static struct ids_database sd_database[] =3D {
>         {
> -               .type =3D "sd",
>                 .id =3D 0x01,
>                 .manufacturer =3D "Panasonic",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x02,
>                 .manufacturer =3D "Toshiba/Kingston/Viking",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x03,
>                 .manufacturer =3D "SanDisk",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x08,
>                 .manufacturer =3D "Silicon Power",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x18,
>                 .manufacturer =3D "Infineon",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x1b,
>                 .manufacturer =3D "Transcend/Samsung",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x1c,
>                 .manufacturer =3D "Transcend",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x1d,
>                 .manufacturer =3D "Corsair/AData",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x1e,
>                 .manufacturer =3D "Transcend",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x1f,
>                 .manufacturer =3D "Kingston",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x27,
>                 .manufacturer =3D "Delkin/Phison",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x28,
>                 .manufacturer =3D "Lexar",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x30,
>                 .manufacturer =3D "SanDisk",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x31,
>                 .manufacturer =3D "Silicon Power",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x33,
>                 .manufacturer =3D "STMicroelectronics",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x41,
>                 .manufacturer =3D "Kingston",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x6f,
>                 .manufacturer =3D "STMicroelectronics",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x74,
>                 .manufacturer =3D "Transcend",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x76,
>                 .manufacturer =3D "Patriot",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x82,
>                 .manufacturer =3D "Gobe/Sony",
>         },
>         {
> -               .type =3D "sd",
>                 .id =3D 0x89,
>                 .manufacturer =3D "Unknown",
>         },
> +};
> +
> +static struct ids_database mmc_database[] =3D {
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x00,
>                 .manufacturer =3D "SanDisk",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x02,
>                 .manufacturer =3D "Kingston/SanDisk",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x03,
>                 .manufacturer =3D "Toshiba",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x05,
>                 .manufacturer =3D "Unknown",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x06,
>                 .manufacturer =3D "Unknown",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x11,
>                 .manufacturer =3D "Toshiba",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x13,
>                 .manufacturer =3D "Micron",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x15,
>                 .manufacturer =3D "Samsung/SanDisk/LG",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x37,
>                 .manufacturer =3D "KingMax",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x44,
>                 .manufacturer =3D "ATP",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x45,
>                 .manufacturer =3D "SanDisk Corporation",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x2c,
>                 .manufacturer =3D "Kingston",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0x70,
>                 .manufacturer =3D "Kingston",
>         },
>         {
> -               .type =3D "mmc",
>                 .id =3D 0xfe,
>                 .manufacturer =3D "Micron",
>         },
>  };
>
> +
>  /* Command line parsing functions */
>  void usage(void)
>  {
> @@ -310,47 +281,18 @@ int parse_opts(int argc, char **argv, struct config=
 *config)
>         return 0;
>  }
>
> -int parse_ids(struct config *config)
> +static char *get_manufacturer(struct config *config, unsigned int manid)
>  {
> -       unsigned int ids_cnt =3D sizeof(database) / sizeof(struct ids_dat=
abase);
> -       unsigned int value;
> -       char **ids;
> -       char *type;
> +       struct ids_database *db =3D config->bus =3D=3D MMC ? mmc_database=
 : sd_database;
> +       unsigned int ids_cnt =3D ARRAY_SIZE(db);
>         int i;
>
>         for (i =3D 0; i < ids_cnt; i++) {
> -               type =3D database[i].type;
> -
> -               if (!strcmp(type, "mmc")) {
> -                       ids =3D config->mmc_ids;
> -               } else if (!strcmp(type, "sd")) {
> -                       ids =3D config->sd_ids;
> -               } else {
> -                       fprintf(stderr,
> -                               "MMC/SD id parse error, unknown type: '%s=
'.\n",
> -                               type);
> -                       return -1;
> -               }
> -
> -               value =3D database[i].id;
> -
> -               if (value >=3D IDS_MAX) {
> -                       fprintf(stderr,
> -                               "MMC/SD id parse error, id out of range.\=
n");
> -                       return -1;
> -               }
> -
> -               if (ids[value]) {
> -                       fprintf(stderr,
> -                               "Duplicate entries: type=3D'%s', id=3D'0x=
%1x'.\n",
> -                               type, value);
> -                       return -1;
> -               }
> -
> -               ids[value] =3D database[i].manufacturer;
> +               if (db[i].id =3D=3D manid)
> +                       return db[i].manufacturer;
>         }
>
> -       return 0;
> +       return NULL;
>  }
>
>  /* MMC/SD file parsing functions */
> @@ -538,6 +480,7 @@ void print_sd_cid(struct config *config, char *cid)
>         unsigned int mdt_month;
>         unsigned int mdt_year;
>         unsigned int crc;
> +       char *manufacturer =3D NULL;
>
>         parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
>                 &mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn,
> @@ -546,12 +489,14 @@ void print_sd_cid(struct config *config, char *cid)
>         oid[2] =3D '\0';
>         pnm[5] =3D '\0';
>
> +       manufacturer =3D get_manufacturer(config, mid);
> +
>         if (config->verbose) {
>                 printf("=3D=3D=3D=3D=3D=3DSD/CID=3D=3D=3D=3D=3D=3D\n");
>
>                 printf("\tMID: 0x%02x (", mid);
> -               if (config->sd_ids[mid])
> -                       printf("%s)\n", config->sd_ids[mid]);
> +               if (manufacturer)
> +                       printf("%s)\n", manufacturer);
>                 else
>                         printf("Unlisted)\n");
>
> @@ -564,9 +509,9 @@ void print_sd_cid(struct config *config, char *cid)
>                        2000 + mdt_year, months[mdt_month]);
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
> -               if (config->sd_ids[mid])
> +               if (manufacturer)
>                         printf("manufacturer: '%s' '%s'\n",
> -                              config->sd_ids[mid], oid);
> +                              manufacturer, oid);
>                 else
>                         printf("manufacturer: 'Unlisted' '%s'\n", oid);
>
> @@ -594,6 +539,7 @@ void print_mmc_cid(struct config *config, char *cid)
>         unsigned int mdt_month;
>         unsigned int mdt_year;
>         unsigned int crc;
> +       char *manufacturer =3D NULL;
>
>         parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
>                 &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
> @@ -601,12 +547,14 @@ void print_mmc_cid(struct config *config, char *cid=
)
>
>         pnm[6] =3D '\0';
>
> +       manufacturer =3D get_manufacturer(config, mid);
> +
>         if (config->verbose) {
>                 printf("=3D=3D=3D=3D=3D=3DMMC/CID=3D=3D=3D=3D=3D=3D\n");
>
>                 printf("\tMID: 0x%02x (", mid);
> -               if (config->mmc_ids[mid])
> -                       printf("%s)\n", config->mmc_ids[mid]);
> +               if (manufacturer)
> +                       printf("%s)\n", manufacturer);
>                 else
>                         printf("Unlisted)\n");
>
> @@ -635,9 +583,9 @@ void print_mmc_cid(struct config *config, char *cid)
>                        1997 + mdt_year, months[mdt_month]);
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
> -               if (config->mmc_ids[mid])
> +               if (manufacturer)
>                         printf("manufacturer: 0x%02x (%s) oid: 0x%01x\n",
> -                              mid, config->mmc_ids[mid], oid);
> +                              mid, manufacturer, oid);
>                 else
>                         printf("manufacturer: 0x%02x (Unlisted) oid: 0x%0=
1x\n", mid, oid);
>
> @@ -2308,6 +2256,8 @@ int process_dir(struct config *config, enum REG_TYP=
E reg)
>                 goto err;
>         }
>
> +       config->bus =3D strcmp(type, "MMC") ? SD : MMC;
> +
>         switch (reg) {
>         case CID:
>                 cid =3D read_file("cid");
> @@ -2369,45 +2319,19 @@ err:
>         return ret;
>  }
>
> -int lsmmc_main(struct config *config, int argc, char **argv)
> -{
> -       int ret;
> -
> -       config->mmc_ids =3D calloc(IDS_MAX, sizeof(char *));
> -       config->sd_ids =3D calloc(IDS_MAX, sizeof(char *));
> -       if (!config->mmc_ids || !config->sd_ids) {
> -               fprintf(stderr, "Could not allocate memory for lsmmc.\n")=
;
> -               return -1;
> -       }
> -
> -       ret =3D parse_opts(argc, argv, config);
> -       if (ret)
> -               return ret;
> -
> -       return parse_ids(config);
> -}
> -
> -void lsmmc_free(struct config *config)
> -{
> -       free(config->mmc_ids);
> -       free(config->sd_ids);
> -       free(config->dir);
> -}
> -
>  static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
>  {
>         struct config cfg =3D {};
>         int ret;
>
> -       ret =3D lsmmc_main(&cfg, argc, argv);
> +       ret =3D parse_opts(argc, argv, &cfg);
>         if (ret)
> -               goto out;
> +               return ret;
>
>         if (cfg.dir)
>                 ret =3D process_dir(&cfg, reg);
>
> -out:
> -       lsmmc_free(&cfg);
> +       free(cfg.dir);
>
>         return ret;
>
> --
> 2.42.0
>
