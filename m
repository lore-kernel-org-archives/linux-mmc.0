Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BBC43461
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842C82087D
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 08:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPTptsUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgIPIGH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIPIGE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 04:06:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887BC061788
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 01:06:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f1so2768218plo.13
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fi/Zb4ASsQ4HPm5PG4mw/XDLk977mbPHCLVZgMYV2fA=;
        b=EPTptsUb6QNgC+Dl6kF2Qx4AO4gHIlEzO88zINkgseZk8iqY3BLuMT2uKcFAwtm+g0
         Ml6hGPHwJRSLrgxYPNyzRPoYMgzPhYS8jmHhWeH/SAihUnGsCyV9UF3/5g4g022U3hJ5
         Mxp3izxSWluBtUz9EjkHaTwTRC7ZnKw59Ahz7nN6C2j6A/z8tPUbtWNnna3Ubts3VtVA
         Qc16LASJtt5b2KQzLDi+C1M9Vw35x2kL7Ga9gmyySvUynlWXaDZF9WWo6W6jXj+JcPBZ
         H9w1Y7rx63ln/YxYfSkHkECxk42LEzcq5FgLeBpCL28kPHMXK9LcsEWbQpTLxw9zei9y
         b2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Fi/Zb4ASsQ4HPm5PG4mw/XDLk977mbPHCLVZgMYV2fA=;
        b=OVBcIJ7gbdmS78GJ2QOwM6aLb6Laa956EENTyatYgT4LLRwRDM+zqMrHIsZ6ndFx9R
         msyTrJBfTPCzRtoTITBT9AijYbQGbyYGgDa8XNR0T8R7IFtuziPZ/KOsPl4lgK2ryE24
         8qMrg9Hnt+Hn87GZHKUyAtmbLENitihcwXvPgNwTmua7s/ieBDBhafvyH2ZomZfqXSDa
         keEoxprdjAoai4tXd9bWronkgryMeOUcQbyMVdPeUQFoJ7hjEQcAO6K8bSvb9ci7bzGB
         BWCWTmkGPoXCX+AxbmIAuo5NrYhFj4u/IbfDFX0VzuEgB4EdIuIo55eqgCCraLaJ42BT
         t9MA==
X-Gm-Message-State: AOAM5322gKj+zjztsNheoPf7mt98KDfFL7FZAyjgNU7wkqUyOTOWcjgk
        0zc6KdS42i3C/t+jTuIll3DwdQ==
X-Google-Smtp-Source: ABdhPJzsP763NSSrjSXgw1uBCV6aabWeEcFbkzoPZJGP13irdmUDbte81s6uBBRgzKIYWudjPWCZ/w==
X-Received: by 2002:a17:90a:ae12:: with SMTP id t18mr3000310pjq.147.1600243563186;
        Wed, 16 Sep 2020 01:06:03 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id y6sm1803111pji.1.2020.09.16.01.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 01:06:02 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:05:58 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
Message-ID: <20200916080558.GA2978867@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian,

Your comments are scattered over various functions, and so
I would like to address them in separate replies.

First, I'd like to discuss sdhci_[add|remove]_host().

On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:10 pm, Ben Chuang wrote:
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > 
> > In this commit, UHS-II related operations will be called via a function
> > pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> > a kernel module.
> > This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> > and when the UHS-II module is loaded. Otherwise, all the functions
> > stay void.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---

 (snip)

> >  		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> >  			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> >  				      SDHCI_CARD_PRESENT;
> > @@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
> >  		/* This may alter mmc->*_blk_* parameters */
> >  		sdhci_allocate_bounce_buffer(host);
> >  
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    host->version >= SDHCI_SPEC_400 &&
> > +	    sdhci_uhs2_ops.add_host) {
> > +		ret = sdhci_uhs2_ops.add_host(host, host->caps1);
> > +		if (ret)
> > +			goto unreg;
> > +	}
> > +
> 
> I think you should look at creating uhs2_add_host() instead
> 
> >  	return 0;
> >  
> >  unreg:
> > @@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
> >  {
> >  	struct mmc_host *mmc = host->mmc;
> >  
> > +	/* FIXME: Do we have to do some cleanup for UHS2 here? */
> > +
> >  	if (!IS_ERR(mmc->supply.vqmmc))
> >  		regulator_disable(mmc->supply.vqmmc);
> >  
> > @@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
> >  		mmc->cqe_ops = NULL;
> >  	}
> >  
> > +	if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
> > +		/* host doesn't want to enable UHS2 support */
> > +		mmc->caps &= ~MMC_CAP_UHS2;
> > +		mmc->flags &= ~MMC_UHS2_SUPPORT;
> > +
> > +		/* FIXME: Do we have to do some cleanup here? */
> > +	}
> > +
> >  	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
> >  	if (!host->complete_wq)
> >  		return -ENOMEM;
> > @@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
> >  unled:
> >  	sdhci_led_unregister(host);
> >  unirq:
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    sdhci_uhs2_ops.remove_host)
> > +		sdhci_uhs2_ops.remove_host(host, 0);
> >  	sdhci_do_reset(host, SDHCI_RESET_ALL);
> >  	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> >  	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> > @@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> >  
> >  	sdhci_led_unregister(host);
> >  
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    sdhci_uhs2_ops.remove_host)
> > +		sdhci_uhs2_ops.remove_host(host, dead);
> > +
> 
> I think you should look at creating uhs2_remove_host() instead

You suggest that we will have separate sdhci_uhs2_[add|remove]_host(),
but I don't think it's always convenient.

UHS-II capable host will be set to call sdhci_uhs2_add_host() explicitly,
but we can't do that in case of pci and pltfm based drivers as they utilize
common helper functions, sdhci_pci_probe() and sdhci_pltfm_register(),
respectively.
Therefore, we inevitably have to call sdhci_uhs2_add_host() there.

If so, why should we distinguish sdhci_uhs2_add_host from sdhci_uhs_add_host?
I don't see any good reason.
Moreover, as a result, there exists a mixed usage of sdhci_ interfaces
and sdhci_uhs2_ interfaces in sdhci-pci-core.c and sdhci-pltfm.c.

It sounds odd to me.

-Takahiro Akashi


> 
> >  	if (!dead)
> >  		sdhci_do_reset(host, SDHCI_RESET_ALL);
> >  
> > 
> 
