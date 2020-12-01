Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7EC63777
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F9420809
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3Q9N9sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgLAC15 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgLAC14 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 21:27:56 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49EFC0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 18:27:16 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 4so249897plk.5
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 18:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ta9y/swT35VtKhxTfZV2j6YXFZIC2RzBuLf4MvgxmWk=;
        b=n3Q9N9syDD99I9uMqSd4m6kqwfHlg75lSW91G78qkQaPPx0atgYLB6Vs0DbSN/aZI6
         vz5Dn8Bjq2PzEp8ZmNafPVuogag0nn53yzndVWqzFxCchapnWE/ne3fdTVF6xroUkKzG
         PeYIspFeDjko2NhKQoWY1JmxFay2+Exd3c/aGRT0y5IGYDF2sxI1z1xBioW7kLWfc+lL
         2fTtyCiTcr8g4SyvAX9LG+xKNSHL6sZqGQ+0lgt/MLWIbM+x6q5Fbn6rDQvnfP0axApZ
         DtcBHGIhyCDufsuba1lJedrP3xbD6/j8P/Fi1vV82OXi90S1zrmNIMEVIo/8rhDUosWk
         EaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ta9y/swT35VtKhxTfZV2j6YXFZIC2RzBuLf4MvgxmWk=;
        b=bTec9se5ITnSim+rUQG011UgWPh9bvyxYbJIs/9UYvhMTOg2XtvTAiW1oF/beiOqcV
         EUNGAqP4dC4cpR2K3GZnedHTe6MzcHNNFhswk+i52ofVCsvfIChXk76bRTnw/vohOBux
         kyNBHzc/4RK1QMcmnfm0DqFZ+36D7NsUmuspXPOKTzLza9eKlg23H4d6uPZNpkGCnHVd
         SjLeOJmBMZFMZRkEWWWcg1g81LiGtL6r0bkOWyM9+zgzmE+xpCXKGT2coctzG1hpzGIH
         ea+OOLxUGb4HrgYe1FXK9J1R8hwzXQ6sIJfvho751+AxBKjAx4/VtbFfMO4jj9cOkI3R
         v68g==
X-Gm-Message-State: AOAM531hxY9fETRS3PzaTmxKGZt95WXgN0q4gyrPWLv2L1SZ46GAeg7l
        sNC5hbFb3PFgn+42Nlh2pf2io6GcIzvaDg==
X-Google-Smtp-Source: ABdhPJy+qtSYBcbF8raBn9CjNSKugPUMhxwhxbhTHo9RabT/9zqd/PA2T2T2Mwq4sDchSmvcphYAzg==
X-Received: by 2002:a17:90b:4b0a:: with SMTP id lx10mr414148pjb.128.1606789636094;
        Mon, 30 Nov 2020 18:27:16 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id q24sm257447pjd.30.2020.11.30.18.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:27:15 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:27:11 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 18/27] mmc: sdhci-uhs2: add clock operations
Message-ID: <20201201022711.GB43403@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-19-takahiro.akashi@linaro.org>
 <14ad8c85-0dbb-b023-6a0d-7805cc6f0ab8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ad8c85-0dbb-b023-6a0d-7805cc6f0ab8@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 26, 2020 at 10:17:59AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 41 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 994dff967e85..55362ace1857 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -11,6 +11,7 @@
> >   */
> >  
> >  #include <linux/delay.h>
> > +#include <linux/ktime.h>
> >  #include <linux/module.h>
> >  
> >  #include "sdhci.h"
> > @@ -385,6 +386,42 @@ void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	__sdhci_uhs2_set_ios(mmc, ios);
> >  }
> >  
> > +static void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> > +{
> > +        struct sdhci_host *host = mmc_priv(mmc);
> > +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +	clk &= ~SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +}
> > +
> > +static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> > +{
> > +        struct sdhci_host *host = mmc_priv(mmc);
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
> 
> Can use read_poll_timeout(sdhci_readw,..., host, SDHCI_CLOCK_CONTROL)

Okay.

-Takahiro Akashi

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
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -556,6 +593,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  
> >  	if (!host->mmc_host_ops.uhs2_detect_init)
> >  		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> > +	if (!host->mmc_host_ops.uhs2_disable_clk)
> > +		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
> > +	if (!host->mmc_host_ops.uhs2_enable_clk)
> > +		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
> >  
> >  	return 0;
> >  }
> > 
> 
