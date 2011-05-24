From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] sh: mark DMA slave ID 0 as invalid
Date: Tue, 24 May 2011 12:23:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105241210000.31628@axis700.grange>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-mmc@vger.kernel.org

This makes it possible to leave DMA slave IDs in the platform data
at default 0 value without hitting DMA channel allocation error paths.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/include/cpu-sh4/cpu/sh7722.h |    1 +
 arch/sh/include/cpu-sh4/cpu/sh7724.h |    1 +
 arch/sh/include/cpu-sh4/cpu/sh7757.h |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7722.h b/arch/sh/include/cpu-sh4/cpu/sh7722.h
index 7a5b8a3..bd06227 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7722.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7722.h
@@ -236,6 +236,7 @@ enum {
 };
 
 enum {
+	SHDMA_SLAVE_INVALID,
 	SHDMA_SLAVE_SCIF0_TX,
 	SHDMA_SLAVE_SCIF0_RX,
 	SHDMA_SLAVE_SCIF1_TX,
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
index 7eb4359..3daef8e 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
@@ -285,6 +285,7 @@ enum {
 };
 
 enum {
+	SHDMA_SLAVE_INVALID,
 	SHDMA_SLAVE_SCIF0_TX,
 	SHDMA_SLAVE_SCIF0_RX,
 	SHDMA_SLAVE_SCIF1_TX,
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7757.h b/arch/sh/include/cpu-sh4/cpu/sh7757.h
index 05b8196..41f9f8b 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7757.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7757.h
@@ -252,6 +252,7 @@ enum {
 };
 
 enum {
+	SHDMA_SLAVE_INVALID,
 	SHDMA_SLAVE_SDHI_TX,
 	SHDMA_SLAVE_SDHI_RX,
 	SHDMA_SLAVE_MMCIF_TX,
-- 
1.7.2.5

