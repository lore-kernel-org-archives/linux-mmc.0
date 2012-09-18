From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ARM: shmobile: fix MMCIF IRQ assignment on kzm9g
Date: Wed, 19 Sep 2012 00:52:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1209190042440.31203@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Tetsuyuki Kobayashi <koba@kmckk.co.jp>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Error and operation IRQs are swapped in kzm9g platform data, this patch
fixes their order. The only problem this bug causes is the confusing IRQ 
count in /proc/interrupts output, otherwise functionality is unaffected, 
since the driver doesn't really differentiate between the two IRQs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

The error is easy to see in /proc/interrupts output, kota2 has the correct 
IRQ assignment, ag5evm has the same problem, as kzm9g, so, it might need 
fixing too. I certainly could cook up a similar trivial patch for it, but 
someone will have to test it.

 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 29cca80..21c90c4 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -346,11 +346,11 @@ static struct resource sh_mmcif_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(141),
+		.start	= gic_spi(140),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start	= gic_spi(140),
+		.start	= gic_spi(141),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.2.5

