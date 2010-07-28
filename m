From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] sdhci-s3c: add regulator support
Date: Wed, 28 Jul 2010 10:39:55 -0700
Message-ID: <20100728173954.GD22544@opensource.wolfsonmicro.com>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
 <1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45697 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753352Ab0G1Rjm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2010 13:39:42 -0400
Content-Disposition: inline
In-Reply-To: <1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org

On Wed, Jul 28, 2010 at 04:19:57PM +0200, Marek Szyprowski wrote:

>  static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
>  {
> +	int ret = 0;
>  	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct sdhci_s3c *sc = sdhci_priv(host);
>  
>  	sdhci_suspend_host(host, pm);
> -	return 0;
> +
> +	if (sc->vmmc)
> +		ret = regulator_disable(sc->vmmc);
> +

So, on suspend you disable the regulator...

> +	struct sdhci_s3c *sc = sdhci_priv(host);
> +
> +	if (sc->vmmc) {
> +		int ret = regulator_disable(sc->vmmc);
> +		if (ret)
> +			return ret;

...and on resume you disable it again.  I'm surprised this works
properly after resume, at the very least the core is going to get
confused about the reference counts I'd expect.

I suspect this is for something we need to do better in the regulator
API - restoring the state of the regulators after a resume if the
hardware changes them.  A lot of regulators just do this in hardware so
we didn't need to worry about it previously.

> +		mdelay(2);

This could do with some sort of comment.
