Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE94DC43461
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8904F214F1
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1fDZO0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIOGtQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgIOGtK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:49:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48141C061788
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 23:49:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c3so829184plz.5
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8Y8jIfnu2JVAS1j+0KEUXwHHRIpYqRhW26zB0qzDvU=;
        b=O1fDZO0OTcPfVTyEkhiGWvaakbkTxJU0OJFtzwi70nuSM1bxWIrUPTq7zpjOn/QhnF
         xYkuFux85KyXuG+8V3yUW0kIh/CaModSD05AlDgShdaoLkOfvfJSsxA++A1Md6hvO7Hp
         4+yBWtCiJm9Lrkc3p7tDW4BiNyWrbAzj3EgZb4dl3CdNLJkgolPXFA2I/JT0JbVZviU1
         182AQxDmGBLRJu4xt1KGfb5dDHSxV7vKzFLIdhZWz4Y6sMwC1dow6rOBXoYizPMdeupQ
         74ROpxiQWU+87RcvEGrA8sprQhgfCACC91xIWHN/MSsPkRBpSsZ8msTFLxwlMzob3EhN
         KeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=s8Y8jIfnu2JVAS1j+0KEUXwHHRIpYqRhW26zB0qzDvU=;
        b=lGnjASLS1FFLb4gf24lte8jKvncNyWcl4k2IYa0rM04U1QU27vSHeZ+UpwNfaxr616
         jhE+J+4uNu9wjaaATApNBjmThM2GiMj0jg6E5mxOubZclgOu8J4s+Jl9Ewk5Y5Bkc+iF
         wPv7wSsAuxGvEIqfRu/YYSkAdf3P+Z9ZDCbESpnHjq3iEh4yo+LXuCZk1+RCF2HEjLEn
         CLkFcA1lOM16d6fPnAe76nYs5oKgq/A519d7Ht3SYm+SxZgM4SYDHXEKFYPiCEO1UAqG
         /W/Pto52T+Fx9uApmIzAGP2QtPb+NChUe99/MCWn5JJIOWNuOaGQji2mnH1bjuH9uZ6m
         pokQ==
X-Gm-Message-State: AOAM533BIkBTotaHGLFPGbPQJQBcgw87E0EOTrvXGD/xpg2X2Fch4arf
        ejNsaaMjErnr2Wm/W40O+b2J9w==
X-Google-Smtp-Source: ABdhPJwKAZXEdCnhPxhlCR79rvCV/I50ra4JqXvRqFle6q52sz/IfSaVsbgToE+24Qk/c5ywvs0QzQ==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr2748960pjq.95.1600152549827;
        Mon, 14 Sep 2020 23:49:09 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id gb19sm11059249pjb.38.2020.09.14.23.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:49:09 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:49:05 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 10/21] mmc: sdhci: UHS-II support, dump UHS-II
 registers
Message-ID: <20200915064905.GD2860208@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111034.29456-1-benchuanggli@gmail.com>
 <bd374ef8-8b8b-031b-0e59-d6f881cb9330@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd374ef8-8b8b-031b-0e59-d6f881cb9330@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 21, 2020 at 05:04:54PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:10 pm, Ben Chuang wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > Dump UHS-II specific registers, if available, in sdhci_dumpregs()
> > for informative/debugging use.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 37b1158c1c0c..c2f6923d296c 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -111,6 +111,30 @@ void sdhci_dumpregs(struct sdhci_host *host)
> >  		}
> >  	}
> >  
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT) {
> > +		SDHCI_DUMP("==================== UHS2 ==================\n");
> > +		SDHCI_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
> > +			   sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
> > +		SDHCI_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_COMMAND),
> > +			   sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
> > +		SDHCI_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
> > +			   sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
> > +		SDHCI_DUMP("Dev Int Code:  0x%08x\n",
> > +			   sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
> > +		SDHCI_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
> > +			   sdhci_readw(host, SDHCI_UHS2_SW_RESET),
> > +			   sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
> > +		SDHCI_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
> > +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
> > +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
> > +		SDHCI_DUMP("ErrSigEn:  0x%08x\n",
> > +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
> > +	}
> > +
> 
> Let's make this a host op instead ie.
> 
> 	if (host->ops->dump_uhs2_regs)
> 		host->ops->dump_uhs2_regs(host);

Sure.

-Takahiro Akashi

> >  	if (host->ops->dump_vendor_regs)
> >  		host->ops->dump_vendor_regs(host);
> >  
> > 
> 
