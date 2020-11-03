Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C723C2D0A3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343BE22226
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qrcs1D7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgKCP0t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgKCPZh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 10:25:37 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A911C0617A6
        for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2020 07:25:37 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id m184so1450868vkb.9
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2020 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLjEoPE1qTScSokPULmNB4sQvaJ/rGjdmpXC27ItG30=;
        b=Qrcs1D7BqopfjKyXLOMzzVa4eS+9u5GkGdbGwgags0VGkVfZgE8JOzgjzQikJkmKJI
         Z/+ZonmjqIkK2xEDE7+TP4uiHKTKrrTO2Nh3zBSjC+jNRIsVD9oHeofBbYISiaZmpXcM
         fDv6q4IadbNmw8LYY4cxsbpgbR3b1iV3eyTEwSflBWiiVM1lNBFvy2MqvOik5bGmm3Le
         n8avcynw4YGjPa14Hpt3Iu3gh+v8Vibu61GPDxOhO234DdvS690vIkznWsAOfAhz9nUI
         V7QFDxezt5WBtxfkaGrNo/AAnQdUAEE15qkc+jLmY91fV8NkgwhpKujv/J1yRuuwXO2v
         1+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLjEoPE1qTScSokPULmNB4sQvaJ/rGjdmpXC27ItG30=;
        b=uS+gW0Qgdqy+7QpK0mhYvlN4TzfwWrpgYrxwBTwjttH27Xv9ZqFBKOvLFtefza2sVt
         ckNpcviAceA6NClHxutspX5vbH6MfofvNBeaDXQxyPmeeisEsH9w/gz3uFo2uXJ519Nb
         EBFB+l43XMsP8l+3XDm//kOJpEh2VGtovzCTEjmngZa1xyhH8UxngyUtr4x/TV7QEUzK
         fxudKuRw/tFiyKwcEwulqoT5JjOPLIWxcooma+NmG6mOQUFtgbPoe7rrdBVYnBVpu84B
         uYt6CuHU6GLAC7ESxc2JXB03ARIYPx76fLnOKrgekMNSv67+n1LLMg345+gxCFTOxpU4
         wOGQ==
X-Gm-Message-State: AOAM531D6q2+l6kv6bZ6rNJijKpwqCbPMrWsEvrNtNJ8XvcV0qC+9HKd
        eJoerVmnge89pNjE6ph035wK0TLCuiuOS9tf8QNIaQ==
X-Google-Smtp-Source: ABdhPJyTp0PHlyAFKFUtsUjjMj+WT1CwwmG3q286e1X59j2WSjlWxw11u3BFrJMk9fcKtdvlqkM/f+2OwetwebVMaHg=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr16837348vkk.6.1604417136460;
 Tue, 03 Nov 2020 07:25:36 -0800 (PST)
MIME-Version: 1.0
References: <1603883984-24333-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1603883984-24333-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Nov 2020 16:25:00 +0100
Message-ID: <CAPDyKFq0zikjeps36=Mq-Y9MuyiOHZyGVELV+Eh56evu8b8D2A@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Prevent new req entering queue while freeing
 up the queue
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Peng Hao <richard.peng@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Oct 2020 at 12:20, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> The commit bbdc74dc19e0 ("mmc: block: Prevent new req entering queue
> after its cleanup") has introduced this change but it got moved after
> del_gendisk() with commit 57678e5a3d51 ("mmc: block: Delete gendisk
> before cleaning up the request queue").

This isn't the first time we have spotted errors in this path. Seems
like a difficult path to get correct. :-)

>
> It is blocking reboot with below Call stack().
>
> INFO: task reboot:3086 blocked for more than 122 seconds.
>      __schedule
>      schedule
>      schedule_timeout
>      io_schedule_timeout
>      do_wait_for_common
>      wait_for_completion_io
>      submit_bio_wait
>      blkdev_issue_flush
>      ext4_sync_fs
>      __sync_filesystem
>      sync_filesystem
>      fsync_bdev
>      invalidate_partition
>      del_gendisk
>      mmc_blk_remove_req
>      mmc_blk_remove
>      mmc_bus_remove
>      device_release_driver_internal
>      device_release_driver
>      bus_remove_device
>      device_del
>      mmc_remove_card
>      mmc_remove
>      mmc_stop_host
>      mmc_remove_host
>      sdhci_remove_host
>      sdhci_msm_remove

Why do you call sdhci_msm_remove() from the shutdown callback? What
specific operations do you need to run in the shutdown path for sdhci
msm?

The important part should be to do a graceful shutdown of the card
(and the block device) - is there anything else?

Or you are just using the shutdown callback as a simple way to trigger
this problem? Could unbinding the driver trigger the same issue?

>      sdhci_msm_shutdown
>      platform_drv_shutdown
>      device_shutdown
>      kernel_restart_prepare
>      kernel_restart
>
> So bringing this change back.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>
> I'm observing this issue 100% of the time with shutdown callback added to sdhci-msm driver.
> I'm trying on 5.4 kernel with ChromeOS.
>
> Please let me know if this can be fixed in a better way.

I don't know yet, but I will have a closer look. Let's also see if
Adrian has some thoughts.

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8d3df0be0355..76dbb2b8a13b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2627,6 +2627,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>                  * from being accepted.
>                  */
>                 card = md->queue.card;
> +               blk_set_queue_dying(md->queue.queue);
>                 if (md->disk->flags & GENHD_FL_UP) {
>                         device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>                         if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
