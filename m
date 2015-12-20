From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 19/17] mmc: sdhci: fix data timeout (part 1)
Date: Sun, 20 Dec 2015 08:27:00 +0000
Message-ID: <E1aAZKW-0000E3-6j@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:37191 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbbLTI1K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Dec 2015 03:27:10 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

The data timeout gives the minimum amount of time that should be
waited before timing out if no data is received from the card.
Simply dividing the nanosecond part by 1000 does not give this
required guarantee, since such a division rounds down.  Use
DIV_ROUND_UP() to give the desired timeout.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ecac99ae7e2..82e799fde113 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -630,7 +630,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	if (!data)
 		target_timeout = cmd->busy_timeout * 1000;
 	else {
-		target_timeout = data->timeout_ns / 1000;
+		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
 		if (host->clock)
 			target_timeout += data->timeout_clks / host->clock;
 	}
-- 
2.1.0

