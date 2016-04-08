From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pic32: remove owner assignment
Date: Fri, 8 Apr 2016 10:05:07 +0300
Message-ID: <57075823.7080104@intel.com>
References: <1460092958-16591-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23573 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbcDHHIv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Apr 2016 03:08:51 -0400
In-Reply-To: <1460092958-16591-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 08/04/16 08:22, Masahiro Yamada wrote:
> A platform_driver does not need to set an owner, it will be populated
> by the driver core.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mmc/host/sdhci-pic32.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index 059df70..72c13b6 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -243,7 +243,6 @@ MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
>  static struct platform_driver pic32_sdhci_driver = {
>  	.driver = {
>  		.name	= "pic32-sdhci",
> -		.owner	= THIS_MODULE,
>  		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
>  	},
>  	.probe		= pic32_sdhci_probe,
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

