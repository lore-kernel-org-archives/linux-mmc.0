Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2663F8F4
	for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330411; cv=none; b=ekR3jD9y8xR/Era6JEVd1XYLDhAUkqWE5OkKluP9dUutxFENpkM0Pi3bBnccmI5LiA4rchQjhM7+A/Cy7nBU4vEUK2+DBO5hPm3UyVzIVNbPkImwbMFrmgDQw9UuvHVYelNAkGxV3XUrADd01EYaObmf0tkI48OM/G97ZE65l4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330411; c=relaxed/simple;
	bh=bf5u4niR/fxRfBTdEPHkaa81VpRplKSi5Qjc1OqtSW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2ynZjR1Blh7KAiIdqpfYtCxIfvzTNXtUta9M2JmM2E6rHM/0m7jYRkSpdyFsNyqjH5284P58h/HtinOuQmhcz/iVlj2dsH4aClqDCw4g7fR6Hjb3gkIxxdFSXdndzGQDRx0K47eS3zTpIvu1Q5BjB958geBef0DAxGv9PYqPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KqQfqI0r; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqQfqI0r"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513c53ed3d8so1041937e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710330407; x=1710935207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sbwx9dfEziliV/89SgDp+Lh5N2uRdyFDXcCaHRpuvlE=;
        b=KqQfqI0rT2jYItlfzDd9WZO7nSy5L3lVVWVZpmQFoCRcqoV4CazAUH3I6eb6M6e+SI
         isTbGwbEVAZLeqTU4peDy45kC0GZr78HWQgXTkGA6d9Zd7BP/YvaTif2+haWwfiodiK2
         TmYtZdUaUttvqzKSP2Xs5tmtVDd2w8eQpC1oRbLo874w+PkottuIoHwR6cgHAxChAJ9F
         JTSh7lqkufoY9yiEAcZzL9GVstlWA4/baBz9ve7qJW9bosVWp63mzWtvMnQMsNfgW4oy
         ZRAHcvizTzbMhzgdlNh2ZlObcQ7ytgPvpaQJlxKTA7DJvl555OTxqVMycg9O+v6WYApa
         N6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710330407; x=1710935207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sbwx9dfEziliV/89SgDp+Lh5N2uRdyFDXcCaHRpuvlE=;
        b=rpBRGE90lM05FMF7pi+9QXMAtd80dQPFH1h66RGtOhtyw8yhXlJmpR65s+b/yzGtxh
         GtD7BeKSUUgpS3MP1GgrpFuZvDFk5soD6jZLv443J7+g2iuU2mkP5KgKX5G5qEtoSD4y
         sYn/ZbqMP/DYqDwyKsyTc8Kdi1lrVZUHzWBqzDDXCJEll/LxwgMC+o7YUbV0kxJ6lRS/
         Fwh3s7iPaf5yMOSlWanS1RikpodlAeeLr3AhjgLapuMRdqxQo9wk5uh9hHBzZ1hpVM2M
         cHQEkDLYpv4c/EezzGv0SrvrOjFFAUfBdwE2zmqhyeAezwVWhX0aXTwvqn/bmWFfCLYh
         V4bg==
X-Forwarded-Encrypted: i=1; AJvYcCWMp2jT0dFMI5fL5FpDdx27be1kmd+DiGzxSG6O3GNnGYa8nsxvO898UPrjuNRaHDPBHhGG1rK0wkhbOEIksHmp2W7bUSJca1bV
X-Gm-Message-State: AOJu0Yzg8wGMXenp5PTXQIRqBh3Di9tniIS4dObKWNEHEUaQVMTZV4aP
	MgDJ1TR43JowEyLSfiqAx/GDDn+DPK8eO5hEpeLXiX1n3CEzUpWKkVJPpVcGZ/I=
X-Google-Smtp-Source: AGHT+IGrifXBUaSu4ytZ+qn2OPigkgvfGBbZWRmkEMzgxHnYAQx+khMgSrAhsfZineoFLATAIZThXg==
X-Received: by 2002:ac2:4e90:0:b0:513:c8b8:aad2 with SMTP id o16-20020ac24e90000000b00513c8b8aad2mr953949lfr.57.1710330407194;
        Wed, 13 Mar 2024 04:46:47 -0700 (PDT)
Received: from nuoska (drt4d6yywjht56pm8q3st-3.rev.dnainternet.fi. [2001:14ba:7430:3d00:1239:a19d:315c:6ddf])
        by smtp.gmail.com with ESMTPSA id f17-20020ac25331000000b00513c290f892sm571426lfh.257.2024.03.13.04.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:46:46 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:46:44 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Daniil Lunev <dlunev@google.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Message-ID: <ZfGSJBuBdzkoooYs@nuoska>
