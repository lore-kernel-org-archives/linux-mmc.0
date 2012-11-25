From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SDHC: support command with busy response expecting for TC
Date: Sun, 25 Nov 2012 15:31:08 -0500
Message-ID: <87wqx977cj.fsf@octavius.laptop.org>
References: <1353662703-27594-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60181 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384Ab2KYUbO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 15:31:14 -0500
In-Reply-To: <1353662703-27594-1-git-send-email-r66093@freescale.com>
	(r66093@freescale.com's message of "Fri, 23 Nov 2012 17:25:03 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

Hi,

On Fri, Nov 23 2012, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> The IP verions older than 2.3 didn't support the command with busy response
> which expect for TC bit set. But after the VVN2.3, eSDHC IP has supported it.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 63d219f..cfabc43 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -177,6 +177,9 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
>  	vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>  	if (vvn == VENDOR_V_22)
>  		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +
> +	if (vvn > VENDOR_V_22)
> +		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
>  }
>  
>  static struct sdhci_ops sdhci_esdhc_ops = {

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
