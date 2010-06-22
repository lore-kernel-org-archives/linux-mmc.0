From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 02/12] mmci: fix multi block transfers
Date: Tue, 22 Jun 2010 14:47:37 +0530
Message-ID: <1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:47734 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759094Ab0FVJSu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:18:50 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

Fix the data transfer size to allow multi block transfers to work.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 683516b..84d782b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -120,7 +120,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		data->blksz, data->blocks, data->flags);
 
 	host->data = data;
-	host->size = data->blksz;
+	host->size = data->blksz * data->blocks;
 	host->data_xfered = 0;
 
 	mmci_init_sg(host, data);
-- 
1.7.0

