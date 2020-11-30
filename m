Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C2C63777
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618C0206CB
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHiyj14L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgK3HQg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgK3HQg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 02:16:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E520C0613CF
        for <linux-mmc@vger.kernel.org>; Sun, 29 Nov 2020 23:15:56 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so5969131pls.10
        for <linux-mmc@vger.kernel.org>; Sun, 29 Nov 2020 23:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=xuyBG48IthI9ndBw0EiO6S8MOVBTdpZxMmZYocloFLI=;
        b=HHiyj14LzDQWuofBPekUZ9/7MLBCdLcsRqwknmARsC824bHr8zUxuqxKwbB0mjr/tQ
         wUIOFLaZ2w3zSeSErwVufJHkBKMBftNZ63FC1tbPzKOORCJyRyAbMYJd2/vG47XCODaw
         9T111Wa5Gn8ZW4k5ou6UXOzgLjevrzt3PtCWEj9XybuQNCtpgiWT+C4SCP67IFdJ/9Vm
         zDmbQ7svP9tGFZ2Dc3wdb1sYdeEc0ixFuRsin664ovGqhPHf4imsr7r0ZYmsLDwJ5sNG
         kDm0T7mCsUZzoTyN4np2zvrRIgoDftDcXOzHz5EvCVTgEYC6o0xb7n4i/yE+hWar2tKg
         5X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xuyBG48IthI9ndBw0EiO6S8MOVBTdpZxMmZYocloFLI=;
        b=i4x8X9BdT8jXjC6kDzbhgHOynS+2kTMedb+tdjMq9ko82mhKN7T2LSoPD6lxt/Q0Sl
         jPXKJ0fZaLL446SGCgGWOO3CgW4KeGtAqqmsW8lfBYSgy1wZ2zfA0vVqhbpmPjXOgbt5
         trVDVxsDie9Vk80dw2BV2l/VlJ/rKwVfSXrhSrHFUWOhiMOe+g79L/PSLJ+SrM0/G65r
         L6yIXaYj1iY/t2rbUd+XOY9NKBYI0DAjFnm2upE4Kuaj0JNme3W0LkuMKC8l472N7QkH
         bg20lYE1IT5tPJsHMiVaF+2bnvb9Rkal2bzicJZqTuYsZLxzrGPs59Me2LGj6I26gOj9
         Fdig==
X-Gm-Message-State: AOAM530nmHivmicV1WLgs3jqSswRoruwtp4JokmypOXzuLj7sU9FkOkp
        wB3JtRzSv4O7/XKOeMTUrE/qSA==
X-Google-Smtp-Source: ABdhPJzRcKzVUEb/dxvTnsFVwzp8LZtlw8HsQaRD64elvLN931ZDoiuS+MF+2lfwwJ0GZ3QJSN9uqQ==
X-Received: by 2002:a17:902:8a91:b029:d9:da43:43ba with SMTP id p17-20020a1709028a91b02900d9da4343bamr17309593plo.14.1606720555624;
        Sun, 29 Nov 2020 23:15:55 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id t19sm3006519pgk.86.2020.11.29.23.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 23:15:54 -0800 (PST)
Date:   Mon, 30 Nov 2020 16:15:50 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 13/27] mmc: sdhci-uhs2: add set_power() to
 support vdd2
Message-ID: <20201130071550.GD48535@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-14-takahiro.akashi@linaro.org>
 <3b47a2d4-a281-3fac-29c4-82dd769459a1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b47a2d4-a281-3fac-29c4-82dd769459a1@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 26, 2020 at 10:16:27AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > This is a UHS-II version of sdhci's set_power operation.
> > VDD2, as well as VDD, is handled here.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 80 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  2 +
> >  drivers/mmc/host/sdhci.c      | 58 +++++++++++++++----------
> >  drivers/mmc/host/sdhci.h      |  2 +
> >  4 files changed, 119 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index e2b9743fe17d..2bf78cc4e9ed 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -98,6 +98,86 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >  
> > +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> > +			  unsigned short vdd)
> 
> This function isn't used, so let's rename it sdhci_uhs2_set_power_noreg and
> drop regulator support.

I have no strong opinion, but here Ben might want to further rework
the new sdhci_uhs2_set_power_noreg() now that it is almost the same as
GLI's gl9755_set_power()(, adding a new quirk?).

