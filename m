Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D0C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 05:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3894E206B2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 05:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+UxwzwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgINFpj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 01:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgINFp2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2020 01:45:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F67C061788
        for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2020 22:45:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v196so11783979pfc.1
        for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2020 22:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=glNkNRmAU7RgWAdV6/8XgRfmftYWgIcuHxeSjWhpb4E=;
        b=f+UxwzwJdNkNO/6FibwIffKu3/WUBpoItsoZOlKwJS4ClrjUc7OGQF7rLPhEigPZrD
         P/LSX8+T0lA3hfpw5AJkM2NzUkVtMTw+9eXZGTFkXle3dbuefjzuP2u56A2i+hXb7OBS
         W2PuJ5VHlKpm+lL6TEhMU+GNl78UdYZrwSXR8X1NodmFpXwcR/hAvQXErMxPamXpnQ+i
         e7LrcwOCXlaxCD1NmKZo+P4elpUvLPpQTXFZiTwOJ/D5o5fBSR7sqcLYsXMvIbF2Srpm
         nw8JyadTJoQswyU5VQR/8+t87+W975kkrMDZWJ6d4f/8/ytcVgIc4TVionvfw8J8K8rP
         sCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=glNkNRmAU7RgWAdV6/8XgRfmftYWgIcuHxeSjWhpb4E=;
        b=RcFmaWTD3hx6EdskYIDlzzDdFCKfggrADPr33oPpA64/clKW4Je7/3RjorF7N5dpac
         Q04raVUu3KZygirvNnYSuBijt9lfv0saWspgU0rcW10CvY//yKc7jE7ZDylowDTZ+For
         JHhqk33gU4hfBVSa5a85MtqqJQNXoA4cvC3cKbah/Dh7xlzWRg/3ZS+18je0jJ4uoxMy
         MIFMoDnx56LYXFY0F0jgKxHJtW1WDPAd1QM8BVtsSPhG4CHHnK/9pVQ+5l4vlcF54QwF
         JG4YIRfeqcCRVNJKBaxvqnDhh2HTnQUjUqChCwLpOhJE/rRali7NWpcmxG/8qVtCC9jL
         UQ8Q==
X-Gm-Message-State: AOAM532Jf6Xbh/4fty7V2X5mPUH2o3qooXWFRGkVoy9/CQcRqEcMuDKB
        0vXnjeOCDbKGI5hNQ892QugPqQ==
X-Google-Smtp-Source: ABdhPJwJlVuw6Kfa4Kii14VYrNit18OMZbeOflpyEGiQalFWMkzBvdH+JWxjbUFip9q52oZ+8dThvQ==
X-Received: by 2002:aa7:8aca:0:b029:13e:d13d:a13e with SMTP id b10-20020aa78aca0000b029013ed13da13emr12165811pfd.38.1600062342826;
        Sun, 13 Sep 2020 22:45:42 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id y13sm7342708pgs.53.2020.09.13.22.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 22:45:42 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:45:37 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 15/21] mmc: sdhci: UHS-II support, modify
 set_power() to handle vdd2
Message-ID: <20200914054537.GA2738017@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111140.29725-1-benchuanggli@gmail.com>
 <97c43596-a18f-4c7a-c226-5209772d91d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c43596-a18f-4c7a-c226-5209772d91d1@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian,

On Fri, Aug 21, 2020 at 05:11:18PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:11 pm, Ben Chuang wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > VDD2 is used for powering UHS-II interface.
> > Modify sdhci_set_power_and_bus_voltage(), sdhci_set_power_noreg()
> > and sdhci_set_power_noreg() to handle VDD2.
> 
> vdd2 is always 1.8 V and I suspect there may never be support for anything
> else, so we should start with 1.8 V only.

What do you mean here?
You don't want to add an extra argument, vdd2, to sdhci_set_power().
Correct?

> Also can we create uhs2_set_power_reg() and uhs2_set_power_noreg() and use
> the existing ->set_power() callback

Again what do you expect here?

Do you want to see any platform-specific mmc driver who supports UHS-II
to implement its own call back like:

