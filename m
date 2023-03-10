Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D876C6FD1F
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 15:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjCJPC4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjCJPCf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 10:02:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4112E154
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 06:55:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u5so5812962plq.7
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678460070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=899uIjNSnSBUDvGA5vdXcbUib6/TzEA7CBXfVAUpl0E=;
        b=PfZ/1K/35eYfryGtgRaPzAfXjm/TTlzN7zmCUyYNSlqd0knXBwYP8lAgb03+zPznv+
         eDQUmy4JZ9Gua1Q9qIgfWjg1NZA25DAABvXnJhzbrkvS5Q9luzxtKkybr5K6DXUngzk3
         xu4AsjDEvmaEnsKbPkKvEo9ougjazOkDwSj5+0EicSGDg8K+N704m4XvG1WxIngqEKXT
         8HnqDuCiY1eQy7JWntcKbKR2zqTLukIMarStVBBNPUg7IbLh0wStPLZ6xsPjdf1GsVNv
         4XFrHoJwthEaIAqn+A7/8Gm6iBh7UpSq+8bCuQi+AGRFiUpeV4ro0Jg8jfuoMeN8DnOz
         uFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=899uIjNSnSBUDvGA5vdXcbUib6/TzEA7CBXfVAUpl0E=;
        b=H7dAPREn3SHPqfo5a06WbdaoGQTp0vLbGEnibIbPh3ArarLRFmR46Y+n0qWAF0tBbJ
         6FEP/t+iW7hnXdlHn1sjnEvmdkCk6T7tpLEpMw+JkXnYngzjE1OgfKeMfRiUQRb7x3ju
         Y50YiXaFO7DxJ/zR53Jh+tU4p554V/fRdZQURhny0ITh7HjH1zlPtUc/F0NgQrbLitIO
         5liEEjUawVA3+wzi7rXV68ml9yYHg3oftMZmjKZWEMCRoUdcstXVKM7az4Pppsbm7dyW
         NNJ6fVUdpLX3S/ExDAo8yzgAaVJdch4SWwW/1VB4VNAM73b8cXCHRgwG0/NfMEUBOCqO
         YT+A==
X-Gm-Message-State: AO0yUKXZ4i3MRMYoJeuc22ZJJ9keuel5igaPoO24bLS5jae63KU3nDpi
        nG9GuGmWATAz7YLb+JeC+7J+LRFfiJZpsext7QTU4Q==
X-Google-Smtp-Source: AK7set+0etYzFVu3Na/+89oOfp44qAlq1xHev4VKDXKuM1ZC3b+8SmFlqToekddehOw2SpuLoDcBLKODDKlT5jN+vR0=
X-Received: by 2002:a17:90a:69c4:b0:233:bc72:1c69 with SMTP id
 s62-20020a17090a69c400b00233bc721c69mr9062179pjj.9.1678460070046; Fri, 10 Mar
 2023 06:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20230302144330.274947-1-ulf.hansson@linaro.org> <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com>
In-Reply-To: <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 15:53:53 +0100
Message-ID: <CAPDyKFq-qToEX+qiuHirNbcuedii_f0KKuHiPAv7+tydrUTpqQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Mar 2023 at 14:43, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> I have benchmarked the FUA/Cache behavior a bit.
> I don't have an actual filesystem benchmark that does what I wanted and i=
s easy to port to the target so I used:
>
> # call with
> # for loop in {1..3}; do sudo dd if=3D/dev/urandom bs=3D1M of=3D/dev/mmcb=
lk2; done; for loop in {1..5}; do time ./filesystembenchmark.sh; umount /mn=
t; done
> mkfs.ext4 -F /dev/mmcblk2
> mount /dev/mmcblk2 /mnt
> for i in {1..3}
> do
> cp -r linux-6.2.2 /mnt/$i
> done
> for i in {1..3}
> do
> rm -r /mnt/$i
> done
> for i in {1..3}
> do
> cp -r linux-6.2.2 /mnt/$i
> done
>
>
> I found a couple of DUTs that I can link, I also tested one industrial ca=
rd.
>
> DUT1: blue PCB Foresee eMMC
> https://pine64.com/product/32gb-emmc-module/
> DUT2: green PCB SiliconGo eMMC
> Couldn't find that one online anymore unfortunately
> DUT3: orange hardkernel PCB 8GB
> https://www.hardkernel.com/shop/8gb-emmc-module-c2-android/
> DUT4: orange hardkernel PCB white dot
> https://rlx.sk/en/odroid/3198-16gb-emmc-50-module-xu3-android-for-odroid-=
xu3.html
> DUT5: Industrial card

Thanks a lot for helping out with testing! Much appreciated!

>
>
> The test issued 461 DO_REL_WR during one of the iterations for DUT5
>
> DUT1:
> Cache, no FUA:
> 13:04.49
> 13:13.82
> 13:30.59
> 13:28:13
> 13:20:64
> FUA:
> 13:30.32
> 13:36.26
> 13:10.86
> 13:32.52
> 13:48.59
>
> DUT2:
> FUA:
> 8:11.24
> 7:47.73
> 7:48.00
> 7:48.18
> 7:47.38
> Cache, no FUA:
> 8:10.30
> 7:48.97
> 7:48.47
> 7:47.93
> 7:44.18
>
> DUT3:
> Cache, no FUA:
> 7:02.82
> 6:58.94
> 7:03.20
> 7:00.27
> 7:00.88
> FUA:
> 7:05.43
> 7:03.44
> 7:04.82
> 7:03.26
> 7:04.74
>
> DUT4:
> FUA:
> 7:23.92
> 7:20.15
> 7:20.52
> 7:19.10
> 7:20.71
> Cache, no FUA:
> 7:20.23
> 7:20.48
> 7:19.94
> 7:18.90
> 7:19.88

Without going into the details of the above, it seems like for DUT1,
DUT2, DUT3 and DUT4 there a good reasons to why we should move forward
with $subject patch.

Do you agree?

>
> Cache, no FUA:
> 7:19.36
> 7:02.11
> 7:01.53
> 7:01.35
> 7:00.37
> Cache, no FUA CQE:
> 7:17.55
> 7:00.73
> 6:59.25
> 6:58.44
> 6:58.60
> FUA:
> 7:15.10
> 6:58.99
> 6:58.94
> 6:59.17
> 6:60.00
> FUA CQE:
> 7:11.03
> 6:58.04
> 6:56.89
> 6:56.43
> 6:56:28
>
> If anyone has any comments or disagrees with the benchmark, or has a spec=
ific eMMC to test, let me know.

If I understand correctly, for DUT5, it seems like using FUA may be
slightly better than just cache-flushing, right?

For CQE, it seems like FUA could be slightly even better, at least for
DUT5.  Do you know if REQ_OP_FLUSH translates into MMC_ISSUE_DCMD or
MMC_ISSUE_SYNC for your case? See mmc_cqe_issue_type().

When it comes to CQE, maybe Adrian have some additional thoughts
around this? Perhaps we should keep using REQ_FUA, if we have CQE?

Kind regards
Uffe
