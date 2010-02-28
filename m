From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 00/05] tmio_mmc: SDHI hotplug and random fixes
Date: Sun, 28 Feb 2010 20:03:52 +0100
Message-ID: <20100228190351.GD3589@sortiz.org>
References: <20100217073735.32726.12020.sendpatchset@t400s>
 <20100219114620.GE10255@sortiz.org>
 <aec7e5c31002212043hf9dd9b6rbe72328592d455ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:18738 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031841Ab0B1TCn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Feb 2010 14:02:43 -0500
Content-Disposition: inline
In-Reply-To: <aec7e5c31002212043hf9dd9b6rbe72328592d455ae@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, g.liakhovetski@gmx.de, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, akpm@linux-foundation.org

Hi Magnus,

On Mon, Feb 22, 2010 at 01:43:54PM +0900, Magnus Damm wrote:
> Hi Samuel,
> 
> On Fri, Feb 19, 2010 at 8:46 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > On Wed, Feb 17, 2010 at 04:37:35PM +0900, Magnus Damm wrote:
> >> tmio_mmc: SDHI hotplug and random fixes
> >>
> >> [PATCH 01/05] tmio_mmc: Keep card-detect interrupts enabled
> >> [PATCH 02/05] tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support V2
> >> [PATCH 03/05] tmio_mmc: Use 100ms mmc_detect_change() delay
> >> [PATCH 04/05] tmio_mmc: Remove const from platform data V3
> >> [PATCH 05/05] tmio_mmc: Balance cell enable()/disable() calls
> >>
> > Since some of this code depends on the tmio.h changes, I'm taking this
> > patchset. Please let me know if that's fine with you.
> 
> Sounds great, thank you! I've just posted two patches for
> sh_mobile_sdhi, please pick them up as well if possible.
Done, thanks a lot.

Cheers,
Samuel.


> Thanks,
> 
> / magnus

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