References: <20231129092535.3278-1-avri.altman@wdc.com>
 <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska>
 <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <Ze8eYFW4yZKcWxdo@nuoska>
 <CAHUa44Eptk+Mvf+vWReCACq6DLCSry0wT2U4aewq==4Q2Z1HCA@mail.gmail.com>
 <Ze8mICZ_22mV4jGQ@nuoska>
 <DM6PR04MB657544B8D60209776E674156FC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAHUa44E9qgFrdORQ4zdnHdqb1Dpo8ODk1ioquXNe8tJA86fWrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44E9qgFrdORQ4zdnHdqb1Dpo8ODk1ioquXNe8tJA86fWrA@mail.gmail.com>

Hi,

With help from Jens we turned tee-opplicant in userspace to single threaded with:

--- a/tee-supplicant/src/tee_supplicant.c
+++ b/tee-supplicant/src/tee_supplicant.c
@@ -588,6 +588,8 @@ static bool spawn_thread(struct thread_arg *arg)
        int e = 0;
        pthread_t tid;
 
+       return true;
+
        memset(&tid, 0, sizeof(tid));
 
        DMSG("Spawning a new thread");


but RPMB access still fails, so issue is not in userspace concurrency.
I added debug prints to this commit and the failures seem to come from
this first check idata->flags & MMC_BLK_IOC_DROP, second hunk in this patch:

@@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
        unsigned int busy_timeout_ms;
        int err;
        unsigned int target_part;
+       struct mmc_blk_ioc_data *idata = idatas[i];
+       struct mmc_blk_ioc_data *prev_idata = NULL;

        if (!card || !md || !idata)
                return -EINVAL;

