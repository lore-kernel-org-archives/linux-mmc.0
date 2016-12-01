From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 1/2] mmc: sdhci: continue normal tuning if unsupported by platform tuning
Date: Thu,  1 Dec 2016 12:36:05 +0900
Message-ID: <1480563366-7259-2-git-send-email-yamada.masahiro@socionext.com>
References: <1480563366-7259-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480563366-7259-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Some SDHCI-compat controllers support not only SD, but also eMMC,
but they use different commands for tuning: CMD19 for SD, CMD21 for
eMMC.

Due to the difference of the underlying mechanism, some controllers
(at least, the Cadence IP is the case) provide their own registers
for the eMMC tuning.

This commit will be useful when we want to use platform-specific
tuning (to support eMMC HS200), but still let it reuse the code
provided by sdhci_execute_tuning() for SD timing.

If sdhci_ops::platform_execute_tuning receives a timing it does not
take care of, it can return -ENOTSUPP.  Then, it will fall back to
the SDHCI standard tuning.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I want to use this in the next commit.

The Cadence IP supports eMMC as well as SD.

The tuning for SD is pretty simple; just set the "Execute Tuning" bit
of the HOST_CONTROL2 register.  So, I can re-use the
sdhci_execute_tuning().

On the other hand, Cadence provides its own way for eMMC HS200 tuning;
I need to touch some registers that are specific to Cadence's design.


Changes in v2: None

 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 42ef3eb..cdce489 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2004,7 +2004,9 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (host->ops->platform_execute_tuning) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		err = host->ops->platform_execute_tuning(host, opcode);
-		return err;
+		if (err != -ENOTSUPP)
+			return err;
+		spin_lock_irqsave(&host->lock, flags);
 	}
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-- 
2.7.4
