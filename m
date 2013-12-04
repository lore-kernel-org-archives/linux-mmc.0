From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 0/7] mmc: omap: Fixes, cleanup and add ERASE capability
Date: Wed,  4 Dec 2013 21:14:07 +0000
Message-ID: <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
References: <20131202193459.GL26766@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20131202193459.GL26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Lavinen <j.lavinen@samsung.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

Hi

I've sent these patches earlier to linux-mmc list. This time set is one
patch smaller since commit 31ee9181eb92
("mmc: omap: Fix DMA configuration to not rely on device id") does
practically same what one of my patch did.

Patch 1 is an obvious fix. 2-4 are preparing for 5 which also should fix
the error introduced by 31ee9181eb92:
http://www.spinics.net/lists/linux-omap/msg100790.html

Patch 6 continue cleanup and 7 adds the ERASE capability to the driver so
one could utilize discards with mkfs, mount option or with the fstrim.

Set goes on top of v3.13-rc2-208-g8ecffd791448.

Jarkko Nikula (7):
  mmc: omap: Fix NULL pointer dereference due uninitialized
    cover_tasklet
  mmc: omap: Convert to devm_kzalloc
  mmc: omap: Remove duplicate host->irq assignment
  mmc: omap: Remove mem_res field from struct mmc_omap_host
  mmc: omap: Convert to devm_ioremap_resource
  mmc: omap: Remove always set use_dma flag from struct mmc_omap_host
  mmc: omap: Add erase capability

 drivers/mmc/host/omap.c | 93 +++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 57 deletions(-)

-- 
1.8.4.3

