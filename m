From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: add more device ids
Date: Sun, 26 May 2013 13:51:05 -0400
Message-ID: <87k3mlljee.fsf@octavius.laptop.org>
References: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33264 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633Ab3EZRvL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:51:11 -0400
In-Reply-To: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Fri, 26 Apr 2013 11:27:20 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

Hi Adrian,

On Fri, Apr 26 2013, Adrian Hunter wrote:
> Here is a minor fix and some more device ids for sdhci-acpi and sdhci-pci.
>
> Please queue for 3.10 if possible.
>
> Adrian Hunter (3):
>       mmc: sdhci-acpi: fix initial runtime pm status
>       mmc: sdhci-acpi: add more device ids
>       mmc: sdhci-pci: add more device ids
>
>  drivers/mmc/host/sdhci-acpi.c | 69 +++++++++++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci-pci.c  | 54 +++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+), 9 deletions(-)

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
