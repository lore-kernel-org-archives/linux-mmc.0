From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 00/11] mmc: Add support for drive strength for eMMCs
Date: Mon, 11 May 2015 12:29:04 +0300
Message-ID: <55507660.4010307@intel.com>
References: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10214 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbbEKJbW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 May 2015 05:31:22 -0400
In-Reply-To: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>

On 06/02/15 14:12, Adrian Hunter wrote:
> Hi
> 
> Here is V2 of some patches to enable a host controller to select
> driver strength for eMMCs using HS200 or HS400. These are based
> on top of the re-tuning series.
> 
> There can be some confusion over the term "driver strength".
> SD calls it "drive strength" for the card but "driver type"
> for the host. Whereas JEDEC calls it both "driver strength"
> and "driver type". The values are the same for both SD
> and eMMC:
> 
>   Value   Driver Type   Relative strength
>     0       B             x1	default and mandatory support
>     1       A             x1.5
>     2       C             x0.75
>     3       D             x0.5
> 
> Except eMMC also defines value 4:
> 
>   Value   Driver Type   Relative strength
>     4                     x1.2
> 
> 
> Changes in V2:
> 
>     mmc: core: Add function to read driver-strength device property
>         Dropped because there are still questions over how to use
>         device properties.
> 
>     mmc: sdhci-pci: Add support for drive strength selection for SPT
>         Amended to reflect the change above.
> 
> 
> Adrian Hunter (11):
>       mmc: core: Reset driver type to default
>       mmc: core: Allow card drive strength to be different to host
>       mmc: core: Simplify card drive strength mask
>       mmc: core: Add 'card' to drive strength selection callback
>       mmc: core: Factor out common code in drive strength selection
>       mmc: core: Record card drive strength
>       mmc: mmc: Read card's valid driver strength mask
>       mmc: mmc: Add driver strength selection
>       mmc: sdhci: Add a callback to select drive strength
>       mmc: sdhci-pci: Add support for drive strength selection for SPT
>       mmc: sdhci-pci: Enable HS400 for some Intel host controllers
> 
>  drivers/mmc/core/core.c            | 39 ++++++++++++++++++
>  drivers/mmc/core/core.h            |  2 +
>  drivers/mmc/core/mmc.c             | 46 +++++++++++++++++----
>  drivers/mmc/core/sd.c              | 69 ++++++++-----------------------
>  drivers/mmc/core/sdio.c            | 77 +++++++++++-----------------------
>  drivers/mmc/host/sdhci-pci-data.c  |  3 ++
>  drivers/mmc/host/sdhci-pci.c       | 84 ++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h       |  4 ++
>  drivers/mmc/host/sdhci.c           | 13 ++++++
>  drivers/mmc/host/sdhci.h           |  4 ++
>  include/linux/mmc/card.h           |  2 +
>  include/linux/mmc/host.h           |  4 +-
>  include/linux/mmc/mmc.h            |  4 ++
>  include/linux/mmc/sdhci-pci-data.h |  2 +
>  14 files changed, 240 insertions(+), 113 deletions(-)

Hi Ulf

These patches still apply. Would have time to look at them?

Regards
Adrian

