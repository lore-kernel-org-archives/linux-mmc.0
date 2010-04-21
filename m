From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/8] SH: add DMA slave IDs for two SDHI controllers, add
 slaves to sh7722
Date: Wed, 21 Apr 2010 17:36:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004211732340.5292@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

SuperH SDHI controllers can use DMA, add slave IDs to the header and slave
definitions to sh7722.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/include/asm/dmaengine.h        |    4 ++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   10 ++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/dmaengine.h
index 2a02b61..876e601 100644
--- a/arch/sh/include/asm/dmaengine.h
+++ b/arch/sh/include/asm/dmaengine.h
@@ -29,6 +29,10 @@ enum {
 	SHDMA_SLAVE_SIUA_RX,
 	SHDMA_SLAVE_SIUB_TX,
 	SHDMA_SLAVE_SIUB_RX,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI1_TX,
 };
 
 #endif
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index fe28f52..7f78cc2 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -75,6 +75,16 @@ static const struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
 		.addr		= 0xa454c094,
 		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
 		.mid_rid	= 0xb6,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
+		.addr		= 0x04ce0030,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
+		.addr		= 0x04ce0030,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc2,
 	},
 };
 
-- 
1.6.2.4

