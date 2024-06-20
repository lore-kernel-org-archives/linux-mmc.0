Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B18386
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718857892; cv=none; b=TNcbniVyB4fWuygEvRKv6U+5zGwobYvlPMWeVaoe339l+QcR7vLxD1I7H7ErsVPPeYg1+kKvzYlsKuOrU6O2pxlriK1jr90u6+hNZ1bjX8NlqzAnCvC6Q0FNMubOb4T98EDsef6DX54B5JPWv+2W52T9tPmTrmeiy3Tjtge+IfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718857892; c=relaxed/simple;
	bh=Qfm/Xr0C4A6kQnsrwWmYapehcCV2jhQ2MbLKZHuZyQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NV3XzQBk+zPN/Ex2rfOI9xa0Y1Kftj6yRuwK3i3A6y/x7xVRVMrXweSXsOwCso9b/c03SUDaLbSCLzAU9daLk4rC3KdwdRtCnoKJ1tKnz8VYjtp62YCtiGhG0Z4S5GuyqxHKAWEkMqTNveVhdOdPV2Exs7wsdA6rflhudit15Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k27XmsxK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k27XmsxK"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso431413a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Jun 2024 21:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718857890; x=1719462690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hp1Bcnp+P0RgQBTpBx5/4rF/Kc1Obevj1Aa8WoZ1M3Q=;
        b=k27XmsxKSLTyE8BmFzq4J5qoMUURquhBQWkB/ZOjsEpZWYvDuUbak9q0oBRkQMpSDQ
         ErMGJAuWKf91mlf9ufxRCDnXjdcYX+mRqUZHWI2RiH1U4nwVydaiAcR/dliK8P0fDaIV
         Iv7QlCFlac3Pm2rXYi5Sn2GwiU++AIwvYA03FOJanw7EMeSxtsof5vtNKQ6TgC/Aejkk
         GPysVsGccUdKiKaCe+8H2SJpoDDKNF/hkXlWR6om/PX3oXv4tFkFgERlC7UPDxKx8exn
         7CU3oGuYGkFNw3X/3drsLW8AN/2i5UC2PmEpUkTnxKazgbPuQzZHYDJL0+GiAewvXv3d
         o7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718857890; x=1719462690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hp1Bcnp+P0RgQBTpBx5/4rF/Kc1Obevj1Aa8WoZ1M3Q=;
        b=Hg+0o7Hekx+kQygenvkxr01ZyMK/PRElfTsA6j8PSAJ6yv91WVdelTnCWDgeLGYct7
         wLVNT4lfpUsX1blYbd6ChBOaYaLesqsTDUt/m/f2RXE/hcKO+yL+AqsviyFdwmjn+JZt
         54oOcgnHQo0+v9UTF95R5SyHYflirIfGESxavAHu4dgarlgr8sHMwj4KMmKiHAR+MrUe
         mrtikNiFj7RV0p2AY7Dnu3wcc1KiLgNvLmbCE1g1ryHrO7d61DrHMgk2slSi88GE49Wf
         kZb3O5qm7IXYTWm/PUuk/GZzRBg3nq3/YfUG92cJgUlQaX9LCL7uH9Wz6/DJSb40xJlg
         EM7g==
X-Gm-Message-State: AOJu0YyxcjGbsWsN13Gg+VpApSyJrb901f8ezq8BA4uXvNJ6BkXPnslS
	JTiRbhVcu3EhPZLWdtbiXO9vTy5E7Hcwg/3EFlcpaNncVespUjaOrEnWa3waWNlIX3LrCEli42s
	a4SFhEpeo8bRFLzwF2qxjuyzI6u2gPqrs
X-Google-Smtp-Source: AGHT+IFsDFzpivVoXaBwwPwEAFaInNmefLsgfxHOvxdKNjoL9ATXFk25fG+Tbycui9F7hGWGDoDekMc/VejxDgIYnCM=
X-Received: by 2002:a17:90a:3009:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2c7b58fb984mr4312828a91.5.1718857889842; Wed, 19 Jun 2024
 21:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BY5PR08MB6264AE3F237D7E11B9AEFBA4CA052@BY5PR08MB6264.namprd08.prod.outlook.com>
 <SN4PR0801MB77274A7D8C6A14020C61A406CA0C2@SN4PR0801MB7727.namprd08.prod.outlook.com>
 <CABqN7BzAp8m=Q40n+HVfDq4L9SeuQz9m2z5=5bFNdqeuQfpb2w@mail.gmail.com>
