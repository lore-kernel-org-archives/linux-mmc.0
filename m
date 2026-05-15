Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B3305665
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878242; cv=pass; b=F56WNNzqraXVy4EZfPy7rj3IEyFpATYrm/w6u+8nF7A6Of0Qyhp3XUrSc4D0i+V2KsT3d74Lsnp3psDBXO3Mp5C05jEJoFxC/N8ckVY21R+gTLrAGT/vuM5f68Q/HnnwmynZJuC+dX3Q/xd0nBtwOW3RCuxm9MmAA19MuwQeND8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878242; c=relaxed/simple;
	bh=TaITGLOOhFs7rG/RhRkEn/1fhy0Ec3X55JdWvWkLkvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfbm4Z+P0Lyq/af6e73VlJW5pRm8AOHuA6dMPOdV23lwmrHezPqB7/Q3uUhufDg3PhE0vKDlauYaO+u2fJUUrPqRpBMo7gtnFFejNKVUIw2hRWcm8rteRxbyTkxdAkbClPf5LTbgNod5iGq2ikFQfu5SfzsAwzTVBXZFX1sQhKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdbLRbrL; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdbLRbrL"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70c112cb61so212401a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 13:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778878240; cv=none;
        d=google.com; s=arc-20240605;
        b=ksG4g0Jk/EBZ138/YZaPk+rHBUrvm93iDGcSOoroJVfRT9ZdZlPfbldNCR3iKr5o9L
         mq/9AIHlRLHFQ16zFxUwlnxbOg9N7WvZxCdNraVxAH1OoaBSMhivDE9Agx8PVES+K1yo
         l82xqCHJ261gLruZHVjuCkZIbIwREQPeYGXxHgXuY9n/FXeyDnXor0Bef7oRJdVY/XMU
         7x38o2KtbXGxQex9mbOq713gvrYS4Nx//iw9oo+MtMDoCigQf8vpEnpudgydknlST9CT
         W2nC32CZ/KNPdcgcGbIZWxNB4lyOBEy8OKl5oGAMKw4mbSiqE9woWxuRmUAsBJKteRRB
         vCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nyJ72Fyu/R8/3WRGsgWwW7gPq4UgVQ0FJeSoeV2iCA4=;
        fh=Xn5gGOD0wfvxR3QQnaA7YlzIeHMppEapma8laY3ceNU=;
        b=ieYjWwkJFoCbVyHrTwV6wWE2SN8J+8pnzawyRtphiSPeaBs03J+enbQ3OQtpmURhpD
         vVT2CSvJRh3LtPwILXMbTUb5NgmP5UvbjrdDhpJWQ71X710zYM29UzljU6u5/LVWgtOV
         UH3G67yrIsGG5O7ypCZoEaV5ih6AotyEnppnRttqxuZcaMii48bqOXQUBXX8G/vunfwf
         vzEH2DnJcWTeVMthYcR7vNfsJXf6QvcW7Bws0KC1RcINK9lDaFeWbajehemOtEwBBnbj
         36TnUYHrcEguRPnJzCj3C90ffDP+d+z0ahzPTzG8wxAWtXNggL/IxDjltw94WOO0+niR
         gLJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778878240; x=1779483040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyJ72Fyu/R8/3WRGsgWwW7gPq4UgVQ0FJeSoeV2iCA4=;
        b=WdbLRbrLYWGbgOi++NIcW7YKbcY++GwOr3okWHpIlJtJecjrQ1A0tQkA8W1MfoG0fr
         cONbYMnwvAupiyrW6TdAB0DWgEy3MImPzKl3WL2Z7+lpL0CBWEaGuZP526uEjAZEfxMl
         zYJp4ot8ZRpZ77DWSMZ0exgXmv7oyoRBKrD58vhWkmaYF1HupJzkipJfBBMidzrKgObd
         QJHmmpZ2YcO8lx6ZZ5t41L1HjAoXWJPy1RxO0TQ2TzS/Yb0tEtI9cd3QPwPrslvDABsR
         80nZzm5vsK4x3AuF6vdSFj7LVEQrHp+136reP74tKgAfU3bXasCPCEcs+VuP6ZQC0/F8
         1BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778878240; x=1779483040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyJ72Fyu/R8/3WRGsgWwW7gPq4UgVQ0FJeSoeV2iCA4=;
        b=s9NQfi/q4dfTrt2X+ytnYAU0TM5kKcvc6ixMWfeVJU4PUhttVz1TZiEU8Rl8OuTY8/
         tPKOegMa5sUdNysyC64z47kVmrVsRy6NIRxKpYZ1ZtMBZzn/pUIqVWNyrHwWCO/+47aY
         Ii2DuG9InfBHoppVwHXIGOuM5e9CrFOfLe1/PWHHL5pHlKegXKzD06a2noyi+MsJEchL
         r4bkohLkfT5VH/5Tm0grLlJwAlf1jELZp/09vKQy31DAgUhFSxMl4pYiXl3Xh/Je/fqB
         UcYlEH++H9kysVgMHYl1VM7owY51hDo1pIza0tt9Nm3Wx3/iPGHmQNHH7yo7lxxGxx9/
         p55g==
