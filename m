Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C12BEC43
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778998849; cv=pass; b=Tcn5PJ40A6DwpXt0wqjfJG4YvMj4CRpOzsbZCy5JAQmy4oN+oiWik2vIE10Biz4jXhxsvjk5aeYiK/4cF+AUIoQrWmwhpWmwQrQGtVXvOQPUu6vRC0JLwsP3Q5RiJeuIw/rFgql5A1XBBEQVVmuLm3p7+pe48QNXebAJOyI1yok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778998849; c=relaxed/simple;
	bh=aBiFT4aT8Po2JG+LuO8EDEl8qzfk1tCZU2K7gvIQGRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjVhCmqpT5m3qK06CXreXeFYhiMyT6rZ7AxOKLpcfkVNq3pLfWVaDngtrlIOMxmiaawPqZYQVuNK68WzrvJaW9xQ1cf66wi9I2ldPKaKxpV5h/KoA9ApZuU7ClOM14kNHpBZdLsNCjX1uaHQ9LBO0LCUfX2xQRu70I8HssHqWRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SENcLA+9; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SENcLA+9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba4a1a0325so8529915ad.0
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2026 23:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778998847; cv=none;
        d=google.com; s=arc-20240605;
        b=LHU/XR9129UsyUcERS/TesO2aK3fHBmwvXZQw1RSf+RrjnA/6suVYHy5A2FICgGxZs
         xyenmzNkRccW9/V7+YEcBB8Xl1sfm8kNQz3LySE86Li4khNLXslOyqW5VuNqBzbI3LtA
         nlSZkeJtGUklwkIK8DwGPh18rVL1KT0gPL4v+PbnhboWa7c/RJtvGE572k7C7J3NH7hm
         Bag4Fjp7UpFmndROR82ezih5UxcksD5sYydPzVpTcwOMcLL2lC5Dkv/O9bb53IVFEnuE
         5eiyc60QRqs100sMWKUhs2AV8rJ1YOeEI3QdedPlRiIOwCB6/JxU9DaIVbtegXWbWjBl
         ytxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SFjniKEdZfr82cZh69E1YrGsbub+4FdiKDs5AV9RsVk=;
        fh=Xn5gGOD0wfvxR3QQnaA7YlzIeHMppEapma8laY3ceNU=;
        b=Um1U0H6SisqI2H4re6BgCJdO6G3QmIMewlqj5AVC1QWnQaQXWbcsZpfrADpy4lQG5/
         Tgbp0uEMHVmzv8od7ljPZsuyUx3jcgVrLymOLpBWcUIA8NpdEjIUMcVOrChf79UPXz//
         KJD4kNLoy1l1BKRDC3FV78xtJIP8KlheLjboS7x8e5UcbJPplIwLUBWisOJEsFTlIiIv
         h1yhY892uhrLTg/hISmrl7gxz3ITRVFsuf+yfqfQ5AgPn8yB7V4DiiwuQDvgEkgrGbRX
         3cF6kT4rf5MzxLMA6tmk/vsYhF2GEwi9QthUYTGveUkI3SYb2R2jCfqL5ntzjdKvnNl7
         1F9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778998847; x=1779603647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFjniKEdZfr82cZh69E1YrGsbub+4FdiKDs5AV9RsVk=;
        b=SENcLA+9W4DGGB6dhnHYZuZIFx6+1r6hAmf3rOBsT5TnPUi8zXJCKrRUKYvEOkedCh
         +u0kHl7ajaMWWHJ+xeB0bLZIsvcEsGLtQdjt7Fa8hJYgphBl2LmfEq40kv4t9CGZG9Jb
         s9iz9VYiujVYCGzquunnFbcgwYj8cnGYdMbuiUYwNiEhg9DNkcJsFXD6H5J2eJeE9miz
         jypl3yET6EtVrE4LTloYq9XCxplruXZ3VwqTJeK/G50mkaptnEO2ZTn6jb7QDdqRbmIL
         eL0hC2UkHxB97YyBocuXtx69+jHPROHmbBAjNAQCEKse9FTEvoQ65B6L/hOzbUu9BCyA
         MyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778998847; x=1779603647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFjniKEdZfr82cZh69E1YrGsbub+4FdiKDs5AV9RsVk=;
        b=hoSsgS/4VJSa3qcWq+GUA8WP9MYR858FXbOWm9GuL7Cw/5F935fN4TkKQj2UiNsKit
         4iysuNizMzfGLV9XM5iGr8Ra+AaYXgBogCDhVc6lwJoUi4lVAAQd96l44I1GIdxLYXgR
         nYCfeGh0R8b/8vCs5/S4JScNa3TnFeOyTSznfFH1IGeguHmDfDZVH+gi1VbrDLuhCJev
         fVE2nid9N+cTU6Z5pvyB6E2cbSnPAU6Uw5DqcFOOBq41nAXyP813vPEOtp22bX0bNZYB
         Ofv36T0CwnSUNUhVpM5uuhkcUDP6QOAGCfzSbJyBE3fW2bHtUliAlxxvMYT9iw02f6IL
         aZEA==
