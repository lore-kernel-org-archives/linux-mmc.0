From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] ARM: configs: Enable TI_EDMA in
 omap2plus_defconfig
Date: Thu, 4 Jul 2013 05:05:23 -0700
Message-ID: <20130704120523.GM5523@atomide.com>
References: <1372304523-30742-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53286 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756172Ab3GDMFh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jul 2013 08:05:37 -0400
Content-Disposition: inline
In-Reply-To: <1372304523-30742-1-git-send-email-joelf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>

* Joel Fernandes <joelf@ti.com> [130626 20:48]:
> Build EDMA in by default to avoid fewer people stepping on their toes
> with broken DMA on drivers needing EDMA.

Thanks applying this one into omap-for-v3.11/fixes.

Tony
