From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 04/24] mmc: core: report tuning command execution failure
 reason
Date: Mon, 21 Dec 2015 11:40:41 +0000
Message-ID: <E1aAypV-000167-QN@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39680 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbLULkw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:40:52 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Print the error code when the tuning command fails.  This allows the
reason for the failure to be reported, which aids debugging.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e698c08c7a67..a88fccb6ffe9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1085,7 +1085,7 @@ int mmc_execute_tuning(struct mmc_card *card)
 	err = host->ops->execute_tuning(host, opcode);
 
 	if (err)
-		pr_err("%s: tuning execution failed\n", mmc_hostname(host));
+		pr_err("%s: tuning execution failed: %d\n", mmc_hostname(host), err);
 	else
 		mmc_retune_enable(host);
 
-- 
2.1.0

