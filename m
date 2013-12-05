From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv3 3/4] mmc: dw_mmc-socfpga: Clean up SOCFPGA platform
 specific funcationality
Date: Thu, 5 Dec 2013 11:47:40 +0000
Message-ID: <20131205114740.GM29200@e106331-lin.cambridge.arm.com>
References: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
 <1386197576-3825-4-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42737 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755650Ab3LELsV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 06:48:21 -0500
Content-Disposition: inline
In-Reply-To: <1386197576-3825-4-git-send-email-dinguyen@altera.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "dinguyen@altera.com" <dinguyen@altera.com>
Cc: "dinh.linux@gmail.com" <dinh.linux@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "mturquette@linaro.org" <mturquette@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "cjb@laptop.org" <cjb@laptop.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 04, 2013 at 10:52:55PM +0000, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The SDR timing registers for the SD/MMC IP block for SOCFPGA is located
> in the system manager. This system manager IP block is located outside of
> the SD IP block itself. We can use the normal clock API to set the SDR
> settings.
> 
> Also, there is no need for "altr,dw-mshc-ciu-div" as the driver can get
> the value of the CIU clock from the common clock API.

If this property isn't necessary, please mark it as deprecated in the
documentation.

[...]

> +	if (IS_ERR(sysmgr_clk))
> +		dev_err(host->dev, "sysmgr-sdr-mmc not available\n");
> +	else {
> +		clk_disable_unprepare(host->ciu_clk);
> +		clk_prepare_enable(sysmgr_clk);
> +		clk_prepare_enable(host->ciu_clk);
> +	}
>  	return 0;
>  }

This looks a little odd. Should you not return an error if you don't
have the requisite clocks?

[...]

> -	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> -	if (IS_ERR(priv->sysreg)) {
> -		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
> -		return PTR_ERR(priv->sysreg);
> -	}

Is this property deprecated?

> -
> -	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
> -	if (ret)
> -		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
> -	priv->ciu_div = div;
> -
> -	ret = of_property_read_u32_array(np,
> -			"altr,dw-mshc-sdr-timing", timing, 2);

Deprecated too?

Thanks,
Mark.
