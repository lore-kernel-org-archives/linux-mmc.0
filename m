From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] mmc: add a cap and a quirk
Date: Tue, 13 Mar 2012 08:41:01 +0200
Message-ID: <4F5EEBFD.2070606@intel.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59180 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab2CMGkw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Mar 2012 02:40:52 -0400
In-Reply-To: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, linus walleij <linus.walleij@linaro.org>

On 07/02/12 14:48, Adrian Hunter wrote:
> Hi
> 
> Here are patches for Medfield to allow the use of high-capacity erase size
> and to allow the SDIO host controller to be off when the card is kept on
> during suspend - replacing the earlier patch "mmc: sdhci: always reset all
> during resume"
> 
> 
> Adrian Hunter (4):
>       mmc: core: add high-capacity erase size capability flag
>       mmc: sdhci-pci: select HC erase size for Medfield eMMC
>       mmc: sdhci: add quirk for keeping card power during suspend
>       mmc: sdhci-pci: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for Medfield SDIO
> 
>  drivers/mmc/core/mmc.c       |    3 ++-
>  drivers/mmc/host/sdhci-pci.c |    8 +++++++-
>  drivers/mmc/host/sdhci.c     |   13 +++++++++++--
>  include/linux/mmc/host.h     |    1 +
>  include/linux/mmc/sdhci.h    |    2 ++
>  5 files changed, 23 insertions(+), 4 deletions(-)

Chris can you take these?

MMC_CAP2_HC_ERASE_SZ needs to move to bit9 but otherwise they apply.
