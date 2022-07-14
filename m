Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3399FC43334
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 17:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiGNRVJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbiGNRU7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 13:20:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B167CA5
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 10:20:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so3344958edd.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R0eCBW6gIOeABqP+QOSPQqie5SvSsYMJMqzDgv9akXE=;
        b=CfRK1wJ2kw95sLNpfAh6nGher8B9X0DfY+fDmFFw5Wi5WckddmuYplX35tKEM156fG
         qwiiKg2c/Jd1sKTIXrJCKk3R0PbK+k8t+RJTWchXY1iYphK/KJ6PLa7wq3s3PRPJgtqu
         rh/2cvP7M/3S40weJQktuhZp/zG0jfG5DzfPOSJRHu12MtzsBNMUj3eT+OzMYFqLan/w
         Fje53xz7fa4synYuznJsBFpRvipsUOgFZtqh3tzmjU3w8XkBiY5E69+hPmxozJKC+DxM
         XDGLLAMem/NRjVew8MjZ4yp8WL4Wl2lH95H+w2ZuYgskSwtq1Njn6Cy6BgpOXDcBbr/p
         StYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R0eCBW6gIOeABqP+QOSPQqie5SvSsYMJMqzDgv9akXE=;
        b=zCBhm3kpm4UYUiGo8UuIHmXCW5zlDZ71lB553RQJ0iJxXppDoy6fuirCzyQymP6kNd
         FIrAhUmh907g8VwUug3LFtC7ky4GEllqAkPWEaQVYIbR4HPXZ8QlRADKbsySmFvh2oVp
         uj2kuYqwO0JelahvKbWrh/WW2eHs+IHix2pRawKKvP0la4fuRCg+QfQnnTIAjh2Y11XH
         QzrTcpeMPlluJhFnzxUIreYjmudsyc6dVrJNMCA9T5ButaRv5Z7AM+KwgXBJCj+NwbMc
         RotEWXlN+gGSnNbLh9Af4xSQe/6OujldXGaaRvOzmu86zXN+QG1TZkJwQF371SBj8gut
         IwWQ==
X-Gm-Message-State: AJIora+QANDEL4iLKKcpu2qusBD/moKtqH234RjFdB/Co3S6KS5VqsJl
        EMcrXEDc2rTnOprClkdDhJ15Mg==
X-Google-Smtp-Source: AGRyM1sQyVfa9avVu5+MC4fx+3aAZcYUn8uCsYmEA8DuGqjstE57+GWuHnNHy2rvrPRE66ToH7v72A==
X-Received: by 2002:a05:6402:4016:b0:43a:f310:9522 with SMTP id d22-20020a056402401600b0043af3109522mr13626248eda.200.1657819249162;
        Thu, 14 Jul 2022 10:20:49 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090636c800b0072a815f569bsm890617ejc.185.2022.07.14.10.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:20:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <eec07acea8694191a75880acc397dafe@hyperstone.com>
Date:   Thu, 14 Jul 2022 19:20:47 +0200
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94A234A2-9725-4159-A23C-F3DD8D4BCC06@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <eec07acea8694191a75880acc397dafe@hyperstone.com>
To:     Christian Loehle <CLoehle@hyperstone.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Am 14.07.2022 um 18:44 schrieb Christian Loehle =
<CLoehle@hyperstone.com>:
>=20
> I only briefly skimmed the discussion, but does this mean that a =
soft-reset (CMD0) of a UHS (post-voltage-switch) will not work?
> (As the card/spec requires a power-cycle by the host which will not =
come, right?)
> Can you try this real quick? I can give you a mmc-utils snippet if you =
have trouble issuing one.
> If that does indeed not work I think the general approach is to =
disable uhs in the dts or at least document that.
> Regards,
> Christian

I tried disabling UHS in the DTS, but that would still cause mmc =
detection issues.

"rmmod dw_mmc_rockchip" followed by "modprobe dw_mmc_rockchip" still =
detects the card:
> [ 4481.141764] mmc1: card 0001 removed
> [ 4488.133398] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit =
address mode.
> [ 4488.133462] dwmmc_rockchip fe320000.mmc: Using internal DMA =
controller.
> [ 4488.133484] dwmmc_rockchip fe320000.mmc: Version ID is 270a
> [ 4488.133541] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq =
32,32 bit host data width,256 deep fifo
> [ 4488.134320] dwmmc_rockchip fe320000.mmc: Got CD GPIO
> [ 4488.147329] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot =
req 400000Hz, actual 400000HZ div =3D 0)
> [ 4488.218364] mmc_host mmc1: Bus speed (slot 0) =3D 148500000Hz (slot =
req 150000000Hz, actual 148500000HZ div =3D 0)
> [ 4488.678181] dwmmc_rockchip fe320000.mmc: Successfully tuned phase =
to 214
> [ 4488.678239] mmc1: new ultra high speed SDR104 SDHC card at address =
0001
> [ 4488.680315] mmcblk1: mmc1:0001 ASTC 14.6 GiB=20
> [ 4488.684871]  mmcblk1: p1 p2

