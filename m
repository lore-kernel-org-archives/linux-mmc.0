Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2248C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CABC218AC
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 08:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576657787;
	bh=Fzfpbt9JX0wNm8rRu7tHK7Up5oc+JJ5GXixsDBHZ1zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l2jnFVXvvmwIrTLIjFjjqgTpUp1lYRqOtH+B02K4qEt/JxWWgPqoGMhfC+l+NAoK5
	 HrmG1HDmGekB+/uvnHNaW2BFZgo/dx7QKlvktGeOu48iaFha+TF+urKA5yvx0yNtfk
	 ncN0ReOzLFp1ZxI5vRDmC+LeolEt86wAuzmBI5ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfLRI3r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfLRI3q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Dec 2019 03:29:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B892320717;
        Wed, 18 Dec 2019 08:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576657785;
        bh=Fzfpbt9JX0wNm8rRu7tHK7Up5oc+JJ5GXixsDBHZ1zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foEnAQQZ+BJBpd72yJ5tjGMOweQY+brT9HxBOqitTbUu9AyFBY6WxL9AHpLBc6S6E
         o9cbcUQ0tCx+n5GBDzgd5NKYiOsVjiMEjXIc3ac5VojTyjnCG9zgcCaAdJwarT5dNm
         XK9dhjqT8fA2CVsfkgeyiC+hdivEiByv0v3gi2ro=
Date:   Wed, 18 Dec 2019 09:29:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        "Bao D. Nguyen" <nguyenb@quicinc.com>
Subject: Re: [<PATCH v1> 9/9] mmc: sd: Fix trivial SD card issues
Message-ID: <20191218082943.GB1554871@kroah.com>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
 <25f3b41fb4950cad5cf075b245d0ac4010cd1aac.1576540908.git.nguyenb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f3b41fb4950cad5cf075b245d0ac4010cd1aac.1576540908.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 16, 2019 at 06:50:42PM -0800, Bao D. Nguyen wrote:
> From: "Bao D. Nguyen" <nguyenb@quicinc.com>
> 
> Fix various trivial SD card issues.

There are a number of real bugfixes in here, please split these out and
put them at the beginning of the series so that they can be backported
to the stable kernel tree.  Specifics below:

> 
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/mmc/core/block.c |  4 ++--
>  drivers/mmc/core/bus.c   | 13 +++++++++++++
>  drivers/mmc/core/core.c  | 13 ++++++++-----
>  drivers/mmc/core/sd.c    |  9 ++++++---
>  4 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 95b41c0..200882d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -653,13 +653,13 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
>  	struct request *req;
>  
>  	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
> -	if (IS_ERR(idata))
> +	if (IS_ERR_OR_NULL(idata))

How can this function ever return NULL?

>  		return PTR_ERR(idata);

If NULL was returned, are you sure you can return 0 here?  That implies
that all went well, when obviously it did not.

But again, I do not see how mmc_blk_ioctl_copy_from_user() can return
NULL, do you?

>  	/* This will be NULL on non-RPMB ioctl():s */
>  	idata->rpmb = rpmb;
>  
>  	card = md->queue.card;
> -	if (IS_ERR(card)) {
> +	if (IS_ERR_OR_NULL(card)) {

How can card be NULL?

>  		err = PTR_ERR(card);

Again, returning "success" is ok?  Are you sure?

>  		goto cmd_done;
>  	}
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 74de3f2..fb17d21 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -131,6 +131,16 @@ static void mmc_bus_shutdown(struct device *dev)
>  	struct mmc_host *host = card->host;
>  	int ret;
>  
> +	if (!drv) {
> +		pr_debug("%s: %s: drv is NULL\n", dev_name(dev), __func__);

How can this ever happen?

And never use pr_* calls in a driver, you have a valid device, use
dev_dbg() and friends.

> +		return;
> +	}
> +
> +	if (!card) {
> +		pr_debug("%s: %s: card is NULL\n", dev_name(dev), __func__);

Same here, how can this ever happen?

> +		return;
> +	}
> +
>  	if (dev->driver && drv->shutdown)
>  		drv->shutdown(card);
>  
> @@ -247,12 +257,15 @@ void mmc_unregister_driver(struct mmc_driver *drv)
>  static void mmc_release_card(struct device *dev)
>  {
>  	struct mmc_card *card = mmc_dev_to_card(dev);
> +	struct mmc_host *host = card->host;
>  
>  	sdio_free_common_cis(card);
>  
>  	kfree(card->info);
>  
>  	kfree(card);
> +	if (host)
> +		host->card = NULL;

Why are you setting this to null?  Does this solve some race condition
that you are then catching in the shutdown callback?  If so, this should
be broken out as a separate bugfix and put earlier in the series as that
should go to all stable kernels, right?

>  }
>  
>  /*
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 38b0cec..13d496e 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -399,7 +399,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>  	struct mmc_command *cmd;
>  
>  	while (1) {
> -		wait_for_completion(&mrq->completion);
> +		wait_for_completion_io(&mrq->completion);

Why this change?  That seems like a big one.  Why is this not a separate
patch?

>  
>  		cmd = mrq->cmd;
>  
> @@ -666,6 +666,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  {
>  	unsigned int mult;
>  
> +	if (!card) {
> +		WARN_ON(1);

And you just crashed systems that run with panic-on-warn :(

How can this ever happen?  If it is a real issue, catch it, log it, and
then move on, don't splat the kernel log with a full traceback and
reboot machines :(

> +		return;
> +	}
>  	/*
>  	 * SDIO cards only define an upper 1 s limit on access.
>  	 */
> @@ -2341,17 +2345,16 @@ void mmc_rescan(struct work_struct *work)
>  
>  void mmc_start_host(struct mmc_host *host)
>  {
> +	mmc_claim_host(host);

What?  This is a totally separate change, plaese break this out and
describe what you are fixing here.  Again, should be a bugfix for
earlier in the series.

>  	host->f_init = max(freqs[0], host->f_min);
>  	host->rescan_disable = 0;
>  	host->ios.power_mode = MMC_POWER_UNDEFINED;
>  
> -	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
> -		mmc_claim_host(host);
> +	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP))
>  		mmc_power_up(host, host->ocr_avail);
> -		mmc_release_host(host);
> -	}
>  
>  	mmc_gpiod_request_cd_irq(host);
> +	mmc_release_host(host);

And are you sure the reference counting is correct here?  Before this
patch, you dropped the reference above, now you are matching it.  Either
this is wrong, or the original code is wrong.  Either way, you need to
describe it much better please.

>  	_mmc_detect_change(host, 0, false);
>  }
>  
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 5938caf..e163f0e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -989,6 +989,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  		err = mmc_send_relative_addr(host, &card->rca);
>  		if (err)
>  			goto free_card;
> +		host->card = card;

Why?

>  	}
>  
>  	if (!oldcard) {
> @@ -1090,13 +1091,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  		goto free_card;
>  	}
>  done:
> -	host->card = card;
>  	return 0;
>  
>  free_card:
> -	if (!oldcard)
> +	if (!oldcard) {
> +		host->card = NULL;

Again, why?

>  		mmc_remove_card(card);
> -
> +	}
>  	return err;
>  }
>  
> @@ -1106,7 +1107,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  static void mmc_sd_remove(struct mmc_host *host)
>  {
>  	mmc_remove_card(host->card);
> +	mmc_claim_host(host);
>  	host->card = NULL;
> +	mmc_release_host(host);

Huh?  What is this "fixing"?

Again, please break all of these out into logical bugfixes and describe
what you are doing.

thanks,

greg k-h
