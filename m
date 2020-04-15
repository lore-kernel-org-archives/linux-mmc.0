Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00CC2BA2B
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9850020771
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 06:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="MQZvE4nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393581AbgDOGlU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:41:20 -0400
Received: from smtp2.axis.com ([195.60.68.18]:48431 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgDOGlR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 02:41:17 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 02:41:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2270; q=dns/txt; s=axis-central1;
  t=1586932876; x=1618468876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B17eEB4899W0+kA+fQXd+xbt+eJyLrMadTEPJoPvTAE=;
  b=MQZvE4nVs/mgOAeL7lGZ5kztmHInaGzwL6YocZdJvGafeVV+i5C00xsO
   qidShpUVYVr0uhqa3YElrI8OBzNnNzj4FgaQ3CkNdVFuujAJCPzh3d4xx
   o5/YhhwHvdZ1wnxQZ1m+pVnlltrbAOI5ZDyT2SusGgHzsboHioZLzqqUM
   pur1vE9E4sFsTeNCN2YYdSH2BLl7za540Qxty3BeAmbMV3GGwcfDniizU
   dCHxfkb5yRdIUjEAD+f0dd/3WB4JRimz1uxz+1I/QTwKhggPbnvHVPuwt
   oViUEVMqLALCIGKXqqXsnOkfD7WyqN2vaFxs6PdDqsssQJ80nqPZbsiSD
   A==;
IronPort-SDR: SrpZedr+JNCFoQyG9niN3gd4OISxEveaSvZ08PRT276Dz7sjjnYjEOJWuwC/WeDELyldYLH5X+
 1ly05WDl8UKkGtWbF/wtyJDa6y3cF7Hz5DYk1FliXVi6G7XYhzazzsuvROGluqGwNdWaGazeIX
 lrqE1tRtifpVFJdoEmLCFCo2j6t61V1tF6g1UtVkdwUoBu6Yo24h1pQfG1DeC1/OVNuc63/AlS
 NJt3e8wVfUCKlP82H+nNMGbtt0bWvnGidu/1RHfk8XMZcyxbP6DusyV0pYQTrBS54ud8wJzFAs
 tzo=
X-IronPort-AV: E=Sophos;i="5.72,386,1580770800"; 
   d="scan'208";a="7431371"
Date:   Wed, 15 Apr 2020 08:34:03 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 05/19] mmc: usdhi6rol0: Inform the mmc core about the
 maximum busy timeout
Message-ID: <20200415063403.d3e3auv5engh555b@axis.com>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
 <20200414161413.3036-6-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200414161413.3036-6-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 14, 2020 at 06:13:59PM +0200, Ulf Hansson wrote:
> Some commands uses R1B responses, which means the card may assert the DAT0
> line to signal busy for a period of time, after it has received the
> command. The mmc core normally specifies the busy period for the command in
> the cmd->busy_timeout. Ideally the driver should respect it, but that
> requires quite some update of the code, so let's defer that to someone with
> the HW at hand.
> 
> Instead, let's inform the mmc core about the maximum supported busy timeout
> in ->max_busy_timeout during ->probe(). This value corresponds to the fixed
> 4s timeout used by usdhi6rol0. In this way, we let the mmc core validate
> the needed timeout, which may lead to that it converts from a R1B into a R1
> response and then use CMD13 to poll for busy completion.
> 
> In other words, this change enables support for commands with longer busy
> periods than 4s, like erase (CMD38) for example.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Lars Persson <lars.persson@axis.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/usdhi6rol0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 9a0b1e4e405d..369b8dee2e3d 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -136,6 +136,8 @@
>  
>  #define USDHI6_MIN_DMA 64
>  
> +#define USDHI6_REQ_TIMEOUT_MS 4000
> +
>  enum usdhi6_wait_for {
>  	USDHI6_WAIT_FOR_REQUEST,
>  	USDHI6_WAIT_FOR_CMD,
> @@ -1763,7 +1765,12 @@ static int usdhi6_probe(struct platform_device *pdev)
>  	host		= mmc_priv(mmc);
>  	host->mmc	= mmc;
>  	host->wait	= USDHI6_WAIT_FOR_REQUEST;
> -	host->timeout	= msecs_to_jiffies(4000);
> +	host->timeout	= msecs_to_jiffies(USDHI6_REQ_TIMEOUT_MS);
> +	/*
> +	 * We use a fixed timeout of 4s, hence inform the core about it. A
> +	 * future improvement should instead respect the cmd->busy_timeout.
> +	 */
> +	mmc->max_busy_timeout = USDHI6_REQ_TIMEOUT_MS;
>  
>  	host->pinctrl = devm_pinctrl_get(&pdev->dev);
>  	if (IS_ERR(host->pinctrl)) {
> -- 
> 2.20.1
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
