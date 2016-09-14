From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v7 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Wed, 14 Sep 2016 10:53:11 +0200
Message-ID: <20160914085311.GC10233@verge.net.au>
References: <1473764175-24580-1-git-send-email-horms+renesas@verge.net.au>
 <1473764175-24580-7-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54051 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755898AbcINIxS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2016 04:53:18 -0400
Content-Disposition: inline
In-Reply-To: <1473764175-24580-7-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Tue, Sep 13, 2016 at 12:56:15PM +0200, Simon Horman wrote:
> Add tuning support for use with SDR104 mode
> This includes adding support for the sampling clock controller (SCC).
> 
> Based on work by Ai Kyuse.
> 
> Cc: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

...

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 265 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 264 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 49edff7fee49..32d3e01e0840 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c


...

> +static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
> +{
> +	struct sh_mobile_sdhi *priv;
> +
> +	if (host->mmc->caps & MMC_CAP_UHS_SDR104)
> +		return;

The logic above is inverted, it should be:

	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
		return;

An observable side effect of the above is that on the r8a7796/Salvator-X
a card is not detected after being ejected and re-inserted.