> > +{
> > +	struct mmc_host *mmc = host->mmc;
> > +	u8 pwr;
> > +
> > +	/* FIXME: check if flags & MMC_UHS2_SUPPORT? */
> > +	if (!(host->mmc->caps & MMC_CAP_UHS2)) {
> 
> As commented in another patch, please use a helper fn

As said, I would defer this.

> > +		sdhci_set_power(host, mode, vdd);
> > +		return;
> > +	}
> > +
> > +	if (mode != MMC_POWER_OFF) {
> > +		pwr = sdhci_get_vdd_value(vdd);
> 
> Simpler to open code this esp. as there are only 2 valid values:
> 
> 		switch (1 << vdd) {

Can you ignore MMC_VDD_165_195 and MMC_VDD_20_21 here?

> 		case MMC_VDD_29_30..MMC_VDD_30_31:
> 			pwr = SDHCI_POWER_300;
> 			break;
> 		case MMC_VDD_32_33..MMC_VDD_33_34:
> 			pwr = SDHCI_POWER_330;
> 			break;
> 		default:
> 			WARN(1, "%s: Invalid vdd %#x\n",
> 			     mmc_hostname(host->mmc), vdd);
> 			break;
> 		}
> 
> 
> > +		if (!pwr)
> > +			WARN(1, "%s: Invalid vdd %#x\n",
> > +			     mmc_hostname(host->mmc), vdd);
> > +
> > +		pwr |= SDHCI_VDD2_POWER_180;
> > +	}
> > +
> > +	if (host->pwr == pwr)
> > +		return;
> > +	host ->pwr = pwr;
> > +
> > +	if (pwr == 0) {
> > +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +		if (!IS_ERR(host->mmc->supply.vmmc))
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> > +
> > +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> 
> Please drop support for legacy quirk SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON

Okay.

> 
> > +			sdhci_runtime_pm_bus_off(host);
> > +	} else {
> > +		if (!IS_ERR(host->mmc->supply.vmmc))
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> > +			/* support 1.8v only for now */
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2,
> > +					      fls(MMC_VDD2_165_195) - 1);
> > +
> > +		/*
> > +		 * Spec says that we should clear the power reg before setting
> > +		 * a new value. Some controllers don't seem to like this though.
> > +		 */
> > +		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))
> 
> Please drop support for legacy quirk here and several cases below.  As I
> mentioned in another patch, just put a comment somewhere listing what is
> not supported for UHS2 host controllers.

Okay.

-Takahiro Akashi

> 
> > +			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +		/*
> > +		 * At least the Marvell CaFe chip gets confused if we set the
> > +		 * voltage and set turn on power at the same time, so set the
> > +		 * voltage first.
> > +		 */
> > +		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
> > +			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +
> > +		/* vdd first */
> > +		pwr |= SDHCI_POWER_ON;
> > +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +		mdelay(5);
> > +
> > +		pwr |= SDHCI_VDD2_POWER_ON;
> > +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +		mdelay(5);
> > +
> > +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> > +			sdhci_runtime_pm_bus_on(host);
> > +
> > +		/*
> > +		 * Some controllers need an extra 10ms delay of 10ms before
> > +		 * they can apply clock after applying power
> > +		 */
> > +		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> > +			mdelay(10);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 7bb7a0d67109..3c19d8e44c36 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -211,5 +211,7 @@ struct sdhci_host;
> >  
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> > +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> > +			  unsigned short vdd);
> >  
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index af336bdb4305..0b741eb546cb 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -187,13 +187,14 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
> >  	sdhci_set_card_detection(host, false);
> >  }
> >  
> > -static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> > +void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> >  {
> >  	if (host->bus_on)
> >  		return;
> >  	host->bus_on = true;
> >  	pm_runtime_get_noresume(host->mmc->parent);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_on);
> >  
> >  void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> >  {
> > @@ -2017,36 +2018,47 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
> >  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >  }
> >  
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> > +{
> > +	u8 pwr;
> > +
> > +	switch (1 << vdd) {
> > +	case MMC_VDD_165_195:
> > +	/*
> > +	 * Without a regulator, SDHCI does not support 2.0v
> > +	 * so we only get here if the driver deliberately
> > +	 * added the 2.0v range to ocr_avail. Map it to 1.8v
> > +	 * for the purpose of turning on the power.
> > +	 */
> > +	case MMC_VDD_20_21:
> > +		pwr = SDHCI_POWER_180;
> > +		break;
> > +	case MMC_VDD_29_30:
> > +	case MMC_VDD_30_31:
> > +		pwr = SDHCI_POWER_300;
> > +		break;
> > +	case MMC_VDD_32_33:
> > +	case MMC_VDD_33_34:
> > +		pwr = SDHCI_POWER_330;
> > +		break;
> > +	default:
> > +		pwr = 0;
> > +	}
> > +
> > +	return pwr;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> > +
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >  			   unsigned short vdd)
> >  {
> >  	u8 pwr = 0;
> >  
> >  	if (mode != MMC_POWER_OFF) {
> > -		switch (1 << vdd) {
> > -		case MMC_VDD_165_195:
> > -		/*
> > -		 * Without a regulator, SDHCI does not support 2.0v
> > -		 * so we only get here if the driver deliberately
> > -		 * added the 2.0v range to ocr_avail. Map it to 1.8v
> > -		 * for the purpose of turning on the power.
> > -		 */
> > -		case MMC_VDD_20_21:
> > -			pwr = SDHCI_POWER_180;
> > -			break;
> > -		case MMC_VDD_29_30:
> > -		case MMC_VDD_30_31:
> > -			pwr = SDHCI_POWER_300;
> > -			break;
> > -		case MMC_VDD_32_33:
> > -		case MMC_VDD_33_34:
> > -			pwr = SDHCI_POWER_330;
> > -			break;
> > -		default:
> > +		pwr = sdhci_get_vdd_value(vdd);
> > +		if (!pwr)
> >  			WARN(1, "%s: Invalid vdd %#x\n",
> >  			     mmc_hostname(host->mmc), vdd);
> > -			break;
> > -		}
> >  	}
> >  
> >  	if (host->pwr == pwr)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index b9932423db08..2b5b8295cf92 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -831,6 +831,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
> >  	__sdhci_read_caps(host, NULL, NULL, NULL);
> >  }
> >  
> > +void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
> >  void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
> >  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  		   unsigned int *actual_clock);
> > @@ -841,6 +842,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >  				     unsigned char mode,
> >  				     unsigned short vdd);
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd);
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >  			   unsigned short vdd);
> >  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> > 
> 
