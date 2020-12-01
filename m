Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0DDC63777
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEEE20809
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tz/zcBvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgLAC3J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLAC3J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 21:29:09 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC50C0613D3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 18:28:28 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b12so297296pjl.0
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 18:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EXoDwvSjt22E8mrtUvILlvBbztf50ITW2DwnFsqDqOY=;
        b=Tz/zcBvQZ/T+ZZV4+7cBfs7h72J4yEszVWGaNb+QjOSynIFfPbkdzYzzU9S9dcMqkN
         ZYLM8GzMd+GKqE8h6xMRYG7DXjkPkp1ErVmKyvKTbhLiSUf43H9cEibz8HalldOdrxkr
         +CkxOIDM4cj4Uorv6QlE/ZLIaBz04xDjOnQrSRmXNIfNy0VLsmT+1JoE0k4KzBmuXGSJ
         kHQjG+IdinN9eTF2AFjXUsaP7gnztXDYelca5W6tIS7k7jEUqC1lchgWrdYjAmMomkbn
         FzMW2MoBAMVFGztjUwnIYaozuR3n8QXQQ+EdBnpDwhvjJBupzFFyUQPwbpwEqyWvqTAN
         ljng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EXoDwvSjt22E8mrtUvILlvBbztf50ITW2DwnFsqDqOY=;
        b=Fb4qiFAEo/NkS9ezX57wcOLo9M/p3ibiOt5xNgtqlPV5/mm0G/XisuUTma2ZVRh8N5
         p5TNC46XjUvoZMOZp+9RZcaf/ZgNA3xINsxw9To3JEuN8dQheppkq1MEoiZcvjwfve/m
         uE3AomEhbC/u4NKSGnIf7fMg4sokm+wTGKRua5OYc4yyULzfiUCJVN7WspHTBpZdpY0q
         Uhh73aW8GgPVDKjUMgsN/xw6/vh0YtSVNVzZ2qsbiMwkrTsYCB46M6bYnvzd9BfHTjjV
         zw8crOtwb20e2Ks6ZQQO5iWVFRCq18VJruaKqxQhSrO7YGG3lXXtbl1ZBIFEdSyoxaFr
         CBZQ==
X-Gm-Message-State: AOAM533BZ+IDmR2lvkKDqqSZ1LayZmAcT3Gf33anHIBzwED58HdUqF02
        VMWiIq+YAR4fyyaWkfYCRgFtFA==
X-Google-Smtp-Source: ABdhPJyAS3ArmLirT98GlWYnDPZln9OFDPoScT1Tt8wK9FFy2ujWhMXdE3AK5C+pq45FKn8dunYmYw==
X-Received: by 2002:a17:902:b90b:b029:da:97e2:722d with SMTP id bf11-20020a170902b90bb02900da97e2722dmr664648plb.3.1606789707973;
        Mon, 30 Nov 2020 18:28:27 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id s11sm363266pfh.128.2020.11.30.18.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:28:27 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:28:23 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 19/27] mmc: sdhci-uhs2: add set_reg() to
 initialise the interface
Message-ID: <20201201022823.GC43403@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-20-takahiro.akashi@linaro.org>
 <2356a6bc-bb19-0689-3b69-93f612ccb719@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2356a6bc-bb19-0689-3b69-93f612ccb719@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 26, 2020 at 10:18:26AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > This is a sdhci version of mmc's uhs2_set_reg operation.
> > UHS-II interface (related registers) will be initialised here.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 103 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 55362ace1857..d8afb99a9918 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -332,6 +332,68 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >  
> > +/* TODO: move this function to sdhci.c */
> > +static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> > +{
> > +	u32 ier;
> > +
> > +	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
> > +	ier &= ~clear;
> > +	ier |= set;
> > +	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> > +	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> > +}
> > +
> > +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> > +{
> > +	u32 value;
> > +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> > +	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
> > +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> > +	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
> > +	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
> > +
> > +	/* Set Gen Settings */
> > +	sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
> > +		SDHCI_UHS2_GEN_SET_N_LANES_POS, sdhci_uhs2_gen_set_reg);
> > +
> > +	/* Set PHY Settings */
> > +	value = (host->mmc->uhs2_caps.n_lss_dir_set <<
> > +			SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
> > +		(host->mmc->uhs2_caps.n_lss_sync_set <<
> > +			SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
> > +	if (host->mmc->flags & MMC_UHS2_SPEED_B)
> > +		value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
> > +	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> > +
> > +	/* Set LINK-TRAN Settings */
> > +	value = (host->mmc->uhs2_caps.max_retry_set <<
> > +			SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
> > +		(host->mmc->uhs2_caps.n_fcu_set <<
> > +			SDHCI_UHS2_TRAN_SET_N_FCU_POS);
> > +	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> > +	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
> > +		     sdhci_uhs2_tran_set_1_reg);
> > +}
> > +
> > +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> > +{
> > +	int timeout = 100;
> > +
> > +	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> > +		SDHCI_UHS2_IN_DORMANT_STATE)) {
> 
> Can use read_poll_timeout(sdhci_readl,..., host, SDHCI_PRESENT_STATE)

Okay

-Takahiro Akashi

> > +		if (timeout == 0) {
> > +			pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n",
> > +				mmc_hostname(host->mmc));
> > +			sdhci_dumpregs(host);
> > +			return -EIO;
> > +		}
> > +		timeout--;
> > +		mdelay(1);
> > +	}
> > +	return 0;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * MMC callbacks                                                             *
> > @@ -422,6 +484,45 @@ static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> >  	}
> >  }
> >  
> > +static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
> > +{
> > +        struct sdhci_host *host = mmc_priv(mmc);
> > +	unsigned long flags;
> > +	int err = 0;
> > +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> > +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> > +
> > +	DBG("Begin sdhci_uhs2_set_reg, act %d.\n", act);
> > +	spin_lock_irqsave(&host->lock, flags);
> > +
> > +	switch (act) {
> > +	case SET_CONFIG:
> > +		sdhci_uhs2_set_config(host);
> > +		break;
> > +	case ENABLE_INT:
> > +		sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> > +		break;
> > +	case DISABLE_INT:
> > +		sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> > +		break;
> > +	case SET_SPEED_B:
> > +		sdhci_writeb(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
> > +			     sdhci_uhs2_phy_set_reg);
> > +		break;
> > +	case CHECK_DORMANT:
> > +		err = sdhci_uhs2_check_dormant(host);
> > +		break;
> > +	default:
> > +		pr_err("%s: input action %d is wrong!\n",
> > +		       mmc_hostname(host->mmc), act);
> > +		err = -EIO;
> > +		break;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +	return err;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -597,6 +698,8 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
> >  	if (!host->mmc_host_ops.uhs2_enable_clk)
> >  		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
> > +	if (!host->mmc_host_ops.uhs2_set_reg)
> > +		host->mmc_host_ops.uhs2_set_reg = sdhci_uhs2_set_reg;
> >  
> >  	return 0;
> >  }
> > 
> 
