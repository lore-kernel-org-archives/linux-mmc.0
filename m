From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/5] mmc: sdhi: Allow waiting for idle
Date: Mon, 20 Jun 2011 15:06:50 +0900
Message-ID: <1308550015-15717-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Some SDHI controllers require waiting for the SD bus to become
idle before writing to some registers. This series allows
this to occur by:
	* ensuring all relevant accesses are made via sd_ctrl_write16()
	* Adding a hook to sd_ctrl_write16()
	* Supplying a hook that implements waiting for idle

The series also includes some clean-ups of related code.

The first three patches are intended for the mmc tree
	* [PATCH 1/5] mmc: tmio: name 0xd8 as CTL_DMA_ENABLE
	* [PATCH 2/5] mmc: tmio: Share register access functions
	* [PATCH 3/5] mmc: sdhi: Add write16_hook

The remaining two patches are intended for the rmobile tree
	* [PATCH 4/5] ARM: mach-shmobile: ag5evm: consistently name sdhi info
	* [PATCH 5/5] ARM: mach-shmobile: ag5evm: SDHI requires waiting for

I am not aware of any dependencies on patches outside this series.
Dependencies on patches within the series are noted inline.

