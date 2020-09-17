Return-Path: <SRS0=rnDB=C2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8455C43461
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 05:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EC320872
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 05:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9VN5VlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIQFQk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Sep 2020 01:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQFQi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2020 01:16:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C0EC061756
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 22:16:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y1so660882pgk.8
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9XtLHYVfm+BR9OEJ4f29pIKtgyhVRfQbh1PSyFLI3vA=;
        b=I9VN5VlYuRIPT/7Ruux2nCuo4TmsRtOPHlYQTDi2ovbDj3kQ+P5lc+aGIJ8TC7PL+L
         3z4i399IHJWHRUPuCBUTzyHo+P5stkGymiMgB30y6PFkPoNNijOlb1GDfG51jfeWtEow
         iK4kluMiAycen1zBJ28BGdGncBMAM9m9gGKk0/prJnQ842p/StLRDanPJUwq6PbkzUiC
         Hif1Luc9/srxP00ljK+cfGL8FtkxsqYc5iA6mSvsEk9yFKOrMSwQn2j+c0awQSdO01No
         Jh+FLvsVdASpd2r3/QW6rVpmOsXXUFpd+tzRbtnGUP6XMriTw9boNsMU9zeL+/x3NUDH
         YjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9XtLHYVfm+BR9OEJ4f29pIKtgyhVRfQbh1PSyFLI3vA=;
        b=Y9TYJiiUR/c3ym/suy0Z1LHYyE38EZ9PnB2ZqK5uMrWeXLaZTj0JTKh1WxTZQsjn1a
         tK6/e85r894nkZoTRd05LKaiG6LoHCrjHlyy9rdksuFBzR9MYUOA91La6V73EkfOoulf
         0zSKvg5dTDp635LOBlLlboAchs86XDa6atvpkoo2D0R4GNeGAHGC5CCqe5k4PzfsNsAz
         jsDITJIbcnIZkzNyVotj3NjxTdduI4cewnqVhBCdoSczinwwxbpdOcsGhso67L3zd9wm
         RL2YcfuJ/anAmvN4ezZNZEb0Pb7/isjjo13neT/REVq/jfpkWTxvIyLy7IOdh80gnmF0
         TCBA==
X-Gm-Message-State: AOAM530bWv+Jq78USEKn5p9eMNaypakJ2NNXoumHzl9MauD2h4MdWKCH
        jFUR1kfUUk1s+vKTZF52IsCzPA==
X-Google-Smtp-Source: ABdhPJyWeKpsNo04BwT9GyrSz9bi95i7kaOExulgDBaktfJRO+b0s1dg4qc4VfTMOVlk9dpBkd4/Vg==
X-Received: by 2002:a63:3645:: with SMTP id d66mr1853058pga.167.1600319797345;
        Wed, 16 Sep 2020 22:16:37 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id kf10sm4352858pjb.2.2020.09.16.22.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 22:16:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:16:32 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
Message-ID: <20200917051632.GB3094018@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
 <20200916080558.GA2978867@laputa>
 <6bf86b26-391a-0699-1818-d070357b9ddc@intel.com>
 <20200917023113.GB3071249@laputa>
 <255e030e-98e3-713a-a8fe-9f4c470c630f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255e030e-98e3-713a-a8fe-9f4c470c630f@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 17, 2020 at 07:52:03AM +0300, Adrian Hunter wrote:
