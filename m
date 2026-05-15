Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A83FBB55
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861918; cv=pass; b=KV3YCrgQxUKj7jgnuVsLnr/DasQoiIl3AjRPVjMKXe1Kdw3kfT4DG3kZ6zmAdiIL8BbPWymW9qbjQkQcLd+9P2EUV0xfxgEhFnS8xry8Z2JyXU6smIFRtVMsa9FGmoP9uaH5KzvwCuC+1hHvFNKkQksi/FJQAB0J26BwMHAwAJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861918; c=relaxed/simple;
	bh=WGIgwtun/3S0dYD5X5UBlqpRrDTGUmrE12CG5HeU/HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdEaURQVKK8R0zP0GVgfBOHuS81I8aOZ6gCfbRYZGTu7HkTRvbFUcB7Y4Xa28qFMBgomKgy8vwLPCSe3i+eHFBqcrrHlU50k1rqsWgJDV1Ep4Q1h763RW7HHK5jyRjSiq+PxTkdC1vVlxlIwWREFlDMnBvwV075m/V4+phJ42qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akfO9GFN; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akfO9GFN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70c112cb61so7366021a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 09:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778861916; cv=none;
        d=google.com; s=arc-20240605;
        b=jEP+t+YRjUN/df//urfE4wtNHNjsWWGUQHsLJ64RcDH1CWFDInPVXsf29zP/WLjsoJ
         bbvOagIY8whndTahDcXV6zhcTqDZ1LiVw7I3Ni6mX6CbFuAYevEwohfYymxDRe3UrFzf
         xde6I/QoZclNgFvSsHH/lsM9CNQC9QH5hHMjfnOl3wddvqb3DfQzzRvVgGEBrKbuV1cm
         Oi32pDmCqMDGNSmSEXtFYgfWQNGnxw1MTSsZrlWq9jxsRNWBBIx/Fmnjuw7Pjcm9B9ON
         QFDAWNQ+d2V3IQ5rEMizvsaqASfkn1AttxPFnmeBuO6jhbbyZIbXcAId2mXlWfpU6hXP
         A75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kb+u+1qC+iLC/vS9K9mWzHoFu1rU0Plu+0Xk4YTKfXY=;
        fh=Xn5gGOD0wfvxR3QQnaA7YlzIeHMppEapma8laY3ceNU=;
        b=JbK99GkCP5MmnaJepbwLen4MUVUmwxj2jfNgWgCjZi0YkSIGx6fsADDB4FCwScvXXp
         1SOiGs27xl+nugRiMwSZySI3w5sjDNa8IdWMKzH9jW/nBct6Sh+qYWS9qCadysZLzVxd
         h5Ce/KKETiZhiKn7H5jdvIrl2jgCcoFuks/fJsOEA3cMV9gswqbU2IOUr/LhiuMyVrAn
         uSqVEh3/yT0HUMbbF4+EVRIY/xr9SG9vcKcuUx543QYP8xJHDewCP0HBhq5oWzTZnmp5
         D2nFJNCtNhRFKVRX/YqcmUOfl3V9UwT7NG/h3cj57xQD+XFV89HCKy8C0mGK4vgHgZVn
         Wtuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861916; x=1779466716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kb+u+1qC+iLC/vS9K9mWzHoFu1rU0Plu+0Xk4YTKfXY=;
        b=akfO9GFNSrihLuGskixaqBKWJ7HtdANK21ONk1EVuvfR/ZHWar5jdP2ydH5tOaHFk6
         LBs1L2KWKSYxM4+WTjG6YLHk2OXOK5svJVU14JrUZp1mhHZTNbfsfdN9toszfTf2RXTJ
         1VRKfWjZfs6XteBJsVJiegVieWEhk0/k/WeA3LUmFm3+jPYHYVOCMrhqC0SXdgVXbKDj
         1nWSGl8S02j4iv9wyiNjDXC1Dyb1wyg0nj2Cx/EvLVFYwvKMoLoL1q64W/T/ah4ToJth
         HuIHO5IMsPCPM9aYzwUQa5Mo/+qBcRr4J6JY6XSLyVCF2s4gLr2NFWLY3QzEhnVwP0Wm
         +6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861916; x=1779466716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb+u+1qC+iLC/vS9K9mWzHoFu1rU0Plu+0Xk4YTKfXY=;
        b=mWmgK83BwNg4SLu3iTBEwE2Yd8/Dp52sX/029W2ga7TATGxENcL8lElqYWzP2xRRAf
         MKRxaNuPdheiZ0TZ5eUy+2rmSg8c/nwfMB79eJ05n3oGuCyYUKIhUCReO+n+CY5BWLmD
         0xwLBNTorajecxkGhaSJ+wGLE/Fs4QcFYmlxtgaaT0iEepwFJDUc09T7OSqGkemn8TCv
         ra1CPgcrCK7Daxt/f1wuGR0ikjGSJ3MNSf4OUixCSA/jqkjN2p2vMGXIk+1ogW48ekVK
         wc7ZNzMdzwiSv1hKra+lA80xu/89GHZmNeo8GqPvu/MAPTD88SWVNyVCrVRL7NuF7RGa
         DpcA==
