Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B367C4363D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 09:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFA8208B8
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 09:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmFXZvSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIXJfq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIXJfo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 05:35:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4C2C0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 02:35:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so1366828plt.9
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=klloSdQCjQ4qA/DLBUzVlJByLToqRxqXBowBRJ2ysfA=;
        b=pmFXZvSIRYEC2CLR7gtshCqd0R4QDP3o4kHK2VcL7Yva+iLoSOjDjwQtZHLFRRWXRQ
         qNiarq6A7JNgLREVY5XW2Cpaojmjq7fyh/goITVuRkNm2wUuMpIdp1Z5lolJOcIapCqo
         4KIHcwBWaff9dkcfgxXUKhy3Li/xE+da0wThSSCX0LQ2QkdajaI3ZtcyRDdXB4cjw0TS
         k9iONpgT6uEsaTkQPmW5eeqa4isf30zhxuWXDzGqYTaNgHbgTA6zA0fRPer72Ko7f+da
         2SuFnAUa3e2s65Shza3CbVJxKLSZ5fOaPbl2N/y0vvMNP8YHl8lhZ2xZfB46JWLeTkCT
         lD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=klloSdQCjQ4qA/DLBUzVlJByLToqRxqXBowBRJ2ysfA=;
        b=mWGs765yHpY/etoizpSuEIr3S4SYtlgenYCEBjRmHPXwP6Ata8/h/AlxcsM60WJh3K
         wzdBcNOV584lCldV+8vh17+O1ceDw/83H+bm2mfK09XQEz7HMDbSYC+4JiksXRB8IzCs
         1a5ZedFBSiwzhF5OA7qmLIXxuBy8dnInm1N6PdCLuupAhqFOl81dwxjOkqKyu5F6OIRZ
         IU4BbmH91r+weBcSgwH7J43l/MpLuq7zegOCIjVfFdiu6Sd+X1bpAVacaiIRzTf9Elk6
         gWi1EAFF6qrxTh04o/g3isUYjF92a1tVQkTnjj4lRsAZwnm2PoMquSeD+6Tm+KyFbmzr
         ISQw==
X-Gm-Message-State: AOAM530DM/205XUEN6xIGJoo8dMwMUYAlTM5wy7FdHXB1nsCfP+mUhPU
        l5Iidl6VOXnQJEP66gQG5ybkWg==
X-Google-Smtp-Source: ABdhPJwKs1c6wRqDhepeTEqLuX8YY0Nw3/1AORj+APMCBYb+JNuaMi1Ufj2DJqrfHhWm15V9vYmC/g==
X-Received: by 2002:a17:90b:793:: with SMTP id l19mr3238788pjz.154.1600940143918;
        Thu, 24 Sep 2020 02:35:43 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id x4sm2365081pfm.86.2020.09.24.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:35:43 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:35:38 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
Message-ID: <20200924093538.GA35720@laputa>
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

Adrian,

This is, hopefully, my last reply to your comments on this patch#12.

Regarding _request() and _send_command() (and more),

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
  (snip)

