From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: add quirk about BROKEN_ADMA_ZEROLEN_DESC
Date: Thu, 28 Jul 2011 18:28:55 -0400
Message-ID: <m2bowejazc.fsf@bob.laptop.org>
References: <4E1C0637.2090603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35750 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab1G1W3P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 18:29:15 -0400
In-Reply-To: <4E1C0637.2090603@samsung.com> (Jaehoon Chung's message of "Tue,
	12 Jul 2011 17:30:47 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

On Tue, Jul 12 2011, Jaehoon Chung wrote:
> This patch is added the quirk for Samsung SoCs.
>
> Samsung SoCs need to set QUIRK_BROKEN_ADMA_ZEROLEN_DESC.
> (If ADMA operation is more than 65535, maybe set by zero.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 460ffaf..03da44a 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -502,6 +502,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	/* This host supports the Auto CMD12 */
>  	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
> +	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
> +
>  	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
>  	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;

Pushed to mmc-next for 3.1, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