X-Gm-Message-State: AOJu0YzlFj4ClxNn4k1/rxHmbe1LwJ8y6OW0apFK4Uwag/2qNPgAEQTA
	42bjvjK1S8JxdtxijaSIkMB8hR8pW0HGWPTR7tzSpAotjWATYMvmPRK0M0bWqhWgGSfotN+CPn8
	fUQgYQBYwwmtwNHTvt9CLOauzDQrlTl4=
X-Gm-Gg: Acq92OFfSrERh+cAwjfZBDor/ymqFbJue6WZKG3ZNgQGksejQYi+VifbXOnu4dL6Ejo
	9R6jR3GQQ6xWXXAnkiiZO9/PBHNYqUB3E+8DMTFhGxsZmROsWdyarqNWHqiW5GheGRXg/BFJBUy
	1lTteqVvHb5FkxdLhNIcRcphWoo8HAZGrnsZSHZ51l7hALv4zFEYxXLQJJK8nd5UQroxVgV2iF0
	FNEJoHxW3irFG/GU1OzOxCo5uClC9F3m2kKgEQi4iCwwdwAB3uOk3vCV216K/4S8fcCUPDtg/he
	yB6/KQwWlVBiOYFAwY7xBVyh83fagwolj/vo8w==
X-Received: by 2002:a05:6a20:12d3:b0:3a2:f14a:4275 with SMTP id
 adf61e73a8af0-3b22e67fcf9mr6389930637.6.1778878239750; Fri, 15 May 2026
 13:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <20260515083457.3690804-4-torsteine+linux@gmail.com> <DS1PR16MB67536F09AFA69FC335A2F1C4E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB67536F09AFA69FC335A2F1C4E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Torstein Eide <torsteine@gmail.com>
Date: Fri, 15 May 2026 22:50:26 +0200
X-Gm-Features: AVHnY4Jiup8lzJOUNHEO4NJdEnfQQnQ8M9pVo2NJgdYmSIYckq3iCBf5JaLCqt8
Message-ID: <CAL5DHTF+rP5LPxk=Rq8Wym+bZ9gW8WbrbtS5XsDMO+M=maPR-g@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmc-utils: lsmmc: Add mmc list command
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide <torsteine+linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

