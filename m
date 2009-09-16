From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 0/8] s3c6410: sdhci: Update Samsung 6410 SDHCI driver.
Date: Wed, 16 Sep 2009 01:54:42 +0100
Message-ID: <20090916005442.GV13508@trinity.fluff.org>
References: <1252388710-28478-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:45380 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbZIPAyk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 20:54:40 -0400
Content-Disposition: inline
In-Reply-To: <1252388710-28478-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 02:45:10PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch series updates Samsung's 6410 SDHCI driver. This patch series
> adds clock configuration code in the sdhci driver, adds ADMA support and 
> adds module exit functionality. This patch set includes the following
> patches

couple of things

1) s3c should be capitalised to fit in with how the rest of the patch
   submissions are

2) Please keep feature removal and their fixups together to make sure
   that from one change to another the kernel keeps compiling.
 
> [PATCH 1/8] s3c6410: sdhci: Adding additional elements in sdhci platform data structure.
> [PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci platform data structure.
> [PATCH 3/8] s3c6410: sdhci: Set parent clock, source clock and sdhci module speed.
> [PATCH 4/8] s3c6410: sdhci: Enable ADMA feature in 6410 sdhci controller.
> [PATCH 5/8] s3c6410: sdhci: Removing unused host_caps entry from sdhci0 platform data
> [PATCH 6/8] s3c6410: sdhci: Modify platform data for sdhci-1
> [PATCH 7/8] s3c6410: sdhci: Remove host_caps field from sdhci platform data structure
> [PATCH 8/8] s3c6410: sdhci: Updating sdhci_s3c_remove module exit function
> 
> This patch sets depends on the following patches for proper functioning.
> 
> [PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
> [PATCH 2/4] s3c6410: update clk->parent when setting clock source
> [PATCH 3/4] s3c6410: Fix divider value calculation in s3c64xx_roundrate_clksrc
> [PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.
> [PATCH] sdhci: Add new quirk in sdhci driver and update ADMA descriptor build.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

