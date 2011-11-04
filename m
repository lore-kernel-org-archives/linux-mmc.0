From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] mmc: sdhci: remove "state" argument from sdhci_suspend_host
Date: Fri, 04 Nov 2011 12:12:51 +0200
Message-ID: <4EB3BAA3.3020408@intel.com>
References: <1320314985-9536-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44812 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262Ab1KDKMy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Nov 2011 06:12:54 -0400
In-Reply-To: <1320314985-9536-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 03/11/11 12:09, Manuel Lauss wrote:
> Drop the "state" argument from sdhci_suspend_host.  Its only user
> is the PCI glue;  this allows to move all SDHCI glues to use
> dev_pm_ops instead.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> V4: get rid of last checkpatch warning.
> V3: remove unused local var in sdhci-pci.c
> V2: sdhci-s3c does not use sdhci-pltfm.c and gets its own dev_pm_ops.
> 
> run-tested on pci/x64 and compile-tested with tegra_defconfig.
> 
>  drivers/mmc/host/sdhci-cns3xxx.c   |    5 +----
>  drivers/mmc/host/sdhci-dove.c      |    5 +----
>  drivers/mmc/host/sdhci-esdhc-imx.c |    5 +----
>  drivers/mmc/host/sdhci-of-esdhc.c  |    5 +----
>  drivers/mmc/host/sdhci-of-hlwd.c   |    5 +----
>  drivers/mmc/host/sdhci-pci.c       |   26 +++++++++++++-------------
>  drivers/mmc/host/sdhci-pltfm.c     |   18 +++++++++++-------
>  drivers/mmc/host/sdhci-pltfm.h     |    6 ++++--
>  drivers/mmc/host/sdhci-pxav2.c     |    5 +----
>  drivers/mmc/host/sdhci-pxav3.c     |    5 +----
>  drivers/mmc/host/sdhci-s3c.c       |   21 ++++++++++++++-------
>  drivers/mmc/host/sdhci-tegra.c     |    5 +----
>  drivers/mmc/host/sdhci.c           |    2 +-
>  drivers/mmc/host/sdhci.h           |    2 +-
>  14 files changed, 52 insertions(+), 63 deletions(-)
> 