fre. 15. mai 2026 kl. 18:38 skrev Avri Altman <Avri.Altman@sandisk.com>:
>
> > Add a 'mmc list' command that scans /sys/bus/mmc/devices/, resolves each
> > card's sysfs path, and prints a one-line summary per device.
> >
> > find_block_devname() maps a sysfs device path back to its mmcblkN name by
> > scanning /sys/class/block/mmcblkN/device symlinks.
> >
> > print_list_entry() parses the CID register and formats a fixed-width table row with
> > device name, /dev path, bus type, manufacturer, product, revision, serial number,
> > and manufacturing date.
> >
> > The header is printed once before the first result. Devices without a readable cid
> > file are skipped silently via access() so unrelated sysfs entries do not produce
> > spurious error messages.
> >
> > Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> > ---
> >  docs/HOWTO.rst |  12 ++++
> >  lsmmc.c        | 167 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  mmc.c          |   6 +-
> >  mmc_cmds.h     |   1 +
> >  4 files changed, 185 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst index 76214a3..167a153 100644
> > --- a/docs/HOWTO.rst
> > +++ b/docs/HOWTO.rst
> > @@ -90,6 +90,18 @@ Running mmc-utils
> >              sysfs:
> > /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
> >              SCR Register: 0235800000000000
> >
> > +    ``list``
> > +        List all MMC/SD devices present on the system. Output is a table with
> > +        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD),
> > +        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
> > +
> > +        Example::
> > +
> > +            $ mmc list
> > +            DEVICE          DEV            TYPE  MANUFACTURER         PRODUCT    REV
> > SERIAL      DATE
> > +            mmc0:0001       /dev/mmcblk0   MMC   Samsung              MAG4FA     1.0
> > 0x1a2b3c4d  2021-jan
> > +            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk              SP32G      8.0
> > 0x5e6f7a8b  2020-mar
> > +
> >      ``ffu <image name> <device> [chunk-bytes]``
> >        Default mode.  Run Field Firmware Update with `<image name>` on
> > `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in
> > decimal bytes and sector aligned.
> >
> > diff --git a/lsmmc.c b/lsmmc.c
> > index 3149409..4f378fa 100644
> > --- a/lsmmc.c
> > +++ b/lsmmc.c
> > @@ -253,6 +253,38 @@ static char *resolve_dev_path(const char *path)
> >         return resolved;
> >  }
> >
> > +static char *find_block_devname(const char *sysfs_devpath) {
> > +       DIR *d;
> > +       struct dirent *ent;
> > +
> > +       d = opendir("/sys/class/block");
> > +       if (!d)
> > +               return NULL;
> > +
> > +       while ((ent = readdir(d)) != NULL) {
> > +               char linkpath[PATH_MAX];
> > +               char resolved[PATH_MAX];
> > +
> > +               if (strncmp(ent->d_name, "mmcblk", 6) != 0)
> > +                       continue;
> > +               if (strchr(ent->d_name + 6, 'p'))
> > +                       continue;
> > +
> > +               snprintf(linkpath, sizeof(linkpath),
> > +                        "/sys/class/block/%s/device", ent->d_name);
> > +               if (realpath(linkpath, resolved) == NULL)
> > +                       continue;
> > +               if (strcmp(resolved, sysfs_devpath) == 0) {
> > +                       closedir(d);
> > +                       return strdup(ent->d_name);
> > +               }
> > +       }
> > +
> > +       closedir(d);
> > +       return NULL;
> > +}
> > +
> >  /* MMC/SD file parsing functions */
> >  static char *read_file(char *name)
> >  {
> > @@ -2203,6 +2235,141 @@ static int do_read_reg(int argc, char **argv, enum
> > REG_TYPE reg)
> >         return ret;
> >  }
> >
> > +static const char *month_name(unsigned int month) {
> > +       static const char *months[] = {
> > +               "???", "jan", "feb", "mar", "apr", "may", "jun",
> > +               "jul", "aug", "sep", "oct", "nov", "dec",
> > +       };
> Maybe maintain consistency with the month's arrays in print_sd_cid()` / `print_mmc_cid()`

