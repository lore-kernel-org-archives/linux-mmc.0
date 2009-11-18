From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH] [mmc-omap] Add support for 16-bit and 32-bit registers
Date: Wed, 18 Nov 2009 19:41:55 +0100
Message-ID: <20091118184152.GA6865@localhost.localdomain>
References: <1258255495.4209.3.camel@runt>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:51288 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758009AbZKRRlt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Nov 2009 12:41:49 -0500
Content-Disposition: inline
In-Reply-To: <1258255495.4209.3.camel@runt>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Sat, Nov 14, 2009 at 07:24:55PM -0800, Cory Maccarrone wrote:
> The omap850 and omap730 use 16-bit registers instead of 32-bit, requiring
> a modification of the register addresses in the mmc-omap driver.  To
> make this as portable as possible, I made the following changes:

Hmm, I would not trade portability anyone currently needs for complexity...

> * Moved register address offsets from drivers/mmc/host/omap.c to
>   drivers/mmc/host/omap.h
> * Implemented a lookup table for 16-bit and 32-bit register offsets
> * Added a reg_size field in the mmc_omap_host structure
> * Added code in mmc_omap_probe() to populate the reg_size
>   field based on processor in use
> * Added inline function to return the register offset based on
>   the register size and register name
> * Modified mmc-omap driver to use the new inline function to call out
>   register names

All this could be probably done by making register definition an index and
shifting it left by one or two depending on CPU. No lookup table needed.

> This change should allow the omap7xx-series of processors to correctly
> utilize the MMC driver.

Did you test it? It does not work on 5910, see here:
http://thread.gmane.org/gmane.linux.kernel.mmc/649

Best regards,
	ladis
