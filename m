From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 2/3] mmc: core: add random fault injection
Date: Tue, 19 Jul 2011 23:31:45 +0200
Message-ID: <1311111106-26814-3-git-send-email-per.forlin@linaro.org>
References: <1311111106-26814-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1311111106-26814-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY@public.gmane.org
Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This adds support to inject data errors after a completed host transfer.
The mmc core will return error even though the host transfer is successful.
This simple fault injection proved to be very useful to test the
non-blocking error handling in the mmc_blk_issue_rw_rq().
Random faults can also test how the host driver handles pre_req()
and post_req() in case of errors.

Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/core.c    |   58 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/debugfs.c |    5 ++++
 include/linux/mmc/host.h   |    3 ++
 lib/Kconfig.debug          |   11 ++++++++
 4 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ab36c7b..3f822b4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -23,6 +23,8 @@
 #include <linux/log2.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/fault-inject.h>
+#include <linux/random.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -82,6 +84,58 @@ static void mmc_flush_scheduled_work(void)
 	flush_workqueue(workqueue);
 }
 
+#ifdef CONFIG_FAIL_MMC_REQUEST
+
+static DECLARE_FAULT_ATTR(fail_mmc_request);
+
+static int __init setup_fail_mmc_request(char *str)
+{
+	return setup_fault_attr(&fail_mmc_request, str);
+}
+__setup("fail_mmc_request=", setup_fail_mmc_request);
+
+static void mmc_should_fail_request(struct mmc_host *host,
+				    struct mmc_request *mrq)
+{
+	struct mmc_command *cmd = mrq->cmd;
+	struct mmc_data *data = mrq->data;
+	static const int data_errors[] = {
+		-ETIMEDOUT,
+		-EILSEQ,
+		-EIO,
+	};
+
+	if (!data)
+		return;
+
+	if (cmd->error || data->error || !host->make_it_fail ||
+	    !should_fail(&fail_mmc_request, data->blksz * data->blocks))
+		return;
+
+	data->error = data_errors[random32() % ARRAY_SIZE(data_errors)];
+	data->bytes_xfered = (random32() % (data->bytes_xfered >> 9)) << 9;
+}
+
+static int __init fail_mmc_request_debugfs(void)
+{
+	return init_fault_attr_dentries(&fail_mmc_request,
+					"fail_mmc_request");
+}
+
+#else /* CONFIG_FAIL_MMC_REQUEST */
+
+static void mmc_should_fail_request(struct mmc_host *host,
+				    struct mmc_request *mrq)
+{
+}
+
+static int __init fail_mmc_request_debugfs(void)
+{
+	return 0;
+}
+#endif /* CONFIG_FAIL_MMC_REQUEST */
+
+
 /**
  *	mmc_request_done - finish processing an MMC request
  *	@host: MMC host which completed request
@@ -108,6 +162,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 		cmd->error = 0;
 		host->ops->request(host, mrq);
 	} else {
+		mmc_should_fail_request(host, mrq);
+
 		led_trigger_event(host->led, LED_OFF);
 
 		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
@@ -2064,6 +2120,8 @@ static int __init mmc_init(void)
 	if (ret)
 		goto unregister_host_class;
 
+	fail_mmc_request_debugfs();
+
 	return 0;
 
 unregister_host_class:
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 998797e..588e76f 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -188,6 +188,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 				root, &host->clk_delay))
 		goto err_node;
 #endif
+#ifdef CONFIG_FAIL_MMC_REQUEST
+	if (!debugfs_create_u8("make-it-fail", S_IRUSR | S_IWUSR,
+			       root, &host->make_it_fail))
+		goto err_node;
+#endif
 	return;
 
 err_node:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 771455f..250b46d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -303,6 +303,9 @@ struct mmc_host {
 
 	struct mmc_async_req	*areq;		/* active async req */
 
+#ifdef CONFIG_FAIL_MMC_REQUEST
+	u8			make_it_fail;
+#endif
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c768bcd..c2d1423 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1057,6 +1057,17 @@ config FAIL_IO_TIMEOUT
 	  Only works with drivers that use the generic timeout handling,
 	  for others it wont do anything.
 
+config FAIL_MMC_REQUEST
+	bool "Fault-injection capability for MMC IO"
+	select DEBUG_FS
+	depends on FAULT_INJECTION && MMC
+	help
+	  Provide fault-injection capability for MMC IO.
+	  This will make the mmc core return data errors. This is
+	  useful to test the error handling in the mmc block device
+	  and to test how the mmc host driver handles retries from
+	  the block device.
+
 config FAULT_INJECTION_DEBUG_FS
 	bool "Debugfs entries for fault-injection capabilities"
 	depends on FAULT_INJECTION && SYSFS && DEBUG_FS
-- 
1.7.4.1
