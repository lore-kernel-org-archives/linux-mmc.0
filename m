Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A511C04FE1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Jul 2023 14:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjGYOUw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Jul 2023 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGYOUu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jul 2023 10:20:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FEA2697;
        Tue, 25 Jul 2023 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690294648;
        bh=6N3Sq6NeH6BbaiavR7O3xkbcCrkvZ1yXDKwPR9c54IU=;
        h=From:Date:Subject:To:Cc:From;
        b=hZ4Dq9Jty0CBm1B7i/IztsQxrb73cmHBaM0NYBp6fvT7DGdtx4mBfmmMS14ZkvrRv
         ppxfYAfBsRvn6Ys+FkI1lEnTclH/udPHoMyCawp4j4ds11iUF4x6qMKGIwe6MQaCPy
         S2JRsDZ8eJaxyi3f7dj4asyV+jEMrXaeyLkATuVY=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 25 Jul 2023 16:17:25 +0200
Subject: [PATCH] mmc: core: propagate removable attribute to driver core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230725-mmc-removable-v1-1-b2e0c4f18e6d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHTZv2QC/x3MQQqAIBBA0avIrBPMsKirRAvTsQZSQ0EC6e5Jy
 7f4v0LGRJhhYRUSFsoUQ0PfMTCnDgdyss0ghRzEJBX33vCEPha9X8iVcdboGa0YJbTmTujo+X/
 r9r4fQjtuzl8AAAA=
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690294647; l=1153;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6N3Sq6NeH6BbaiavR7O3xkbcCrkvZ1yXDKwPR9c54IU=;
 b=ccSN6txL/80O9P0/RQTEBgYopVxGhLEMhnyOhucPYN3wxQW7b+nj4Az6lPuzFezzvZvisQThA
 DTD/f6hfMyGC1EklsVkc0zaRopPw7Ki5/6PnPxDhwo+zFkoxk0MG8db
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Userspace can use this to distinguish hotpluggable mmc devices such as
sdcards from non-hotpluggable ones such as eMMC.
One example is the lsblk tool from util-linux.

Note that dev_set_removable() is not related to GENHD_FL_REMOVABLE which
is not applicable as per the comment in drivers/mmc/core/block.c

Link: https://github.com/util-linux/util-linux/issues/2379
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/mmc/core/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 2c3074a605fc..0af96548e7da 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -310,6 +310,9 @@ int mmc_add_card(struct mmc_card *card)
 
 
 	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), card->rca);
+	dev_set_removable(&card->dev,
+			  mmc_card_is_removable(card->host) ?
+			  DEVICE_REMOVABLE : DEVICE_FIXED);
 
 	switch (card->type) {
 	case MMC_TYPE_MMC:

---
base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
change-id: 20230725-mmc-removable-5cfdca9ed062

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

