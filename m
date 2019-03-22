From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 01/25] mmc: pwrseq: constify mmc_pwrseq_ops structures
Date: Fri, 22 Mar 2019 16:43:52 +0100
Message-ID: <20190322154425.3852517-2-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Tobin C. Harding" <me@tobin.cc>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The mmc_pwrseq_ops structures are never modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit ffedbd2210f2f4cba490a9205adc11fd1b89a852)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/pwrseq.h        | 2 +-
 drivers/mmc/core/pwrseq_emmc.c   | 2 +-
 drivers/mmc/core/pwrseq_simple.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index 096da48c6a7e..133de0426687 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -16,7 +16,7 @@ struct mmc_pwrseq_ops {
 };
 
 struct mmc_pwrseq {
-	struct mmc_pwrseq_ops *ops;
+	const struct mmc_pwrseq_ops *ops;
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index ad4f94ec7e8d..4a82bc77fe49 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -51,7 +51,7 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *host)
 	kfree(pwrseq);
 }
 
-static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
+static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
 	.post_power_on = mmc_pwrseq_emmc_reset,
 	.free = mmc_pwrseq_emmc_free,
 };
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index d10538bb5e07..2b16263458af 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -87,7 +87,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 	kfree(pwrseq);
 }
 
-static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
+static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
 	.post_power_on = mmc_pwrseq_simple_post_power_on,
 	.power_off = mmc_pwrseq_simple_power_off,
-- 
2.20.0
