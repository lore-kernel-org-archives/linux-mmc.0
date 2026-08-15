Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576E31327D
	for <linux-mmc@vger.kernel.org>; Sat, 15 Aug 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781430; cv=none; b=h8f559v+1i4WrZUsv7HUASmkw6EXMcezo9fLhZZb7bjQdTF/b4NjYPGdfui1sf7JkiP65wWyAJAHAOnEwpHqlc/8fghEeM8rk2ZDYF1S4LQE1fry/zlkVgCUWysoFYX6TAMa50VCBTgmjghXTOpWlzXvagXOgpW+dSrkkpShglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781430; c=relaxed/simple;
	bh=66oio1iBquwMzpKVN5vCKfaA1boxE8tRsNBeCsYxuJE=;
	h=Message-Id:From:Date:Subject:To:Cc; b=HBGMCWzv8DSVqU9DcHi5H++gnzui3+maxziwESWUoyv//UAC8u7qNAEgNs/KSfLOG0S9yzhoY0qNWYY3OP54650NWRqte8FAZruGmujIroSRYGeAnGHKB3d0meGZQJms7mVqQelIavabDHuuCWkPH9lOVQJwO6wMnB6VEj8yKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 8845EC3B;
	Sat, 15 Aug 2026 10:10:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 540936198889; Sat, 15 Aug 2026 10:10:26 +0200 (CEST)
Message-Id: <f20e08ef831f0bad278adcec44046742b54ab648.1786781008.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 15 Aug 2026 10:10:29 +0200
Subject: [PATCH] mmc: rtsx_pci: Cope with hot-removal of MMC host
To: Ulf Hansson <ulfh@kernel.org>, Ricky Wu <ricky_wu@realtek.com>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, Matthew Schwartz <matthew.schwartz@linux.dev>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-mmc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Derek reports a lockup on hot-removal of a PCI-attached Realtek RTS525A
MMC host if a card is inserted.  He has root-caused it to the block
layer being unaware of the hot-removal and waiting indefinitely in
sync_filesystem().

For comparison, the NVMe subsystem copes with hot-removal by setting the
controller state to NVME_CTRL_DEAD in nvme_remove(), which in turn leads
to blk_mark_disk_dead() being called from nvme_mark_namespaces_dead().
That avoids the indefinite wait in sync_filesystem().

Adopt this approach:  Detect hot-removal in rtsx_pci_sdmmc_drv_remove()
and invoke a new mmc_host_set_removed() helper which in turn invokes
mmc_card_set_removed().  Before flushing outstanding requests to the
card in mmc_blk_remove_req(), check for its removal and call
blk_mark_disk_dead().

Note that mmc_card_set_removed() cannot be called from the MMC host
driver because it is private to the MMC core, hence the indirection
through the newly introduced mmc_host_set_removed() helper.

Other removable MMC hosts, in particular if attached via PCI or USB,
may need to be amended with a similar check for hot-removal.  The
present commit seeks to get that process going.

Reported-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Closes: https://lore.kernel.org/r/20260806214808.1202819-1-derekjohn.clark@gmail.com/
Link: https://github.com/ValveSoftware/SteamOS/issues/2473
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/mmc/core/block.c          | 11 +++++++----
 drivers/mmc/core/host.c           | 15 +++++++++++++++
 drivers/mmc/host/rtsx_pci_sdmmc.c |  3 +++
 include/linux/mmc/host.h          |  1 +
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0274e8d..1a82233 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2978,8 +2978,11 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 	return 0;
 }
 
-static void mmc_blk_remove_req(struct mmc_blk_data *md)
+static void mmc_blk_remove_req(struct mmc_card *card, struct mmc_blk_data *md)
 {
+	if (mmc_card_removed(card))
+		blk_mark_disk_dead(md->disk);
+
 	/*
 	 * Flush remaining requests and free queues. It is freeing the queue
 	 * that stops new requests from being accepted.
@@ -3006,7 +3009,7 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
 	list_for_each_safe(pos, q, &md->part) {
 		part_md = list_entry(pos, struct mmc_blk_data, part);
 		list_del(pos);
-		mmc_blk_remove_req(part_md);
+		mmc_blk_remove_req(card, part_md);
 	}
 }
 
@@ -3252,7 +3255,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 
 out:
 	mmc_blk_remove_parts(card, md);
-	mmc_blk_remove_req(md);
+	mmc_blk_remove_req(card, md);
 out_free:
 	destroy_workqueue(card->complete_wq);
 	return ret;
@@ -3273,7 +3276,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 	if (!mmc_card_sd_combo(card))
 		pm_runtime_disable(&card->dev);
 	pm_runtime_put_noidle(&card->dev);
-	mmc_blk_remove_req(md);
+	mmc_blk_remove_req(card, md);
 	destroy_workqueue(card->complete_wq);
 }
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce313..2625d91 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -22,6 +22,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/slot-gpio.h>
 
+#include "card.h"
 #include "core.h"
 #include "crypto.h"
 #include "host.h"
@@ -703,3 +704,17 @@ void mmc_free_host(struct mmc_host *host)
 }
 
 EXPORT_SYMBOL(mmc_free_host);
+
+/**
+ *	mmc_host_set_removed - declare host removed
+ *	@host: mmc host
+ *
+ *	Declare the host (and any inserted card) removed and inaccessible.
+ */
+void mmc_host_set_removed(struct mmc_host *host)
+{
+	if (host->card)
+		mmc_card_set_removed(host->card);
+}
+
+EXPORT_SYMBOL(mmc_host_set_removed);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 8dfbc62..3f97659f 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1511,6 +1511,9 @@ static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
 	mmc = host->mmc;
 
+	if (pci_dev_is_disconnected(pcr->pci))
+		mmc_host_set_removed(mmc);
+
 	cancel_work_sync(&host->work);
 
 	mutex_lock(&host->host_mutex);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02..a240306 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -588,6 +588,7 @@ struct mmc_host {
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
+void mmc_host_set_removed(struct mmc_host *host);
 void mmc_of_parse_clk_phase(struct device *dev,
 			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
-- 
2.53.0