X-Gm-Message-State: AOJu0YwzY/tEL8sIl7QeIcmpRlWfWPuMsdzFutDQmKV21Pob5QPYTMUs
	LIcihyiCc6rWkOFAuGsYt8tvhqBIgPE3ALPpsKowekgmyPSwOOEiTdvCtbXqpec+ARCvdM1EIDf
	MaQf/NI3z76mKflJAo8K3Xfij3+Yg3ek=
X-Gm-Gg: Acq92OHeQ80LfHIlTrG/bjBaYmvSezUqi79V7CPEjpm6EvFSo27qC0/4H80S7XiC142
	ptVOut2KIK1gKs9C5KfsP8llOdEiJx84Ja9jRzpUGgKqrNalnDuXzg2MIL80RjD7ZnVN+ehxWEK
	pftsDlhee4ePSaP0nwp1oUC3lMaK3jvr9EJddk4rq1li1A/qhFBuGdauZtHBjqEVhzpo8O5jkZy
	sQUQtX1+z75lDR0K1AaxKKm6ftSYxW+slTDrwcazrxnInJ3Nn57/snYt9FLyTh/7yM+sXBYFKyN
	TfvR/75KY39HitzGBkhWlJf4FUy0wnvoaNborw==
X-Received: by 2002:a05:6a20:3d94:b0:39f:5671:921 with SMTP id
 adf61e73a8af0-3b22e67feadmr5380851637.3.1778861915962; Fri, 15 May 2026
 09:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <20260515083457.3690804-2-torsteine+linux@gmail.com> <DS1PR16MB675328EBEAC3FDCB8DCA599EE5042@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB675328EBEAC3FDCB8DCA599EE5042@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Torstein Eide <torsteine@gmail.com>
Date: Fri, 15 May 2026 18:18:23 +0200
X-Gm-Features: AVHnY4KaUNyuH7JjCM3ERR9V7JQQwz3Km1vOY9zk2wznQrXnViIKU0BadiyAw1g
Message-ID: <CAL5DHTEM2=Jm1F9_qvFfJ5+Cine=3wKZmw8hKyfoig_PCKDHpg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc-utils: lsmmc: Use external .ids files for
 manufacturer lookup
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide <torsteine+linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

