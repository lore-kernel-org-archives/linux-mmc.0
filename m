From: Simon Horman <simon@horms.net>
Subject: Re: [patch 3/3] mmc, ARM: Add zboot from MMC support for SuperH
 Mobile ARM
Date: Mon, 6 Dec 2010 09:44:52 +0900
Message-ID: <20101206004452.GA30296@verge.net.au>
References: <20101206001243.949375995@vergenet.net>
 <20101206001310.825497890@vergenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101206001310.825497890@vergenet.net>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 06, 2010 at 09:12:46AM +0900, Simon Horman wrote:
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
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> --- 
> 
> This patch depends on "ARM: 6514/1: mach-shmobile: Add zboot support for
> SuperH Mobile ARM" which has been merged into the devel branch
> of Russell King's linux-2.6-arm tree.

This patch also depends on the previous two patches in this series.

