From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 4/5] mmc: core: Export mmc_retune_hold_now() mmc_retune_release()
Date: Fri,  7 Jun 2019 15:37:15 -0700
Message-ID: <20190607223716.119277-5-dianders@chromium.org>
References: <20190607223716.119277-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607223716.119277-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211-dev-list.pdl@broadcom.com, linux-rockchip@lists.infradead.org, Double Lo <double.lo@cypress.com>, briannorris@chromium.org, linux-wireless@vger.kernel.org, Naveen Gupta <naveen.gupta@cypress.com>, Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, netdev@vger.kernel.org, brcm80211-dev-list@cypress.com, Douglas Anderson <dianders@chromium.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Pan Bian <bianpan2016@163.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-mmc@vger.kernel.org

We want SDIO drivers to be able to temporarily stop retuning when the
driver knows that the SDIO card is not in a state where retuning will
work (maybe because the card is asleep).  We'll move the relevant
functions to a place where drivers can call them.

NOTE: We'll leave the calls with a mmc_ prefix following the lead of
the API call mmc_hw_reset(), which is also expected to be called
directly by SDIO cards.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("mmc: core: Export mmc_retune_hold_now() mmc_retune_release()") new for v3.

Changes in v2: None

 drivers/mmc/core/host.c  | 7 +++++++
 drivers/mmc/core/host.h  | 7 -------
 include/linux/mmc/core.h | 2 ++
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 6a51f7a06ce7..361f4d151d20 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -111,6 +111,13 @@ void mmc_retune_hold(struct mmc_host *host)
 	host->hold_retune += 1;
 }
 
+void mmc_retune_hold_now(struct mmc_host *host)
+{
+	host->retune_now = 0;
+	host->hold_retune += 1;
+}
+EXPORT_SYMBOL(mmc_retune_hold_now);
+
 void mmc_retune_release(struct mmc_host *host)
 {
 	if (host->hold_retune)
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 4805438c02ff..3212afc6c9fe 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -19,17 +19,10 @@ void mmc_unregister_host_class(void);
 void mmc_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
-void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 void mmc_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
 
-static inline void mmc_retune_hold_now(struct mmc_host *host)
-{
-	host->retune_now = 0;
-	host->hold_retune += 1;
-}
-
 static inline void mmc_retune_recheck(struct mmc_host *host)
 {
 	if (host->hold_retune <= 1)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 02a13abf0cda..53085245383c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -181,5 +181,7 @@ int mmc_sw_reset(struct mmc_host *host);
 void mmc_expect_errors_begin(struct mmc_host *host);
 void mmc_expect_errors_end(struct mmc_host *host);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
+void mmc_retune_release(struct mmc_host *host);
+void mmc_retune_hold_now(struct mmc_host *host);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