fre. 15. mai 2026 kl. 17:05 skrev Avri Altman <Avri.Altman@sandisk.com>:
>
> > Similar to pci.ids and usb.ids, move the statically defined manufacturer ID arrays
> > out of the source and into external sdcard.ids and multimediacard.ids files. This
> > allows other programs to use the same database without an API, ABI, or cmd
> > interface.
> >
> > Make the program able to read from the base directory to test without installing.
> >
> > Make it possible from the Makefile to change the install directory of the
> > database.
> >
> > Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> > ---
> >  Makefile           |   8 +-
> >  lsmmc.c            | 225 ++++++++++++---------------------------------
> >  multimediacard.ids |  16 ++++
> >  sdcard.ids         |  23 +++++
> >  4 files changed, 104 insertions(+), 168 deletions(-)  create mode 100644
> > multimediacard.ids  create mode 100644 sdcard.ids
> >
> > diff --git a/Makefile b/Makefile
> > index c0284bb..11685b9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1,7 +1,9 @@
> >  CC ?= gcc
> >  GIT_VERSION := "$(shell git describe --abbrev=6 --always --tags)"
> >  AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
> > -           -DVERSION=\"$(GIT_VERSION)\"
> > +           -DVERSION=\"$(GIT_VERSION)\" \
> > +           -DSD_IDS_PATH=\"$(idsdir)/sdcard.ids\" \
> > +           -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\"
> >  CFLAGS ?= -g -O2
> >  objects = \
> >         mmc.o \
> > @@ -19,6 +21,7 @@ override CFLAGS := $(CHECKFLAGS) $(AM_CFLAGS)
> > $(CFLAGS)  INSTALL = install  prefix ?= /usr/local  bindir = $(prefix)/bin
> > +idsdir ?= /usr/share/misc
> >  LIBS=
> >  RESTORE_LIBS=
> >  mandir = /usr/share/man
> > @@ -55,6 +58,9 @@ install: $(progs)
> >         $(INSTALL) $(progs) $(DESTDIR)$(bindir)
> >         $(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
> >         $(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
> > +       $(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
> > +       $(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
> > +       $(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
> >
> >  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
> >
> > diff --git a/lsmmc.c b/lsmmc.c
> > index 799e1ea..113f371 100644
> > --- a/lsmmc.c
> > +++ b/lsmmc.c
> > @@ -56,6 +56,13 @@
> >  #define IDS_MAX                        256
> >  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> >
> > +#ifndef SD_IDS_PATH
> > +#define SD_IDS_PATH "/usr/share/misc/sdcard.ids"
> > +#endif
> > +#ifndef MMC_IDS_PATH
> > +#define MMC_IDS_PATH "/usr/share/misc/multimediacard.ids"
> > +#endif
> > +
> >  enum bus_type {
> >         MMC = 1,
> >         SD,
> > @@ -63,6 +70,7 @@ enum bus_type {
> >
> >  struct config {
> >         char *dir;
> > +       char *ids_dir;
> >         bool verbose;
> >
> >         enum bus_type bus;
> > @@ -75,157 +83,6 @@ enum REG_TYPE {
> >         SCR,
> >  };
> >
> > -struct ids_database {
> > -       int id;
> > -       char *manufacturer;
> > -};
> > -
> > -static struct ids_database sd_database[] = {
> > -       {
> > -               .id = 0x01,
> > -               .manufacturer = "Panasonic",
> > -       },
> > -       {
> > -               .id = 0x02,
> > -               .manufacturer = "Toshiba/Kingston/Viking",
> > -       },
> > -       {
> > -               .id = 0x03,
> > -               .manufacturer = "SanDisk",
> > -       },
> > -       {
> > -               .id = 0x08,
> > -               .manufacturer = "Silicon Power",
> > -       },
> > -       {
> > -               .id = 0x18,
> > -               .manufacturer = "Infineon",
> > -       },
> > -       {
> > -               .id = 0x1b,
> > -               .manufacturer = "Transcend/Samsung",
> > -       },
> > -       {
> > -               .id = 0x1c,
> > -               .manufacturer = "Transcend",
> > -       },
> > -       {
> > -               .id = 0x1d,
> > -               .manufacturer = "Corsair/AData",
> > -       },
> > -       {
> > -               .id = 0x1e,
> > -               .manufacturer = "Transcend",
> > -       },
> > -       {
> > -               .id = 0x1f,
> > -               .manufacturer = "Kingston",
> > -       },
> > -       {
> > -               .id = 0x27,
> > -               .manufacturer = "Delkin/Phison",
> > -       },
> > -       {
> > -               .id = 0x28,
> > -               .manufacturer = "Lexar",
> > -       },
> > -       {
> > -               .id = 0x30,
> > -               .manufacturer = "SanDisk",
> > -       },
> > -       {
> > -               .id = 0x31,
> > -               .manufacturer = "Silicon Power",
> > -       },
> > -       {
> > -               .id = 0x33,
> > -               .manufacturer = "STMicroelectronics",
> > -       },
> > -       {
> > -               .id = 0x41,
> > -               .manufacturer = "Kingston",
> > -       },
> > -       {
> > -               .id = 0x6f,
> > -               .manufacturer = "STMicroelectronics",
> > -       },
> > -       {
> > -               .id = 0x74,
> > -               .manufacturer = "Transcend",
> > -       },
> > -       {
> > -               .id = 0x76,
> > -               .manufacturer = "Patriot",
> > -       },
> > -       {
> > -               .id = 0x82,
> > -               .manufacturer = "Gobe/Sony",
> > -       },
> > -       {
> > -               .id = 0x89,
> > -               .manufacturer = "Unknown",
> > -       },
> > -};
> > -
> > -static struct ids_database mmc_database[] = {
> > -       {
> > -               .id = 0x00,
> > -               .manufacturer = "SanDisk",
> > -       },
> > -       {
> > -               .id = 0x02,
> > -               .manufacturer = "Kingston/SanDisk",
> > -       },
> > -       {
> > -               .id = 0x03,
> > -               .manufacturer = "Toshiba",
> > -       },
> > -       {
> > -               .id = 0x05,
> > -               .manufacturer = "Unknown",
> > -       },
> > -       {
> > -               .id = 0x06,
> > -               .manufacturer = "Unknown",
> > -       },
> > -       {
> > -               .id = 0x11,
> > -               .manufacturer = "Toshiba",
> > -       },
> > -       {
> > -               .id = 0x13,
> > -               .manufacturer = "Micron",
> > -       },
> > -       {
> > -               .id = 0x15,
> > -               .manufacturer = "Samsung/SanDisk/LG",
> > -       },
> > -       {
> > -               .id = 0x37,
> > -               .manufacturer = "KingMax",
> > -       },
> > -       {
> > -               .id = 0x44,
> > -               .manufacturer = "ATP",
> > -       },
> > -       {
> > -               .id = 0x45,
> > -               .manufacturer = "SanDisk Corporation",
> > -       },
> > -       {
> > -               .id = 0x2c,
> > -               .manufacturer = "Kingston",
> > -       },
> > -       {
> > -               .id = 0x70,
> > -               .manufacturer = "Kingston",
> > -       },
> > -       {
> > -               .id = 0xfe,
> > -               .manufacturer = "Micron",
> > -       },
> > -};
> > -
> >  /* Command line parsing functions */
> >  static void usage(char *progname)
> >  {
> > @@ -319,25 +176,53 @@ static int parse_opts(int argc, char **argv, struct config
> > *config)
> >         return 0;
> >  }
> >
> > -static char *get_manufacturer(struct config *config, unsigned int manid)
> > +static const char *get_manufacturer(struct config *config, unsigned int
> > +manid)
> >  {
> > -       struct ids_database *db;
> > -       unsigned int ids_cnt;
> > +       const char *paths[] = {NULL, NULL};
> > +       char local_path[PATH_MAX];
> >         int i;
> > +       FILE *f;
> > +       static char name[256];
> I guess you are preparing here to iterate over several devices.
> The static buffer will work here only if the result is printed before the next call.
> Maybe use strdup() instead?
>

Good catch will repalce it.

> > +       char line[256];
> > +       const char *local_name;
> > +
> > +       local_name = (config->bus == MMC) ? "multimediacard.ids" : "sdcard.ids";
> > +       /* check local directory first, then fall back to system path */
> > +       if (config->ids_dir)
> > +               snprintf(local_path, sizeof(local_path), "%s/%s", config->ids_dir,
> > local_name);
> > +       else
> > +               snprintf(local_path, sizeof(local_path), "%s", local_name);
> > +       paths[0] = local_path;
> > +       paths[1] = (config->bus == MMC) ? MMC_IDS_PATH : SD_IDS_PATH;
> >
> > -       if (config->bus == MMC) {
> > -               db = mmc_database;
> > -               ids_cnt = ARRAY_SIZE(mmc_database);
> > -       } else {
> > -               db = sd_database;
> > -               ids_cnt = ARRAY_SIZE(sd_database);
> > +       for (i = 0; i < 2; i++) {
> > +               f = fopen(paths[i], "r");
> Maybe just:
> f = fopen(local_path, "r");
> if (!f)
>      f = fopen(system_path, "r");
>
> > +               if (f)
> > +                       break;
> >         }
> > +       if (!f)
> > +               return NULL;
> A warning that the ids files are missing?
>

I agree, i will also add a flag to check that we printer a error.

> >
> > -       for (i = 0; i < ids_cnt; i++) {
> > -               if (db[i].id == manid)
> > -                       return db[i].manufacturer;
> > +       while (fgets(line, sizeof(line), f)) {
> > +               unsigned int id;
> > +               char *nl;
> > +
> > +               nl = strchr(line, '\n');
> > +               if (nl)
> > +                       *nl = '\0';
> > +
> > +               if (line[0] == '#' || line[0] == '\0')
> > +                       continue;
> > +
> > +               if (sscanf(line, "0x%x %255[^\n]", &id, name) == 2) {
> > +                       if (id == manid) {
> > +                               fclose(f);
> > +                               return name;
> > +                       }
> > +               }
> >         }
> >
> > +       fclose(f);
> >         return NULL;
> >  }
> >
> > @@ -526,7 +411,7 @@ static void print_sd_cid(struct config *config, char *cid)
> >         unsigned int mdt_month;
> >         unsigned int mdt_year;
> >         unsigned int crc;
> > -       char *manufacturer = NULL;
> > +       const char *manufacturer = NULL;
> >
> >         parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
> >                 &mid, &oid[0], &pnm[0], &prv_major, &prv_minor, &psn, @@ -585,7
> > +470,7 @@ static void print_mmc_cid(struct config *config, char *cid)
> >         unsigned int mdt_month;
> >         unsigned int mdt_year;
> >         unsigned int crc;
> > -       char *manufacturer = NULL;
> > +       const char *manufacturer = NULL;
> >
> >         parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
> >                 &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn, @@ -
> > 2220,11 +2105,14 @@ static int process_dir(struct config *config, enum
> > REG_TYPE reg)
> >         char *type = NULL;
> >         int ret = 0;
> >
> > +       config->ids_dir = getcwd(NULL, 0);
> I think it's an opportunity to replace the `chdir()`/`getcwd()` pattern with reading via full paths (e.g., a `read_file_at(dir, name)` helper)?
> That would eliminate the need for `ids_dir` entirely - `get_manufacturer()` could just open the `.ids` files directly since the working directory wouldn't change.
> Your code is fine, if you decided to do that, it should be a cleanup first patch.
>
> Thanks,
> Avri

I agree the chdir is unnecessary.

I will make a V2 patch.

>
> > +
> >         if (chdir(config->dir) < 0) {
> >                 fprintf(stderr,
> >                         "MMC/SD information directory '%s' does not exist.\n",
> >                         config->dir);
> > -               return -1;
> > +               ret = -1;
> > +               goto err;
> >         }
> >
> >         type = read_file("type");
> > @@ -2232,7 +2120,8 @@ static int process_dir(struct config *config, enum
> > REG_TYPE reg)
> >                 fprintf(stderr,
> >                         "Could not read card interface type in directory '%s'.\n",
> >                         config->dir);
> > -               return -1;
> > +               ret = -1;
> > +               goto err;
> >         }
> >
> >         if (strcmp(type, "MMC") && strcmp(type, "SD")) { @@ -2247,6 +2136,8 @@
> > static int process_dir(struct config *config, enum REG_TYPE reg)
> >
> >  err:
> >         free(type);
> > +       free(config->ids_dir);
> > +       config->ids_dir = NULL;
> >
> >         return ret;
> >  }
> > diff --git a/multimediacard.ids b/multimediacard.ids new file mode 100644 index
> > 0000000..0c91118
> > --- /dev/null
> > +++ b/multimediacard.ids
> > @@ -0,0 +1,16 @@
> > +# MMC manufacturer IDs
> > +# This file is maintained at:
> > +https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
> > +0x00 SanDisk
> > +0x02 Kingston/SanDisk
> > +0x03 Toshiba
> > +0x05 Unknown
> > +0x06 Unknown
> > +0x11 Toshiba
> > +0x13 Micron
> > +0x15 Samsung/SanDisk/LG
> > +0x37 KingMax
> > +0x44 ATP
> > +0x45 SanDisk Corporation
> > +0x2c Kingston
> > +0x70 Kingston
> > +0xfe Micron
> > diff --git a/sdcard.ids b/sdcard.ids
> > new file mode 100644
> > index 0000000..cbddcae
> > --- /dev/null
> > +++ b/sdcard.ids
> > @@ -0,0 +1,23 @@
> > +# SD card (secure digital) manufacturer IDs # This file is maintained
> > +at: https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
> > +0x01 Panasonic
> > +0x02 Toshiba/Kingston/Viking
> > +0x03 SanDisk
> > +0x08 Silicon Power
> > +0x18 Infineon
> > +0x1b Transcend/Samsung
> > +0x1c Transcend
> > +0x1d Corsair/AData
> > +0x1e Transcend
> > +0x1f Kingston
> > +0x27 Delkin/Phison
> > +0x28 Lexar
> > +0x30 SanDisk
> > +0x31 Silicon Power
> > +0x33 STMicroelectronics
> > +0x41 Kingston
> > +0x6f STMicroelectronics
> > +0x74 Transcend
> > +0x76 Patriot
> > +0x82 Gobe/Sony
> > +0x89 Unknown
> > --
> > 2.53.0
> >
>
