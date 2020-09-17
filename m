Return-Path: <SRS0=rnDB=C2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA98C433E2
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 05:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B222078D
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Sep 2020 05:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXzS5r2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIQFNC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Sep 2020 01:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgIQFNA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2020 01:13:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20130C061756
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 22:12:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d13so662124pgl.6
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=qXMpYhecBeuqzUAGr3eBH/btIMT72oL1vXttuRwPdRY=;
        b=DXzS5r2SFx2p77SvZs2InZJEGQXoE1vqORBwq2kF+4I7EwKAd4j3PBJtq54LAWbPf1
         yxQxJ8h3MppjKq7XlcRLy0J1krhqIBvDj/2ZqN3VGafiBPI3+WeZQTM/QT3ig8J7s+XU
         NG4SIzEi5bSlYgrIkSJZkEB0UIkOuSevuGNzNu2ZOebE7AoXlLmBzIs+vl+lwuR8TUUC
         o1LZpHnHu6mnH4owGH4PpOD2aJu0vxsJ/fu/hA8wWOvUW8Pi5ar1zEVITVI327r9Svwb
         a9wOOUh+fTNCMFJz0U6EY/ol5JbOo2n6ZqtCuZt/PB/yR1RMjcW/axgXuWNTDlWYbLwa
         ho0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qXMpYhecBeuqzUAGr3eBH/btIMT72oL1vXttuRwPdRY=;
        b=Z+YChQcuuI5sdLiKWDQMvzNXsXjqWbxPh/ds88J6yLaPF7LAlzCNwXIPx1nQfD2LJl
         NJAqcdbcshHLGG/8R8y5QaZEnZSri+CcYs7uxMjKmuoMBAN8eDxsdvL7SpVxrlC7USgs
         o6VhdNMtocp7xVFOWkvhiXBBJPmTgUNHDOdaxjSh2eep4PrFOhuZlJrYWcIJrAGwfEPi
         rJUUOX51hW6gjqyPqKhvS4u6sH7ed33aq7lJXQsbNDCg2R2Nnd9ihKtm5LemZbn0Oj+L
         9lanVRx6JlO8qYpwY9iBQeXCh4cjLm+cH0UktBoPz3lN8jrzjDjqthVF/RJKgLJmnETU
         dSxA==
X-Gm-Message-State: AOAM5309YIFWBMafGun5wBiUSGuZMKvwvvGIb9QQ8C/3KBIUvtUAdsrD
        ZKhKQbOADAXCbloOgKlDlgz3gyx9YhmrNKgu
X-Google-Smtp-Source: ABdhPJyBF9JQoD+adDRDl69cLFop7DNj+CsII5Ioo20OPT+VjA1wn9rq2QZZoqj22m1CiXvs7hkadw==
X-Received: by 2002:a63:4102:: with SMTP id o2mr21108868pga.354.1600319578460;
        Wed, 16 Sep 2020 22:12:58 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id q198sm15866801pfq.185.2020.09.16.22.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 22:12:57 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:12:53 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
Message-ID: <20200917051253.GA3094018@laputa>
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
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian, Ben,

Regarding _reset() function,

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
> >  drivers/mmc/host/sdhci.c | 152 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 136 insertions(+), 16 deletions(-)
> > 

  (snip)

> >  	if (host->ops->platform_send_init_74_clocks)
> >  		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> >  
> > @@ -2331,7 +2411,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	}
> >  
> >  	if (host->version >= SDHCI_SPEC_300) {
> > -		u16 clk, ctrl_2;
> > +		u16 clk;
> >  
> >  		if (!host->preset_enabled) {
> >  			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > @@ -3173,11 +3253,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >  			/* This is to force an update */
> >  			host->ops->set_clock(host, host->clock);
> >  
> > -		/* Spec says we should do both at the same time, but Ricoh
> > -		   controllers do not like that. */
> > -		sdhci_do_reset(host, SDHCI_RESET_CMD);
> > -		sdhci_do_reset(host, SDHCI_RESET_DATA);
> > -
> > +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +		    host->mmc->flags & MMC_UHS2_INITIALIZED) {
> > +			if (sdhci_uhs2_ops.reset)
> > +				sdhci_uhs2_ops.reset(host,
> > +						     SDHCI_UHS2_SW_RESET_SD);
> > +		} else {
> > +			/*
> > +			 * Spec says we should do both at the same time, but
> > +			 * Ricoh controllers do not like that.
> > +			 */
> > +			sdhci_do_reset(host, SDHCI_RESET_CMD);
> > +			sdhci_do_reset(host, SDHCI_RESET_DATA);
> > +		}
> 
> Please look at using the existing ->reset() sdhci host op instead.

Well, the second argument to those reset functions is a bit-wise value
to different "reset" registers, SDHCI_SOFTWARE_RESET and SDHCI_UHS2_SW_RESET,
respectively.

This fact raises a couple of questions to me:

1) Does it make sense to merge two functionality into one, i.e.
   sdhci_do_reset(), which is set to call ->reset hook?

        -> Adrian

2) UHS2_SW_RESET_SD is done only at this place while there are many callsites
   of reset(RESET_CMD|RESET_DATA) in sdhci.c.
   Why does the current code work?

   I found, in sdhci-pci-gli.c,
   sdhci_gl9755_reset()
        /* reset sd-tran on UHS2 mode if need to reset cmd/data */
        if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
                gl9755_uhs2_reset_sd_tran(host);

   Is this the trick to avoid the issue?
   (It looks redundant in terms of the hack above in sdhci_request_done()
   and even quite dirty to me. Moreover, no corresponding code for gl9750
   and gl9763.)

        -> Ben

3) (More or less SD specification issue)
   In UHS-II mode, do we have to call reset(SHCI_RESET_ALL) along with
   reset(UHS2_SW_RESET_FULL)?
   Under the current implementation, both will be called at the end.

        -> Adrian, Ben

4) (Not directly linked to UHS-II support)
  In some places, we see the sequence:
        sdhci_do_reset(host, SDHCI_RESET_CMD);
        sdhci_do_reset(host, SDHCI_RESET_DATA);
  while in other places,
        sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);

  If the statement below is true,
> > -		/* Spec says we should do both at the same time, but Ricoh
> > -		   controllers do not like that. */
  the latter should be wrong.

        -> Adrian

-Takahiro Akashi



> >  		host->pending_reset = false;
> >  	}
> >  
> > @@ -3532,6 +3620,13 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> >  				  SDHCI_INT_BUS_POWER);
> >  		sdhci_writel(host, mask, SDHCI_INT_STATUS);
> >  
> > +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +		    intmask & SDHCI_INT_ERROR &&
> > +		    host->mmc->flags & MMC_UHS2_SUPPORT) {
> > +			if (sdhci_uhs2_ops.irq)
> > +				sdhci_uhs2_ops.irq(host);
> > +		}
> > +
> 
> Please look at using the existing ->irq() sdhci host op instead
> 
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
> 
> >  	if (!dead)
> >  		sdhci_do_reset(host, SDHCI_RESET_ALL);
> >  
> > 
> 
