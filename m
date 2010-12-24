From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch v3] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
Date: Fri, 24 Dec 2010 13:15:54 +0900
Message-ID: <20101224041553.GA9152@linux-sh.org>
References: <1292137027-17779-1-git-send-email-horms@verge.net.au> <1291855635-30882-1-git-send-email-horms@verge.net.au> <20101222224901.GA16187@verge.net.au> <20101222230450.GA21134@verge.net.au> <1291855635-30882-1-git-send-email-horms@verge.net.au> <20101208221653.GA25239@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:43300 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0LXERa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2010 23:17:30 -0500
Content-Disposition: inline
In-Reply-To: <1292137027-17779-1-git-send-email-horms@verge.net.au> <20101222230450.GA21134@verge.net.au> <1291855635-30882-1-git-send-email-horms@verge.net.au> <20101208221653.GA25239@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>

On Thu, Dec 09, 2010 at 07:16:53AM +0900, Simon Horman wrote:
> This allows a ROM-able zImage to be written to MMC and
> for SuperH Mobile ARM to boot directly from the MMCIF
> hardware block.
> 
> This is achieved by the MaskROM loading the first portion
> of the image into MERAM and then jumping to it. This portion
> contains loader code which copies the entire image to SDRAM
> and jumps to it. From there the zImage boot code proceeds
> as normal, uncompressing the image into its final location
> and then jumping to it.
> 
> This patch depends on:
> * "ARM: 6514/1: mach-shmobile: Add zboot support for SuperH Mobile ARM"
>   which has been merged into the devel branch of Russell King's
>   linux-2.6-arm tree.
> * "mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h"
>   which has been merged into the common/mmcif branch of
>   Paul Mundt's sh-2.6 tree
> * "mmc, sh: Remove sh_mmcif_boot_slurp()"
>   which has been merged into the common/mmcif branch of
>   Paul Mundt's sh-2.6 tree

This one at least should go through Russell's tree. The dependencies from
my side will be sorted out early in the merge window, so you should be
able to submit this to Russell's patch tracker after that for a late -rc1
merge, or for -rc2. After that's done, there don't seem to be any more
outstanding dependencies, so at that point I'll be able to take care of
the remaining patches.