> Again, this is what I want to avoid.  I would like to have 3 kinds of functions:
> 	- SD mode only
> 	- UHS-II only
> 	- SD functions with no UHS-II code, that can also be used by UHS-II
> i.e. I don't want to mix UHS-II code and SD mode code in the same function.
> 
> I think sdhci-uhs2.c should provide a request function and a send_command function.
> I would start by removing everything you may not need, and then see if you have any problems.
> e.g.
> 
> void uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> {
> 	struct sdhci_host *host = mmc_priv(mmc);
> 	struct mmc_command *cmd;
> 	unsigned long flags;
> 
> 	if (!host->uhs2_mode) {
> 		sdhci_request(mmc, mrq);
> 		return;
> 	}
> 
> 	spin_lock_irqsave(&host->lock, flags);
> 	uhs2_send_command(host, cmd);
> 	spin_unlock_irqrestore(&host->lock, flags);
> }
> EXPORT_SYMBOL_GPL(uhs2_request);
> 
> For sdhci_prepare_data(), I would factor out the dma part, so
> 
> static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> {
> 	struct mmc_data *data = cmd->data;
> 
> 	sdhci_initialize_data(host, data);
> 
> 	sdhci_prepare_dma(host, data);
> 
> 	sdhci_set_block_info(host, data);
> }
> 
> The you could export sdhci_initialize_data() and sdhci_prepare_dma() for uhs2.
> 
> >  }
> >  
> >  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> > @@ -1439,6 +1463,13 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
> >  	u16 mode = 0;
> >  	struct mmc_data *data = cmd->data;
> >  
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    host->mmc->flags & MMC_UHS2_SUPPORT) {
> > +		if (sdhci_uhs2_ops.set_transfer_mode)
> > +			sdhci_uhs2_ops.set_transfer_mode(host, cmd);
> > +		return;
> > +	}
> > +
> 
> Once you provide uhs2_request() and uhs2_send_command(), the transfer mode setting can be done in sdhci-uhs2.c

If I try to make changes as you suggested above, a lot of other uhs2-flavored
functions will also be created due to calling dependency/sequences
and for "completeness" compared to uhs counterparts.
They probably include
    sdhci_uhs2_prepare_data()
    sdhci_uhs2_external_dma_prepare_data()
    sdhci_uhs2_send_command()
    sdhci_uhs2_send_command_try()
    sdhci_uhs2_send_tuning()
    sdhci_uhs2_request()
    sdhci_uhs2_request_atomic()
    sdhci_uhs2_thread_irq()
    sdhci_uhs2_irq()
    sdhci_uhs2_cmd_irq()
    sdhci_uhs2_finish_command()
    sdhci_uhs2_resume_host()
    __sdhci_uhs2_add_host()
    sdhci_uhs2_add_host()
(Some may not be used under the current drivers.)

In addition, a bunch of functions in sdhci.c will also have to be exported
to uhs2 as "global" functions instead of "static."

Is this all that you expect to see?

-Takahiro Akashi



