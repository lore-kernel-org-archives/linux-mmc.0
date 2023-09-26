Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63194E7E649
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 15:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjIZPEO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjIZPEM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 11:04:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85BC194
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 08:04:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d89ba259964so465912276.2
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695740643; x=1696345443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TcjwYRwL69muqyv1WW+HbLLHgJZWDCWftJPkWhnlOQo=;
        b=MYX8omH6mV3SSxnEt7zkgugPUkEK8v83ymqbThCIzi/QPr05Mlx6Vi1lohWu5UYW1R
         eiSeVBOKqAOwCw+oHFybwtEBgWiSD26JD2c8+/8biX/5Q9ZykLForG0h/QNQ8xu5IOWB
         rpl8L9UOLAOBkGsxpkl+vSlKqh4/1YGpWu1I+kf1RZHCPx9WkuiAsNTDgun0jyouiMHL
         QlzzLJHdHh62q/CiBdEpEWjcVvxxHz/S4fH90AZQcOzCTTfj1tALLKsPWYN45yCyUUr6
         bE1EkSPPsmJWaQ2p8wZ7eSR1gRjWjx5Phaa2uIjlv+bstJ3+rSOhQsq7VV+uK+bOhPiW
         hJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740643; x=1696345443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcjwYRwL69muqyv1WW+HbLLHgJZWDCWftJPkWhnlOQo=;
        b=vd7Rn5LdP3LdPq+weUQiO8sil9kbJS+gMaQtlgXZOFVJ87wVnc2qBWPo7wcmeGp776
         FKxYM2pOcc24MoL1+rArvMA14VXQWGTOZYdMd3Z6POS9nJLfR0SsGXdwzbl52MmlAvNL
         MOxsrKGllFCvI+YXZhdOedq9HvKTAISBF3DqcS1ZnlikYrJBdY+xJbeUJ4MXJ7u66EGP
         6SoeFtwURxXZ7gmnjxyzdarC7l8XezrmRW+9znfejm1vL/98pU8Q8M0bg+MS6El1RqfG
         V2qAzyZKLuFm2ER5FXaY6+OuBwT+IdGwgkH/nIAq5GWEsZPf7Iplo2uda5zQ3c6X/bHG
         MKYQ==
X-Gm-Message-State: AOJu0YwlgAuiYIWI5CwKisxarnrZZeUWXpQ6afLoKvRiUhZBa47RWeG/
        HfsONy9gkizADZ2eMcf3OCmcU3KuszexjSLJxaCSeQ==
X-Google-Smtp-Source: AGHT+IEZGoX9zjVQ9TTAIR+/HZVjLDjUhCGrqR225PsM9vQcAjzMAV9hOJbGjvV1tBebVAOEVieTFFkSTwxcSMBg5Fw=
X-Received: by 2002:a25:a329:0:b0:d85:eb7b:5c74 with SMTP id
 d38-20020a25a329000000b00d85eb7b5c74mr8951447ybi.31.1695740643421; Tue, 26
 Sep 2023 08:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074707.25517-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230919074707.25517-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 17:03:27 +0200
Message-ID: <CAPDyKFpR9LXJqE7bh9aTyZ8Z6mArvoi2YE_0v57wz3fmq9OP2A@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] mmc: hsq: dynamically adjust hsq_depth to improve performance
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhang.lyra@gmail.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Sept 2023 at 09:47, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Change in v4:
> - Remove "struct hsq_slot *slot" and simplify the code.
> - In general, need_change has to be greater than or equal to 2 to allow the threshold
>   to be adjusted.
>
> Change in v3:
> - Use "mrq->data->blksz * mrq->data->blocks == 4096" for 4K.
> - Add explanation for "HSQ_PERFORMANCE_DEPTH".
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
>
> In addition, we tested 8K and 16K.
> 1.Fixed hsq_depth
> 1) Random write(bs=8K):
> Speed: 116 114 115
> Average speed: 115MB/S
>
> 2) Random read(bs=8K):
> Speed: 83 83 82.5
> Average speed: 82.8MB/S
>
> 3) Random write(bs=16K):
> Speed: 141 142 141
> Average speed: 141.3MB/S
>
> 4) Random read(bs=16K):
> Speed: 132 132 132
> Average speed: 132MB/S
>
> 2.Dynamic hsq_depth(mrq->data->blksz * mrq->data->blocks == 8192 or 16384)
> 1) Random write(bs=8K):
> Speed: 115 115 115
> Average speed: 115MB/S
>
> 2) Random read(bs=8K):
> Speed: 82.7 82.9 82.8
> Average speed: 82.8MB/S
>
> 3) Random write(bs=16K):
> Speed: 143 141 141
> Average speed: 141.6MB/S
>
> 4) Random read(bs=16K):
> Speed: 132 132 132
> Average speed: 132MB/S
>
> Increasing hsq_depth cannot improve 8k and 16k random read/write performance.
> To reduce latency, we dynamically increase hsq_depth only for 4k random writes.
>
> Test cmd
> =========
> 1)write: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=write -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 2)read: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=read -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 3)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 4)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 5)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=8K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 6)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=8K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 7)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=16K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
> 8)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=16K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64
>
> Wenchao Chen (2):
>   mmc: queue: replace immediate with hsq->depth
>   mmc: hsq: dynamic adjustment of hsq->depth
>
>  drivers/mmc/core/queue.c   |  6 +-----
>  drivers/mmc/host/mmc_hsq.c | 22 ++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h | 11 +++++++++++
>  include/linux/mmc/host.h   |  1 +
>  4 files changed, 35 insertions(+), 5 deletions(-)
>
> --
> 2.17.1
>

The series applied for next! I took the liberty of making some updates
to the commit messages and a small adjustment of the code in patch2.
Please have a look and yell at me if there is something that looks
odd!

Thanks and kind regards
Uffe
