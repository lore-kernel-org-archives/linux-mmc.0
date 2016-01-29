From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 22/25] mmc: sdhci: fix data timeout (part 2)
Date: Fri, 29 Jan 2016 09:45:41 +0000
Message-ID: <E1aP5cb-0001qk-8Y@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44256 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbcA2Jpp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:45:45 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

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
index 48bc0c6b74f7..60ec6b5f5600 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -634,8 +634,19 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
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