> >  	if (data == NULL) {
> >  		if (host->quirks2 &
> >  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
> > @@ -1570,6 +1601,12 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
> >  	else
> >  		data->bytes_xfered = data->blksz * data->blocks;
> >  
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    host->mmc->flags & MMC_UHS2_INITIALIZED) {
> > +		__sdhci_finish_mrq(host, data->mrq);
> > +		return;
> > +	}
> 
> At least to start with, I think it would be better to handle UHS-II cmd and data interrupts completely in sdhci-uhs2.c
> 
> > +
> >  	/*
> >  	 * Need to send CMD12 if -
> >  	 * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
> > @@ -1654,7 +1691,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> >  			sdhci_prepare_data(host, cmd);
> >  	}
> >  
> > -	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> > +	if (!IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))
> > +		sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> 
> Not needed when instead you provide uhs2_send_command() 
> >  
> >  	sdhci_set_transfer_mode(host, cmd);
> >  
> > @@ -1699,6 +1737,17 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> >  	if (host->use_external_dma)
> >  		sdhci_external_dma_pre_transfer(host, cmd);
> >  
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    (host->mmc->flags & MMC_UHS2_SUPPORT)) {
> > +		if (sdhci_uhs2_ops.send_command)
> > +			sdhci_uhs2_ops.send_command(host, cmd);
> > +
> > +		return true;
> > +	}
> > +
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))
> > +		sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> 
> Not needed when instead you provide uhs2_send_command()
> 
> > +
> >  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
> >  
> >  	return true;
> > @@ -1780,13 +1829,20 @@ static void sdhci_finish_command(struct sdhci_host *host)
> >  {
> >  	struct mmc_command *cmd = host->cmd;
> >  
> > -	host->cmd = NULL;
> > +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +	    host->mmc->flags & MMC_UHS2_SUPPORT) {
> > +		if (sdhci_uhs2_ops.finish_command)
> > +			sdhci_uhs2_ops.finish_command(host);
> > +	} else {
> > +		host->cmd = NULL;
> >  
> > -	if (cmd->flags & MMC_RSP_PRESENT) {
> > -		if (cmd->flags & MMC_RSP_136) {
> > -			sdhci_read_rsp_136(host, cmd);
> > -		} else {
> > -			cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
> > +		if (cmd->flags & MMC_RSP_PRESENT) {
> > +			if (cmd->flags & MMC_RSP_136) {
> > +				sdhci_read_rsp_136(host, cmd);
> > +			} else {
> > +				cmd->resp[0] = sdhci_readl(host,
> > +							   SDHCI_RESPONSE);
> > +			}
> 
> At least to start with, I think it would be better to handle UHS-II cmd and data interrupts completely in sdhci-uhs2.c
> 
> >  		}
> >  	}
> >  
> > @@ -1809,6 +1865,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
> >  		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> >  			   cmd == host->data_cmd) {
> >  			/* Command complete before busy is ended */
> > +			host->cmd = NULL;
> 
> host->cmd is set to NULL at the start of this function, so this is not needed.
> 
> >  			return;
> >  		}
> >  	}
> > @@ -1828,6 +1885,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
> >  		if (!cmd->data)
> >  			__sdhci_finish_mrq(host, cmd->mrq);
> >  	}
> > +
> > +	host->cmd = NULL;
> 
> host->cmd is set to NULL at the start of this function, so this is not needed.
> 
> >  }
> >  
> >  static u16 sdhci_get_preset_value(struct sdhci_host *host)
> > @@ -1855,6 +1914,11 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
> >  	case MMC_TIMING_MMC_HS400:
> >  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
> >  		break;
> > +#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
> 
> Shouldn't need conditional compilation for this
> 
> > +	case MMC_TIMING_UHS2:
> > +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> > +		break;
> > +#endif
> >  	default:
> >  		pr_warn("%s: Invalid UHS-I mode selected\n",
> >  			mmc_hostname(host->mmc));
> > @@ -2095,7 +2159,6 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >  			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> >  
> >  		pwr |= SDHCI_POWER_ON;
> > -
> 
> No white space changes mixed in please
> 
> >  		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> >  
> >  		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> > @@ -2261,6 +2324,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >  	struct sdhci_host *host = mmc_priv(mmc);
> >  	u8 ctrl;
> > +	u16 ctrl_2;
> >  
> >  	if (ios->power_mode == MMC_POWER_UNDEFINED)
> >  		return;
> > @@ -2287,6 +2351,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  		sdhci_enable_preset_value(host, false);
> >  
> >  	if (!ios->clock || ios->clock != host->clock) {
> > +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +		    ios->timing == MMC_TIMING_UHS2)
> > +			host->timing = ios->timing;
> > +
> >  		host->ops->set_clock(host, ios->clock);
> >  		host->clock = ios->clock;
> >  
> > @@ -2308,6 +2376,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	else
> >  		sdhci_set_power(host, ios->power_mode, ios->vdd);
> >  
> > +	/* 4.0 host support */
> > +	if (host->version >= SDHCI_SPEC_400) {
> > +		/* UHS2 Support */
> > +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +		    host->mmc->flags & MMC_UHS2_SUPPORT &&
> > +		    host->mmc->caps & MMC_CAP_UHS2) {
> > +			if (sdhci_uhs2_ops.do_set_ios)
> > +				sdhci_uhs2_ops.do_set_ios(host, ios);
> > +			return;
> > +		}
> > +	}
> > +
> 
> Please look at using existing callbacks instead, maybe creating uhs2_set_ios(), uhs2_set_clock(), uhs2_set_power()
> 
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
> 
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
