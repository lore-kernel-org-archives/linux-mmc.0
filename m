From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-pci: add 8-bit bus width support for Medfield eMMCs
Date: Sat, 09 Jul 2011 16:53:39 -0400
Message-ID: <m2mxgnkwfg.fsf@bob.laptop.org>
References: <1309346627-32630-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45279 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab1GIUxq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 16:53:46 -0400
In-Reply-To: <1309346627-32630-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Wed, 29 Jun 2011 14:23:45 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>

Hi Adrian,

On Wed, Jun 29 2011, Adrian Hunter wrote:
> Just setting some MMC_CAP_8_BIT_DATA bits.
>
>
> Adrian Hunter (1):
>       mmc: sdhci-pci: allow 8-bit bus width for Intel Medfield eMMCs
>
> Major Lee (1):
>       mmc: sdhci-pci: add 8-bit bus width support for mrst hc0

Pushed to mmc-next for 3.1, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
