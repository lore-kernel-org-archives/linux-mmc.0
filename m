From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Convert timers to use timer_setup()
Date: Mon, 30 Oct 2017 14:45:00 -0700
Message-ID: <20171030214500.GA72041@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 37b55b095daf..0aa39975f33b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2991,9 +2991,9 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	host->use_dma = TRANS_MODE_PIO;
 }
 
-static void dw_mci_cmd11_timer(unsigned long arg)
+static void dw_mci_cmd11_timer(struct timer_list *t)
 {
-	struct dw_mci *host = (struct dw_mci *)arg;
+	struct dw_mci *host = from_timer(host, t, cmd11_timer);
 
 	if (host->state != STATE_SENDING_CMD11) {
 		dev_warn(host->dev, "Unexpected CMD11 timeout\n");
@@ -3005,9 +3005,9 @@ static void dw_mci_cmd11_timer(unsigned long arg)
 	tasklet_schedule(&host->tasklet);
 }
 
-static void dw_mci_cto_timer(unsigned long arg)
+static void dw_mci_cto_timer(struct timer_list *t)
 {
-	struct dw_mci *host = (struct dw_mci *)arg;
+	struct dw_mci *host = from_timer(host, t, cto_timer);
 	unsigned long irqflags;
 	u32 pending;
 
@@ -3060,9 +3060,9 @@ static void dw_mci_cto_timer(unsigned long arg)
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
-static void dw_mci_dto_timer(unsigned long arg)
+static void dw_mci_dto_timer(struct timer_list *t)
 {
-	struct dw_mci *host = (struct dw_mci *)arg;
+	struct dw_mci *host = from_timer(host, t, dto_timer);
 	unsigned long irqflags;
 	u32 pending;
 
@@ -3257,14 +3257,9 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	setup_timer(&host->cmd11_timer,
-		    dw_mci_cmd11_timer, (unsigned long)host);
-
-	setup_timer(&host->cto_timer,
-		    dw_mci_cto_timer, (unsigned long)host);
-
-	setup_timer(&host->dto_timer,
-		    dw_mci_dto_timer, (unsigned long)host);
+	timer_setup(&host->cmd11_timer, dw_mci_cmd11_timer, 0);
+	timer_setup(&host->cto_timer, dw_mci_cto_timer, 0);
+	timer_setup(&host->dto_timer, dw_mci_dto_timer, 0);
 
 	spin_lock_init(&host->lock);
 	spin_lock_init(&host->irq_lock);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
