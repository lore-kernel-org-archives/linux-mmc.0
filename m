From: Venkatraman S <svenkatr@ti.com>
Subject: [RFC PATCH 10/11] mmc: core: Utility function for mmc preemption sequence
Date: Wed, 18 Apr 2012 11:55:31 +0530
Message-ID: <1334730332-22244-11-git-send-email-svenkatr@ti.com>
References: <1334730332-22244-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334730332-22244-1-git-send-email-svenkatr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: arnd.bergmann@linaro.org, cjb@laptop.org, alex.limberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add a routine to invoke hpi command after invoking host
controller abort.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/core/core.c  |   15 +++++++++++++++
 include/linux/mmc/core.h |    2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1963305..7230a26 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -467,6 +467,21 @@ out:
 }
 EXPORT_SYMBOL(mmc_interrupt_hpi);
 
+int mmc_preempt_foreground_request(struct mmc_card *card,
+	struct mmc_request *req)
+{
+	int ret;
+
+	ret = mmc_abort_req(card->host, req);
+	if (ret)
+		pr_err("%s: Host Abort failed %d\n",
+			mmc_hostname(card->host), ret);
+	else
+		ret = mmc_interrupt_hpi(card);
+	return ret;
+}
+EXPORT_SYMBOL(mmc_preempt_foreground_request);
+
 /**
  *	mmc_wait_for_cmd - start a command and wait for completion
  *	@host: MMC host to start command
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index d86144e..e2d55c6 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -144,6 +144,8 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
+extern int mmc_preempt_foreground_request(struct mmc_card *card,
+	struct mmc_request *req);
 extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
-- 
1.7.10.rc2
