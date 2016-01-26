From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 21/25] mmc: sdhci: fix data timeout (part 1)
Date: Tue, 26 Jan 2016 13:40:58 +0000
Message-ID: <E1aO3re-0005jh-W2@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36923 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbcAZNpM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:45:12 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

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
index 5e249360a108..7fa9b2e8cfb2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -633,7 +633,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
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

