From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 03/25] mmc: pwrseq_simple: Make reset-gpios optional to match doc
Date: Fri, 22 Mar 2019 16:43:54 +0100
Message-ID: <20190322154425.3852517-4-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "Tobin C. Harding" <me@tobin.cc>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Martin Fuzzey <mfuzzey@parkeon.com>

The DT binding doc says reset-gpios is an optional property but the code
currently bails out if it is omitted.

This is a regression since it breaks previously working device trees.
Fix it by restoring the original documented behaviour.

Fixes: ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 64a67d4762ce3ce4c9466eadd152d825fbf84967)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/pwrseq_simple.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 2b16263458af..aba786daebca 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -29,15 +29,18 @@ struct mmc_pwrseq_simple {
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 					      int value)
 {
-	int i;
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
-	int values[reset_gpios->ndescs];
 
-	for (i = 0; i < reset_gpios->ndescs; i++)
-		values[i] = value;
+	if (!IS_ERR(reset_gpios)) {
+		int i;
+		int values[reset_gpios->ndescs];
 
-	gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
-				       values);
+		for (i = 0; i < reset_gpios->ndescs; i++)
+			values[i] = value;
+
+		gpiod_set_array_value_cansleep(
+			reset_gpios->ndescs, reset_gpios->desc, values);
+	}
 }
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
@@ -79,7 +82,8 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
-	gpiod_put_array(pwrseq->reset_gpios);
+	if (!IS_ERR(pwrseq->reset_gpios))
+		gpiod_put_array(pwrseq->reset_gpios);
 
 	if (!IS_ERR(pwrseq->ext_clk))
 		clk_put(pwrseq->ext_clk);
@@ -112,7 +116,9 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
 	}
 
 	pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(pwrseq->reset_gpios)) {
+	if (IS_ERR(pwrseq->reset_gpios) &&
+	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
+	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
 		ret = PTR_ERR(pwrseq->reset_gpios);
 		goto clk_put;
 	}
-- 
2.20.0