void sdhci_foo_set_power(struct sdhci_host *host, unsigned char mode,
                                  unsigned short vdd)
{
        sdhci_set_power(host, mode,vdd);

        /* in case that sdhci_uhs2 module is not inserted */
        if (!(mmc->caps & MMC_CAP_UHS2))
                return;

        /* vdd2 specific operation */
        if (IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
                sdhci_uhs2_set_power_noreg(host, mode);
        else
                sdhci_uhs2_set_power_reg(host, mode);

        /* maybe more platform-specific initialization */
}

struct sdhci_ops sdhci_foo_ops = {
        .set_power = sdhci_foo_set_power,
        ...
}

Is this what you mean?
(I'm not quite sure yet that sdhci_ush2_set_power_noreg() can be split off
from sdhci_set_power_noreg().)

-Takahiro Akashi

}

> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-omap.c     |  2 +-
> >  drivers/mmc/host/sdhci-pci-core.c |  4 +--
> >  drivers/mmc/host/sdhci-pxav3.c    |  4 +--
> >  drivers/mmc/host/sdhci-xenon.c    |  4 +--
> >  drivers/mmc/host/sdhci.c          | 42 ++++++++++++++++++++++++-------
> >  drivers/mmc/host/sdhci.h          |  9 +++----
> >  6 files changed, 43 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> > index 1ec74c2d5c17..1926585debe5 100644
> > --- a/drivers/mmc/host/sdhci-omap.c
> > +++ b/drivers/mmc/host/sdhci-omap.c
> > @@ -678,7 +678,7 @@ static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
> >  }
> >  
> >  static void sdhci_omap_set_power(struct sdhci_host *host, unsigned char mode,
> > -			  unsigned short vdd)
> > +			  unsigned short vdd, unsigned short vdd2)
> >  {
> >  	struct mmc_host *mmc = host->mmc;
> >  
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index bb6802448b2f..40f5a24a8982 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -629,12 +629,12 @@ static int bxt_get_cd(struct mmc_host *mmc)
> >  #define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
> >  
> >  static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
> > -				  unsigned short vdd)
> > +				  unsigned short vdd, unsigned short vdd2)
> >  {
> >  	int cntr;
> >  	u8 reg;
> >  
> > -	sdhci_set_power(host, mode, vdd);
> > +	sdhci_set_power(host, mode, vdd, -1);
> >  
> >  	if (mode == MMC_POWER_OFF)
> >  		return;
> > diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> > index e55037ceda73..457e9425339a 100644
> > --- a/drivers/mmc/host/sdhci-pxav3.c
> > +++ b/drivers/mmc/host/sdhci-pxav3.c
> > @@ -298,12 +298,12 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
> >  }
> >  
> >  static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
> > -			    unsigned short vdd)
> > +			    unsigned short vdd, unsigned short vdd2)
> >  {
> >  	struct mmc_host *mmc = host->mmc;
> >  	u8 pwr = host->pwr;
> >  
> > -	sdhci_set_power_noreg(host, mode, vdd);
> > +	sdhci_set_power_noreg(host, mode, vdd, -1);
> >  
> >  	if (host->pwr == pwr)
> >  		return;
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> > index 4703cd540c7f..2b0ebb91895a 100644
> > --- a/drivers/mmc/host/sdhci-xenon.c
> > +++ b/drivers/mmc/host/sdhci-xenon.c
> > @@ -214,12 +214,12 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
> >  }
> >  
> >  static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
> > -		unsigned short vdd)
> > +		unsigned short vdd, unsigned short vdd2)
> >  {
> >  	struct mmc_host *mmc = host->mmc;
> >  	u8 pwr = host->pwr;
> >  
> > -	sdhci_set_power_noreg(host, mode, vdd);
> > +	sdhci_set_power_noreg(host, mode, vdd, -1);
> >  
> >  	if (host->pwr == pwr)
> >  		return;
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index d38d734ec83f..ca3d4a506e01 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2089,12 +2089,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >  EXPORT_SYMBOL_GPL(sdhci_set_clock);
> >  
> >  static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
> > -				unsigned short vdd)
> > +				unsigned short vdd, unsigned short vdd2)
> >  {
> >  	struct mmc_host *mmc = host->mmc;
> >  
> >  	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> >  
> > +	if (mmc->caps & MMC_CAP_UHS2 && !IS_ERR(mmc->supply.vmmc2))
> > +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, vdd2);
> > +
> >  	if (mode != MMC_POWER_OFF)
> >  		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> >  	else
> > @@ -2102,7 +2105,7 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
> >  }
> >  
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> > -			   unsigned short vdd)
> > +			   unsigned short vdd, unsigned short vdd2)
> >  {
> >  	u8 pwr = 0;
> >  
> > @@ -2133,6 +2136,20 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >  		}
> >  	}
> >  
> > +	if (mode != MMC_POWER_OFF) {
> > +		if (vdd2 != (unsigned short)-1) {
> > +			switch (1 << vdd2) {
> > +			case MMC_VDD2_165_195:
> > +				pwr |= SDHCI_VDD2_POWER_180;
> > +				break;
> > +			default:
> > +				WARN(1, "%s: Invalid vdd2 %#x\n",
> > +				     mmc_hostname(host->mmc), vdd2);
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> >  	if (host->pwr == pwr)
> >  		return;
> >  
> > @@ -2159,7 +2176,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >  			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> >  
> >  		pwr |= SDHCI_POWER_ON;
> > +		if (vdd2 != (unsigned short)-1)
> > +			pwr |= SDHCI_VDD2_POWER_ON;
> > +
> > +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +		mdelay(5);
> >  		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +		mdelay(5);
> >  
> >  		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> >  			sdhci_runtime_pm_bus_on(host);
> > @@ -2175,12 +2198,12 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >  EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
> >  
> >  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> > -		     unsigned short vdd)
> > +		     unsigned short vdd, unsigned short vdd2)
> >  {
> >  	if (IS_ERR(host->mmc->supply.vmmc))
> > -		sdhci_set_power_noreg(host, mode, vdd);
> > +		sdhci_set_power_noreg(host, mode, vdd, vdd2);
> >  	else
> > -		sdhci_set_power_reg(host, mode, vdd);
> > +		sdhci_set_power_reg(host, mode, vdd, vdd2);
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_set_power);
> >  
> > @@ -2192,14 +2215,15 @@ EXPORT_SYMBOL_GPL(sdhci_set_power);
> >   */
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >  				     unsigned char mode,
> > -				     unsigned short vdd)
> > +				     unsigned short vdd,
> > +				     unsigned short vdd2)
> >  {
> >  	if (!IS_ERR(host->mmc->supply.vmmc)) {
> >  		struct mmc_host *mmc = host->mmc;
> >  
> >  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> >  	}
> > -	sdhci_set_power_noreg(host, mode, vdd);
> > +	sdhci_set_power_noreg(host, mode, vdd, -1);
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_set_power_and_bus_voltage);
> >  
> > @@ -2377,9 +2401,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	}
> >  
> >  	if (host->ops->set_power)
> > -		host->ops->set_power(host, ios->power_mode, ios->vdd);
> > +		host->ops->set_power(host, ios->power_mode, ios->vdd, -1);
> >  	else
> > -		sdhci_set_power(host, ios->power_mode, ios->vdd);
> > +		sdhci_set_power(host, ios->power_mode, ios->vdd, -1);
> >  
> >  	/* 4.0 host support */
> >  	if (host->version >= SDHCI_SPEC_400) {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index ecf55394ea46..f6732f33f29f 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -689,7 +689,7 @@ struct sdhci_ops {
> >  
> >  	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
> >  	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
> > -			     unsigned short vdd);
> > +			     unsigned short vdd, unsigned short vdd2);
> >  
> >  	u32		(*irq)(struct sdhci_host *host, u32 intmask);
> >  
> > @@ -852,13 +852,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  		   unsigned int *actual_clock);
> >  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> >  void sdhci_enable_clk(struct sdhci_host *host, u16 clk);
> > -void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> > -		     unsigned short vdd);
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >  				     unsigned char mode,
> > -				     unsigned short vdd);
> > -void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> > -			   unsigned short vdd);
> > +				     unsigned short vdd,
> > +				     unsigned short vdd2);
> >  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> >  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
> >  void sdhci_set_bus_width(struct sdhci_host *host, int width);
> > 
> 
