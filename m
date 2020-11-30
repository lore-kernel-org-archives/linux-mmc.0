Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A54C63777
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F1920731
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS6dvXId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgK3Hwd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgK3Hwd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 02:52:33 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF3C0613D3
        for <linux-mmc@vger.kernel.org>; Sun, 29 Nov 2020 23:51:53 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so9861999pfb.9
        for <linux-mmc@vger.kernel.org>; Sun, 29 Nov 2020 23:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aMAPiTNtbwp3+xod+WaGg7AbIQCIY/HHf/W9JevANis=;
        b=IS6dvXIdLG7npwnDxFzpCJdsOQwk3AuaswVMDw2PkDXeY4de4Vp5AZPqBdXhqhPPDR
         NJ6zM1x7+R2Oy6OobJYM4vBDc2ufO1x97fukQ4MlxN0JdYS4QYijA85SMrI7za2A3Vnw
         a7nNdkOT32hEBtOQhaW7hNiWh953Hfc0+z9C97rAaNEOHs6OZlzJqhmu0H1s7aZNf8eT
         AzDPI9cIypPoM+QSAvoLf051bp0g1P7+JPEtS6Zw02PHeK+QnTPXgQdL8Xgvqk6I55tQ
         xTPnfMJ1k+wK28tuvT7S+98WNI9MOklSY/li3v9vWPAhvSDL3/PGHBLHjUIMe2XMHKtw
         dS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aMAPiTNtbwp3+xod+WaGg7AbIQCIY/HHf/W9JevANis=;
        b=SzbgyfwKfQzWmcdzgOz4uRs0WX/3nxizfXlo15vnUsUi30oKU632JWO8jX5gO35N5A
         E2iA5z0s9ahsgNVHGcGa4v7oziDsZohaZNNvIRPTtTvq4rneUOrXeSxHr5Fjlzi3mINZ
         cvKvs/QX345WaITehjXA6Qe5PYZpIL6nJ+krYAoy1fuEM8t2zNoMh6a64FWxNYryR0BL
         1JcEYlv9aEiuyx7fyiBovjy/YwpJ3SPDRmBHf8RFnNX0pR0YeVntaYG3nL5Efa80jfBY
         lMKUAY6+bJeS0/Pv2i7aCv6AVyzaIJG0tZ2xLONmw/RupFqrjXEfcVouKnhtHVL7QHDn
         iHqg==
X-Gm-Message-State: AOAM5311vyXOyuXTwFsQivj59jE9qaf6AiL3BnLUwAKdrEjCr7dDt80P
        wcMyuKBmU8ZyGm/Hgl2PpTfyg+9pBpW3og==
X-Google-Smtp-Source: ABdhPJy4iXOOUtuaeIsiAtSAyhX5LuXu/GrDI2tCimPFexdfhXG4t2jGHqscwiry3lhvHEDKXLUuFQ==
X-Received: by 2002:a63:4e58:: with SMTP id o24mr16678640pgl.322.1606722712518;
        Sun, 29 Nov 2020 23:51:52 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id m14sm15313956pgu.0.2020.11.29.23.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 23:51:51 -0800 (PST)
Date:   Mon, 30 Nov 2020 16:51:47 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 16/27] mmc: sdhci-uhs2: add set_ios()
Message-ID: <20201130075147.GF48535@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-17-takahiro.akashi@linaro.org>
 <7d2b6524-b6ab-0fd0-edfa-8d7ff274cd1a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d2b6524-b6ab-0fd0-edfa-8d7ff274cd1a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 26, 2020 at 10:17:11AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > This is a sdhci version of mmc's set_ios operation.
> > It covers both UHS-I and UHS-II.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 100 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   1 +
> >  drivers/mmc/host/sdhci.c      |  40 +++++++++-----
> >  drivers/mmc/host/sdhci.h      |   2 +
> >  4 files changed, 128 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index d9e98c097bfe..637464748cc4 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -263,6 +263,74 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> >  
> > +/**
> > + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
> > + * @host:	SDHCI host
> > + * @clear:	bit-wise clear mask
> > + * @set:	bit-wise set mask
> > + *
> > + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> > + */
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> > +{
> > +	u32 ier;
> > +
> > +	ier = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN);
> > +	ier &= ~clear;
> > +	ier |= set;
> > +	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_STATUS_EN);
> > +	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_SIG_EN);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> > +
> > +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	u8 cmd_res, dead_lock;
> > +	u16 ctrl_2;
> > +	unsigned long flags;
> > +
> > +	/* FIXME: why lock? */
> > +	spin_lock_irqsave(&host->lock, flags);
> > +
> > +	/* UHS2 Timeout Control */
> > +	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +
> > +	/* change to use calculate value */
> > +	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
> > +
> > +	sdhci_uhs2_clear_set_irqs(host,
> > +				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
> > +				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT,
> > +				  0);
> > +	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +	sdhci_uhs2_clear_set_irqs(host, 0,
> > +				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
> > +				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT);
> > +
> > +	/* UHS2 timing */
> > +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +	if (ios->timing == MMC_TIMING_UHS2)
> > +		ctrl_2 |= SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN;
> > +	else
> > +		ctrl_2 &= ~(SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN);
> > +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +
> > +	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> > +		sdhci_enable_preset_value(host, true);
> > +
> > +	if (host->ops->set_power)
> > +		host->ops->set_power(host, ios->power_mode, ios->vdd);
> > +	else
> > +		sdhci_set_power(host, ios->power_mode, ios->vdd);
> > +	udelay(100);
> > +
> > +	host->timing = ios->timing;
> > +	sdhci_set_clock(host, host->clock);
> 
> sdhci_set_ios_common() already called ->set_clock() and ->set_power(), so I
> am not really following what is going on here.  Can you explain some more?

