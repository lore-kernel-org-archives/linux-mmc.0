Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF7C43460
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Apr 2021 06:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364F0613CB
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Apr 2021 06:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhDYGDR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Apr 2021 02:03:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58450 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDYGDQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Apr 2021 02:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619330556; x=1650866556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hx30ht37sMZVxflv2s8pvO57hw8ECCLQpz04Uv49N8U=;
  b=GnNxBAQ0nVak+l/N1ZN3eyTCwjR7coe11XYGywTvIqYJ8ZD+ewcaHx/e
   0ROelrdhwXbRhuuGBWN5BCyywq8kvhDyAEUoVd+Onxbw5v4rB1xRrtIcb
   clKStt6oek/58M6egGObvnL/DwbSfy1AdjUvl9ih2Cd6SeLo96TUUvxOq
   HDR5E/o/8LlpR3Bcc0L1tHtv0UwQjpCQDyALokD98bi/CJE5S7/UMdbKV
   XsdFtwuGuXhtljHhLgb2w+UBvT3tpDMqUqvQQ6wGkkUV6T4QFcpPPmYOC
   a7cpfdBCUjJa9KGnXqrEfpUsKcrTV68TrbFsCGr/LUG+d41d7MSR7YP/E
   A==;
IronPort-SDR: JuVSYZrZOBalJ8Ftdy/0SS3fHvbwmrJu0SJqmd9+sCEXFzEe00la07oNt4YeumWAqlTU/8Ea0D
 J70lph0OcIUrhdK/WluNqYHbljTl3X+nW0fwLLHHhDg6K/NniskJ5JJstrPSVjqtZORJqKB5FT
 SmKXmJ02xFBqhN9nWt32fF9xLwX8SAe+eAEHXroNiGoNppCSDJjDVEFM73XUBxkn+QBPqrPtrT
 yO6qT4IZ74GhEg9O7QcC9RE5dIPrzhSRXRX/Zbs6mqelYkgpnYNtKnFRFb2tFDA4nXkNvjFpQq
 grk=
X-IronPort-AV: E=Sophos;i="5.82,249,1613404800"; 
   d="scan'208";a="170725277"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2021 14:02:34 +0800
IronPort-SDR: zHtgrXGP9zoufu7aI74LBT0Se3NyGuFfGkE16xGIXgJ1B9gveOCfx+nfzCVG2xTnCT9S/PcMnc
 J9iSlx53G3BFUEhgGsFUi4Mt6elLhZvIt+mXigha2ZJQ6csvqUeVIRAcp4ABHbWDEAhyCoG0uk
 E95IQSwzzVyIgpJALCS6CCgZQrB+L6E6k/wbdrCwhNFKuastCaw8+qKWpvlfZoOuu4FazuyuDN
 DXg7L+z1or2gnitxahNbUcBVXCmrem5d9aojlKOZSRWuxrzlNAvYH9MvrE1YRRPJ5+qN/tGVm1
 jU0MAhayIs3FVXosmpVzo6Ho
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 22:41:31 -0700
IronPort-SDR: uVJD+yqQXC4HA/gPjk7uVvJMUAhI/DSmoRWUELE8FeHm+GW3Gx2JBlAbihfL9rlRHQzNR5M0Vt
 UtT3kZ6VHQO0TAd4b91qlT1xw+5yykZ3cbZcBX2VWCxkmoHoF1vvEnmdtXQl0lLKHAiK+PwApY
 noWoiS8N9715Me89/W19hW16Iv4iMcL8FRCwVVbamyBKzOmZn27g8/VIGJ3ULKYsoeQBKbKPyG
 +PKAQ+SR1oAHBnODUMvWqREQ8SB6zxvzlp81El7W2k01xWHmnVt+ZwOSwSdAqahZFoWGTZC0zF
 vTs=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Apr 2021 23:02:33 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 1/2] mmc: Add cache_enabled bus ops
Date:   Sun, 25 Apr 2021 09:02:06 +0300
Message-Id: <20210425060207.2591-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210425060207.2591-1-avri.altman@wdc.com>
References: <20210425060207.2591-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a new bus ops callback ->cache_enabled() and implement it for the
mmc bus type.

From the mmc block layer point of view, it would then mean that if the
callback isn't implemented, the cache ctrl isn't supported (which
would be the case for SD then).

Going forward, newer SD cards support both cache and command queueing
nowadays, which means that we need to make the code in the mmc block
layer more agnostic. To do that, we should use the bus_ops callbacks,
e.g. adding the ->flush_cache() callback in the near future.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.h    | 9 +++++++++
 drivers/mmc/core/mmc.c     | 7 +++++++
 drivers/mmc/core/mmc_ops.c | 4 +---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 8032451abaea..db3c9c68875d 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -29,6 +29,7 @@ struct mmc_bus_ops {
 	int (*shutdown)(struct mmc_host *);
 	int (*hw_reset)(struct mmc_host *);
 	int (*sw_reset)(struct mmc_host *);
+	bool (*cache_enabled)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -163,4 +164,12 @@ static inline void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 		host->ops->post_req(host, mrq, err);
 }
 
+static inline bool mmc_cache_enabled(struct mmc_host *host)
+{
+	if (host->bus_ops->cache_enabled)
+		return host->bus_ops->cache_enabled(host);
+
+	return false;
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d35231feac68..8674c3e0c02c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2029,6 +2029,12 @@ static void mmc_detect(struct mmc_host *host)
 	}
 }
 
+static bool _mmc_cache_enabled(struct mmc_host *host)
+{
+	return host->card->ext_csd.cache_size > 0 &&
+	       host->card->ext_csd.cache_ctrl & 1;
+}
+
 static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 {
 	int err = 0;
@@ -2208,6 +2214,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
 	.hw_reset = _mmc_hw_reset,
+	.cache_enabled = _mmc_cache_enabled,
 };
 
 /*
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index cdf02d88fe92..5756781fef37 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -968,9 +968,7 @@ int mmc_flush_cache(struct mmc_card *card)
 {
 	int err = 0;
 
-	if (mmc_card_mmc(card) &&
-			(card->ext_csd.cache_size > 0) &&
-			(card->ext_csd.cache_ctrl & 1)) {
+	if (mmc_cache_enabled(card->host)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
 				 MMC_CACHE_FLUSH_TIMEOUT_MS);
-- 
2.25.1

