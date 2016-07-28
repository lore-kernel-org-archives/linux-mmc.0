From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 3/4] mmc: sh_mobile_sdhi: Add tuning support
Date: Thu, 28 Jul 2016 09:12:14 +0900
Message-ID: <20160728001214.GA16587@verge.net.au>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
 <1469592803-13842-4-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469592803-13842-4-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 27, 2016 at 01:13:22PM +0900, Simon Horman wrote:
> Add tuning support for use with SDR104 mode
> This includes adding support for the sampling clock controller (SCC).
> 
> Based on work by Ai Kyuse.
> 
> Cc: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

...

> +static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
> +{
> +	struct sh_mobile_sdhi *priv;
> +
> +	if (host->mmc->caps & MMC_CAP_UHS_SDR104)
> +		return 0;

The above line should be:

		return;
