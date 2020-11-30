Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C2C8300F
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 06:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FE42087D
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 06:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpT798Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgK3GVB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 01:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgK3GVB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 01:21:01 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D853C0617A6
        for <linux-mmc@vger.kernel.org>; Sun, 29 Nov 2020 22:20:21 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so5934018plo.0
        for <linux-mmc@vger.kernel.org>; Sun, 29 Nov 2020 22:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NcaMm2Jn2fgAt5evZPMqqoeBJsul0xEcKF+ID9hTdMc=;
        b=MpT798Rt5T8G+N4KmlXbuOX7O4fAX68ESJoYRmo/x0cwVq2n5iUt8PvihpduE2CA0J
         tWjJjo7X713RPAmTr4FS73sYTtjCOvBdXDR4jIDx98Qqb9WUq+ifloDJs1dWfjhEud24
         MnT+m/ks+yTPWCStCPtCAzkkEDyJCNhQHWVrKc3xcBDoZbJ0QSkMRPkBYFk3oBK+W1xx
         qZB1hvEhayxEmpPLup8ktIKpFTkAIhU4P/p1JYS+jI2DjlumJKyqSBKbcGCTZ8R5A1UG
         LyR2JSDdhkYXPZtWyUV8LPb2Js9TvVGU4c6vsm4S3XBUOdKTUi2C4CQGvr+XrJAHjJnU
         bJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NcaMm2Jn2fgAt5evZPMqqoeBJsul0xEcKF+ID9hTdMc=;
        b=aiE1hf2q+L+Ye65N41F+umDfaL/EkEqIWKmniJvPr0p4Ke500YPJfCJJtCkyJSFI6z
         TUH0OB2ZsZ+UocHxU1meBVQlKRmZOHAmkgwIONOeT/F39EEPhaNkfrxw5U7d4F3t0hhE
         kYncIxQ/WqgSg1c/WUH9585J2kmW9/U5iUIDEuKIKE6aQBsvpfHxGllJ2+YKz9qM2G9l
         WGX+k919u47sR4JOw7g2zT68TfYvFAwcCXitrerPYIoVmPa9n+4ocBq5Dv/9fq7jnMbD
         QeGy2CLe7QbeomHKw+d9LoIhyrmORp95k7q4T+3I1Vpw2SXg3kH9Qr63Ik3+KCOEZ9Jt
         KA1Q==
X-Gm-Message-State: AOAM531mLb3eJ+lMlign83NRqobTMrjQsqFG0F4Rf86zroNBFKcM2eC7
        AhqKaI5nxujb/H5ygkLdNNPFKA==
X-Google-Smtp-Source: ABdhPJw6ijU+1apoukiM5kSJUf8psRalBTLYhOgfeDpbPJAn9JojVzlRXWTugPrqpwli6qlFTnc5IA==
X-Received: by 2002:a17:90b:1c10:: with SMTP id oc16mr24355592pjb.144.1606717220786;
        Sun, 29 Nov 2020 22:20:20 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id b10sm20797632pju.27.2020.11.29.22.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 22:20:20 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:20:16 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 12/27] mmc: sdhci-uhs2: add reset function
Message-ID: <20201130062016.GC48535@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-13-takahiro.akashi@linaro.org>
 <ed1e3497-4deb-49ad-22b0-ed74fb0ef7ec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1e3497-4deb-49ad-22b0-ed74fb0ef7ec@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 26, 2020 at 10:16:11AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 49 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  drivers/mmc/host/sdhci.c      |  3 ++-
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  4 files changed, 53 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 08905ed081fb..e2b9743fe17d 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -10,6 +10,7 @@
> >   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >   */
> >  
> > +#include <linux/delay.h>
> >  #include <linux/module.h>
> >  
> >  #include "sdhci.h"
> > @@ -49,6 +50,54 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >  
> > +/*****************************************************************************\
> > + *                                                                           *
> > + * Low level functions                                                       *
> > + *                                                                           *
> > +\*****************************************************************************/
> > +
> > +/**
> > + * sdhci_uhs2_reset - invoke SW reset
> > + * @host: SDHCI host
> > + * @mask: Control mask
> > + *
> > + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> > + */
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> > +{
> > +	unsigned long timeout;
> > +
> > +	if (!(host->mmc->caps & MMC_CAP_UHS2))
> 
> Please make a helper so this can be like:
> 
> 	if (!sdhci_uhs2_mode(host))
> 
> The capability will be always present for hosts that support UHS2, but not
> all cards support UHS2 mode.  I suggest just adding a bool to struct
> sdhci_host to keep track of when the host is in UHS2 mode.

Given the fact that UHS-2 host may (potentially) support a topology like
a ring, this kind of status should be attributed to a card (structure)
rather than a host.

I'm asking Ben to modify the way how the current mode be managed
in both 'core' side and 'host' side.
That is why I marked "TODO" in many places to check the mode.

So I'd defer the change until his rework be done.


> > +		return;
> > +
> > +	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> > +
> > +	if (mask & SDHCI_UHS2_SW_RESET_FULL) {
> > +		host->clock = 0;
> > +		/* Reset-all turns off SD Bus Power */
> > +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> 
> I would prefer not to support any legacy quirks that we do not need right
> now.  Just be sure to add a comment somewhere listing which quirks are not
> supported for UHS2 host controllers.

No strong opinion. I'd defer to you.

> > +			sdhci_runtime_pm_bus_off(host);
> > +	}
> > +
> > +	/* Wait max 100 ms */
> > +	timeout = 10000;
> > +
> > +	/* hw clears the bit when it's done */
> > +	while (sdhci_readw(host, SDHCI_UHS2_SW_RESET) & mask) {
> 
> This kind of loop can now be done with read_poll_timeout_atomic(sdhci_readw,
> ..., host, SDHCI_UHS2_SW_RESET)

Okay.

-Takahiro Akashi

> > +		if (timeout == 0) {
> > +			pr_err("%s: %s: Reset 0x%x never completed.\n",
> > +			       __func__, mmc_hostname(host->mmc), (int)mask);
> > +			pr_err("%s: clean reset bit\n",
> > +			       mmc_hostname(host->mmc));
> > +			sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> > +			return;
> > +		}
> > +		timeout--;
> > +		udelay(10);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index b9529d32b58d..7bb7a0d67109 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -210,5 +210,6 @@
> >  struct sdhci_host;
> >  
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index d4a57e8c9bb8..af336bdb4305 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -195,13 +195,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> >  	pm_runtime_get_noresume(host->mmc->parent);
> >  }
> >  
> > -static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> > +void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> >  {
> >  	if (!host->bus_on)
> >  		return;
> >  	host->bus_on = false;
> >  	pm_runtime_put_noidle(host->mmc->parent);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
> >  
> >  void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index d9d7a76cedc1..b9932423db08 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -831,6 +831,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
> >  	__sdhci_read_caps(host, NULL, NULL, NULL);
> >  }
> >  
> > +void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
> >  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  		   unsigned int *actual_clock);
> >  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> > 
> 
