From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 00/05] tmio_mmc: SDHI hotplug and random fixes
Date: Fri, 19 Feb 2010 12:46:21 +0100
Message-ID: <20100219114620.GE10255@sortiz.org>
References: <20100217073735.32726.12020.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28564 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751446Ab0BSLpH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Feb 2010 06:45:07 -0500
Content-Disposition: inline
In-Reply-To: <20100217073735.32726.12020.sendpatchset@t400s>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, g.liakhovetski@gmx.de, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, akpm@linux-foundation.org

Hi Magnus,

On Wed, Feb 17, 2010 at 04:37:35PM +0900, Magnus Damm wrote:
> tmio_mmc: SDHI hotplug and random fixes
> 
> [PATCH 01/05] tmio_mmc: Keep card-detect interrupts enabled
> [PATCH 02/05] tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support V2
> [PATCH 03/05] tmio_mmc: Use 100ms mmc_detect_change() delay
> [PATCH 04/05] tmio_mmc: Remove const from platform data V3
> [PATCH 05/05] tmio_mmc: Balance cell enable()/disable() calls
> 
> These patches are a collection of fixes for SDHI hotplug and
> other minor improvements for the tmio_mmc driver.
> 
> The first and the third patch contain tmio-mmc specific fixes
> for SDHI hotplug. Hot insertion and eject have been tested using
> the sh-2.6 tree with the two SDHI blocks provided by the sh7724
> processor using Ecovec24 and ms7724se boards. The single SDHI
> block included in sh7722 has been tested on Migo-R.
> 
> The second patch is the ground work to allow the SDHI mfd driver
> to enable MMC_CAP_MMC_HIGHSPEED.
> 
> The last two patches are just random improvements and fixes for
> the tmio_mmc driver.
Since some of this code depends on the tmio.h changes, I'm taking this
patchset. Please let me know if that's fine with you.

Cheers,
Samuel.


> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/mmc/host/tmio_mmc.c |   13 ++++++++++---
>  drivers/mmc/host/tmio_mmc.h |    6 ++----
>  include/linux/mfd/tmio.h    |    3 ++-
>  3 files changed, 14 insertions(+), 8 deletions(-)

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
