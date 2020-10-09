Return-Path: <SRS0=zmAv=DQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8CFC433E7
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 06:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D72122255
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Oct 2020 06:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tU0Jj/Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgJIG30 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Oct 2020 02:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbgJIG30 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2020 02:29:26 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8FC0613D4
        for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2020 23:29:26 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id z10so1904169vkn.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2020 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=29TPjXHq/BNLabnsJW1LaxXDiuG1x9tYewU9pgUGQT8=;
        b=tU0Jj/MpM4lhRIpYC1RoltT97ueOKcw7JWL+loQCcDXb63XC+Z/78WcXODBBv4Gvlj
         6nh4DWjTmeBV0P4SKBeUla0Q88NfJQg1PSP7KDZgQNcMDViwnDrf5WhG2+KmRz/OVcQC
         KV6o4yJOr6OCbAzQxXlglR5WxOCXkTNeSx8Rb76wQv6NXS5kuWga4lvHyk8qogRpRqT3
         DpC7NMcQtcMDMh5sarPw0p2UG1wxzXuLWMJk1sD56L1ZOgNA1+txN0lU1w7TqnG4wHYQ
         nqNAPzSm/tbUVjRb2sqlOHEAEJwZlMH8IXrC2uhoQFqlolDwMoeablnCy5g8NEKBCKyE
         LnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=29TPjXHq/BNLabnsJW1LaxXDiuG1x9tYewU9pgUGQT8=;
        b=H2MqT7MUCOfLzU4e+Etnezdxn7SHlFtBTygQzIlzZWIZjbZhAGf9+44cRGEly3X9Yk
         0ty3lWBPhL3t4JT0+9R2oH5pJzQoQdkfVLNgSSfWJGuQE7ErgnmreuNiAs+9Wn17zhEd
         14gU7K+3JKX0Vy2Q5jOGK6uoC+7zVhzXvjzfyRK88CwHI/36HY+cUdPRqyuzEkY3NGVW
         U0y4/jgHGyvZGi8KRWUbUcWkanjHn//5yyc14FPrcToBiY+Gea74/N9e3sclpvNQKYnM
         zyhiPKAnA8riNaPw0i7L1UVBrSj7J5jyhPntz6N1epfeRt+qCfPAtcN/0bofGXQZV/I1
         eLKg==
X-Gm-Message-State: AOAM5306FQZFHaUW8URgZCcoRJkcR2HwNY3mGOQZ9CdnloRRHfOxZ5OV
        Rf3gs3z5dAXYLfHi3FE1VaHlRL/r3yNAm3BHMV32XA==
X-Google-Smtp-Source: ABdhPJz4n+U9vseqM4gSLaEt+c3jl3buZB4FQyIUsFMpR8FQOqAC7YdrEYODHprc5waifmsL8d13qRiLVsjacE3ee3I=
X-Received: by 2002:a1f:1c2:: with SMTP id 185mr6748118vkb.15.1602224965129;
 Thu, 08 Oct 2020 23:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201002013852.51968-1-colyli@suse.de>
In-Reply-To: <20201002013852.51968-1-colyli@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Oct 2020 08:28:47 +0200
Message-ID: <CAPDyKFokxaKxaDqip-ZTxBSAZ_EK=9EjuWQUw+1nwoPmoP88Zw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: don't set limits.discard_granularity as 0
To:     Coly Li <colyli@suse.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Vicente Bergas <vicencb@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Oct 2020 at 03:39, Coly Li <colyli@suse.de> wrote:
>
> In mmc_queue_setup_discard() the mmc driver queue's discard_granularity
> might be set as 0 (when card->pref_erase > max_discard) while the mmc
> device still declares to support discard operation. This is buggy and
> triggered the following kernel warning message,
>
> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
> Hardware name: Google Kevin (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=3D--)
> pc : __blkdev_issue_discard+0x200/0x294
> lr : __blkdev_issue_discard+0x54/0x294
> sp : ffff800011dd3b10
> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26: ff=
ff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000f1d=
eaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 x19=
: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000000=
000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000000=
 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : fff=
f800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f192=
6400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 :=
 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
> __blkdev_issue_discard+0x200/0x294
> __submit_discard_cmd+0x128/0x374
> __issue_discard_cmd_orderly+0x188/0x244
> __issue_discard_cmd+0x2e8/0x33c
> issue_discard_thread+0xe8/0x2f0
> kthread+0x11c/0x120
> ret_from_fork+0x10/0x1c
> ---[ end trace e4c8023d33dfe77a ]---
>
> This patch fixes the issue by setting discard_granularity as SECTOR_SIZE
> instead of 0 when (card->pref_erase > max_discard) is true. Now no more
> complain from __blkdev_issue_discard() for the improper value of discard
> granularity.
>
> This issue is exposed after commit b35fd7422c2f ("block: check queue's
> limits.discard_granularity in __blkdev_issue_discard()"), a "Fixes:" tag
> is also added for the commit to make sure people won't miss this patch
> after applying the change of __blkdev_issue_discard().
>
> Fixes: e056a1b5b67b ("mmc: queue: let host controllers specify maximum di=
scard timeout")
> Fixes: b35fd7422c2f ("block: check queue's limits.discard_granularity in =
__blkdev_issue_discard()").
> Reported-and-tested-by: Vicente Bergas <vicencb@gmail.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>

While waiting for a new version that uses the logical block size, I
instead decided to apply this for fixes as is, thanks!

Please base the new version on top of this one instead.

Kind regards
Uffe


> ---
> Changelog,
> v4, update to Reported-and-tested-by tag for Vicente Bergas.
> v3, add Fixes tag for both commits.
> v2, change commit id of the Fixes tag.
> v1, initial version.
>
>  drivers/mmc/core/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 6c022ef0f84d..350d0cc4ee62 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct request_qu=
eue *q,
>         q->limits.discard_granularity =3D card->pref_erase << 9;
>         /* granularity must not be greater than max. discard */
>         if (card->pref_erase > max_discard)
> -               q->limits.discard_granularity =3D 0;
> +               q->limits.discard_granularity =3D SECTOR_SIZE;
>         if (mmc_can_secure_erase_trim(card))
>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
> --
> 2.26.2
>
