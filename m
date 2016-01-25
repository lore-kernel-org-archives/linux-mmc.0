From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 8/9] mmc: tmio: disable clock before changing it
Date: Mon, 25 Jan 2016 20:15:15 +0100
Message-ID: <1453749316-1848-9-git-send-email-wsa@the-dreams.de>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33086 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757953AbcAYTP3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jan 2016 14:15:29 -0500
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Rcar2 & 3 docs state that for going to and coming from the 0xff setting,
the clock must first be disabled before the DIV bits are changed.
Instead of tracking this, let's just do this unconditionally.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 7f6b5adf12094b..03f6e74c190691 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -174,6 +174,8 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	if (host->set_clk_div)
 		host->set_clk_div(host->pdev, (clk >> 22) & 1);
 
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
 		msleep(10);
-- 
2.1.4

