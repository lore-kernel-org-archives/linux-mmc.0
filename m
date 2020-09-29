Return-Path: <SRS0=RpB2=DG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F36C4727C
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Sep 2020 00:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA652193E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Sep 2020 00:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v69NAAku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgI2Afz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgI2Afz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 20:35:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04210C061755
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 17:35:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j19so559051pjl.4
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uaAgCWaphNg4XUpNx4joWU1xUSe7LvQcJOGZWvIHnHc=;
        b=v69NAAkuCTEr7hg3phUdSwS/jRxtb9RhagIGnDoxmqRXRs2S6C/CmnrYbXfDPrKmM7
         QKjikJoR6KEdqOFIQ0BMA2SDVoq2ov6NBMoBRH42AjSEXXz+zca8AQjnpe+FciLxsMNS
         mTm0/iSB/gGJ4zkbRi+9IGT69J067NB76CdJmDnGwpZ/eZqCO8nZ6G77J0x6C6sZn2Tf
         sarRvQVDFOV4eSjr1zdVf9CA+EwfAUiXpEjL+jpMGujhWiuo7JMxdHoy6SCk+CbR09Q3
         u8QlDxiw3bRifR3UEMb1QX9f82B+GzxbIkCVeaMBS+mMYhLjSMIZFQFQCl6DcBSG+mhW
         HwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uaAgCWaphNg4XUpNx4joWU1xUSe7LvQcJOGZWvIHnHc=;
        b=YuElbPP2ZWObimuu4U8gTjILBGH1pFLxWbd/iJcfCQCD+pVzVmWYXnq//tDB3Qhstq
         +MmeB6DH7RMrNO5GfRXEv7EBwlDbY6rX7eykgCLa7tbaabh9zY5dKQDq4Yb4KFe//MfV
         SmCllotAV8HOgDJtAYF5Xh7vv67UBdOmmAEwmBa1S8afrWQ4slAOZwqfv0bQmDv+Oq4D
         fWuqq6kezSeF21FO+RZXQ2FANWujUGvUs6FNP27qz8FgN1SgxwM8oltdOOfS22uCJuQ2
         +lRCnzzl4cbR4DTxtcDtZiLnP6hdatJt845xxtyLhijHErKPxsJfvo7HNmH/HCxZpQ5Y
         5gLA==
X-Gm-Message-State: AOAM5317NdofN5X9nKuTgbY7JNbnPY5Sd3EwnfjdX3Ao1pmQ2A7NGxPW
        tgjrVBST3YCYmy98aBYVLdlogA==
X-Google-Smtp-Source: ABdhPJw4qd17QzT6F2MmDcBshvhH/7FLRINF+lgsSnB4r4uMssLfw33w1g4TzP14kOgM0kQATT3GoA==
X-Received: by 2002:a17:90a:fc1:: with SMTP id 59mr1653722pjz.156.1601339753340;
        Mon, 28 Sep 2020 17:35:53 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id q16sm3127759pfj.117.2020.09.28.17.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:35:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brad Harper <bjharper@gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: host: meson-gx-mmc: fix possible deadlock condition for preempt_rt
In-Reply-To: <20200927025418.12382-2-bjharper@gmail.com>
References: <20200927025418.12382-1-bjharper@gmail.com> <20200927025418.12382-2-bjharper@gmail.com>
Date:   Mon, 28 Sep 2020 17:35:50 -0700
Message-ID: <7hwo0dmnbt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Brad Harper <bjharper@gmail.com> writes:

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


This patch still needs changelog summarizing the problem and what is
being fixed by the patch.  Most of what's in the cover letter belongs
here.

The cover letter can be used to describe the history/background that you
don't want in the patch itself.  Alternatviely, you could include that
information in the a single patch email also because everything after
the "---" line does not end up in git history.

> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 08a3b1c05..3ba8f988d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -146,6 +146,7 @@ struct sd_emmc_desc {
>  };
>  
>  struct meson_host {
> +	spinlock_t		lock;
>  	struct	device		*dev;
>  	struct	meson_mmc_data *data;
>  	struct	mmc_host	*mmc;
> @@ -1051,6 +1052,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	host->mmc = mmc;
>  	host->dev = &pdev->dev;
>  	dev_set_drvdata(&pdev->dev, host);
> +	spin_lock_init(&host->lock);

I'm confused about what this lock is intended to do.  You init it here,
but it's never used anywhere.  

>  	/* The G12A SDIO Controller needs an SRAM bounce buffer */
>  	host->dram_access_quirk = device_property_read_bool(&pdev->dev,
> @@ -1139,7 +1141,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	       host->regs + SD_EMMC_IRQ_EN);
>  
>  	ret = request_threaded_irq(host->irq, meson_mmc_irq,
> -				   meson_mmc_irq_thread, IRQF_ONESHOT,
> +				   meson_mmc_irq_thread, 0,
>  				   dev_name(&pdev->dev), host);
>  	if (ret)
>  		goto err_init_clk;

Kevin
