From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 20/17] mmc: sdhci: fix data timeout (part 2)
Date: Sun, 20 Dec 2015 08:27:05 +0000
Message-ID: <E1aAZKb-0000EF-Br@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:37197 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbbLTI1O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Dec 2015 03:27:14 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

The calculation for the timeout based on the number of card clocks is
incorrect.  The calculation assumed:

	timeout in microseconds = clock cycles / clock in Hz

which is clearly a several orders of magnitude wrong.  Fix this by
multiplying the clock cycles by 1000000 prior to dividing by the Hz
based clock.  Also, as per part 1, ensure that the division rounds
up.

As this needs 64-bit math via do_div(), avoid it if the clock cycles
is zero.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 82e799fde113..65b230ea179e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -631,8 +631,19 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		target_timeout = cmd->busy_timeout * 1000;
 	else {
 		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
-		if (host->clock)
-			target_timeout += data->timeout_clks / host->clock;
+		if (host->clock && data->timeout_clks) {
+			unsigned long long val;
+
+			/*
+			 * data->timeout_clks is in units of clock cycles.
+			 * host->clock is in Hz.  target_timeout is in us.
+			 * Hence, us = 1000000 * cycles / Hz.  Round up.
+			 */
+			val = 1000000 * data->timeout_clks;
+			if (do_div(val, host->clock))
+				target_timeout++;
+			target_timeout += val;
+		}
 	}
 
 	/*
-- 
2.1.0