To be frank, I don't know. The logic in Intel's (and/or Ben's?)
original code does so.
What I changed is to remove the code of setting (ios->vdd and) ios->vdd2,
which is executed before calling set_power(), in __sdhci_uhs2_set_ios().

So yes, effectively it may be of no use to call set_power() here.

-Takahiro Akashi

> > +
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * MMC callbacks                                                             *
> > @@ -286,6 +354,37 @@ static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
> >  	return sdhci_start_signal_voltage_switch(mmc, ios);
> >  }
> >  
> > +void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +	if (!(host->version >= SDHCI_SPEC_400) ||
> > +	    !(host->mmc->flags & MMC_UHS2_SUPPORT &&
> > +	      host->mmc->caps & MMC_CAP_UHS2)) {
> > +		sdhci_set_ios(mmc, ios);
> > +		return;
> > +	}
> > +
> > +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> > +		return;
> > +
> > +	if (host->flags & SDHCI_DEVICE_DEAD) {
> > +		if (!IS_ERR(mmc->supply.vmmc) &&
> > +		    ios->power_mode == MMC_POWER_OFF)
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +		if (!IS_ERR_OR_NULL(mmc->supply.vmmc2) &&
> > +		    ios->power_mode == MMC_POWER_OFF)
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> > +		return;
> > +	}
> > +
> > +	/* FIXME: host->timing = ios->timing */
> > +
> > +	sdhci_set_ios_common(mmc, ios);
> > +
> > +	__sdhci_uhs2_set_ios(mmc, ios);
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -296,6 +395,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> >  	host->mmc_host_ops.start_signal_voltage_switch =
> >  		sdhci_uhs2_start_signal_voltage_switch;
> > +	host->mmc_host_ops.set_ios = sdhci_uhs2_set_ios;
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index efe70577bc74..c1ff4ac1ab7a 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -214,5 +214,6 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> >  			  unsigned short vdd);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> >  
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 0b741eb546cb..becb228330af 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -48,8 +48,6 @@
> >  static unsigned int debug_quirks = 0;
> >  static unsigned int debug_quirks2;
> >  
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > -
> >  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> >  
> >  void sdhci_dumpregs(struct sdhci_host *host)
> > @@ -1836,6 +1834,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
> >  	case MMC_TIMING_MMC_HS400:
> >  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
> >  		break;
> > +	case MMC_TIMING_UHS2:
> > +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> > +		break;
> >  	default:
> >  		pr_warn("%s: Invalid UHS-I mode selected\n",
> >  			mmc_hostname(host->mmc));
> > @@ -2249,20 +2250,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
> >  
> > -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >  	struct sdhci_host *host = mmc_priv(mmc);
> > -	u8 ctrl;
> > -
> > -	if (ios->power_mode == MMC_POWER_UNDEFINED)
> > -		return;
> > -
> > -	if (host->flags & SDHCI_DEVICE_DEAD) {
> > -		if (!IS_ERR(mmc->supply.vmmc) &&
> > -		    ios->power_mode == MMC_POWER_OFF)
> > -			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > -		return;
> > -	}
> >  
> >  	/*
> >  	 * Reset the chip on each power off.
> > @@ -2299,6 +2289,25 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  		host->ops->set_power(host, ios->power_mode, ios->vdd);
> >  	else
> >  		sdhci_set_power(host, ios->power_mode, ios->vdd);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> > +
> > +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	u8 ctrl;
> > +
> > +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> > +		return;
> > +
> > +	if (host->flags & SDHCI_DEVICE_DEAD) {
> > +		if (!IS_ERR(mmc->supply.vmmc) &&
> > +		    ios->power_mode == MMC_POWER_OFF)
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +		return;
> > +	}
> > +
> > +	sdhci_set_ios_common(mmc, ios);
> >  
> >  	if (host->ops->platform_send_init_74_clocks)
> >  		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> > @@ -2869,7 +2878,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
> >  
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> >  {
> >  	/* Host Controller v3.00 defines preset value registers */
> >  	if (host->version < SDHCI_SPEC_300)
> > @@ -2897,6 +2906,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> >  		host->preset_enabled = enable;
> >  	}
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
> >  
> >  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
> >  				int err)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 2b5b8295cf92..e84ebddb20d8 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -851,6 +851,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
> >  void sdhci_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
> >  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >  				      struct mmc_ios *ios);
> > 
> 
