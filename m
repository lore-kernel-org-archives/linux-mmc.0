Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F832C64E90
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B9A20809
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3gitewa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgLACZx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgLACZw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 21:25:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F39C0613D2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 18:25:06 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b63so90608pfg.12
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 18:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXJAOizCIn9REKbBh3tFFbJLwvJ9trLZ9NBPaeCE0+8=;
        b=C3gitewaAFOV3DbhWxaiYhMUQsWls4w3SvlXVnYmm+Ce6raQnyeEAHgUHVBzDatHae
         bqRxdSVpfnvmRLPAScObzRcjRcRbodOZWpful2rK2h8sbygwfHoFIhIj3XXnFkoWd7+T
         hxarP22SSTK/0V1nViiSlOCV1cJKAcr/Ry3970DXNwuTyasBAWI4JLcznOxSSvX9NGR2
         z3JcKZ86qXFcHepR7nUHA3d0yrho8pVdjZh8uPnjznzf699Wgb4W6SdwAxfD0qn1hzxP
         KYKZaves09WjEQmOo919diVy+zINA8ICtpOiJfkyDM15b6WME4x4pvzY5xNfZJoqRE60
         NMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zXJAOizCIn9REKbBh3tFFbJLwvJ9trLZ9NBPaeCE0+8=;
        b=EZZ95xMbpnb6kDHeogReftedCYHxPvRyPLvCQWbQUL6qtjzYNIW2fQAFLIm4UkHEzv
         JyCXFk53czJlha6VDqKt+KzSvurQv7gPkKTLifVGCKZhBHBxNZvqJ2a3rGRoUJAkpB9Q
         q7FRPpUwSoV4Q7YQKUVemAXahxGryUKI6Z2p4ibEQ77IV5RnDHcbri7f/pNh9reDmuCM
         Zn9h0C+RRBWLmjVnIdJi3cfvd+m6bbag4Thad03L6NrO3ch30B5bLQsOz8nAV1iHCw7z
         N6Gswf0jD3uvWSPfeH/OYo3NI3Q7XmXqVvbOGWCJzeyYfBPGtY26Okv9FFWfTnHW+KGY
         tWFg==
X-Gm-Message-State: AOAM531qV+ghKWQdLtH6LWVi/HlapdWeA494KaDUzqEqNr+qIb7+ZrmH
        2dXME8SSPG/aFsom17o8R9y0Kg==
X-Google-Smtp-Source: ABdhPJzsIeIl706sl5FYqmGUjP/aZX7colhVmvpTYmaMelqoPdo7QO5MP54qsMbiA/cob/+8CmfPew==
X-Received: by 2002:aa7:8506:0:b029:197:f2d2:ac24 with SMTP id v6-20020aa785060000b0290197f2d2ac24mr590527pfn.47.1606789506156;
        Mon, 30 Nov 2020 18:25:06 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id m18sm244962pjl.41.2020.11.30.18.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:25:05 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:25:01 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 17/27] mmc: sdhci-uhs2: add detect_init() to
 detect the interface
Message-ID: <20201201022501.GA43403@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-18-takahiro.akashi@linaro.org>
 <38b7390f-7845-292b-77e1-33b610196cfd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b7390f-7845-292b-77e1-33b610196cfd@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 26, 2020 at 10:17:38AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
