From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 04/25] mmc: core: report tuning command execution failure
 reason
Date: Tue, 26 Jan 2016 13:39:29 +0000
Message-ID: <E1aO3qD-0005ht-4k@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36823 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965129AbcAZNje (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:39:34 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Print the error code when the tuning command fails.  This allows the
reason for the failure to be reported, which aids debugging.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c4b95a5d7299..cfb5281b6cd7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1079,7 +1079,7 @@ int mmc_execute_tuning(struct mmc_card *card)
 	err = host->ops->execute_tuning(host, opcode);
 
 	if (err)
-		pr_err("%s: tuning execution failed\n", mmc_hostname(host));
+		pr_err("%s: tuning execution failed: %d\n", mmc_hostname(host), err);
 	else
 		mmc_retune_enable(host);
 
-- 
2.1.0

