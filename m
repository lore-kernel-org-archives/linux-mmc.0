Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098DBC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 22:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355869AbiDZWjj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbiDZWjg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 18:39:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C552D1E9
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 15:36:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w19so63445lfu.11
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04Y8EyqnAbPDlYjoJfa9pCdb/3RIuUZtouX02UGOfkA=;
        b=qAHfoAeMRGkvQCCgNkzXueTpE5HbWAnqTeZz/l7FeuBitYOV8RQuwKK8MfNw57uAtZ
         pYQX7T6MVdj4lmKivT9j9MkwLu2f5LZPRG1gRa031pIYQ+ixSjArmTIKOzGtcQUbGM6H
         fP1jGl2juXBqK6Df1l6SRzJ8Jm5Pd/DaRK/PWt/7Jtiwfp1GUrtDWrPZ5ScZ5henqrau
         pVII2vOXkFVnpzjo+K9MIkyNsppyudSeQNEGoAV096jBsmhhZfkHz9FzJv1XxpPNME3+
         OjSxvwty+JEjvKRaQ66UY1INVcNpqHeX9LQvZfDjtyXX5Qp9+hUDRxR+ZqQ4pGAOA0a/
         TxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04Y8EyqnAbPDlYjoJfa9pCdb/3RIuUZtouX02UGOfkA=;
        b=PzryuU0O5Mb4LNRy3CN4FUsNlCAjsqRFqZSzdBOFOyKP+9vuY18UXlbSBL3AGUXx45
         DB2cr9b35jcqHRQBeO5/gRhog8yQWEVJzwM+jZSyvq8kRDwKndeh9zOa40/DHt8nZlql
         B0gK5TOwGQlDAcN7csP8rKpe7HE9w5L3CBvbgou49FBsINefz7kncRbTFJBrZN6kUK6f
         9DPaqv09mUrhnj5QvCIrSGpMJt3d2B6d6E1M7OoSa6TVWein9ZuZjGNb+eXfrqzRQd+g
         Sg/RAH//Ph1SA1Zh1YRvlBbhp2kBhzxygkVX8DQIt6+cE20jGsfAIpOogJCPc4mYkAeu
         fCIQ==
X-Gm-Message-State: AOAM530Xhht2dTF9V9SywIZ5rSvzkhyElic8lbYMMD55/SYMVxKWvRRs
        yAEEIwOamg40C/ytThP0/khcBUAOJ2KcOwhZP21ykQ==
X-Google-Smtp-Source: ABdhPJyIBGeFnsgimn2eHwICxuOo+vIFi0N6c3BUm2LRZzNwHj51sTxilw72jDXJpm7to95EgKiisyTtfXeZa/9Mh1k=
X-Received: by 2002:a19:e007:0:b0:44a:a22d:2d49 with SMTP id
 x7-20020a19e007000000b0044aa22d2d49mr18217571lfg.254.1651012585552; Tue, 26
 Apr 2022 15:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <1650964225-6705-1-git-send-email-quic_spathi@quicinc.com>
In-Reply-To: <1650964225-6705-1-git-send-email-quic_spathi@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Apr 2022 00:35:48 +0200
Message-ID: <CAPDyKFoq2zJwTT6JrnvEjh0VvJLkt6PKhk9KhwVjTF0Eq3jOYw@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Add wakeup functionality support for
 sdio cards
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>
Cc:     u.kleine-koenig@pengutronix.de, YehezkelShB@gmail.com,
        rmk+kernel@armlinux.org.uk, t.scherer@eckelmann.de,
        s.shtylyov@omp.ru, sensor1010@163.com, sartgarg@codeaurora.org,
        hns@goldelico.com, uic_kamasali@quicinc.com,
        tiantao6@hisilicon.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kamasali <quic_kamasali@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Apr 2022 at 11:10, Srinivasarao Pathipati
<quic_spathi@quicinc.com> wrote:
>
> From: Sarthak Garg <sartgarg@codeaurora.org>
>
> This adds external GPIO wakeup support to sdhci-msm driver
> for sdio cards.

There is not a single line changed in the sdhci-msm driver, so I am
not sure what this is intended to fix.

I assume this is a downstream patch you want to upstream, which is a
good thing that we all appreciate. However, before just posting a
patch from downstream code, please have a look at the commit message
and let it explain what and why you want to change things.

I am deferring to review this, until you post a version with a proper
commit message. Sorry.

Kind regards
Uffe

>
> Also enables clk gating only in system Suspend/Resume for SDIO card.
>
> Also add the below fixes from 4.9 kernel :
>
> c363224b: Fix wakeup functionality for SDIO
> 61fc5bf6: Remove flag MMC_PM_WAKE_SDIO_IRQ in mmc_resume_host
> a7a2a82e: Set sdio_pending_processing default state to false.
>
> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
> ---
>  drivers/mmc/core/bus.c  | 7 +++++++
>  drivers/mmc/core/sdio.c | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 58a60af..a475fe1 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -364,6 +364,13 @@ int mmc_add_card(struct mmc_card *card)
>  #endif
>         card->dev.of_node = mmc_of_find_child_device(card->host, 0);
>
> +       if (mmc_card_sdio(card)) {
> +               ret = device_init_wakeup(&card->dev, true);
> +               if (ret)
> +                       pr_err("%s: %s: failed to init wakeup: %d\n",
> +                               mmc_hostname(card->host), __func__, ret);
> +       }
> +
>         device_enable_async_suspend(&card->dev);
>
>         ret = device_add(&card->dev);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 25799ac..9502318 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1096,6 +1096,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>         mmc_release_host(host);
>
>         host->pm_flags &= ~MMC_PM_KEEP_POWER;
> +       host->pm_flags &= ~MMC_PM_WAKE_SDIO_IRQ;
>         return err;
>  }
>
> --
> 2.7.4
>