> > operation. After detected, the host's UHS-II capabilities will be set up
> > here and interrupts will also be enabled.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 160 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 160 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 637464748cc4..994dff967e85 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -391,12 +391,172 @@ void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >   *                                                                           *
> >  \*****************************************************************************/
> >  
> > +static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
> > +{
> > +	int timeout = 100;
> 
> Please comment on where timeouts / delays come from. e.g. as per spec

It does exist in the original code, but I will try to find the source
of information.

> > +
> > +	udelay(200); /* wait for 200us before check */
> > +
> > +	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> > +		SDHCI_UHS2_IF_DETECT)) {
> 
> 
> Can be read_poll_timeout(sdhci_readl,...,host, SDHCI_PRESENT_STATE)

Okay.

> > +		if (timeout == 0) {
> > +			pr_warn("%s: not detect UHS2 interface in 200us.\n",
> > +				mmc_hostname(host->mmc));
> > +			sdhci_dumpregs(host);
> > +			return -EIO;
> > +		}
> > +		timeout--;
> > +		mdelay(1);
> > +	}
> > +
> > +	/* Enable UHS2 error interrupts */
> > +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> > +				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
> > +
> > +	timeout = 150;
> > +	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> > +		SDHCI_UHS2_LANE_SYNC)) {
> 
> Ditto

Okay.

-Takahiro Akashi

> 
> > +		if (timeout == 0) {
> > +			pr_warn("%s: UHS2 Lane sync fail in 150ms.\n",
> > +				mmc_hostname(host->mmc));
> > +			sdhci_dumpregs(host);
> > +			return -EIO;
> > +		}
> > +		timeout--;
> > +		mdelay(1);
> > +	}
> > +
> > +	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
> > +	    mmc_hostname(host->mmc));
> > +	return 0;
> > +}
> > +
> > +static int sdhci_uhs2_init(struct sdhci_host *host)
> > +{
> > +	u16 caps_ptr = 0;
> > +	u32 caps_gen = 0;
> > +	u32 caps_phy = 0;
> > +	u32 caps_tran[2] = {0, 0};
> > +	struct mmc_host *mmc = host->mmc;
> > +
> > +	/*
> > +	 * TODO: may add corresponding members in sdhci_host to
> > +	 * keep these caps.
> > +	 */
> > +	caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
> > +	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> > +		pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
> > +		       mmc_hostname(mmc), caps_ptr);
> > +		return -ENODEV;
> > +	}
> > +	caps_gen = sdhci_readl(host,
> > +			       caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);
> > +	caps_phy = sdhci_readl(host,
> > +			       caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
> > +	caps_tran[0] = sdhci_readl(host,
> > +				   caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
> > +	caps_tran[1] = sdhci_readl(host,
> > +				   caps_ptr
> > +					+ SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
> > +
> > +	/* General Caps */
> > +	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
> > +	mmc->uhs2_caps.gap = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK) >>
> > +			     SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT;
> > +	mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
> > +			>> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
> > +	mmc->uhs2_caps.addr64 =
> > +		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
> > +	mmc->uhs2_caps.card_type =
> > +		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
> > +		SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
> > +
> > +	/* PHY Caps */
> > +	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
> > +	mmc->uhs2_caps.speed_range =
> > +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
> > +		>> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
> > +	mmc->uhs2_caps.n_lss_sync =
> > +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
> > +		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
> > +	mmc->uhs2_caps.n_lss_dir =
> > +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
> > +		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
> > +	if (mmc->uhs2_caps.n_lss_sync == 0)
> > +		mmc->uhs2_caps.n_lss_sync = 16 << 2;
> > +	else
> > +		mmc->uhs2_caps.n_lss_sync <<= 2;
> > +	if (mmc->uhs2_caps.n_lss_dir == 0)
> > +		mmc->uhs2_caps.n_lss_dir = 16 << 3;
> > +	else
> > +		mmc->uhs2_caps.n_lss_dir <<= 3;
> > +
> > +	/* LINK/TRAN Caps */
> > +	mmc->uhs2_caps.link_rev =
> > +		caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
> > +	mmc->uhs2_caps.n_fcu =
> > +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
> > +		>> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
> > +	if (mmc->uhs2_caps.n_fcu == 0)
> > +		mmc->uhs2_caps.n_fcu = 256;
> > +	mmc->uhs2_caps.host_type =
> > +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
> > +		>> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
> > +	mmc->uhs2_caps.maxblk_len =
> > +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
> > +		>> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
> > +	mmc->uhs2_caps.n_data_gap =
> > +		caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> > +{
> > +        struct sdhci_host *host = mmc_priv(mmc);
> > +	unsigned long flags;
> > +	int ret = -EIO;
> > +
> > +	DBG("%s: begin UHS2 init.\n", __func__);
> > +	spin_lock_irqsave(&host->lock, flags);
> > +
> > +	if (sdhci_uhs2_interface_detect(host)) {
> > +		pr_warn("%s: cannot detect UHS2 interface.\n",
> > +			mmc_hostname(host->mmc));
> > +		goto out;
> > +	}
> > +
> > +	if (sdhci_uhs2_init(host)) {
> > +		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
> > +		goto out;
> > +	}
> > +
> > +	/* Init complete, do soft reset and enable UHS2 error irqs. */
> > +	sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> > +				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
> > +	/*
> > +	 * !!! SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
> > +	 * by SDHCI_UHS2_SW_RESET_SD
> > +	 */
> > +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +
> > +	ret = 0;
> > +out:
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +	return ret;
> > +}
> > +
> >  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> >  	host->mmc_host_ops.start_signal_voltage_switch =
> >  		sdhci_uhs2_start_signal_voltage_switch;
> >  	host->mmc_host_ops.set_ios = sdhci_uhs2_set_ios;
> >  
> > +	if (!host->mmc_host_ops.uhs2_detect_init)
> > +		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> > +
> >  	return 0;
> >  }
> >  
> > 
> 
