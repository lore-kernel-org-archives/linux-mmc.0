From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 1/2] sdhci: register defs for sd 3.0 HOST CONTROL 2
Date: Sun, 2 Jan 2011 18:21:17 +0000
Message-ID: <20110102182117.GA24820@void.printf.net>
References: <F78395C7-D00C-4E33-883D-657474EE80EC@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49518 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126Ab1ABSVT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Jan 2011 13:21:19 -0500
Content-Disposition: inline
In-Reply-To: <F78395C7-D00C-4E33-883D-657474EE80EC@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

Hi Philip,

On Sun, Jan 02, 2011 at 08:43:29AM -0800, Philip Rakity wrote:
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Mark F. Brown <markb@marvell.com>
> ---
>  drivers/mmc/host/sdhci.h |   17 ++++++++++++++++-
>  1 files changed, 16 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6e0969e..36f3861 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -145,7 +145,22 @@
>  
>  #define SDHCI_ACMD12_ERR	0x3C
>  
> -/* 3E-3F reserved */
> +#define SDHCI_HOST_CONTROL_2             0x3E
> +#define SDCTRL_2_UHS_MODE_SEL_SDR12		0x0000
> +#define SDCTRL_2_UHS_MODE_SEL_SDR25		0x0001
> +#define SDCTRL_2_UHS_MODE_SEL_SDR50		0x0002
> +#define SDCTRL_2_UHS_MODE_SEL_SDR104		0x0003
> +#define SDCTRL_2_UHS_MODE_SEL_DDR50		0x0004
> +#define SDCTRL_2_UHS_MODE_MASK			7

0x0007 for consistency?

> +#define SDCTRL_2_SDH_V18_EN			0x0008
> +#define SDCTRL_2_DRV_STRENGTH_SEL_B		0x0000

Is this really 0?

> +#define SDCTRL_2_DRV_STRENGTH_SEL_A		0x0010

Is A really after B?

> +#define SDCTRL_2_DRV_STRENGTH_SEL_C		0x0020
> +#define SDCTRL_2_DRV_STRENGTH_SEL_D		0x0030
> +#define SDCTRL_2_EXE_TUNING			0x0040
> +#define SDCTRL_2_SAMPLING_CLK_SEL		0x0080
> +#define SDCTRL_2_ASYNC_INT_EN			0x4000
> +#define SDCTRL_2_PRESET_VAL_EN			0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
>  #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
