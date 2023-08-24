Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF2C6FA8F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 10:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHXK0s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjHXK0q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 06:26:46 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC8198D
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:26:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58fb73e26a6so55347127b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692872803; x=1693477603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiVO2zIIfAlMOLu1hE32MnDX+QGTLXrL91WCVdNOGro=;
        b=snHFrSX9kpgGnVaHypf4EWd1p7qcpSAzammAIwD8QSTejP8bl8J0oy6MiEPe5zkjLT
         5Kx/3ON3pU4omX68exa8+FuX/R67h9YdNt1Fyqi811yca+pdnjcXscyxyDaP02PFUGAu
         ORcAJf5fRlvWUsoRIbVvbuvyNXfmTdnd4bebXz92mGG2Ks6x9eJ9zrvLqtWy9AJ+ixUI
         8k5zgJqipAjc32b8Te5RIs0nr3rw4W7SUe+8Mzlbq11hj1eoNauIiojBVxwKkQGR3Kc4
         +5cY/4d2Jscl0HWHqdf/bXPL2i7g34EmSBWVXKCtoetsQ0usHZgvmsRrUhb1RV6zf26C
         jsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692872803; x=1693477603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiVO2zIIfAlMOLu1hE32MnDX+QGTLXrL91WCVdNOGro=;
        b=NCNEhpnb6G1Q3Re4VXjWbpomViolzEVrGe+2c2ogXSQsOTGTO+idvtC19QxPlamenQ
         GSEPwWXBfn3IffTFvMMP4xpKezfqO46T9pNdaYf08998aCKPM6oyGEjGPw3DrQHndIKD
         I4OeF6fZbc2PBj6hLf7V8LRrHIRUKjeXMUYQcUG1CGsdPYVBsf4hU4TriYXNZ+wwCnP5
         fQFl/ecA2FQoGVw/3OWZedOVT0eyr3r8c9oV2sHyBCgd+MdAXEX8eizntm9KHDvkzw++
         O+FWUdevAkO1ey+YOuoBvpKDYdL6v9X2j2tHAFNTGol2h5yRPtaFfF0uDie467YEs9XH
         DUrA==
X-Gm-Message-State: AOJu0Yz+aS/KqEVwjpB8dzr/QmcLOdNwEEUGr50oJTJcGAjCsdYqC+qp
        Du/5U3bHfP2YXnnJjPWz0EdBaUx2LyzLea0nVOIwbg==
X-Google-Smtp-Source: AGHT+IGEF/ohPnecRPr+1/Us9nPZdUGng0F281dTDctUO63ONUqAvna6vjLJF4sW+SdB52LmJ61MFUpiBprWMIl6vSk=
X-Received: by 2002:a81:6cd5:0:b0:54f:ba89:225d with SMTP id
 h204-20020a816cd5000000b0054fba89225dmr14041774ywc.19.1692872803527; Thu, 24
 Aug 2023 03:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230823061734.27479-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230823061734.27479-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 12:26:07 +0200
Message-ID: <CAPDyKFqbY5yLNwhODDq0XimKtnf0V93rEbmSdG+qZ2FrYWJFsw@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: hsq: Dynamically adjust hsq_depth to improve performance
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Aug 2023 at 08:18, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Change in v2:
> - Support for dynamic adjustment of hsq_depth.
>
> Test
> =====
> I tested 3 times for each case and output a average speed.
> Ran 'fio' to evaluate the performance:
> 1.Fixed hsq_depth
> 1) Sequential write:
> Speed: 168 164 165
> Average speed: 165.67MB/S
>
> 2) Sequential read:
> Speed: 326 326 326
> Average speed: 326MB/S
>
> 3) Random write:
> Speed: 82.6 83 83
> Average speed: 82.87MB/S
>
> 4) Random read:
> Speed: 48.2 48.3 47.6
> Average speed: 48.03MB/S
>
> 2.Dynamic hsq_depth
> 1) Sequential write:
> Speed: 167 166 166
> Average speed: 166.33MB/S
>
> 2) Sequential read:
> Speed: 327 326 326
> Average speed: 326.3MB/S
>
> 3) Random write:
> Speed: 86.1 86.2 87.7
> Average speed: 86.67MB/S
>
> 4) Random read:
> Speed: 48.1 48 48
> Average speed: 48.03MB/S
>
> Based on the above data, dynamic hsq_depth can improve the performance of random writes.
> Random write improved by 4.6%.

Thanks for sharing this, interesting!

>
> Test cmd
> =========
> 1)write: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=write -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 2)read: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=read -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 3)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 4)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
>

The buffer you used for randwrite/randread is 4K blocks. Did you try
with something bigger too?

Or maybe we are afraid of introducing a bigger latency if we
dynamically change the hsq_depth to match something bigger than 4K?

>
> Wenchao Chen (2):
>   mmc: queue: replace immediate with hsq->depth
>   mmc: hsq: dynamic adjustment of hsq->depth
>
>  drivers/mmc/core/queue.c   |  6 +-----
>  drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h |  8 ++++++++
>  include/linux/mmc/host.h   |  1 +
>  4 files changed, 37 insertions(+), 5 deletions(-)
>

Kind regards
Uffe
