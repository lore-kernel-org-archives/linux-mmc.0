Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6E3DEFED
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834603; cv=none; b=MweEg5H/g1burZTkWu9sBhsdWzoqVB6zdHiJp6hTkegrQoyEW4a+K3+Qh77SK7QsmeUFbvav+LN0qJ8blcWfQbWw5rDm/h3NxwmDqFctcNAXJ4x2hikMUPdGKgN8IMz/KGitb+UXQDVwdOWvytnMHLdolsm4CJNPyKDp8cKrXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834603; c=relaxed/simple;
	bh=x2yo6CICkldRI6XdyqrnNYhZEp39nohlpxTFZrGRw28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWoxrh5QITwE9o+8YkRiW4/OBWMrrIm8SgSRbAXGPYNno9ht/CJ1uSJubNzoVzfIUFWgIJrK5OJGb7g+rhUaItsSRlQv9EF/OOQDu0rszAauPmBuMRWJBjV0iaLEYn2mCY8GDqnyTYYA03RrnINfKQ1SCW42RsXXMQg4KMFqrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZUWSVh1e; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZUWSVh1e"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-67e09232daeso1295820eaf.2
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 08:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834600; x=1776439400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir9kNiJ3ftO15px6E4plgUuA06wXA3N1Upy/IfNbSpk=;
        b=tCG1kOdCfLGJrl9mqmmAbOsEd6RgnlV+oZBF2pLjzqt4WqgYh3kLBuYvEykwvISCln
         8wwR7wQ+LVkD1WKmKIUZrN2wSbWL0Q9gGhO0P2r9IlhrChkgkJ71W3/QGgNuKHJwhtFw
         q1cmeVT/KfQ0fdBd5pP63G9l0T1KNfilQ9sJGrTTFmpwbRdQ/U1+XeUsnzi/qus1UUDJ
         2mSe67Ce8tlKWjlh1U3e7T6Vwi3r/83VigAg4LO4MGmdUXZkZu4NgHn70Vk1b8KvwdcA
         GlKwHMbqIWOM+BYFuy3G2HvaQh+f0GjPlXaOQ3jtgt5pFvBjM74dvHkywUzC07DXUKpU
         d55Q==
X-Forwarded-Encrypted: i=1; AJvYcCXljUHLeMxibAJzmcHaIeGSxc54MtuqGh6xKv6g+6llaSU8TwtFqNJ4f+VrffvT5nGk3UrJD6F5uX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnb7aWJ1kRfGQ0sXfi4BCE5ME6era7FT2ynnA8TdpbCqbcHkDG
	bEy16NdDlKVXEB3Bs1Kqg74Mlq37cb8eKfyGRYzspXqoT7d59JCNnnh2j4+9kKBCWneO6JCuJtQ
	KARR8D0qvwnma9qkKd5Z+scfcQg7cB0C0GIgdmJpC2kFlJehYmBsaGUasWctKj96nXJUPOXKKzm
	5Sx9o+3JhEKXvdST34b018N5txC8QiU9z+kDuLX46E4uS76+d2su/n0A0EjUafrv39fQ9T7WIT8
	caHagl3M+yl
X-Gm-Gg: AeBDiet0Gv2K+aJ5ZGE6FEYqpJcZU5ZuNxlZuOyc1nNivz2HpQ5MA0L8pahm3w6wUl7
	EhlXMIJIkkPjmKsxyssM51sW63Rcel4hKdnpb7eU/P4lZVAtF8L9EjPXYgb3XjOBWhBc2PK2FSW
	rVYiGi6zYbbRCj4x+QXr69oaulZqOD5TXDy/guSA9Fn8SWyL+zCs7rFTE0shS/iw2fFXrvunR0D
	+mtg4ZcPv0WYZ7uGMWdApe473TVA7zMxk1iRWXoWdDoszw9SnViUldilojmq8bd3Y7v6atfRiyf
	vnJtxuB8jmZ6p0KiRTrhSwvser+quAFc4LtYkQiXKC80Qp1Iuj88ypptUaQvQQYdR4gO6TySuyX
	kHELdy2Eoer+z+Jz9kfb9svGvXSWXr/GHnZha4WgdBhT09Xcd2/ufdm1SNR4smSK3ydFP7BZ0dO
	TpQnij7mA/mm4x7cqUhEcLaoLgB7lAsJmVlGLjRpi03QgBu/pG33y9iw==
X-Received: by 2002:a05:6820:1895:b0:681:22fd:a584 with SMTP id 006d021491bc7-68be64356famr1857568eaf.16.1775834600097;
        Fri, 10 Apr 2026 08:23:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-68bca5f9493sm225438eaf.13.2026.04.10.08.23.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:23:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c20d5d7f4so3830522c88.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775834598; x=1776439398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ir9kNiJ3ftO15px6E4plgUuA06wXA3N1Upy/IfNbSpk=;
        b=ZUWSVh1e8COc20WzosU1l0/z+8j+QLxy1tktit2kwDu2kzI9kxg6DIBZRrNhgWmdQW
         4hfTtJC4C4eTZgVCT6w4jPLS7IxCFFhRqSckkY0aWFFTAjq7zSqC65B96mZdY1jtqkE5
         Cd2Hy61LcgJZF7jTYWTze3ApeBerwo+sUzYlE=
X-Forwarded-Encrypted: i=1; AJvYcCWl0v+Tg4x/EyiwNe67b5xTq/GS9+TkwWMupazE1eP574OZKSfUHNmHRT17JvdvBbWZDgxH+v7Y0Rc=@vger.kernel.org
X-Received: by 2002:a05:7022:6183:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12c34dbeaddmr2309037c88.0.1775834598249;
        Fri, 10 Apr 2026 08:23:18 -0700 (PDT)
X-Received: by 2002:a05:7022:6183:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-12c34dbeaddmr2309002c88.0.1775834597447; Fri, 10 Apr 2026
 08:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319185705.1516950-5-kamal.dasu@broadcom.com> <202603202338.OYFgRuuU-lkp@intel.com>
In-Reply-To: <202603202338.OYFgRuuU-lkp@intel.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Fri, 10 Apr 2026 11:22:40 -0400
X-Gm-Features: AQROBzAGaqNg9lo7s53mwOhwVjJnKkNQ5M8fkFVF230EiNezCs_J7GxLgpz0gLI
Message-ID: <CAKekbevXyZ9dyE8fJyaf1yYjVgJD=mzsSScFFgGrym-RO4=pTQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mmc: core: Add MMC pstore backend driver
To: kernel test robot <lkp@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kees Cook <kees@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, William Zhang <william.zhang@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000719669064f1cb6c1"

--000000000000719669064f1cb6c1
Content-Type: multipart/alternative; boundary="0000000000005c8849064f1cb657"

--0000000000005c8849064f1cb657
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:18=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:

> Hi Kamal,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v7.0-rc4 next-20260319]
> [cannot apply to ulf-hansson-mmc-mirror/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:
> https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-core-Add-pa=
nic-context-host-operations-for-pstore-backends/20260320-064639
> base:   linus/master
> patch link:
> https://lore.kernel.org/r/20260319185705.1516950-5-kamal.dasu%40broadcom.=
com
> patch subject: [PATCH v3 4/4] mmc: core: Add MMC pstore backend driver
> config: m68k-allyesconfig (
> https://download.01.org/0day-ci/archive/20260320/202603202338.OYFgRuuU-lk=
p@intel.com/config
> )
> compiler: m68k-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=3D1 build): (
> https://download.01.org/0day-ci/archive/20260320/202603202338.OYFgRuuU-lk=
p@intel.com/reproduce
> )
>
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> https://lore.kernel.org/oe-kbuild-all/202603202338.OYFgRuuU-lkp@intel.com=
/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/mmc/core/mmcpstore.c: In function 'mmcpstore_register_for_card=
':
> >> drivers/mmc/core/mmcpstore.c:1016:23: warning: variable 'offset_bytes'
> set but not used [-Wunused-but-set-variable]
>     1016 |         unsigned long offset_bytes;
>          |                       ^~~~~~~~~~~~
> --
> >> Warning: drivers/mmc/core/mmcpstore.c:250 function parameter
> 'sect_offset' not described in 'mmcpstore_do_request_internal'
> >> Warning: drivers/mmc/core/mmcpstore.c:573 expecting prototype for
> mmcpstore_read(). Prototype was for mmcpstore_read_zone() instead
> >> Warning: drivers/mmc/core/mmcpstore.c:1248 function parameter 'disk'
> not described in 'mmcpstore_card_add'
> >> Warning: drivers/mmc/core/mmcpstore.c:250 function parameter
> 'sect_offset' not described in 'mmcpstore_do_request_internal'
> >> Warning: drivers/mmc/core/mmcpstore.c:1248 function parameter 'disk'
> not described in 'mmcpstore_card_add'
>
>
Fixed all warnings and sent a v4 version a couple of weeks back. Please
review the v4 changes.



