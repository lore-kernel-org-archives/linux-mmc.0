From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2 0/2] patch set about the MXS-DMA
Date: Wed, 1 Feb 2012 10:21:35 +0800
Message-ID: <4F28A1AF.8040402@freescale.com>
References: <1327044818-4464-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:21571 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752987Ab2BACTx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 21:19:53 -0500
In-Reply-To: <1327044818-4464-1-git-send-email-b32955@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: vinod.koul@intel.com, shawn.guo@linaro.org, artem.bityutskiy@intel.com, shijie8@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, LW@KARO-electronics.de, alsa-devel@alsa-project.org, b29396@freescale.com

hi,
> patch 1: move the mxs dma header to a more common place.
> 	Beside the mx23/mx28, the apbh-dma is also used by MX50 and MX6Q.
> 	So move the mxs dma header file to a more common place, and rename
> 	it to mxs-dma.h
>
> patch 2: rewrite the last parameter of mxs_dma_prep_slave_sg().
> 	In the new GPMI version, some hardware behavior changes.
> 	The WAIT4END bit should be set in the middle one of the ECC READ page DMA chain.
> 	The DMA chain should be set like this:
>
>           +-----+               +-----+                      +-----+
>           | cmd | ------------> | cmd | ------------------>  | cmd |
>           +-----+               +-----+                      +-----+
>                                    ^                            ^
>                                    |                            |
>                                    |                            |
>                               set WAIT4END here too        set WAIT4END here
>
>         So rewrite the last parameter of mxs_dma_prep_slave_sg(), use the
> 	dma_ctrl_flags to set the proper DMA bit for DMA Command Structure.
> 	And change the relative drivers with the dma_ctrl_flags.
>
> TEST:
> 	Tested the mxs-mmc driver and gpmi-nand drive with the two patches
> 	in MX28 board.
>
> v1 --> v2:
> 	[1] squash the trial patches into single patch.
> 	[2] use the dma_ctrl_flags.
>
> Huang Shijie (2):
>   mxs-dma : move the mxs dma.h to a more common place
>   mxs-dma : rewrite the last parameter of mxs_dma_prep_slave_sg()
>
>  drivers/dma/mxs-dma.c                              |   34 +++++++++++++++++---
>  drivers/mmc/host/mxs-mmc.c                         |   12 +++---
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |   28 +++++++++++++---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    6 +++-
>  drivers/mtd/nand/gpmi-nand/gpmi-regs.h             |    2 +
>  .../include/mach/dma.h => include/linux/mxs-dma.h  |    0
>  sound/soc/mxs/mxs-pcm.c                            |    2 +-
>  sound/soc/mxs/mxs-pcm.h                            |    2 +-
>  sound/soc/mxs/mxs-saif.c                           |    2 +-
>  9 files changed, 67 insertions(+), 21 deletions(-)
>  rename arch/arm/mach-mxs/include/mach/dma.h => include/linux/mxs-dma.h (100%)
>
ping.


Could these two patches ok ?

My following patches depend upon them.


BR
Huang Shijie