good poiint ill fix.
>
> > +
> > +       if (month >= ARRAY_SIZE(months))
> > +               return "???";
> > +
> > +       return months[month];
> > +}
> > +
> > +static void print_list_entry(struct config *cfg, const char *devname,
> > +                            const char *blkdev, char *cid) {
> > +       const char *mfr;
> > +       char devnode[32];
> > +
> > +       snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev :
> > + "?");
> > +
> > +       if (cfg->bus == SD) {
> > +               unsigned int mid, prv_major, prv_minor, psn, mdt_year;
> > +               unsigned int mdt_month, crc;
> > +               char oid[3], pnm[6];
> > +
> > +               parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
> > +                         &mid, &oid[0], &pnm[0], &prv_major, &prv_minor,
> > +                         &psn, &mdt_year, &mdt_month, &crc);
> > +               oid[2] = '\0';
> > +               pnm[5] = '\0';
> > +
> > +               mfr = get_manufacturer(cfg, mid);
> > +               printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s\n",
> > +                      devname, devnode, mfr ? mfr : "Unlisted", pnm,
> > +                      prv_major, prv_minor, psn, 2000 + mdt_year,
> > +                      month_name(mdt_month));
> > +       } else {
> > +               unsigned int mid, cbx, oid, prv_major, prv_minor, psn;
> > +               unsigned int mdt_year, mdt_month, crc;
> > +               char pnm[7];
> > +
> > +               parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
> > +                         &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor,
> > +                         &psn, &mdt_year, &mdt_month, &crc);
> > +               pnm[6] = '\0';
> > +
> > +               mfr = get_manufacturer(cfg, mid);
> > +               printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s\n",
> > +                      devname, devnode, mfr ? mfr : "Unlisted", pnm,
> > +                      prv_major, prv_minor, psn, 1997 + mdt_year,
> The existing `print_mmc_cid()` has logic to adjust the base year based on `ext_csd_rev` (2013 for rev > 4, 2029 for rev > 8).
> See if you can use it as well.
>
> > +                      month_name(mdt_month));
> > +       }
> > +}
> > +
> > +int do_list(int nargs, char **argv)
> > +{
> > +       const char *bus_path = "/sys/bus/mmc/devices";
> > +       char orig_cwd[PATH_MAX];
> > +       DIR *d;
> > +       struct dirent *ent;
> > +       bool header_printed = false;
> > +
> > +       if (!getcwd(orig_cwd, sizeof(orig_cwd))) {
> If you decide to replace getcwd/chdir (comment in patch 1) - use here read_file_at as well...
>

Yes i will.

> > +               fprintf(stderr, "Cannot get current directory.\n");
> > +               return -1;
> > +       }
> > +
> > +       d = opendir(bus_path);
> > +       if (!d) {
> > +               fprintf(stderr, "Cannot open %s\n", bus_path);
> > +               return -1;
> > +       }
> > +
> > +       while ((ent = readdir(d)) != NULL) {
> > +               char devpath[PATH_MAX];
> > +               char resolved[PATH_MAX];
> > +               char *type, *cid, *blkdev;
> > +               struct config cfg = {};
> re-initializing cfg every iteration is wasteful but harmless - consider moving it out of the loop.
>

Ill move it out of loop.
> > +
> > +               if (!strchr(ent->d_name, ':'))
> > +                       continue;
> > +
> > +               snprintf(devpath, sizeof(devpath), "%s/%s", bus_path, ent->d_name);
> > +               if (realpath(devpath, resolved) == NULL)
> > +                       continue;
> > +
> > +               if (chdir(resolved) < 0)
> silently skip devices with no diagnostics ?
>
> > +                       continue;
> > +
> > +               if (access("cid", R_OK) != 0) {
> Isn't `read_file()` does `fopen()` which checks the same thing as `access()`?
>
> > +                       if (chdir(orig_cwd) < 0)
> > +                               break;
> > +                       continue;
> silently skip devices with no diagnostics ?
>

this will be removed with removal of chdir.

> > +               }
> > +
> > +               type = read_file("type");
> > +               if (!type) {
> > +                       if (chdir(orig_cwd) < 0)
> > +                               break;
> > +                       continue;
> > +               }
> > +
> > +               cid = read_file("cid");
> > +               if (!cid) {
> > +                       free(type);
> > +                       if (chdir(orig_cwd) < 0)
> > +                               break;
> > +                       continue;
> > +               }
> > +
> > +               blkdev = find_block_devname(resolved);
> > +               cfg.bus = strcmp(type, "MMC") ? SD : MMC;
> > +               cfg.ids_dir = orig_cwd;
> > +
> > +               if (!header_printed) {
> > +                       printf("%-14s %-14s %-5s%-20s %-10s %-5s %-12s %s\n",
> > +                              "DEVICE", "DEV", "TYPE", "MANUFACTURER", "PRODUCT",
> > +                              "REV", "SERIAL", "DATE");
> > +                       header_printed = true;
> > +               }
> > +
> > +               print_list_entry(&cfg, ent->d_name, blkdev, cid);
> > +
> > +               free(blkdev);
> > +               free(cid);
> > +               free(type);
> > +               if (chdir(orig_cwd) < 0)
> We fail here but returns 0?
>

> Thanks,
> Avri

This will also be removed.

Torstein.
> > +                       break;
> > +       }
> > +
> > +       closedir(d);
> > +       return 0;
> > +}
> > +
> >  int do_read_csd(int argc, char **argv)
> >  {
> >         return do_read_reg(argc, argv, CSD); diff --git a/mmc.c b/mmc.c index
> > 077e901..01ad181 100644
> > --- a/mmc.c
> > +++ b/mmc.c
> > @@ -292,6 +292,11 @@ static struct Command commands[] = {
> >           "4. The MMC will perform a soft reset, if your system cannot handle that do
> > not use the boot operation from mmc-utils.\n",
> >           NULL
> >         },
> > +       { do_list, 0,
> > +         "list", "\n"
> > +               "List all MMC/SD devices with their /dev path and CID info.",
> > +         NULL
> > +       },
> >         { NULL, 0, NULL, NULL }
> >  };
> >
> > @@ -567,4 +572,3 @@ int main(int ac, char **av )
> >
> >         exit(func(nargs, args));
> >  }
> > -
> > diff --git a/mmc_cmds.h b/mmc_cmds.h
> > index 407cbe6..508776c 100644
> > --- a/mmc_cmds.h
> > +++ b/mmc_cmds.h
> > @@ -49,6 +49,7 @@ int do_opt_ffu4(int nargs, char **argv);  int do_read_scr(int
> > argc, char **argv);  int do_read_cid(int argc, char **argv);  int do_read_csd(int
> > argc, char **argv);
> > +int do_list(int nargs, char **argv);
> >  int do_erase(int nargs, char **argv);
> >  int do_general_cmd_read(int nargs, char **argv);  int do_softreset(int nargs,
> > char **argv);
> > --
> > 2.53.0
> >
>
