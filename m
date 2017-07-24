From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc/host: add FSP2(ppc476fpe) into depends for
 sdhci-st
Date: Mon, 24 Jul 2017 11:02:03 +0300
Message-ID: <877175d0-1568-d0aa-1084-678d547f054f@intel.com>
References: <20170623154726.15019-2-ivan@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23620 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdGXIIW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Jul 2017 04:08:22 -0400
In-Reply-To: <20170623154726.15019-2-ivan@de.ibm.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>, Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mmc@vger.kernel.org, kernel@stlinux.com

On 23/06/17 18:47, Ivan Mikhaylov wrote:
> * shdci-st driver can be used for ppc476 fsp2 soc

shdci-st -> sdhci-st

> 
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2eb9701..e6c0d86 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -354,8 +354,8 @@ config MMC_MOXART
>  
>  config MMC_SDHCI_ST
>  	tristate "SDHCI support on STMicroelectronics SoC"
> -	depends on ARCH_STI
>  	depends on MMC_SDHCI_PLTFM
> +	depends on ARCH_STI || FSP2
>  	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the Secure Digital Host Controller Interface in
> 

