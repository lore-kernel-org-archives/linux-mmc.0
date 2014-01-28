From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 1/8] mmc: core add the property for hs200
Date: Tue, 28 Jan 2014 21:52:56 +0900
Message-ID: <000501cf1c27$ddf42120$99dc6360$%jun@samsung.com>
References: <52E76954.1020507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46197 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaA1Mw7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 07:52:59 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0400BYJ3S9E750@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jan 2014 21:52:57 +0900 (KST)
In-reply-to: <52E76954.1020507@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Arnd Bergmann' <arnd@arndb.de>, 'Ulf Hansson' <ulf.hansson@linaro.org>

On Tuesday, January 28, 2014, Jaehoon Chung wrote:
> mmc-hs200-1.8v and mmc-hs200-1.2v can be used to the general capability.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog V2:
> 	- Rename the mmc-hs200-1_8v/1_2v instead of "_caps2_"
> 	- Add the properties into Documentation/devicetree/bindings/mmc/mmc.txt
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
>  drivers/mmc/core/host.c                       |    4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
> b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 458b57f..4bb3894 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -29,6 +29,8 @@ Optional properties:
>  - cap-power-off-card: powering off the card is safe
>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>  - full-pwr-cycle: full power cycle of the card is supported
> +- mmc-hs200-1_8v: HS200 mode(1.8V I/O) is supported
> +- mmc-hs200-1_2v: HS200 mode(1.2V I/O) is supported
> 
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 49bc403..5a82e81 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -429,6 +429,10 @@ int mmc_of_parse(struct mmc_host *host)
>  		host->pm_caps |= MMC_PM_KEEP_POWER;
>  	if (of_find_property(np, "enable-sdio-wakeup", &len))
>  		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +	if (of_find_property(np, "mmc-hs200-1_8v", NULL))
> +		host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
> +	if (of_find_property(np, "mmc-hs200-1_2v", NULL))
> +		host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
3rd argument(NULL) is replaced with 'len' at patch 2/8.
Can be done here.

Thanks,
Seungwon Jeon

> 
>  	return 0;
> 
> --
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

