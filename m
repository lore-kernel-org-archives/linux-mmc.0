From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/9 v2] SH: add DMA slaves for two SDHI controllers to sh7722
Date: Tue, 4 May 2010 16:06:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005041353450.4925@axis700.grange>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932307Ab0EDOGU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 May 2010 10:06:20 -0400
In-Reply-To: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>

SuperH SDHI controllers can use DMA, add slave definitions to sh7722.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

SDHI slave IDs have already been defined by patch 1/9 from this series

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 5ea2d03..d292170 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -74,6 +74,16 @@ static const struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
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

