Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE42C433E2
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A91214F1
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qR9Ll7o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIOG7O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgIOG7M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:59:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADDEC06174A
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 23:59:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so1276748pjr.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=RM0TRqzdIYCRaUY20HBu5jkowpibtAwtQdq920OxMMs=;
        b=qR9Ll7o2RG84QZEO0G0K6fbhcvZiZVgrOUGDc66w1LqUYkulRaX0ftd6SwoYkdtURI
         U0yTWO9e2+ndVVAFUm/pafo49RX/HI78yjPbVO/H4jVp02YO9nKLTAAiQHFGP2n9GtO0
         z1eQYNT19GwkhQMcKKDxkMd3NpSu7mX9V7zb1Kke032s23emHHPJW97oU2xIrHxoo+jp
         j7SPIF9asXQbjBWQot6TNWd4mi5xSWJJqljHpXWk7EJDJf1b95vFmyNAZOV32svQDlLV
         uU1p0bQ8tFCRIXUxebamqfogTjKKgDNKf29V5GcMKN3UVDmBgUlw7YQB1W5pHw9pVT6v
         QTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RM0TRqzdIYCRaUY20HBu5jkowpibtAwtQdq920OxMMs=;
        b=KfdLgSaZ4GwiD42h/zjmrfbJnTQM/TDE4bOkmy366+6kP5jT7DlxV4se4BJ9vF2ypt
         9FdvU/ew/O9DP8kaoecbmBsh0T9CrDacf4bbxPFljD4utlvCV/gCeQezi01AzlnmWIVY
         p8oG7JPNP3VnYZeQmdH3D3Z29QrQpiZF1HReSc2U3sw/6PL2mAhkFajFhU7gNcuDOB+N
         qHmdQ/IIMjTFrhLxuyWfSVVpaAArJvPQRtLwm8q97xN+jqGK/2sqQLgl4xWWviuc7Yj6
         FYHf34uz9j7MU6Mchc3gnFkI2Tz8GXKcWZT1+MUC0QG4M8g4Eufy0LNT4EvN7vUfZ/Iu
         3Eqw==
X-Gm-Message-State: AOAM5316wyMa1YTXTZSgN8+L2rFD+k5kRxSrYjv6XutohiXJyNL/E197
        WTTHfThVLPeoqMC34Et8DlIdpA==
X-Google-Smtp-Source: ABdhPJyoGkzadOVUWljNrZd3YqDBySXqpwl1WGOMORc4+5w7Wd+P7Fj5Dke9nLAdoa1qiFtPnHmMbA==
X-Received: by 2002:a17:902:d714:b029:d0:cbe1:e7a2 with SMTP id w20-20020a170902d714b02900d0cbe1e7a2mr17469495ply.19.1600153151832;
        Mon, 14 Sep 2020 23:59:11 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id o20sm11034207pgh.63.2020.09.14.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:59:11 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:59:02 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 11/21] mmc: sdhci: UHS-II support, export host
 operations to core
Message-ID: <20200915065902.GE2860208@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111044.29509-1-benchuanggli@gmail.com>
 <5f3dc200-b9ef-a678-25b7-3bff3a529703@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3dc200-b9ef-a678-25b7-3bff3a529703@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 21, 2020 at 05:05:44PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:10 pm, Ben Chuang wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > Export sdhci-specific UHS-II operations to core.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c | 70 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c2f6923d296c..aaf41954511a 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2977,6 +2977,70 @@ static void sdhci_card_event(struct mmc_host *mmc)
> >  	spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
> > +static int sdhci_uhs2_detect_init(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	int ret;
> > +
> > +	if (sdhci_uhs2_ops.do_detect_init)
> > +		ret = sdhci_uhs2_ops.do_detect_init(host);
> > +	else
> > +		return 0;
> > +
> > +	return ret;
> > +}
> > +
> > +static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	int ret;
> > +
> > +	if (sdhci_uhs2_ops.do_set_reg)
> > +		ret = sdhci_uhs2_ops.do_set_reg(host, act);
> > +	else
> > +		ret = 0;
> > +
> > +	return ret;
> > +}
> > +
> > +static void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +	clk &= ~SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +}
> > +
> > +static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +	ktime_t timeout;
> > +
> > +	clk |= SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +	/* Wait max 20 ms */
> > +	timeout = ktime_add_ms(ktime_get(), 20);
> > +	while (1) {
> > +		bool timedout = ktime_after(ktime_get(), timeout);
> > +
> > +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +		if (clk & SDHCI_CLOCK_INT_STABLE)
> > +			break;
> > +		if (timedout) {
> > +			pr_err("%s: Internal clock never stabilised.\n",
> > +			       mmc_hostname(host->mmc));
> > +			sdhci_dumpregs(host);
> > +			return;
> > +		}
> > +		udelay(10);
> > +	}
> > +}
> > +#endif /* CONFIG_MMC_SDHCI_UHS2 */
> 
> Please put all uhs2 functions in sdhci-uhs2.c and call them through sdhci_ops.

Okay although the logic itself in sdhci_uhs2_[enable|disable]_clk()
doesn't seem to be UHS-II specific.

-Takahiro Akashi

> 
> > +
> >  static const struct mmc_host_ops sdhci_ops = {
> >  	.request	= sdhci_request,
> >  	.post_req	= sdhci_post_req,
> > @@ -2992,6 +3056,12 @@ static const struct mmc_host_ops sdhci_ops = {
> >  	.execute_tuning			= sdhci_execute_tuning,
> >  	.card_event			= sdhci_card_event,
> >  	.card_busy	= sdhci_card_busy,
> > +#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
> > +	.uhs2_detect_init	= sdhci_uhs2_detect_init,
> > +	.uhs2_set_reg		= sdhci_uhs2_set_reg,
> > +	.uhs2_disable_clk	= sdhci_uhs2_disable_clk,
> > +	.uhs2_enable_clk	= sdhci_uhs2_enable_clk,
> > +#endif /* CONFIG_MMC_SDHCI_UHS2 */
> >  };
> >  
> >  /*****************************************************************************\
> > 
> 
