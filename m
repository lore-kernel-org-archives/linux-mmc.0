From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [Patch] MULTIMEDIA CARD (MMC): Avoid useless selection of
 MMC_RICOH_MMC quirk
Date: Fri, 22 Sep 2017 21:29:09 +0800
Message-ID: <6bee0df0-1414-6b92-5fee-b69a1564ad8e@rock-chips.com>
References: <F6127EC53C695C46907CD6EE43F3462352911290BD@messagesink.samelson.uni-hildesheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:53833 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdIVN3t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 09:29:49 -0400
In-Reply-To: <F6127EC53C695C46907CD6EE43F3462352911290BD@messagesink.samelson.uni-hildesheim.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2017/9/22 20:21, Sascha El-Sharkawy wrote:
> Ensure correct functionality of MMC_RICOH_MMC pci quirk.
>
> MMC_RICOH_MMC is a pci quirk (realized in /drivers/pci/quirks.c lines 2877
> - 2959), which in turn depend on PCI_QUIRKS. However, MMC_RICOH_MMC can be
> selected even if pci quirks (PCI_QUIRKS) are globally disabled. This patch
> adds the missing dependency to MMC_RICOH_MMC to ensure that it can only be
> selected if pci quirks are active.
>

The commit title should be something like:
mmc: ricoh: Avoid ........

> Signed-off-by:  Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c15637..81143fb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -91,7 +91,7 @@ config MMC_SDHCI_PCI
>
>  config MMC_RICOH_MMC
>  	bool "Ricoh MMC Controller Disabler"
> -	depends on MMC_SDHCI_PCI
> +	depends on MMC_SDHCI_PCI && PCI_QUIRKS

So why not select PCI_QUIRKS directly here?

>  	default y
>  	help
>  	  This adds a pci quirk to disable Ricoh MMC Controller. This
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��g"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
>


-- 
Best Regards
Shawn Lin

