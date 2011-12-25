From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: use S3C_SDHCI_CONTROL2 instead of hardcoded offeset value
Date: Sat, 24 Dec 2011 21:13:35 -0500
Message-ID: <m2fwg9z9dc.fsf@bob.laptop.org>
References: <003801ccba18$736ebb80$5a4c3280$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53875 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758056Ab1LYCNz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Dec 2011 21:13:55 -0500
In-Reply-To: <003801ccba18$736ebb80$5a4c3280$%han@samsung.com> (Jingoo Han's
	message of "Wed, 14 Dec 2011 13:25:46 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Ben Dooks' <ben-linux@fluff.org>

Hi,

On Tue, Dec 13 2011, Jingoo Han wrote:
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index cb60c41..62ff6b4 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -80,7 +80,7 @@ static void sdhci_s3c_check_sclk(struct sdhci_host *host)
>  
>  		tmp &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
>  		tmp |= ourhost->cur_clk << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
> -		writel(tmp, host->ioaddr + 0x80);
> +		writel(tmp, host->ioaddr + S3C_SDHCI_CONTROL2);
>  	}
>  }

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