X-Gm-Message-State: AOJu0Yz8Z+2hyojsYkYLnx4eoP8kjyi7k4UFYaHfRE1/lwjbaBDx503y
	60rx6qCqjOzqNGGgNOsp4JDadEMl/kDHUGCnxRClWAXmNkjsI6to0U+Y6+s+GjCgb2sYwvAIec4
	f6HcHuNG7sHjdFEVRJ7l0X5eLhTKBILU=
X-Gm-Gg: Acq92OFo8tAZ4WAs7QDawiqMcZqcSBWhtLM18dbZMqZ4e3lEBfODlt/iamcGGw5e2Hu
	6giuk+ez6JWHsFl9giuDQAUuZRmKOmmktfDVhZGGryk5UixZAOpRZbaro28iv1wAXQqAuoGzXtj
	czLs1v7XGujPscbBRf1T2QjR8f/PaHYvjOPH/ktun8HX29PxxDGJ0tKWOpp/+2nQE5nYhwhVCE4
	VpXn4uZjKhCYSsSDf7i6VHTJzwZ8Y1T5fq3R6UkFBxmE20aXchHypuSfRJeQIKcaUTxl9JuZ+Nc
	LDoZSYNObzBUNIcmnTSE6Em0ZMJSCh+K+o1koq9hCOT9LwTDYw==
X-Received: by 2002:a17:902:db06:b0:2b7:aba0:ac10 with SMTP id
 d9443c01a7336-2bd7e7bdd1cmr111666135ad.11.1778998847340; Sat, 16 May 2026
 23:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-5-torsteine+linux@gmail.com> <DS1PR16MB67538B5E159FD215CF4E9598E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
 <DS1PR16MB675371AD8EDF1E70DE5070E4E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB675371AD8EDF1E70DE5070E4E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Torstein Eide <torsteine@gmail.com>
Date: Sun, 17 May 2026 08:20:34 +0200
X-Gm-Features: AVHnY4IdbhU_9Oec2tBKLtMh-KHir1kEr7mTzdalcfszUeINV694G-lcEO3CrLM
Message-ID: <CAL5DHTGkRe108Ft1_0p98tmv5Mr3_pJFmijcoOEE9EYcCjHioQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mmc-utils: lsmmc: Add mmc list command
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide <torsteine+linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I included it in patch1 ill move to patch4.

s=C3=B8n. 17. mai 2026 kl. 08:07 skrev Avri Altman <Avri.Altman@sandisk.com=
>:
>
> > > Add a 'mmc list' command that scans /sys/bus/mmc/devices/, resolves
> > > each card's sysfs path, and prints a one-line summary per device.
> > >
> > > find_block_devname() maps a sysfs device path back to its mmcblkN nam=
e
> > > by scanning /sys/class/block/mmcblkN/device symlinks.
> > >
> > > print_list_entry() parses the CID register and formats a fixed-width
> > > table row with device name, /dev path, bus type, manufacturer,
> > > product, revision, serial number, and manufacturing date.
> > >
> > > The header is printed once before the first result. Devices without a
> > > readable cid file are skipped silently via access() so unrelated sysf=
s
> > > entries do not produce spurious error messages.
> > >
> > > Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> > > ---
> > >  docs/HOWTO.rst | 12 ++++++++++++
> > >  lsmmc.c        | 34 +++++++++++++++++++++++++++++++++-
> > >  mmc.c          |  6 +++++-
> >
> > Looks like you are missing the do_list body in mmc_cmds.c ?
> Or in lsmmc.c.  Either way it is missing.
>
> Thanks,
> Avri
>
> >
> > Thanks,
> > Avri
> >
> > >  mmc_cmds.h     |  1 +
> > >  4 files changed, 51 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 76214a3..167a153
> > > 100644
> > > --- a/docs/HOWTO.rst
> > > +++ b/docs/HOWTO.rst
> > > @@ -90,6 +90,18 @@ Running mmc-utils
> > >              sysfs:
> > > /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
> > >              SCR Register: 0235800000000000
> > >
> > > +    ``list``
> > > +        List all MMC/SD devices present on the system. Output is a t=
able with
> > > +        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or =
SD),
> > > +        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
> > > +
> > > +        Example::
> > > +
> > > +            $ mmc list
> > > +            DEVICE          DEV            TYPE  MANUFACTURER       =
  PRODUCT    REV