> vim +/offset_bytes +1016 drivers/mmc/core/mmcpstore.c
>
>    998
>    999  /**
>   1000   * mmcpstore_register_for_card - Register pstore for specific MMC
> card
>   1001   * @card: MMC card to register pstore for
>   1002   * @dev_name_param: Device path (e.g., "/dev/mmcblk1p5")
>   1003   * @disk: gendisk for the card (non-NULL for builtin path, NULL
> for module)
>   1004   *
>   1005   * Returns: 0 on success, negative error on failure
>   1006   */
>   1007  static int mmcpstore_register_for_card(struct mmc_card *card,
>   1008                                         const char *dev_name_param=
,
>   1009                                         struct gendisk *disk)
>   1010  {
>   1011          struct mmcpstore_context *cxt;
>   1012          struct pstore_blk_config conf;
>   1013          struct file *bdev_file;
>   1014          struct block_device *bdev;
>   1015          sector_t partition_sectors;
> > 1016          unsigned long offset_bytes;
>   1017          unsigned long required_size;
>   1018          unsigned long kmsg_records;
>   1019          int ret;
>   1020
>   1021          /*
>   1022           * Open the block device to get partition start sector an=
d
> size.
>   1023           * When called from mmc_blk_probe() (builtin path), /dev/
> may not
>   1024           * be mounted yet, so use the gendisk + partition number
> to look
>   1025           * up the dev_t directly.
>   1026           */
>   1027          if (disk) {
>   1028                  int partno =3D
> mmcpstore_extract_partno(dev_name_param);
>   1029                  dev_t devt;
>   1030
>   1031                  if (partno < 0) {
>   1032                          pr_warn("Cannot parse partition from %s\n=
",
>   1033                                  dev_name_param);
>   1034                          return -EINVAL;
>   1035                  }
>   1036                  devt =3D part_devt(disk, partno);
>   1037                  if (!devt) {
>   1038                          pr_warn("Partition %d not found on %s\n",
>   1039                                  partno, disk->disk_name);
>   1040                          return -ENODEV;
>   1041                  }
>   1042                  bdev_file =3D bdev_file_open_by_dev(devt,
> BLK_OPEN_READ,
>   1043                                                    NULL, NULL);
>   1044          } else {
>   1045                  bdev_file =3D bdev_file_open_by_path(dev_name_par=
am,
>   1046                                                     BLK_OPEN_READ,
> NULL, NULL);
>   1047          }
>   1048          if (IS_ERR(bdev_file)) {
>   1049                  ret =3D PTR_ERR(bdev_file);
>   1050                  pr_warn("Failed to open device %s: %d\n",
> dev_name_param, ret);
>   1051                  return ret;
>   1052          }
>   1053          bdev =3D file_bdev(bdev_file);
>   1054
>   1055          cxt =3D mmcpstore_ctx;
>   1056          if (!cxt) {
>   1057                  pr_err("No context available\n");
>   1058                  fput(bdev_file);
>   1059                  return -ENODEV;
>   1060          }
>   1061
>   1062          /* pre-allocated buffer for alignment handling */
>   1063          cxt->buffer_size =3D MMC_PSTORE_MAX_BUFFER_SIZE;
>   1064          cxt->buffer =3D kmalloc(cxt->buffer_size, GFP_KERNEL);
>   1065          if (!cxt->buffer) {
>   1066                  pr_err("Failed to allocate %zu bytes for pstore
> buffer\n",
>   1067                         cxt->buffer_size);
>   1068                  fput(bdev_file);
>   1069                  return -ENOMEM;
>   1070          }
>   1071
>   1072          if (!(card->host->caps & MMC_CAP_NONREMOVABLE)) {
>   1073                  dev_err(&card->dev, "MMC pstore only supports
> non-removable cards (eMMC)\n");
>   1074                  dev_err(&card->dev, "This card is removable and
> not suitable for pstore\n");
>   1075                  ret =3D -EOPNOTSUPP;
>   1076                  goto err_free;
>   1077          }
>   1078
>   1079          /* Initialize context */
>   1080          cxt->card =3D card;
>   1081          strscpy(cxt->card_name, dev_name_param,
> sizeof(cxt->card_name));
>   1082          cxt->start_sect =3D bdev->bd_start_sect;
>   1083          cxt->size =3D bdev_nr_bytes(bdev);
>   1084
>   1085          /* Apply user-specified sector offset and count within th=
e
> partition */
>   1086          if (part_sect_ofs > 0 || part_sect_cnt > 0) {
>   1087                  if ((part_sect_ofs > 0 && part_sect_cnt =3D=3D 0)=
 ||
>   1088                      (part_sect_ofs =3D=3D 0 && part_sect_cnt > 0)=
) {
>   1089                          dev_err(&card->dev, "sector_offset and
> sector_count must be specified\n");
>   1090                          ret =3D -EINVAL;
>   1091                          goto err_free;
>   1092                  }
>   1093
>   1094                  /* Validate offset and count */
>   1095                  partition_sectors =3D cxt->size >> 9;
>   1096                  offset_bytes =3D part_sect_ofs *
> MMC_PSTORE_SECTOR_SIZE;
>   1097
>   1098                  if (part_sect_ofs >=3D partition_sectors) {
>   1099                          dev_err(&card->dev, "Sector offset %lu >=
=3D
> partition size %llu sectors\n",
>   1100                                  part_sect_ofs, partition_sectors)=
;
>   1101                          ret =3D -EINVAL;
>   1102                          goto err_free;
>   1103                  }
>   1104
>   1105                  if (part_sect_ofs + part_sect_cnt >
> partition_sectors) {
>   1106                          dev_err(&card->dev, "Sector range %lu-%lu
> exceeds partition size %llu sectors\n",
>   1107                                  part_sect_ofs,
>   1108                                  part_sect_ofs + part_sect_cnt - 1=
,
>   1109                                  partition_sectors);
>   1110                          ret =3D -EINVAL;
>   1111                          goto err_free;
>   1112                  }
>   1113
>   1114                  cxt->start_sect +=3D part_sect_ofs;
>   1115                  cxt->size =3D part_sect_cnt * MMC_PSTORE_SECTOR_S=
IZE;
>   1116
>   1117                  pr_info("Pstore will use: sectors %lu-%lu (%llu
> bytes total)\n",
>   1118                          part_sect_ofs, part_sect_ofs +
> part_sect_cnt - 1,
>   1119                          cxt->size);
>   1120          }
>   1121
>   1122          fput(bdev_file);
>   1123
>   1124          /* Configure pstore */
>   1125          memset(&conf, 0, sizeof(conf));
>   1126          strscpy(conf.device, dev_name_param, sizeof(conf.device))=
;
>   1127          conf.max_reason =3D KMSG_DUMP_PANIC;
>   1128
>   1129          /* Fetch pstore configuration including sizes from module
> parameters */
>   1130          ret =3D pstore_blk_get_config(&conf);
>   1131          if (ret !=3D 0) {
>   1132                  pr_err("Failed to get pstore block config: %d\n",
> ret);
>   1133                  goto err_free;
>   1134          }
>   1135
>   1136          /* Validate size requirements */
>   1137          ret =3D mmcpstore_calculate_sizes(cxt, &conf, &required_s=
ize,
>   1138                                          &kmsg_records);
>   1139          if (ret)
>   1140                  goto err_free;
>   1141
>   1142          pr_debug("Pstore requirements: kmsg=3D%lu KB, pmsg=3D%lu =
KB,
> console=3D%lu KB, ftrace=3D%lu KB\n",
>   1143                  MMC_PSTORE_BYTES_TO_KB(conf.kmsg_size),
>   1144                  MMC_PSTORE_BYTES_TO_KB(conf.pmsg_size),
>   1145                  MMC_PSTORE_BYTES_TO_KB(conf.console_size),
>   1146                  MMC_PSTORE_BYTES_TO_KB(conf.ftrace_size));
>   1147          pr_debug("Pstore capacity: ~%lu kmsg records possible (%l=
u
> KB each, varies with compression)\n",
>   1148                  kmsg_records,
> MMC_PSTORE_BYTES_TO_KB(conf.kmsg_size));
>   1149
>   1150          /* Set up pstore device info */
>   1151          cxt->dev.flags =3D 0; /* Support all backends */
>   1152          if (conf.kmsg_size > 0)
>   1153                  cxt->dev.flags |=3D PSTORE_FLAGS_DMESG;
>   1154          if (conf.pmsg_size > 0)
>   1155                  cxt->dev.flags |=3D PSTORE_FLAGS_PMSG;
>   1156          if (conf.console_size > 0)
>   1157                  cxt->dev.flags |=3D PSTORE_FLAGS_CONSOLE;
>   1158          if (conf.ftrace_size > 0)
>   1159                  cxt->dev.flags |=3D PSTORE_FLAGS_FTRACE;
>   1160
>   1161          /* Set up zone structure for pstore/zone API */
>   1162          cxt->dev.zone.read =3D mmcpstore_read_zone;
>   1163          cxt->dev.zone.write =3D mmcpstore_write;
>   1164          cxt->dev.zone.panic_write =3D mmcpstore_panic_write;
>   1165          cxt->dev.zone.total_size =3D cxt->size;
>   1166          cxt->dev.zone.kmsg_size =3D conf.kmsg_size;
>   1167          cxt->dev.zone.pmsg_size =3D conf.pmsg_size;
>   1168          cxt->dev.zone.console_size =3D conf.console_size;
>   1169          cxt->dev.zone.ftrace_size =3D conf.ftrace_size;
>   1170          cxt->dev.zone.max_reason =3D conf.max_reason;
>   1171          cxt->dev.zone.name =3D "mmcpstore";
>   1172          cxt->dev.zone.owner =3D THIS_MODULE;
>   1173
>   1174          mutex_init(&cxt->lock);
>   1175
>   1176          /*
>   1177           * Set state to READY before registration because
> register_pstore_device()
>   1178           * triggers pstore_zone recovery which calls our read
> callback, and the
>   1179           * read callback requires state =3D=3D READY to proceed.
>   1180           */
>   1181          mutex_lock(&mmcpstore_global_lock);
>   1182          cxt->state =3D MMCPSTORE_STATE_READY;
>   1183          mutex_unlock(&mmcpstore_global_lock);
>   1184
>   1185          ret =3D register_pstore_device(&cxt->dev);
>   1186          if (ret) {
>   1187                  dev_err(&card->dev, "Failed to register pstore
> device: %d\n",
>   1188                          ret);
>   1189                  mutex_lock(&mmcpstore_global_lock);
>   1190                  cxt->state =3D MMCPSTORE_STATE_UNINITIALIZED;
>   1191                  mutex_unlock(&mmcpstore_global_lock);
>   1192                  goto err_free;
>   1193          }
>   1194
>   1195          dev_info(&card->dev, "MMC pstore backend registered
> successfully\n");
>   1196          dev_info(&card->dev, "Device: %s, Size: %llu bytes (%llu
> KB)\n",
>   1197                   dev_name_param, cxt->size,
> MMC_PSTORE_BYTES_TO_KB(cxt->size));
>   1198          dev_info(&card->dev, "Start sector: %llu, Sector count:
> %llu\n",
>   1199                   cxt->start_sect, cxt->size /
> MMC_PSTORE_SECTOR_SIZE);
>   1200          dev_info(&card->dev, "Pstore components: kmsg=3D%lu KB,
> pmsg=3D%lu KB, console=3D%lu KB, ftrace=3D%lu KB\n",
>   1201                   MMC_PSTORE_BYTES_TO_KB(conf.kmsg_size),
>   1202                   MMC_PSTORE_BYTES_TO_KB(conf.pmsg_size),
>   1203                   MMC_PSTORE_BYTES_TO_KB(conf.console_size),
>   1204                   MMC_PSTORE_BYTES_TO_KB(conf.ftrace_size));
>   1205
>   1206          return 0;
>   1207
>   1208  err_free:
>   1209          kfree(cxt->buffer);
>   1210          /* Don't free cxt here - it's the global context */
>   1211          return ret;
>   1212  }
>   1213
>
>
Thanks
Kamal



> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

--0000000000005c8849064f1cb657
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBGcmksIE1hciAyMCwgMjAyNiBhdCAxMToxOOKAr0FNIGtlcm5lbCB0ZXN0
IHJvYm90ICZsdDs8YSBocmVmPSJtYWlsdG86bGtwQGludGVsLmNvbSI+bGtwQGludGVsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgS2FtYWwsPGJyPg0KPGJyPg0Ka2VybmVs
IHRlc3Qgcm9ib3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1aWxkIHdhcm5pbmdzOjxicj4NCjxi
cj4NClthdXRvIGJ1aWxkIHRlc3QgV0FSTklORyBvbiBsaW51cy9tYXN0ZXJdPGJyPg0KW2Fsc28g
YnVpbGQgdGVzdCBXQVJOSU5HIG9uIHY3LjAtcmM0IG5leHQtMjAyNjAzMTldPGJyPg0KW2Nhbm5v
dCBhcHBseSB0byB1bGYtaGFuc3Nvbi1tbWMtbWlycm9yL25leHRdPGJyPg0KW0lmIHlvdXIgcGF0
Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVzIGEgbm90
ZS48YnI+DQpBbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAmIzM5
Oy0tYmFzZSYjMzk7IGFzIGRvY3VtZW50ZWQgaW48YnI+DQo8YSBocmVmPSJodHRwczovL2dpdC1z
Y20uY29tL2RvY3MvZ2l0LWZvcm1hdC1wYXRjaCNfYmFzZV90cmVlX2luZm9ybWF0aW9uIiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdC1zY20uY29tL2RvY3MvZ2l0
LWZvcm1hdC1wYXRjaCNfYmFzZV90cmVlX2luZm9ybWF0aW9uPC9hPl08YnI+DQo8YnI+DQp1cmw6
wqAgwqAgPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvY29t
bWl0cy9LYW1hbC1EYXN1L21tYy1jb3JlLUFkZC1wYW5pYy1jb250ZXh0LWhvc3Qtb3BlcmF0aW9u
cy1mb3ItcHN0b3JlLWJhY2tlbmRzLzIwMjYwMzIwLTA2NDYzOSIgcmVsPSJub3JlZmVycmVyIiB0
YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvY29t
bWl0cy9LYW1hbC1EYXN1L21tYy1jb3JlLUFkZC1wYW5pYy1jb250ZXh0LWhvc3Qtb3BlcmF0aW9u
cy1mb3ItcHN0b3JlLWJhY2tlbmRzLzIwMjYwMzIwLTA2NDYzOTwvYT48YnI+DQpiYXNlOsKgIMKg
bGludXMvbWFzdGVyPGJyPg0KcGF0Y2ggbGluazrCoCDCoCA8YSBocmVmPSJodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjYwMzE5MTg1NzA1LjE1MTY5NTAtNS1rYW1hbC5kYXN1JTQwYnJvYWRj
b20uY29tIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjYwMzE5MTg1NzA1LjE1MTY5NTAtNS1rYW1hbC5kYXN1JTQwYnJvYWRjb20u
Y29tPC9hPjxicj4NCnBhdGNoIHN1YmplY3Q6IFtQQVRDSCB2MyA0LzRdIG1tYzogY29yZTogQWRk
IE1NQyBwc3RvcmUgYmFja2VuZCBkcml2ZXI8YnI+DQpjb25maWc6IG02OGstYWxseWVzY29uZmln
ICg8YSBocmVmPSJodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyNjAz
MjAvMjAyNjAzMjAyMzM4Lk9ZRmdSdXVVLWxrcEBpbnRlbC5jb20vY29uZmlnIiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2Fy
Y2hpdmUvMjAyNjAzMjAvMjAyNjAzMjAyMzM4Lk9ZRmdSdXVVLWxrcEBpbnRlbC5jb20vY29uZmln
PC9hPik8YnI+DQpjb21waWxlcjogbTY4ay1saW51eC1nY2MgKEdDQykgMTUuMi4wPGJyPg0KcmVw
cm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTogKDxhIGhyZWY9Imh0dHBzOi8vZG93bmxvYWQu
MDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI2MDMyMC8yMDI2MDMyMDIzMzguT1lGZ1J1dVUtbGtw
QGludGVsLmNvbS9yZXByb2R1Y2UiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0
dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI2MDMyMC8yMDI2MDMyMDIz
MzguT1lGZ1J1dVUtbGtwQGludGVsLmNvbS9yZXByb2R1Y2U8L2E+KTxicj4NCjxicj4NCklmIHlv
dSBmaXggdGhlIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0
IGEgbmV3IHZlcnNpb24gb2Y8YnI+DQp0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRk
IGZvbGxvd2luZyB0YWdzPGJyPg0KfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgJmx0
OzxhIGhyZWY9Im1haWx0bzpsa3BAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bGtwQGludGVs
LmNvbTwvYT4mZ3Q7PGJyPg0KfCBDbG9zZXM6IDxhIGhyZWY9Imh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL29lLWtidWlsZC1hbGwvMjAyNjAzMjAyMzM4Lk9ZRmdSdXVVLWxrcEBpbnRlbC5jb20vIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xvcmUua2VybmVsLm9yZy9v
ZS1rYnVpbGQtYWxsLzIwMjYwMzIwMjMzOC5PWUZnUnV1VS1sa3BAaW50ZWwuY29tLzwvYT48YnI+
DQo8YnI+DQpBbGwgd2FybmluZ3MgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ICZndDsmZ3Q7KTo8YnI+
DQo8YnI+DQrCoCDCoGRyaXZlcnMvbW1jL2NvcmUvbW1jcHN0b3JlLmM6IEluIGZ1bmN0aW9uICYj
Mzk7bW1jcHN0b3JlX3JlZ2lzdGVyX2Zvcl9jYXJkJiMzOTs6PGJyPg0KJmd0OyZndDsgZHJpdmVy
cy9tbWMvY29yZS9tbWNwc3RvcmUuYzoxMDE2OjIzOiB3YXJuaW5nOiB2YXJpYWJsZSAmIzM5O29m
ZnNldF9ieXRlcyYjMzk7IHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFi
bGVdPGJyPg0KwqAgwqAgMTAxNiB8wqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBsb25nIG9mZnNldF9i
eXRlczs8YnI+DQrCoCDCoCDCoCDCoCDCoHzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoF5+fn5+fn5+fn5+fjxicj4NCi0tPGJyPg0KJmd0OyZndDsgV2FybmluZzogZHJpdmVycy9t
bWMvY29yZS9tbWNwc3RvcmUuYzoyNTAgZnVuY3Rpb24gcGFyYW1ldGVyICYjMzk7c2VjdF9vZmZz
ZXQmIzM5OyBub3QgZGVzY3JpYmVkIGluICYjMzk7bW1jcHN0b3JlX2RvX3JlcXVlc3RfaW50ZXJu
YWwmIzM5Ozxicj4NCiZndDsmZ3Q7IFdhcm5pbmc6IGRyaXZlcnMvbW1jL2NvcmUvbW1jcHN0b3Jl
LmM6NTczIGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIG1tY3BzdG9yZV9yZWFkKCkuIFByb3RvdHlw
ZSB3YXMgZm9yIG1tY3BzdG9yZV9yZWFkX3pvbmUoKSBpbnN0ZWFkPGJyPg0KJmd0OyZndDsgV2Fy
bmluZzogZHJpdmVycy9tbWMvY29yZS9tbWNwc3RvcmUuYzoxMjQ4IGZ1bmN0aW9uIHBhcmFtZXRl
ciAmIzM5O2Rpc2smIzM5OyBub3QgZGVzY3JpYmVkIGluICYjMzk7bW1jcHN0b3JlX2NhcmRfYWRk
JiMzOTs8YnI+DQomZ3Q7Jmd0OyBXYXJuaW5nOiBkcml2ZXJzL21tYy9jb3JlL21tY3BzdG9yZS5j
OjI1MCBmdW5jdGlvbiBwYXJhbWV0ZXIgJiMzOTtzZWN0X29mZnNldCYjMzk7IG5vdCBkZXNjcmli
ZWQgaW4gJiMzOTttbWNwc3RvcmVfZG9fcmVxdWVzdF9pbnRlcm5hbCYjMzk7PGJyPg0KJmd0OyZn
dDsgV2FybmluZzogZHJpdmVycy9tbWMvY29yZS9tbWNwc3RvcmUuYzoxMjQ4IGZ1bmN0aW9uIHBh
cmFtZXRlciAmIzM5O2Rpc2smIzM5OyBub3QgZGVzY3JpYmVkIGluICYjMzk7bW1jcHN0b3JlX2Nh
cmRfYWRkJiMzOTs8YnI+DQo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+Rml4
ZWQgYWxsIHdhcm5pbmdzIGFuZCBzZW50IGEgdjQgdmVyc2lvbiBhIGNvdXBsZSBvZiB3ZWVrcyBi
YWNrLiBQbGVhc2UgcmV2aWV3IHRoZSB2NCBjaGFuZ2VzLsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KPGJyPg0KdmltICsvb2Zmc2V0X2J5dGVzICsxMDE2IGRy
aXZlcnMvbW1jL2NvcmUvbW1jcHN0b3JlLmM8YnI+DQo8YnI+DQrCoCDCoDk5OMKgIDxicj4NCsKg
IMKgOTk5wqAgLyoqPGJyPg0KwqAgMTAwMMKgIMKgKiBtbWNwc3RvcmVfcmVnaXN0ZXJfZm9yX2Nh
cmQgLSBSZWdpc3RlciBwc3RvcmUgZm9yIHNwZWNpZmljIE1NQyBjYXJkPGJyPg0KwqAgMTAwMcKg
IMKgKiBAY2FyZDogTU1DIGNhcmQgdG8gcmVnaXN0ZXIgcHN0b3JlIGZvcjxicj4NCsKgIDEwMDLC
oCDCoCogQGRldl9uYW1lX3BhcmFtOiBEZXZpY2UgcGF0aCAoZS5nLiwgJnF1b3Q7L2Rldi9tbWNi
bGsxcDUmcXVvdDspPGJyPg0KwqAgMTAwM8KgIMKgKiBAZGlzazogZ2VuZGlzayBmb3IgdGhlIGNh
cmQgKG5vbi1OVUxMIGZvciBidWlsdGluIHBhdGgsIE5VTEwgZm9yIG1vZHVsZSk8YnI+DQrCoCAx
MDA0wqAgwqAqPGJyPg0KwqAgMTAwNcKgIMKgKiBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIG5lZ2F0
aXZlIGVycm9yIG9uIGZhaWx1cmU8YnI+DQrCoCAxMDA2wqAgwqAqLzxicj4NCsKgIDEwMDfCoCBz
dGF0aWMgaW50IG1tY3BzdG9yZV9yZWdpc3Rlcl9mb3JfY2FyZChzdHJ1Y3QgbW1jX2NhcmQgKmNh
cmQsPGJyPg0KwqAgMTAwOMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqZGV2X25hbWVfcGFyYW0sPGJyPg0KwqAg
MTAwOcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3RydWN0IGdlbmRpc2sgKmRpc2spPGJyPg0KwqAgMTAxMMKgIHs8YnI+DQrCoCAx
MDExwqAgwqAgwqAgwqAgwqAgc3RydWN0IG1tY3BzdG9yZV9jb250ZXh0ICpjeHQ7PGJyPg0KwqAg
MTAxMsKgIMKgIMKgIMKgIMKgIHN0cnVjdCBwc3RvcmVfYmxrX2NvbmZpZyBjb25mOzxicj4NCsKg
IDEwMTPCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgZmlsZSAqYmRldl9maWxlOzxicj4NCsKgIDEwMTTC
oCDCoCDCoCDCoCDCoCBzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2Ozxicj4NCsKgIDEwMTXCoCDC
oCDCoCDCoCDCoCBzZWN0b3JfdCBwYXJ0aXRpb25fc2VjdG9yczs8YnI+DQomZ3Q7IDEwMTbCoCDC
oCDCoCDCoCDCoCB1bnNpZ25lZCBsb25nIG9mZnNldF9ieXRlczs8YnI+DQrCoCAxMDE3wqAgwqAg
wqAgwqAgwqAgdW5zaWduZWQgbG9uZyByZXF1aXJlZF9zaXplOzxicj4NCsKgIDEwMTjCoCDCoCDC
oCDCoCDCoCB1bnNpZ25lZCBsb25nIGttc2dfcmVjb3Jkczs8YnI+DQrCoCAxMDE5wqAgwqAgwqAg
wqAgwqAgaW50IHJldDs8YnI+DQrCoCAxMDIwwqAgPGJyPg0KwqAgMTAyMcKgIMKgIMKgIMKgIMKg
IC8qPGJyPg0KwqAgMTAyMsKgIMKgIMKgIMKgIMKgIMKgKiBPcGVuIHRoZSBibG9jayBkZXZpY2Ug
dG8gZ2V0IHBhcnRpdGlvbiBzdGFydCBzZWN0b3IgYW5kIHNpemUuPGJyPg0KwqAgMTAyM8KgIMKg
IMKgIMKgIMKgIMKgKiBXaGVuIGNhbGxlZCBmcm9tIG1tY19ibGtfcHJvYmUoKSAoYnVpbHRpbiBw
YXRoKSwgL2Rldi8gbWF5IG5vdDxicj4NCsKgIDEwMjTCoCDCoCDCoCDCoCDCoCDCoCogYmUgbW91
bnRlZCB5ZXQsIHNvIHVzZSB0aGUgZ2VuZGlzayArIHBhcnRpdGlvbiBudW1iZXIgdG8gbG9vazxi
cj4NCsKgIDEwMjXCoCDCoCDCoCDCoCDCoCDCoCogdXAgdGhlIGRldl90IGRpcmVjdGx5Ljxicj4N
CsKgIDEwMjbCoCDCoCDCoCDCoCDCoCDCoCovPGJyPg0KwqAgMTAyN8KgIMKgIMKgIMKgIMKgIGlm
IChkaXNrKSB7PGJyPg0KwqAgMTAyOMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBwYXJ0
bm8gPSBtbWNwc3RvcmVfZXh0cmFjdF9wYXJ0bm8oZGV2X25hbWVfcGFyYW0pOzxicj4NCsKgIDEw
MjnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfdCBkZXZ0Ozxicj4NCsKgIDEwMzDCoCA8
YnI+DQrCoCAxMDMxwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHBhcnRubyAmbHQ7IDAp
IHs8YnI+DQrCoCAxMDMywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJf
d2FybigmcXVvdDtDYW5ub3QgcGFyc2UgcGFydGl0aW9uIGZyb20gJXNcbiZxdW90Oyw8YnI+DQrC
oCAxMDMzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZGV2X25hbWVfcGFyYW0pOzxicj4NCsKgIDEwMzTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCByZXR1cm4gLUVJTlZBTDs8YnI+DQrCoCAxMDM1wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTxicj4NCsKgIDEwMzbCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZ0ID0g
cGFydF9kZXZ0KGRpc2ssIHBhcnRubyk7PGJyPg0KwqAgMTAzN8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGlmICghZGV2dCkgezxicj4NCsKgIDEwMzjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBwcl93YXJuKCZxdW90O1BhcnRpdGlvbiAlZCBub3QgZm91bmQgb24gJXNc
biZxdW90Oyw8YnI+DQrCoCAxMDM5wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcGFydG5vLCBkaXNrLSZndDtkaXNrX25hbWUpOzxicj4NCsKgIDEwNDDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVOT0RFVjs8YnI+
DQrCoCAxMDQxwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIDEwNDLCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBiZGV2X2ZpbGUgPSBiZGV2X2ZpbGVfb3Blbl9ieV9kZXYoZGV2
dCwgQkxLX09QRU5fUkVBRCw8YnI+DQrCoCAxMDQzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwg
TlVMTCk7PGJyPg0KwqAgMTA0NMKgIMKgIMKgIMKgIMKgIH0gZWxzZSB7PGJyPg0KwqAgMTA0NcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJkZXZfZmlsZSA9IGJkZXZfZmlsZV9vcGVuX2J5X3Bh
dGgoZGV2X25hbWVfcGFyYW0sPGJyPg0KwqAgMTA0NsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQkxL
X09QRU5fUkVBRCwgTlVMTCwgTlVMTCk7PGJyPg0KwqAgMTA0N8KgIMKgIMKgIMKgIMKgIH08YnI+
DQrCoCAxMDQ4wqAgwqAgwqAgwqAgwqAgaWYgKElTX0VSUihiZGV2X2ZpbGUpKSB7PGJyPg0KwqAg
MTA0OcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldCA9IFBUUl9FUlIoYmRldl9maWxlKTs8
YnI+DQrCoCAxMDUwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJfd2FybigmcXVvdDtGYWls
ZWQgdG8gb3BlbiBkZXZpY2UgJXM6ICVkXG4mcXVvdDssIGRldl9uYW1lX3BhcmFtLCByZXQpOzxi
cj4NCsKgIDEwNTHCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gcmV0Ozxicj4NCsKg
IDEwNTLCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgMTA1M8KgIMKgIMKgIMKgIMKgIGJkZXYgPSBm
aWxlX2JkZXYoYmRldl9maWxlKTs8YnI+DQrCoCAxMDU0wqAgPGJyPg0KwqAgMTA1NcKgIMKgIMKg
IMKgIMKgIGN4dCA9IG1tY3BzdG9yZV9jdHg7PGJyPg0KwqAgMTA1NsKgIMKgIMKgIMKgIMKgIGlm
ICghY3h0KSB7PGJyPg0KwqAgMTA1N8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByX2Vycigm
cXVvdDtObyBjb250ZXh0IGF2YWlsYWJsZVxuJnF1b3Q7KTs8YnI+DQrCoCAxMDU4wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZnB1dChiZGV2X2ZpbGUpOzxicj4NCsKgIDEwNTnCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVOT0RFVjs8YnI+DQrCoCAxMDYwwqAgwqAgwqAgwqAg
wqAgfTxicj4NCsKgIDEwNjHCoCA8YnI+DQrCoCAxMDYywqAgwqAgwqAgwqAgwqAgLyogcHJlLWFs
bG9jYXRlZCBidWZmZXIgZm9yIGFsaWdubWVudCBoYW5kbGluZyAqLzxicj4NCsKgIDEwNjPCoCDC
oCDCoCDCoCDCoCBjeHQtJmd0O2J1ZmZlcl9zaXplID0gTU1DX1BTVE9SRV9NQVhfQlVGRkVSX1NJ
WkU7PGJyPg0KwqAgMTA2NMKgIMKgIMKgIMKgIMKgIGN4dC0mZ3Q7YnVmZmVyID0ga21hbGxvYyhj
eHQtJmd0O2J1ZmZlcl9zaXplLCBHRlBfS0VSTkVMKTs8YnI+DQrCoCAxMDY1wqAgwqAgwqAgwqAg
wqAgaWYgKCFjeHQtJmd0O2J1ZmZlcikgezxicj4NCsKgIDEwNjbCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBwcl9lcnIoJnF1b3Q7RmFpbGVkIHRvIGFsbG9jYXRlICV6dSBieXRlcyBmb3IgcHN0
b3JlIGJ1ZmZlclxuJnF1b3Q7LDxicj4NCsKgIDEwNjfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGN4dC0mZ3Q7YnVmZmVyX3NpemUpOzxicj4NCsKgIDEwNjjCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBmcHV0KGJkZXZfZmlsZSk7PGJyPg0KwqAgMTA2OcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHJldHVybiAtRU5PTUVNOzxicj4NCsKgIDEwNzDCoCDCoCDCoCDCoCDC
oCB9PGJyPg0KwqAgMTA3McKgIDxicj4NCsKgIDEwNzLCoCDCoCDCoCDCoCDCoCBpZiAoIShjYXJk
LSZndDtob3N0LSZndDtjYXBzICZhbXA7IE1NQ19DQVBfTk9OUkVNT1ZBQkxFKSkgezxicj4NCsKg
IDEwNzPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJyKCZhbXA7Y2FyZC0mZ3Q7ZGV2
LCAmcXVvdDtNTUMgcHN0b3JlIG9ubHkgc3VwcG9ydHMgbm9uLXJlbW92YWJsZSBjYXJkcyAoZU1N
QylcbiZxdW90Oyk7PGJyPg0KwqAgMTA3NMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldl9l
cnIoJmFtcDtjYXJkLSZndDtkZXYsICZxdW90O1RoaXMgY2FyZCBpcyByZW1vdmFibGUgYW5kIG5v
dCBzdWl0YWJsZSBmb3IgcHN0b3JlXG4mcXVvdDspOzxicj4NCsKgIDEwNzXCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCByZXQgPSAtRU9QTk9UU1VQUDs8YnI+DQrCoCAxMDc2wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZ290byBlcnJfZnJlZTs8YnI+DQrCoCAxMDc3wqAgwqAgwqAgwqAgwqAg
fTxicj4NCsKgIDEwNzjCoCA8YnI+DQrCoCAxMDc5wqAgwqAgwqAgwqAgwqAgLyogSW5pdGlhbGl6
ZSBjb250ZXh0ICovPGJyPg0KwqAgMTA4MMKgIMKgIMKgIMKgIMKgIGN4dC0mZ3Q7Y2FyZCA9IGNh
cmQ7PGJyPg0KwqAgMTA4McKgIMKgIMKgIMKgIMKgIHN0cnNjcHkoY3h0LSZndDtjYXJkX25hbWUs
IGRldl9uYW1lX3BhcmFtLCBzaXplb2YoY3h0LSZndDtjYXJkX25hbWUpKTs8YnI+DQrCoCAxMDgy
wqAgwqAgwqAgwqAgwqAgY3h0LSZndDtzdGFydF9zZWN0ID0gYmRldi0mZ3Q7YmRfc3RhcnRfc2Vj
dDs8YnI+DQrCoCAxMDgzwqAgwqAgwqAgwqAgwqAgY3h0LSZndDtzaXplID0gYmRldl9ucl9ieXRl
cyhiZGV2KTs8YnI+DQrCoCAxMDg0wqAgPGJyPg0KwqAgMTA4NcKgIMKgIMKgIMKgIMKgIC8qIEFw
cGx5IHVzZXItc3BlY2lmaWVkIHNlY3RvciBvZmZzZXQgYW5kIGNvdW50IHdpdGhpbiB0aGUgcGFy
dGl0aW9uICovPGJyPg0KwqAgMTA4NsKgIMKgIMKgIMKgIMKgIGlmIChwYXJ0X3NlY3Rfb2ZzICZn
dDsgMCB8fCBwYXJ0X3NlY3RfY250ICZndDsgMCkgezxicj4NCsKgIDEwODfCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBpZiAoKHBhcnRfc2VjdF9vZnMgJmd0OyAwICZhbXA7JmFtcDsgcGFydF9z
ZWN0X2NudCA9PSAwKSB8fDxicj4NCsKgIDEwODjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAocGFydF9zZWN0X29mcyA9PSAwICZhbXA7JmFtcDsgcGFydF9zZWN0X2NudCAmZ3Q7IDAp
KSB7PGJyPg0KwqAgMTA4OcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRl
dl9lcnIoJmFtcDtjYXJkLSZndDtkZXYsICZxdW90O3NlY3Rvcl9vZmZzZXQgYW5kIHNlY3Rvcl9j
b3VudCBtdXN0IGJlIHNwZWNpZmllZFxuJnF1b3Q7KTs8YnI+DQrCoCAxMDkwwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gLUVJTlZBTDs8YnI+DQrCoCAxMDkxwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJfZnJlZTs8YnI+DQrC
oCAxMDkywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIDEwOTPCoCA8YnI+DQrC
oCAxMDk0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogVmFsaWRhdGUgb2Zmc2V0IGFuZCBj
b3VudCAqLzxicj4NCsKgIDEwOTXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXJ0aXRpb25f
c2VjdG9ycyA9IGN4dC0mZ3Q7c2l6ZSAmZ3Q7Jmd0OyA5Ozxicj4NCsKgIDEwOTbCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBvZmZzZXRfYnl0ZXMgPSBwYXJ0X3NlY3Rfb2ZzICogTU1DX1BTVE9S
RV9TRUNUT1JfU0laRTs8YnI+DQrCoCAxMDk3wqAgPGJyPg0KwqAgMTA5OMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGlmIChwYXJ0X3NlY3Rfb2ZzICZndDs9IHBhcnRpdGlvbl9zZWN0b3JzKSB7
PGJyPg0KwqAgMTA5OcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldl9l
cnIoJmFtcDtjYXJkLSZndDtkZXYsICZxdW90O1NlY3RvciBvZmZzZXQgJWx1ICZndDs9IHBhcnRp
dGlvbiBzaXplICVsbHUgc2VjdG9yc1xuJnF1b3Q7LDxicj4NCsKgIDExMDDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwYXJ0X3NlY3Rfb2ZzLCBwYXJ0
aXRpb25fc2VjdG9ycyk7PGJyPg0KwqAgMTEwMcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJldCA9IC1FSU5WQUw7PGJyPg0KwqAgMTEwMsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyX2ZyZWU7PGJyPg0KwqAgMTEwM8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCAxMTA0wqAgPGJyPg0KwqAgMTEwNcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmIChwYXJ0X3NlY3Rfb2ZzICsgcGFydF9zZWN0X2NudCAmZ3Q7IHBh
cnRpdGlvbl9zZWN0b3JzKSB7PGJyPg0KwqAgMTEwNsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGRldl9lcnIoJmFtcDtjYXJkLSZndDtkZXYsICZxdW90O1NlY3RvciByYW5n
ZSAlbHUtJWx1IGV4Y2VlZHMgcGFydGl0aW9uIHNpemUgJWxsdSBzZWN0b3JzXG4mcXVvdDssPGJy
Pg0KwqAgMTEwN8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHBhcnRfc2VjdF9vZnMsPGJyPg0KwqAgMTEwOMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhcnRfc2VjdF9vZnMgKyBwYXJ0X3NlY3RfY250IC0g
MSw8YnI+DQrCoCAxMTA5wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcGFydGl0aW9uX3NlY3RvcnMpOzxicj4NCsKgIDExMTDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXQgPSAtRUlOVkFMOzxicj4NCsKgIDExMTHCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycl9mcmVlOzxicj4NCsKgIDEx
MTLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgMTExM8KgIDxicj4NCsKgIDEx
MTTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjeHQtJmd0O3N0YXJ0X3NlY3QgKz0gcGFydF9z
ZWN0X29mczs8YnI+DQrCoCAxMTE1wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3h0LSZndDtz
aXplID0gcGFydF9zZWN0X2NudCAqIE1NQ19QU1RPUkVfU0VDVE9SX1NJWkU7PGJyPg0KwqAgMTEx
NsKgIDxicj4NCsKgIDExMTfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcl9pbmZvKCZxdW90
O1BzdG9yZSB3aWxsIHVzZTogc2VjdG9ycyAlbHUtJWx1ICglbGx1IGJ5dGVzIHRvdGFsKVxuJnF1
b3Q7LDxicj4NCsKgIDExMTjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBw
YXJ0X3NlY3Rfb2ZzLCBwYXJ0X3NlY3Rfb2ZzICsgcGFydF9zZWN0X2NudCAtIDEsPGJyPg0KwqAg
MTExOcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGN4dC0mZ3Q7c2l6ZSk7
PGJyPg0KwqAgMTEyMMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCAxMTIxwqAgPGJyPg0KwqAgMTEy
MsKgIMKgIMKgIMKgIMKgIGZwdXQoYmRldl9maWxlKTs8YnI+DQrCoCAxMTIzwqAgPGJyPg0KwqAg
MTEyNMKgIMKgIMKgIMKgIMKgIC8qIENvbmZpZ3VyZSBwc3RvcmUgKi88YnI+DQrCoCAxMTI1wqAg
wqAgwqAgwqAgwqAgbWVtc2V0KCZhbXA7Y29uZiwgMCwgc2l6ZW9mKGNvbmYpKTs8YnI+DQrCoCAx
MTI2wqAgwqAgwqAgwqAgwqAgc3Ryc2NweShjb25mLmRldmljZSwgZGV2X25hbWVfcGFyYW0sIHNp
emVvZihjb25mLmRldmljZSkpOzxicj4NCsKgIDExMjfCoCDCoCDCoCDCoCDCoCBjb25mLm1heF9y
ZWFzb24gPSBLTVNHX0RVTVBfUEFOSUM7PGJyPg0KwqAgMTEyOMKgIDxicj4NCsKgIDExMjnCoCDC
oCDCoCDCoCDCoCAvKiBGZXRjaCBwc3RvcmUgY29uZmlndXJhdGlvbiBpbmNsdWRpbmcgc2l6ZXMg
ZnJvbSBtb2R1bGUgcGFyYW1ldGVycyAqLzxicj4NCsKgIDExMzDCoCDCoCDCoCDCoCDCoCByZXQg
PSBwc3RvcmVfYmxrX2dldF9jb25maWcoJmFtcDtjb25mKTs8YnI+DQrCoCAxMTMxwqAgwqAgwqAg
wqAgwqAgaWYgKHJldCAhPSAwKSB7PGJyPg0KwqAgMTEzMsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHByX2VycigmcXVvdDtGYWlsZWQgdG8gZ2V0IHBzdG9yZSBibG9jayBjb25maWc6ICVkXG4m
cXVvdDssIHJldCk7PGJyPg0KwqAgMTEzM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8g
ZXJyX2ZyZWU7PGJyPg0KwqAgMTEzNMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCAxMTM1wqAgPGJy
Pg0KwqAgMTEzNsKgIMKgIMKgIMKgIMKgIC8qIFZhbGlkYXRlIHNpemUgcmVxdWlyZW1lbnRzICov
PGJyPg0KwqAgMTEzN8KgIMKgIMKgIMKgIMKgIHJldCA9IG1tY3BzdG9yZV9jYWxjdWxhdGVfc2l6
ZXMoY3h0LCAmYW1wO2NvbmYsICZhbXA7cmVxdWlyZWRfc2l6ZSw8YnI+DQrCoCAxMTM4wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
JmFtcDtrbXNnX3JlY29yZHMpOzxicj4NCsKgIDExMznCoCDCoCDCoCDCoCDCoCBpZiAocmV0KTxi
cj4NCsKgIDExNDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycl9mcmVlOzxicj4N
CsKgIDExNDHCoCA8YnI+DQrCoCAxMTQywqAgwqAgwqAgwqAgwqAgcHJfZGVidWcoJnF1b3Q7UHN0
b3JlIHJlcXVpcmVtZW50czoga21zZz0lbHUgS0IsIHBtc2c9JWx1IEtCLCBjb25zb2xlPSVsdSBL
QiwgZnRyYWNlPSVsdSBLQlxuJnF1b3Q7LDxicj4NCsKgIDExNDPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBNTUNfUFNUT1JFX0JZVEVTX1RPX0tCKGNvbmYua21zZ19zaXplKSw8YnI+DQrCoCAx
MTQ0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTU1DX1BTVE9SRV9CWVRFU19UT19LQihjb25m
LnBtc2dfc2l6ZSksPGJyPg0KwqAgMTE0NcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1NQ19Q
U1RPUkVfQllURVNfVE9fS0IoY29uZi5jb25zb2xlX3NpemUpLDxicj4NCsKgIDExNDbCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBNTUNfUFNUT1JFX0JZVEVTX1RPX0tCKGNvbmYuZnRyYWNlX3Np
emUpKTs8YnI+DQrCoCAxMTQ3wqAgwqAgwqAgwqAgwqAgcHJfZGVidWcoJnF1b3Q7UHN0b3JlIGNh
cGFjaXR5OiB+JWx1IGttc2cgcmVjb3JkcyBwb3NzaWJsZSAoJWx1IEtCIGVhY2gsIHZhcmllcyB3
aXRoIGNvbXByZXNzaW9uKVxuJnF1b3Q7LDxicj4NCsKgIDExNDjCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBrbXNnX3JlY29yZHMsIE1NQ19QU1RPUkVfQllURVNfVE9fS0IoY29uZi5rbXNnX3Np
emUpKTs8YnI+DQrCoCAxMTQ5wqAgPGJyPg0KwqAgMTE1MMKgIMKgIMKgIMKgIMKgIC8qIFNldCB1
cCBwc3RvcmUgZGV2aWNlIGluZm8gKi88YnI+DQrCoCAxMTUxwqAgwqAgwqAgwqAgwqAgY3h0LSZn
dDtkZXYuZmxhZ3MgPSAwOyAvKiBTdXBwb3J0IGFsbCBiYWNrZW5kcyAqLzxicj4NCsKgIDExNTLC
oCDCoCDCoCDCoCDCoCBpZiAoY29uZi5rbXNnX3NpemUgJmd0OyAwKTxicj4NCsKgIDExNTPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjeHQtJmd0O2Rldi5mbGFncyB8PSBQU1RPUkVfRkxBR1Nf
RE1FU0c7PGJyPg0KwqAgMTE1NMKgIMKgIMKgIMKgIMKgIGlmIChjb25mLnBtc2dfc2l6ZSAmZ3Q7
IDApPGJyPg0KwqAgMTE1NcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGN4dC0mZ3Q7ZGV2LmZs
YWdzIHw9IFBTVE9SRV9GTEFHU19QTVNHOzxicj4NCsKgIDExNTbCoCDCoCDCoCDCoCDCoCBpZiAo
Y29uZi5jb25zb2xlX3NpemUgJmd0OyAwKTxicj4NCsKgIDExNTfCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBjeHQtJmd0O2Rldi5mbGFncyB8PSBQU1RPUkVfRkxBR1NfQ09OU09MRTs8YnI+DQrC
oCAxMTU4wqAgwqAgwqAgwqAgwqAgaWYgKGNvbmYuZnRyYWNlX3NpemUgJmd0OyAwKTxicj4NCsKg
IDExNTnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjeHQtJmd0O2Rldi5mbGFncyB8PSBQU1RP
UkVfRkxBR1NfRlRSQUNFOzxicj4NCsKgIDExNjDCoCA8YnI+DQrCoCAxMTYxwqAgwqAgwqAgwqAg
wqAgLyogU2V0IHVwIHpvbmUgc3RydWN0dXJlIGZvciBwc3RvcmUvem9uZSBBUEkgKi88YnI+DQrC
oCAxMTYywqAgwqAgwqAgwqAgwqAgY3h0LSZndDtkZXYuem9uZS5yZWFkID0gbW1jcHN0b3JlX3Jl
YWRfem9uZTs8YnI+DQrCoCAxMTYzwqAgwqAgwqAgwqAgwqAgY3h0LSZndDtkZXYuem9uZS53cml0
ZSA9IG1tY3BzdG9yZV93cml0ZTs8YnI+DQrCoCAxMTY0wqAgwqAgwqAgwqAgwqAgY3h0LSZndDtk
ZXYuem9uZS5wYW5pY193cml0ZSA9IG1tY3BzdG9yZV9wYW5pY193cml0ZTs8YnI+DQrCoCAxMTY1
wqAgwqAgwqAgwqAgwqAgY3h0LSZndDtkZXYuem9uZS50b3RhbF9zaXplID0gY3h0LSZndDtzaXpl
Ozxicj4NCsKgIDExNjbCoCDCoCDCoCDCoCDCoCBjeHQtJmd0O2Rldi56b25lLmttc2dfc2l6ZSA9
IGNvbmYua21zZ19zaXplOzxicj4NCsKgIDExNjfCoCDCoCDCoCDCoCDCoCBjeHQtJmd0O2Rldi56
b25lLnBtc2dfc2l6ZSA9IGNvbmYucG1zZ19zaXplOzxicj4NCsKgIDExNjjCoCDCoCDCoCDCoCDC
oCBjeHQtJmd0O2Rldi56b25lLmNvbnNvbGVfc2l6ZSA9IGNvbmYuY29uc29sZV9zaXplOzxicj4N
CsKgIDExNjnCoCDCoCDCoCDCoCDCoCBjeHQtJmd0O2Rldi56b25lLmZ0cmFjZV9zaXplID0gY29u
Zi5mdHJhY2Vfc2l6ZTs8YnI+DQrCoCAxMTcwwqAgwqAgwqAgwqAgwqAgY3h0LSZndDtkZXYuem9u
ZS5tYXhfcmVhc29uID0gY29uZi5tYXhfcmVhc29uOzxicj4NCsKgIDExNzHCoCDCoCDCoCDCoCDC
oCBjeHQtJmd0OzxhIGhyZWY9Imh0dHA6Ly9kZXYuem9uZS5uYW1lIiByZWw9Im5vcmVmZXJyZXIi
IHRhcmdldD0iX2JsYW5rIj5kZXYuem9uZS5uYW1lPC9hPiA9ICZxdW90O21tY3BzdG9yZSZxdW90
Ozs8YnI+DQrCoCAxMTcywqAgwqAgwqAgwqAgwqAgY3h0LSZndDtkZXYuem9uZS5vd25lciA9IFRI
SVNfTU9EVUxFOzxicj4NCsKgIDExNzPCoCA8YnI+DQrCoCAxMTc0wqAgwqAgwqAgwqAgwqAgbXV0
ZXhfaW5pdCgmYW1wO2N4dC0mZ3Q7bG9jayk7PGJyPg0KwqAgMTE3NcKgIDxicj4NCsKgIDExNzbC
oCDCoCDCoCDCoCDCoCAvKjxicj4NCsKgIDExNzfCoCDCoCDCoCDCoCDCoCDCoCogU2V0IHN0YXRl
IHRvIFJFQURZIGJlZm9yZSByZWdpc3RyYXRpb24gYmVjYXVzZSByZWdpc3Rlcl9wc3RvcmVfZGV2
aWNlKCk8YnI+DQrCoCAxMTc4wqAgwqAgwqAgwqAgwqAgwqAqIHRyaWdnZXJzIHBzdG9yZV96b25l
IHJlY292ZXJ5IHdoaWNoIGNhbGxzIG91ciByZWFkIGNhbGxiYWNrLCBhbmQgdGhlPGJyPg0KwqAg
MTE3OcKgIMKgIMKgIMKgIMKgIMKgKiByZWFkIGNhbGxiYWNrIHJlcXVpcmVzIHN0YXRlID09IFJF
QURZIHRvIHByb2NlZWQuPGJyPg0KwqAgMTE4MMKgIMKgIMKgIMKgIMKgIMKgKi88YnI+DQrCoCAx
MTgxwqAgwqAgwqAgwqAgwqAgbXV0ZXhfbG9jaygmYW1wO21tY3BzdG9yZV9nbG9iYWxfbG9jayk7
PGJyPg0KwqAgMTE4MsKgIMKgIMKgIMKgIMKgIGN4dC0mZ3Q7c3RhdGUgPSBNTUNQU1RPUkVfU1RB
VEVfUkVBRFk7PGJyPg0KwqAgMTE4M8KgIMKgIMKgIMKgIMKgIG11dGV4X3VubG9jaygmYW1wO21t
Y3BzdG9yZV9nbG9iYWxfbG9jayk7PGJyPg0KwqAgMTE4NMKgIDxicj4NCsKgIDExODXCoCDCoCDC
oCDCoCDCoCByZXQgPSByZWdpc3Rlcl9wc3RvcmVfZGV2aWNlKCZhbXA7Y3h0LSZndDtkZXYpOzxi
cj4NCsKgIDExODbCoCDCoCDCoCDCoCDCoCBpZiAocmV0KSB7PGJyPg0KwqAgMTE4N8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGRldl9lcnIoJmFtcDtjYXJkLSZndDtkZXYsICZxdW90O0ZhaWxl
ZCB0byByZWdpc3RlciBwc3RvcmUgZGV2aWNlOiAlZFxuJnF1b3Q7LDxicj4NCsKgIDExODjCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXQpOzxicj4NCsKgIDExODnCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtdXRleF9sb2NrKCZhbXA7bW1jcHN0b3JlX2dsb2JhbF9s
b2NrKTs8YnI+DQrCoCAxMTkwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3h0LSZndDtzdGF0
ZSA9IE1NQ1BTVE9SRV9TVEFURV9VTklOSVRJQUxJWkVEOzxicj4NCsKgIDExOTHCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBtdXRleF91bmxvY2soJmFtcDttbWNwc3RvcmVfZ2xvYmFsX2xvY2sp
Ozxicj4NCsKgIDExOTLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycl9mcmVlOzxi
cj4NCsKgIDExOTPCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgMTE5NMKgIDxicj4NCsKgIDExOTXC
oCDCoCDCoCDCoCDCoCBkZXZfaW5mbygmYW1wO2NhcmQtJmd0O2RldiwgJnF1b3Q7TU1DIHBzdG9y
ZSBiYWNrZW5kIHJlZ2lzdGVyZWQgc3VjY2Vzc2Z1bGx5XG4mcXVvdDspOzxicj4NCsKgIDExOTbC
oCDCoCDCoCDCoCDCoCBkZXZfaW5mbygmYW1wO2NhcmQtJmd0O2RldiwgJnF1b3Q7RGV2aWNlOiAl
cywgU2l6ZTogJWxsdSBieXRlcyAoJWxsdSBLQilcbiZxdW90Oyw8YnI+DQrCoCAxMTk3wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXZfbmFtZV9wYXJhbSwgY3h0LSZndDtzaXplLCBNTUNf
UFNUT1JFX0JZVEVTX1RPX0tCKGN4dC0mZ3Q7c2l6ZSkpOzxicj4NCsKgIDExOTjCoCDCoCDCoCDC
oCDCoCBkZXZfaW5mbygmYW1wO2NhcmQtJmd0O2RldiwgJnF1b3Q7U3RhcnQgc2VjdG9yOiAlbGx1
LCBTZWN0b3IgY291bnQ6ICVsbHVcbiZxdW90Oyw8YnI+DQrCoCAxMTk5wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBjeHQtJmd0O3N0YXJ0X3NlY3QsIGN4dC0mZ3Q7c2l6ZSAvIE1NQ19QU1RP
UkVfU0VDVE9SX1NJWkUpOzxicj4NCsKgIDEyMDDCoCDCoCDCoCDCoCDCoCBkZXZfaW5mbygmYW1w
O2NhcmQtJmd0O2RldiwgJnF1b3Q7UHN0b3JlIGNvbXBvbmVudHM6IGttc2c9JWx1IEtCLCBwbXNn
PSVsdSBLQiwgY29uc29sZT0lbHUgS0IsIGZ0cmFjZT0lbHUgS0JcbiZxdW90Oyw8YnI+DQrCoCAx
MjAxwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTUNfUFNUT1JFX0JZVEVTX1RPX0tCKGNv
bmYua21zZ19zaXplKSw8YnI+DQrCoCAxMjAywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBN
TUNfUFNUT1JFX0JZVEVTX1RPX0tCKGNvbmYucG1zZ19zaXplKSw8YnI+DQrCoCAxMjAzwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTUNfUFNUT1JFX0JZVEVTX1RPX0tCKGNvbmYuY29uc29s
ZV9zaXplKSw8YnI+DQrCoCAxMjA0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTUNfUFNU
T1JFX0JZVEVTX1RPX0tCKGNvbmYuZnRyYWNlX3NpemUpKTs8YnI+DQrCoCAxMjA1wqAgPGJyPg0K
wqAgMTIwNsKgIMKgIMKgIMKgIMKgIHJldHVybiAwOzxicj4NCsKgIDEyMDfCoCA8YnI+DQrCoCAx
MjA4wqAgZXJyX2ZyZWU6PGJyPg0KwqAgMTIwOcKgIMKgIMKgIMKgIMKgIGtmcmVlKGN4dC0mZ3Q7
YnVmZmVyKTs8YnI+DQrCoCAxMjEwwqAgwqAgwqAgwqAgwqAgLyogRG9uJiMzOTt0IGZyZWUgY3h0
IGhlcmUgLSBpdCYjMzk7cyB0aGUgZ2xvYmFsIGNvbnRleHQgKi88YnI+DQrCoCAxMjExwqAgwqAg
wqAgwqAgwqAgcmV0dXJuIHJldDs8YnI+DQrCoCAxMjEywqAgfTxicj4NCsKgIDEyMTPCoCA8YnI+
DQo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzPC9kaXY+PGRpdj5L
YW1hbDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+DQotLSA8YnI+DQow
LURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlPGJyPg0KPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIu
Y29tL2ludGVsL2xrcC10ZXN0cy93aWtpIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij5odHRwczovL2dpdGh1Yi5jb20vaW50ZWwvbGtwLXRlc3RzL3dpa2k8L2E+PGJyPg0KPC9ibG9j
a3F1b3RlPjwvZGl2PjwvZGl2Pg0K
--0000000000005c8849064f1cb657--

--000000000000719669064f1cb6c1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H0K0rs+X8O45xZIUJlxzf5UZex3BLi1f/H+08rSQULWEtO/ECwkFod2DIzSX7fZdz5RQ1PpziEOp
goo/JZPYIeCmgt3rIyvMuupj8Ymb0J/velhpXfQuYUM52viw2nmqVcxCwBqyM3Iq7eI4xtEOFRmR
wxSizd3MSQMf6GCHA4/B/6ttnxhGAr3utaOU+x/RnzG0gPLTW1XRAQ0+GVc/tGFdI864OG1cyrRl
GvBnHJQSAFOIKwYrUk2oFpgMbafQ6osCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQEAwIFoDAMBgNV
HRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIgYDVR0RBBswGYEX
a2FtYWwuZGFzdUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAU
ACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFOV9h+N/T9ZsJ40qRxh7NYYD+N6MMA0GCSqG
SIb3DQEBCwUAA4ICAQAKtKh30wv1/30230mCimgUjMWQE/LImRmyfDgrp2IhBVS6mDun+wH8thEB
WhBHQMz3gsGixU4ZBJG72eWi39IzQ7CGnisJwA0+hsGaGg03AVtFtqo1rXYRZ81MEDOb6BPYLigJ
RsHbNmrUGR+LsGeUwOWUeRXqBrYaYFrkgHKvVK1NEewv+vUY08n4tsezO3jq0HKhVDY46bMbf8vL
oQqqhtcQvu2+5FK2jpUayeubpzPwobjEG61RIhBvM0KivY4CB2s9A7qgjL1XBycAybIvG03BbFoT
t282FqXwk9JU6YihLlt+hpzO9UF7E8GZYlQlVIZOLOvytqilhua+2h77Yy8Jz/FJyIXKuaLPtvb2
SC2shL7jF28kQbP3QUKwAig+cxwbpngnUkd9D9cXSHVq9PPwYm0A4eAO0YQ/80Uq20+gXF++g0sy
NKrrV3i0T1dbCd86miGDKvarGzjh7pdsdwNY15liGP6Orib1tnWkJcbtP1rJty4r/mbbxcK8ILO4
IvTGFG6BfjJ+La0aRt69i1fQmjUWHLwzkLNpw9cJH8/MONZcEJeDkq9WELSyy29bagStk5KHu7NO
TH65sZg+i/4qmj3DEeEGTr/Shzp4YWSNn4W7NEelr0VgDlwa7xqlwZjXxG4MIJqy0SsQlAwEXtqd
nH2FpJfzgAetkuyU6DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEca
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgyFV0Mfmtletwg95r
/3yCjpwctd/VNlImqg9dyy/rZZYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYwNDEwMTUyMzE4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAb3nbx2NBv0Kjn4VMU1m1iXe+LVIBNjlXMJbZ/0zPbn4jhBSyD8ed
s6RAAcuT1JREC96l/C8P18KEgNxfxTHXulmvbzpYzrFwUPP2VxMj9xsaInFIEr/pRVZovQm7rZ8g
I3oCyg5syDaI0KAuXDGcPXgCTuqmDWTzziC7VNJ0SN/kYwbTP8y6JI5Mjfr7xm4fohm6YWNx/YMx
DWev+uP6JG3My/0HDZeu5F6NFE+m23HnH0DwcqqTvmvskmOrLQ2S6KUMu73DBELpy7kGm9Us6BjA
uZmaa4+qdy0rSbDg1g3OrDtU3oeSBgIzZTUYu3kfNjf2cM1Dv/GwB9GVh9XMjg==
--000000000000719669064f1cb6c1--
