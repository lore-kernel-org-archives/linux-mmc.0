From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/4] dmaengine: add DMA_TRANS_NONE to dma_transfer_direction
Date: Tue, 13 Dec 2011 23:48:03 +0800
Message-ID: <1323791286-29574-2-git-send-email-shawn.guo@linaro.org>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44326 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1LMPkP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 10:40:15 -0500
In-Reply-To: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, Artem Bityutskiy <artem.bityutskiy@intel.com>
Cc: Huang Shijie <b32955@freescale.com>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Before dma_transfer_direction was introduced to replace
dma_data_direction, some dmaengine device uses DMA_NONE of
dma_data_direction for some talk with its client drivers.
The mxs-dma and its clients mxs-mmc and gpmi-nand are such case.

This patch adds DMA_TRANS_NONE to dma_transfer_direction and
migrate the DMA_NONE use in mxs-dma to it.

It also fixes the compile warning below.

CC      drivers/dma/mxs-dma.o
drivers/dma/mxs-dma.c: In function =E2=80=98mxs_dma_prep_slave_sg=E2=80=
=99:
drivers/dma/mxs-dma.c:420:16: warning: comparison between =E2=80=98enum=
 dma_transfer_direction=E2=80=99 and =E2=80=98enum dma_data_direction=E2=
=80=99

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/mxs-dma.c     |    2 +-
 include/linux/dmaengine.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index bdf4672..ff89211 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -417,7 +417,7 @@ static struct dma_async_tx_descriptor *mxs_dma_prep=
_slave_sg(
 		idx =3D 0;
 	}
=20
-	if (direction =3D=3D DMA_NONE) {
+	if (direction =3D=3D DMA_TRANS_NONE) {
 		ccw =3D &mxs_chan->ccw[idx++];
 		pio =3D (u32 *) sgl;
=20
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 5532bb8..679b349 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -88,6 +88,7 @@ enum dma_transfer_direction {
 	DMA_MEM_TO_DEV,
 	DMA_DEV_TO_MEM,
 	DMA_DEV_TO_DEV,
+	DMA_TRANS_NONE,
 };
=20
 /**
--=20
1.7.4.1