> On 17/09/20 5:31 am, AKASHI Takahiro wrote:
> > Adrian,
> > 
> > On Wed, Sep 16, 2020 at 01:00:35PM +0300, Adrian Hunter wrote:
> >> On 16/09/20 11:05 am, AKASHI Takahiro wrote:
> >>> Adrian,
> >>>
> >>> Your comments are scattered over various functions, and so
> >>> I would like to address them in separate replies.
> >>>
> >>> First, I'd like to discuss sdhci_[add|remove]_host().
> >>>
> >>> On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
> >>>> On 10/07/20 2:10 pm, Ben Chuang wrote:
> >>>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>>
> >>>>> In this commit, UHS-II related operations will be called via a function
> >>>>> pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> >>>>> a kernel module.
> >>>>> This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> >>>>> and when the UHS-II module is loaded. Otherwise, all the functions
> >>>>> stay void.
> >>>>>
> >>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>> ---
> >>>
> >>>  (snip)
> >>>
> >>>>>  		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> >>>>>  			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> >>>>>  				      SDHCI_CARD_PRESENT;
> >>>>> @@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
> >>>>>  		/* This may alter mmc->*_blk_* parameters */
> >>>>>  		sdhci_allocate_bounce_buffer(host);
> >>>>>  
> >>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> >>>>> +	    host->version >= SDHCI_SPEC_400 &&
> >>>>> +	    sdhci_uhs2_ops.add_host) {
> >>>>> +		ret = sdhci_uhs2_ops.add_host(host, host->caps1);
> >>>>> +		if (ret)
> >>>>> +			goto unreg;
> >>>>> +	}
> >>>>> +
> >>>>
> >>>> I think you should look at creating uhs2_add_host() instead
> >>>>
> >>>>>  	return 0;
> >>>>>  
> >>>>>  unreg:
> >>>>> @@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
> >>>>>  {
> >>>>>  	struct mmc_host *mmc = host->mmc;
> >>>>>  
> >>>>> +	/* FIXME: Do we have to do some cleanup for UHS2 here? */
> >>>>> +
> >>>>>  	if (!IS_ERR(mmc->supply.vqmmc))
> >>>>>  		regulator_disable(mmc->supply.vqmmc);
> >>>>>  
> >>>>> @@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
> >>>>>  		mmc->cqe_ops = NULL;
> >>>>>  	}
> >>>>>  
> >>>>> +	if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
> >>>>> +		/* host doesn't want to enable UHS2 support */
> >>>>> +		mmc->caps &= ~MMC_CAP_UHS2;
> >>>>> +		mmc->flags &= ~MMC_UHS2_SUPPORT;
> >>>>> +
> >>>>> +		/* FIXME: Do we have to do some cleanup here? */
> >>>>> +	}
> >>>>> +
> >>>>>  	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
> >>>>>  	if (!host->complete_wq)
> >>>>>  		return -ENOMEM;
> >>>>> @@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
> >>>>>  unled:
> >>>>>  	sdhci_led_unregister(host);
> >>>>>  unirq:
> >>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> >>>>> +	    sdhci_uhs2_ops.remove_host)
> >>>>> +		sdhci_uhs2_ops.remove_host(host, 0);
> >>>>>  	sdhci_do_reset(host, SDHCI_RESET_ALL);
> >>>>>  	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> >>>>>  	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> >>>>> @@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> >>>>>  
> >>>>>  	sdhci_led_unregister(host);
> >>>>>  
> >>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> >>>>> +	    sdhci_uhs2_ops.remove_host)
> >>>>> +		sdhci_uhs2_ops.remove_host(host, dead);
> >>>>> +
> >>>>
> >>>> I think you should look at creating uhs2_remove_host() instead
> >>>
> >>> You suggest that we will have separate sdhci_uhs2_[add|remove]_host(),
> >>> but I don't think it's always convenient.
> >>>
> >>> UHS-II capable host will be set to call sdhci_uhs2_add_host() explicitly,
> >>> but we can't do that in case of pci and pltfm based drivers as they utilize
> >>> common helper functions, sdhci_pci_probe() and sdhci_pltfm_register(),
> >>> respectively.
> >>
> >> sdhci-pci has an add_host op
> >>
> >> sdhci_pltfm_init can be used instead of sdhci_pltfm_register
> >>
> >>
> >>> Therefore, we inevitably have to call sdhci_uhs2_add_host() there.
> >>>
> >>> If so, why should we distinguish sdhci_uhs2_add_host from sdhci_uhs_add_host?
> >>> I don't see any good reason.
> >>> Moreover, as a result, there exists a mixed usage of sdhci_ interfaces
> >>> and sdhci_uhs2_ interfaces in sdhci-pci-core.c and sdhci-pltfm.c.
> >>>
> >>> It sounds odd to me.
> >>
> >> It is already done that way for cqhci.
> > 
> > Okay, if it is your policy, I will follow that.
> > Then, I'm going to add
> > - remove_host field to struct sdhci_pci_fixes
> > - a controller specific helper function to each driver (only pci-gli for now)
> >   even though it looks quite generic.
> 
> If they seem generic then consider naming them
> sdhci_pci_uhs2_[add|remove]_host and putting them in sdhci-pci-core.c

So you don't mind that UHS-I and UHS-II code are mixed in sdhci-pci-core.c,
do you?

-Takahiro Akashi

> > 
> >   sdhci_gli_[add|remove]_host(struct sdhci_pci_slot *slot)
> >   {
> >       return sdhci_uhs2_[add|remove]_host(slot->host);
> >   }
> > 
> > # Or do you want to create a file like sdhci-uhs2-pci.c for those functions?
> 
> No
> 
> > 
> > -Takahiro Akashi
> > 
> >>>
> >>> -Takahiro Akashi
> >>>
> >>>
> >>>>
> >>>>>  	if (!dead)
> >>>>>  		sdhci_do_reset(host, SDHCI_RESET_ALL);
> >>>>>  
> >>>>>
> >>>>
> >>
> 