Ejecting/re-inserting the card also works:
> [ 4607.521119] mmc1: card 0001 removed
> [ 4608.517343] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot =
req 400000Hz, actual 400000HZ div =3D 0)
> [ 4608.632987] mmc_host mmc1: Bus speed (slot 0) =3D 148500000Hz (slot =
req 150000000Hz, actual 148500000HZ div =3D 0)
> [ 4609.065445] dwmmc_rockchip fe320000.mmc: Successfully tuned phase =
to 213
> [ 4609.065535] mmc1: new ultra high speed SDR104 SDHC card at address =
0001
> [ 4609.067942] mmcblk1: mmc1:0001 ASTC 14.6 GiB=20
> [ 4609.073521]  mmcblk1: p1 p2

and so is changing the clock back and forth:
> echo 400000 > /sys/kernel/debug/mmc1/clock; echo 150000000 > =
kernel/debug/mmc1/clock; fdisk -l /dev/mmcblk1

> [ 4817.829078] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot =
req 400000Hz, actual 400000HZ div =3D 0)
> [ 4820.063457] mmc_host mmc1: Bus speed (slot 0) =3D 148500000Hz (slot =
req 150000000Hz, actual 148500000HZ div =3D 0)
> [ 4835.305419] dwmmc_rockchip fe320000.mmc: Successfully tuned phase =
to 213
> [ 4836.346928]  mmcblk1: p1 p2

Swapping with a "highspeed" (non-UHS) card also seems to work
> [ 5733.702083] mmc1: card 0001 removed
> [ 5738.858439] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot =
req 400000Hz, actual 400000HZ div =3D 0)
> [ 5739.378487] mmc_host mmc1: Bus speed (slot 0) =3D 50000000Hz (slot =
req 50000000Hz, actual 50000000HZ div =3D 0)
> [ 5739.378627] mmc1: new high speed SD card at address 21bb
> [ 5739.380491] mmcblk1: mmc1:21bb APPSD 480 MiB=20
> [ 5739.382795] debugfs: Directory 'mmcblk1' with parent 'block' =
already present!
> [ 5739.385096]  mmcblk1: p1
> [ 5774.386536] FAT-fs (mmcblk1p1): utf8 is not a recommended IO =
charset for FAT filesystems, filesystem will be case sensitive!
> [ 5795.486365] mmc1: card 21bb removed
> [ 5801.302688] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz (slot =
req 400000Hz, actual 400000HZ div =3D 0)
> [ 5801.447128] mmc_host mmc1: Bus speed (slot 0) =3D 148500000Hz (slot =
req 150000000Hz, actual 148500000HZ div =3D 0)
> [ 5801.880374] dwmmc_rockchip fe320000.mmc: Successfully tuned phase =
to 211
> [ 5801.880440] mmc1: new ultra high speed SDR104 SDHC card at address =
0001
> [ 5801.882253] mmcblk1: mmc1:0001 ASTC 14.6 GiB=20
> [ 5801.884145] debugfs: Directory 'mmcblk1' with parent 'block' =
already present!
> [ 5801.886558]  mmcblk1: p1 p2
>=20

Some debug output: cat /sys/kernel/debug/mmc1/ios
UHC
> clock:		150000000 Hz
> actual clock:	148500000 Hz
> vdd:		18 (3.0 ~ 3.1 V)
> bus mode:	2 (push-pull)
> chip select:	0 (don't care)
> power mode:	2 (on)
> bus width:	2 (4 bits)
> timing spec:	6 (sd uhs SDR104)
> signal voltage:	1 (1.80 V)
> driver type:	0 (driver type B)
non-UHC
> cat /sys/kernel/debug/mmc1/ios
> clock:		50000000 Hz
> vdd:		18 (3.0 ~ 3.1 V)
> bus mode:	2 (push-pull)
> chip select:	0 (don't care)
> power mode:	2 (on)
> bus width:	2 (4 bits)
> timing spec:	2 (sd high-speed)
> signal voltage:	0 (3.30 V)
> driver type:	0 (driver type B)
>=20

How do I make sure I specifically send the soft-reset command? I'm happy =
to help but I'm really a novice here.

Best,
Christian

