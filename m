From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] mmc: add support for eMMC hardware reset for BYT eMMC
Date: Thu, 27 Jun 2013 11:54:29 -0400
Message-ID: <87txkjmtvu.fsf@octavius.laptop.org>
References: <1371113427-8257-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35108 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab3F0Pyd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:54:33 -0400
In-Reply-To: <1371113427-8257-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Thu, 13 Jun 2013 11:50:25 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

Hi Adrian,

On Thu, Jun 13 2013, Adrian Hunter wrote:
> Here are 2 patches to add support for eMMC hardware reset for BYT eMMC.
>
>
> Adrian Hunter (2):
>       mmc: sdhci-pci: add support for eMMC hardware reset for BYT eMMC.
>       mmc: sdhci-acpi: add support for eMMC hardware reset for HID 80860F14
>
>  drivers/mmc/host/sdhci-acpi.c | 28 +++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-pci.c  | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 57 insertions(+), 3 deletions(-)

Thanks, both pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
