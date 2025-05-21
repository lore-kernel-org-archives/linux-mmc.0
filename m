Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06E264630
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827912; cv=none; b=RRBTGh9Eym+bFJ2UWDXh8niMiawIV+9vBk4y6SMGn0/hGfeb2Hq+eeluYUWdrGUU7SB/vo9cL/NRLqgyXD1nikjROA5EvAXU1PgFGfSOh6NwHFLocRir3JthmFu10y1V4QBNXsfaCgPCUoVJZ6c2myLv3nyaOYkgQYdHIc9mjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827912; c=relaxed/simple;
	bh=td/pyxwNtvx4HW46UhbjzrcmN3XyrFV0b2aBZlY01Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVXexRwE3ZIRi57gjFZizGhXNn9u+spIS3IlI+IeoDzC7z8iuG12eAWfZX5FtL1R/HcF0CqSUofnTg+IKL8vyKHDS/nxfHQeA8RIeWwYldfoMCDXTRr3KqfPPlhUs5XPHqLzPJGAJgT2rBtFGA5GVqHpAwtyFCkL7qZZ/eEJrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1uHhsc-00018T-H7; Wed, 21 May 2025 13:45:02 +0200
Message-ID: <721420c6-5e65-48a4-81c5-b161d0df8cfd@pengutronix.de>
Date: Wed, 21 May 2025 13:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: inherit pins_100mhz from
 pins_200mhz when unconfigured
To: ziniu.wang_1@nxp.com, haibo.chen@nxp.com, adrian.hunter@intel.com,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev, s32@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20250521112042.266111-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20250521112042.266111-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Hi Luke,

Thanks for your patch.

On 21.05.25 13:20, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> On some new i.MX platforms, hardware guidelines recommend using identical
> pin configurations for SDR50/DDR50 (100MHz) and SDR104/HS400 (200MHz)
> modes. But defining two identical pinctrl for 100MHz and 200MHz in dts
> creates redundancy.

I am not convinced this is an improvement. If 200mhz is missing, it's understood
that it's not supported. Now if 100mhz is missing, it means something different
depending on whether state_200mhz exists or not. This is more mental overhead
than having:

  pinctrl-names = "default", "state_100mhz", "state_200mhz";
  pinctrl-0 = <&pinctrl_usdhc1>;        
  pinctrl-1 = <&pinctrl_usdhc1_uhs>;   
  pinctrl-2 = <&pinctrl_usdhc1_uhs>;

where it's directly evident that you share pinctrl states.

> In this case, omit explicit 100MHz configuration,
> driver will inherit 100MHz pinctrl from 200MHz.
> 
> Preserves existing behavior if 100MHz is configured but 200MHz not (e.g,
> imx8mp-navq.dts usdhc1 supports SDR50/DDR50 but SDR104/HS400 not).

This conflicts with the binding, which doesn't allow for state_200mhz
to exist without state_100mhz, so that would need adaptation.

As noted before though, I don't think we really need to change anything
here though.

Thanks,
Ahmad

> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f206b562a6e3..dfd8be5000c8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1810,6 +1810,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  						ESDHC_PINCTRL_STATE_100MHZ);
>  		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
>  						ESDHC_PINCTRL_STATE_200MHZ);
> +
> +		if (IS_ERR_OR_NULL(imx_data->pins_100mhz))
> +			imx_data->pins_100mhz = imx_data->pins_200mhz;
>  	}
>  
>  	/* call to generic mmc_of_parse to support additional capabilities */


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
