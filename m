Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2491C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4BC22573
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbhATASq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 19:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391429AbhASNpo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 08:45:44 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2231C0613ED
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:36 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 186so8619144vsz.13
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1Svz7kp8jlLrAJvTmsrrPfMT8ipdqa9EnIKhQhhtpo=;
        b=k8uXt/4O7KzeCtNH8ezUhflLZ1LhPd4rPFC/yawcZKsRGqEzWDDh5OstLqllLpAQGq
         3ZO0bjzw/Sp0DOCfJiL0JKmLxKGNXllJbaJJjFAbVNnfs7Yo2SAlDUo+n1iNrjZF8OnZ
         WQ0zQDh4BlWO5pW3BDXCNsfAimj6nox2ll+ZjeYbdYODiSwz6IM5uDN0Z5SJazWrjZMS
         46FoaVR6gVtOdqO49x1iRd+QeNmqr4hlD87DmzcaG70UvWv0H85V6UxgGm1v6NCe/nmV
         XPRm5OcplFfCgtMU+A3mqA4I5YS3Zh6QI6UUwYfv914RujRoggdcfhJ+xMfU1XTtj253
         76wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1Svz7kp8jlLrAJvTmsrrPfMT8ipdqa9EnIKhQhhtpo=;
        b=t94qY7IGxi+NA1J2PaShh+MQU3ElatgOMn3risMfYHJcz7Od8YFPxv9ZN5qQGbmISr
         sYqUD9ImB3E6XQqWYO8do0QaZoWBDgaQCC5497g4IA/CP2LoqcuxkpVUQTTwje/anEkj
         VdgR6cOqSjgjgCWfAt29PIK3bDGMRB4X4UNds+IdknEf2g/maX+eVsnSzrzxxqdBQvVL
         B8F+0T+zQMHtDu/uYdkQ6YRBoW/6yRa+jbH2Gb/I9RLf+dlAgvylqEkuhyOYA9z9rVs4
         JRLmjSvEVULQOrI/m+oeg6XLgS4gXdyyUDhA8QrxEnXlmEfiM8xn/U8ZE92x/lQ+c1Ee
         YJDQ==
X-Gm-Message-State: AOAM530gAMJ744QbO8OwsKGcmPpT12GOaUdtwub9nUnN/dgGco3waMbV
        6TJ7roBSkYqRCkthlTvHPq0+3MX9tm/fNHFeLiG6wQ==
X-Google-Smtp-Source: ABdhPJwUZVBgWO1YWE/z9a1WcXivFGotjG+hr0MF+DebfEnUqWSrYWOQm2jKUHfkxpvHn4qBntPjwm1cbnN6Xd+PwTU=
X-Received: by 2002:a67:facb:: with SMTP id g11mr2655226vsq.19.1611063816141;
 Tue, 19 Jan 2021 05:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20201216131737.14883-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201216131737.14883-1-zhengyongjun3@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:42:59 +0100
Message-ID: <CAPDyKFo_eaTpjFZ6zPw8dLOtzT1nyZY=c7=KuoWMER=ZPvD32A@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: core: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Dec 2020 at 14:17, Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d42037f0f10d..07c5f242f28a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -547,10 +547,10 @@ int mmc_cqe_recovery(struct mmc_host *host)
>         host->cqe_ops->cqe_recovery_start(host);
>
>         memset(&cmd, 0, sizeof(cmd));
> -       cmd.opcode       = MMC_STOP_TRANSMISSION,
> -       cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
> +       cmd.opcode       = MMC_STOP_TRANSMISSION;
> +       cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
>         cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
> -       cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
> +       cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
>         mmc_wait_for_cmd(host, &cmd, 0);
>
>         memset(&cmd, 0, sizeof(cmd));
> @@ -558,7 +558,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
>         cmd.arg          = 1; /* Discard entire queue */
>         cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
>         cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
> -       cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
> +       cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
>         err = mmc_wait_for_cmd(host, &cmd, 0);
>
>         host->cqe_ops->cqe_recovery_finish(host);
> --
> 2.22.0
>
