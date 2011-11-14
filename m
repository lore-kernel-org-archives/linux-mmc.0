From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Mon, 14 Nov 2011 13:30:27 -0800
Message-ID: <20111114213026.GP31337@atomide.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
 <1320407441-29697-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21707 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab1KNVac (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2011 16:30:32 -0500
Content-Disposition: inline
In-Reply-To: <1320407441-29697-3-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org

* Rajendra Nayak <rnayak@ti.com> [111104 04:16]:
> @@ -1869,6 +1957,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>  	struct omap_hsmmc_host *host = NULL;
>  	struct resource *res;
>  	int ret, irq;
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(omap_mmc_of_match, &pdev->dev);
> +	if (match) {
> +		pdata = of_get_hsmmc_pdata(&pdev->dev);
> +		if (match->data)
> +			pdata->reg_offset = *(u16 *)match->data;
> +	}

So this is now using both DT and pdata?

We want to use DT only, and get rid of pdata. Other than the
deferred probe, is there some other dependency remaining to
having to use the pdata also?

Regards,

Tony