+       if (idata->flags & MMC_BLK_IOC_DROP)
+               return 0;
+
+       if (idata->flags & MMC_BLK_IOC_SBC)
+               prev_idata = idatas[i - 1];
+   
        /*
         * The RPMB accesses comes in from the character device, so we
         * need to target these explicitly. Else we just target the
 

Debug prints:

@@ -485,11 +485,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
        if (!card || !md || !idata)
                return -EINVAL;
 
-       if (idata->flags & MMC_BLK_IOC_DROP)
+       pr_err("%s: DEBUG0:\n", __func__ );
+
+       if (idata->flags & MMC_BLK_IOC_DROP) {
+               pr_err("%s: DEBUG1: idata->flags & MMC_BLK_IOC_DROP: flags = 0x%x, returning 0\n",
+                                                       __func__, idata->flags );
                return 0;
+       }
 
-       if (idata->flags & MMC_BLK_IOC_SBC)
+       if (idata->flags & MMC_BLK_IOC_SBC && i > 0) {
+               pr_err("%s: DEBUG2: idata->flags & MMC_BLK_IOC_SBC && i > 0, flags = 0x%x\n",
+                                                       __func__, idata->flags);
                prev_idata = idatas[i - 1];
+       }
 
        /*
         * The RPMB accesses comes in from the character device, so we

And the logs show that "idata->flags & MMC_BLK_IOC_DROP" is always true for the RPMB
ioctls.

https://ledge.validation.linaro.org/scheduler/job/83101

[   33.505035] __mmc_blk_ioctl_cmd: DEBUG0:
[   33.505426] __mmc_blk_ioctl_cmd: DEBUG1: idata->flags & MMC_BLK_IOC_DROP: flags = 0x5f797469, returning 0
[   33.506283] __mmc_blk_ioctl_cmd: DEBUG0:
[   33.506639] __mmc_blk_ioctl_cmd: DEBUG2: idata->flags & MMC_BLK_IOC_SBC && i > 0, flags = 0x702e796e
[   33.507447] __mmc_blk_ioctl_cmd: DEBUG2.1: RPMB
[   33.511746] __mmc_blk_ioctl_cmd: DEBUG3: copying to prev_idata
[   43.564084] mmc0: Card stuck being busy! __mmc_poll_for_busy

https://ledge.validation.linaro.org/scheduler/job/83102

[  143.124673] __mmc_blk_ioctl_cmd: DEBUG2: idata->flags & MMC_BLK_IOC_SBC && i > 0, flags = 0x485fb78a
[  143.133854] __mmc_blk_ioctl_cmd: DEBUG2.1: RPMB
[  143.138886] __mmc_blk_ioctl_cmd: DEBUG3: copying to prev_idata
...
[  153.166684] mmc0: Card stuck being busy! __mmc_poll_for_busy

This commit added uint flags to mmc_blk_ioc_data struct but it is only initialized for
MMC_DRV_OP_IOCTL code path and for MMC_DRV_OP_IOCTL_RPMB it is uninialized and happens to
be matching "& MMC_BLK_IOC_DROP" in all cases at runtime thus breaking RPMB ioctls.

Fix will be to initialize mmc_blk_ioc_data->flags in all cases. Would this be fine as
a catch all initialization for mmc_blk_ioc_data?

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
        struct mmc_blk_ioc_data *idata;
        int err;
 
-       idata = kmalloc(sizeof(*idata), GFP_KERNEL);
+       idata = kzalloc(sizeof(*idata), GFP_KERNEL);
        if (!idata) {
                err = -ENOMEM;
                goto out;

I think this is a sensible and future proof way to go.

Then, the second flags check for MMC_BLK_IOC_SBC is accessing array using
index i - 1, but is not checking if i == 0 which results in data[-1] access.
I think this should be fixed with something like:

-       if (idata->flags & MMC_BLK_IOC_SBC)
+       if (idata->flags & MMC_BLK_IOC_SBC && i > 0) {

Would you be fine with this?

With both of these changes in place (and debug logging) test runs on rockpi4b and synquacer
arm64 boards are now ok and firmware TPM devices with RPMB storage works again and optee fTPM TA does
not panic, though there is at least on TPM eventlog read test failing later on (a different kernel or
firmware bug, perhaps).

https://ledge.validation.linaro.org/scheduler/job/83094

+ tee-supplicant -d --rpmb-cid 7001004d33323530385212b201dea300
+ sleep 10
+ modprobe tpm_ftpm_tee
...
+ tpm2_createprimary -Q --hierarchy=o --key-context=prim.ctx
...
+ tpm2_loadexternal --key-algorithm=rsa --hierarchy=o --public=signing_key_public.pem --key-context=signing_key.ctx --name=signing_key.name
+ tpm2_startauthsession --session=session.ctx
+ tpm2_policyauthorize --session=session.ctx --policy=authorized.policy --name=signing_key.name
+ tpm2_flushcontext session.ctx
+ cat /tmp/rand_key
+ tpm2_create --hash-algorithm=sha256 --public=auth_pcr_seal_key.pub --private=auth_pcr_seal_key.priv --sealing-input=- --parent-context=prim.ctx --policy=authorized.policy
...
+ tpm2_load -Q --parent-context=prim.ctx --public=auth_pcr_seal_key.pub --private=auth_pcr_seal_key.priv --name=seal.name --key-context=seal.ctx
+ tpm2_evictcontrol -Q -C o -c 0x8100000a
...
+ cryptsetup -q --type luks2 --cipher aes-xts-plain --hash sha256 --use-random --uuid=6091b3a4-ce08-3020-93a6-f755a22ef03b luksFormat /dev/sda2 --key-file /tmp/rand_key --label otaroot
+ echo 'Creating encrypted filesystem ...'
Creating encrypted filesystem ...
+ cryptsetup luksOpen --key-file /tmp/rand_key /dev/sda2 rootfs
...

https://ledge.validation.linaro.org/scheduler/job/83096

+ modprobe tpm_ftpm_tee
...
+ rngd
...
+ tpm2_dictionarylockout -c
+ tpm2-abrmd --allow-root
...
+ tpm2_seal_password /tmp/rand_key
+ local passfilename=/tmp/rand_key
...
+ tpm2_createprimary -Q --hierarchy=o --key-context=prim.ctx
...
+ tpm2_loadexternal --key-algorithm=rsa --hierarchy=o --public=signing_key_public.pem --key-context=signing_key.ctx --name=signing_key.name
+ tpm2_startauthsession --session=session.ctx
+ tpm2_policyauthorize --session=session.ctx --policy=authorized.policy --name=signing_key.name
+ tpm2_flushcontext session.ctx
...
+ tpm2_create --hash-algorithm=sha256 --public=auth_pcr_seal_key.pub --private=auth_pcr_seal_key.priv --sealing-input=- --parent-context=prim.ctx --policy=authorized.policy
...
+ tpm2_load -Q --parent-context=prim.ctx --public=auth_pcr_seal_key.pub --private=auth_pcr_seal_key.priv --name=seal.name --key-context=seal.ctx
+ tpm2_evictcontrol -Q -C o -c 0x8100000a
+ tpm2_evictcontrol --hierarchy=o --object-context=seal.ctx 0x8100000a
...
+ cryptsetup -q --type luks2 --cipher aes-xts-plain --hash sha256 --use-random --uuid=6091b3a4-ce08-3020-93a6-f755a22ef03b luksFormat /dev/mmcblk1p7 --key-file /tmp/rand_key --label otaroot
...
Creating encrypted filesystem ...
+ cryptsetup luksOpen --key-file /tmp/rand_key /dev/mmcblk1p7 rootfs
...
+ mount /dev/mapper/rootfs /rootfs -o rw,noatime,iversion
[  171.018740] EXT4-fs (dm-0): mounted filesystem 89ae0ee0-b27c-4a66-ac0c-098c7ccd7a3c r/w with ordered data mode. Quota mode: disabled.
...

Cheers,

-Mikko