> > > SERIAL      DATE
> > > +            mmc0:0001       /dev/mmcblk0   MMC   Samsung            =
  MAG4FA     1.0
> > > 0x1a2b3c4d  2021-jan
> > > +            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk            =
  SP32G      8.0
> > > 0x5e6f7a8b  2020-mar
> > > +
> > >      ``ffu <image name> <device> [chunk-bytes]``
> > >        Default mode.  Run Field Firmware Update with `<image name>` o=
n
> > > `<device>`. `[chunk-bytes]` is optional and defaults to its max -
> > > 512k. Should be in decimal bytes and sector aligned.
> > >
> > > diff --git a/lsmmc.c b/lsmmc.c
> > > index 58d4609..0458d1b 100644
> > > --- a/lsmmc.c
> > > +++ b/lsmmc.c
> > > @@ -225,6 +225,39 @@ static char *get_manufacturer(struct config
> > > *config, unsigned int manid)
> > >         return NULL;
> > >  }
> > >
> > > +static char *find_block_devname(const char *sysfs_devpath) {
> > > +       DIR *d;
> > > +       struct dirent *ent;
> > > +
> > > +       d =3D opendir("/sys/class/block");
> > > +       if (!d)
> > > +               return NULL;
> > > +
> > > +       while ((ent =3D readdir(d)) !=3D NULL) {
> > > +               char linkpath[PATH_MAX];
> > > +               char resolved[PATH_MAX];
> > > +
> > > +               if (strncmp(ent->d_name, "mmcblk", 6) !=3D 0)
> > > +                       continue;
> > > +               if (strchr(ent->d_name + 6, 'p'))
> > > +                       continue;
> > > +
> > > +               snprintf(linkpath, sizeof(linkpath),
> > > +                        "/sys/class/block/%s/device", ent->d_name);
> > > +               if (realpath(linkpath, resolved) =3D=3D NULL)
> > > +                       continue;
> > > +               if (strcmp(resolved, sysfs_devpath) =3D=3D 0) {
> > > +                       closedir(d);
> > > +                       return strdup(ent->d_name);
> > > +               }
> > > +       }
> > > +
> > > +       closedir(d);
> > > +       return NULL;
> > > +}
> > > +
> > > +
> > >  /* MMC/SD file parsing functions */
> > >  static char *read_file_at(const char *dir, const char *name)  { @@
> > > -2335,7
> > > +2368,6 @@ int do_list(int nargs, char **argv)
> > >         return 0;
> > >  }
> > >
> > > -
> > >  int do_read_csd(int argc, char **argv)  {
> > >         return do_read_reg(argc, argv, CSD); diff --git a/mmc.c
> > > b/mmc.c index
> > > 077e901..01ad181 100644
> > > --- a/mmc.c
> > > +++ b/mmc.c
> > > @@ -292,6 +292,11 @@ static struct Command commands[] =3D {
> > >           "4. The MMC will perform a soft reset, if your system canno=
t
> > > handle that do not use the boot operation from mmc-utils.\n",
> > >           NULL
> > >         },
> > > +       { do_list, 0,
> > > +         "list", "\n"
> > > +               "List all MMC/SD devices with their /dev path and CID=
 info.",
> > > +         NULL
> > > +       },
> > >         { NULL, 0, NULL, NULL }
> > >  };
> > >
> > > @@ -567,4 +572,3 @@ int main(int ac, char **av )
> > >
> > >         exit(func(nargs, args));
> > >  }
> > > -
> > > diff --git a/mmc_cmds.h b/mmc_cmds.h
> > > index 407cbe6..508776c 100644
> > > --- a/mmc_cmds.h
> > > +++ b/mmc_cmds.h
> > > @@ -49,6 +49,7 @@ int do_opt_ffu4(int nargs, char **argv);  int
> > > do_read_scr(int argc, char **argv);  int do_read_cid(int argc, char
> > > **argv);  int do_read_csd(int argc, char **argv);
> > > +int do_list(int nargs, char **argv);
> > >  int do_erase(int nargs, char **argv);  int do_general_cmd_read(int
> > > nargs, char **argv);  int do_softreset(int nargs, char **argv);
> > > --
> > > 2.53.0
> > >
> >
>