In-Reply-To: <CABqN7BzAp8m=Q40n+HVfDq4L9SeuQz9m2z5=5bFNdqeuQfpb2w@mail.gmail.com>
From: Zhan Liu <liuzhanjobs@gmail.com>
Date: Wed, 19 Jun 2024 21:30:53 -0700
Message-ID: <CABqN7BzKWb4xR1uLRtJKXj8pr_0osNESmE0VY0koEPo-0hc_Fg@mail.gmail.com>
Subject: [PATCH v2] mmc-utils: FFU Status check for device without FW install support
To: "To: 'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Problem and my changes

               ffu:also check ffu status for FW install not support
device to catch the possible error of FW download error
(FFU_STATUS[0x26] = 0x12), which is not captured by current mmc-utils.
current mmc-utils simple ask user to reboot, which give the user false
impression that the FW update is successful. they will only found it
is not after they check the FW version with extcsd read command and
have not idea what is wrong since at this time the FFU_STATUS has been
reset to 0x00. With this patch, user will know that FW download is
failed.

when check the devce don't support FW install, read extcsd and check
the FFU_STATUS value. If it is 0x00, ask user to reboot. If not, print
the error message and exit.



---

Signed-off-by:  Zhan Liu <liuzhanjobs@gmail.com>

---

diff --git a/mmc.h b/mmc.h

index 6f1bf3e..5b06410 100644

--- a/mmc.h

+++ b/mmc.h

@@ -229,6 +229,14 @@

#define EXT_CSD_SEC_GB_CL_EN                         (1<<4)

#define EXT_CSD_SEC_ER_EN                  (1<<0)



+/*

+ * FFU status definition

+ */

+#define EXT_CSD_FFU_SUCCESS
             (0x00)

+#define EXT_CSD_FFU_GENERAL_ERROR                                        (0x10)

+#define EXT_CSD_FFU_FIWMWARE_INSTALL_ERROR                   (0x11)

+#define EXT_CSD_FFU_FIWMWARE_DOWNLOAD_ERROR                         (0x12)

+



 /* From kernel linux/mmc/core.h */

#define MMC_RSP_NONE          0
 /* no response */

diff --git a/mmc_cmds.c b/mmc_cmds.c

index 936e0c5..10bdb94 100644

--- a/mmc_cmds.c

+++ b/mmc_cmds.c

@@ -2962,9 +2962,38 @@ do_retry:

              * if not then skip checking number of sectors programmed
after install

              */

             if (!ext_csd[EXT_CSD_FFU_FEATURES]) {

-                           fprintf(stderr, "Please reboot to complete
firmware installation on %s\n", device);

-                           ret = 0;

-                           goto out;

+                           ret = read_extcsd(dev_fd, ext_csd); //get
the current extcsd after FW download

+                           if (ret) {

+                                         fprintf(stderr, "Could not
read EXT_CSD from %s\n", device);

+                                         goto out;

+                           }

+

+                           switch (ext_csd[EXT_CSD_FFU_STATUS]) {

+                           case EXT_CSD_FFU_SUCCESS:

+                                         fprintf(stderr, "Please
reboot to complete firmware installation on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           case EXT_CSD_FFU_GENERAL_ERROR:

+                                         fprintf(stderr, "FFU General
Error on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           case EXT_CSD_FFU_FIWMWARE_INSTALL_ERROR:
//may never happen since we have not install firmware

+                                         fprintf(stderr, "FFU Install
Error on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           case EXT_CSD_FFU_FIWMWARE_DOWNLOAD_ERROR:
//main purpose is to check this since it will be cleared after power
cycle

+                                         fprintf(stderr, "FFU FW
Download Error on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           default:

+                                         fprintf(stderr, "Unknown FFU
Status on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+                           }

             }



              ret = read_extcsd(dev_fd, ext_csd);
