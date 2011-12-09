From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 0/4] mmc: sdhci/sdhci-pci: prepare for wl12xx/SDIO
Date: Fri, 09 Dec 2011 12:34:13 +0200
Message-ID: <4EE1E425.5090402@intel.com>
References: <1320217041-2580-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320217041-2580-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 02/11/11 08:57, Adrian Hunter wrote:
> Hi
> 
> Here are some changes (V2) to allow wl12xx/SDIO to be set up for sdhci-pci.
> There a a couple of fixes plus a method to get platform data.  The
> changes to the platform files are not included in this patchset.
> 
> 
> V2: change sdhci_pci_get_data() from a weak function to a function
> pointer
> 
> 
> Adrian Hunter (4):
>       mmc: sdhci: fix vmmc handling
>       mmc: sdhci: prevent card detection activity for non-removable cards
>       mmc: sdhci-pci: add platform data
>       mmc: sdhci-pci: get gpio numbers from platform data
> 
>  drivers/Makefile                   |    2 +-
>  drivers/mmc/Makefile               |    3 +-
>  drivers/mmc/host/Makefile          |    1 +
>  drivers/mmc/host/sdhci-pci-data.c  |    5 ++
>  drivers/mmc/host/sdhci-pci.c       |  137 +++++++++++++++++-------------------
>  drivers/mmc/host/sdhci.c           |   50 ++++++-------
>  include/linux/mmc/sdhci-pci-data.h |   18 +++++
>  7 files changed, 116 insertions(+), 100 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-data.c
>  create mode 100644 include/linux/mmc/sdhci-pci-data.h

Any comments?  Chris?
