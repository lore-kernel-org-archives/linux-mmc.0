From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Fix mmc card I/O problem
Date: Fri, 26 Aug 2011 19:46:28 +0900
Message-ID: <4E577984.3070609@samsung.com>
References: <1314350898-26372-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15601 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab1HZKqF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2011 06:46:05 -0400
In-reply-to: <1314350898-26372-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, ben-linux@fluff.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org

This patch looks fine to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Girish K S wrote:

> This patch fixes the problem in sdhci-s3c host driver for
> Samsung Soc's. During the card identification stage the
> mmc core driver enumerates for the best bus width in combination
> with the highest available data rate. It starts enumerating from
> the highest bus width (8) to lowest bus width (1).
> 
> In case of few MMC cards the 4-bit bus enumeration fails and tries
> the 1-bit bus enumeration. When switched to 1-bit bus mode the host driver
> has to clear the previous bus width setting and apply the new setting.
> 
> The current patch will clear the previous bus mode and apply the new
> mode setting.
> 
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 2bd7bf4..fe886d6 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -302,6 +302,8 @@ static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, int width)
>  		ctrl &= ~SDHCI_CTRL_8BITBUS;
>  		break;
>  	default:
> +		ctrl &= ~SDHCI_CTRL_4BITBUS;
> +		ctrl &= ~SDHCI_CTRL_8BITBUS;
>  		break;
>  	}
>  


