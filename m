From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 0/7] mmc: sdhci-pltfm: fix and tidy up
 sdhci_pltfm_init()
Date: Wed, 20 Apr 2016 09:13:36 +0300
Message-ID: <57171E10.7040507@intel.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23296 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbcDTGRX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 02:17:23 -0400
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org

On 20/04/16 05:16, Masahiro Yamada wrote:
> 
> 
> Changes in v2:
>   - Remove resource size checking rather than fix it.
>   - Add \n to the tail of the error message
> 
> Masahiro Yamada (7):
>   mmc: sdhci-pltfm: drop error message for too small MMIO resource size
>   mmc: sdhci-pltfm: check return value of platform_get_irq()
>   mmc: sdhci-pltfm: use devm_request_mem_region()
>   mmc: sdhci-pltfm: use devm_ioremap()
>   mmc: sdhci-pltfm: use devm_ioremap_resource()
>   mmc: sdhci-pltfm: move devm_ioremap_resource() up
>   mmc: sdhci-pltfm: call platform_get_irq() before sdhci_alloc_host()
> 
>  drivers/mmc/host/sdhci-pltfm.c | 42 +++++++++++++-----------------------------
>  1 file changed, 13 insertions(+), 29 deletions(-)
> 

Thank you!

For all 7 patches:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

