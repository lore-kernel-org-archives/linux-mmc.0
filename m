From: <sean.wang@mediatek.com>
Subject: [PATCH v1 3/4] Bluetooth: btmtksdio: Fix hdev->stat.byte_rx accumulation
Date: Thu, 18 Apr 2019 17:08:01 +0800
Message-ID: <ea8d491b7e737a51a6cfbc6d9078ba98012b0e66.1555577565.git.sean.wang@mediatek.com>
References: <cover.1555577565.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1555577565.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: ulf.hansson@linaro.org, linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Accumulate hdev->stat.byte_rx only for valid packets as btmtkuart doing.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 9c123a9de673..877c0a831775 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -391,8 +391,6 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	if (err < 0)
 		goto err_kfree_skb;
 
-	bdev->hdev->stat.byte_rx += rx_size;
-
 	sdio_hdr = (void *)skb->data;
 
 	/* We assume the default error as -EILSEQ simply to make the error path
@@ -457,6 +455,8 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	/* Complete frame */
 	(&pkts[i])->recv(bdev->hdev, skb);
 
+	bdev->hdev->stat.byte_rx += rx_size;
+
 	return 0;
 
 err_kfree_skb:
-- 
2.18.0
