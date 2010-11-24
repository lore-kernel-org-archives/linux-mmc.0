From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/5 v2] ARM: mach-shmobile: add DMA defines for MMCIF on
 sh7372
Date: Wed, 24 Nov 2010 11:05:15 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011241051260.18622@axis700.grange>
References: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Add DMA slave IDs and slave definitions for MMCIF on sh7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: no change

 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 ++
 arch/arm/mach-shmobile/setup-sh7372.c        |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index e4f9004..5736efc 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -455,6 +455,8 @@ enum {
 	SHDMA_SLAVE_SDHI1_TX,
 	SHDMA_SLAVE_SDHI2_RX,
 	SHDMA_SLAVE_SDHI2_TX,
+	SHDMA_SLAVE_MMCIF_RX,
+	SHDMA_SLAVE_MMCIF_TX,
 };
 
 extern struct clk sh7372_extal1_clk;
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 564a6d0..2e3e11e 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -416,6 +416,16 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 		.addr		= 0xe6870030,
 		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
 		.mid_rid	= 0xce,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+		.addr		= 0xe6bd0034,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+		.addr		= 0xe6bd0034,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd2,
 	},
 };
 
-- 
1.7.2.3

