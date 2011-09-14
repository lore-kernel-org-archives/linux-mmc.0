From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 2/3] mmc: add module param to set fault injection attributes
Date: Wed, 14 Sep 2011 10:46:56 +0200
Message-ID: <1315990017-16912-3-git-send-email-per.forlin@linaro.org>
References: <1315990017-16912-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1315990017-16912-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Replace setup("fail_mmc_request") and faulty "ifdef KERNEL" with
a module_param_cb(). The module param mmc_core.fail_request
may be used to set the fault injection attributes during boot time
or module load time.

Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/debugfs.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 5acd707..d80e234 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -20,6 +20,25 @@
 #include "core.h"
 #include "mmc_ops.h"
 
+#ifdef CONFIG_FAIL_MMC_REQUEST
+
+static DECLARE_FAULT_ATTR(fail_default_attr);
+static char *fail_request;
+static int fail_mmc_request_param_set(const char *val,
+				      const struct kernel_param *kp)
+{
+	setup_fault_attr(&fail_default_attr, (char *) val);
+	return 0;
+}
+
+static const struct kernel_param_ops fail_mmc_request_param_ops = {
+	.set = fail_mmc_request_param_set
+};
+module_param_cb(fail_request, &fail_mmc_request_param_ops,
+		&fail_request, 0);
+
+#endif /* CONFIG_FAIL_MMC_REQUEST */
+
 /* The debugfs functions are optimized away when CONFIG_DEBUG_FS isn't set. */
 static int mmc_ios_show(struct seq_file *s, void *data)
 {
@@ -159,23 +178,6 @@ static int mmc_clock_opt_set(void *data, u64 val)
 	return 0;
 }
 
-#ifdef CONFIG_FAIL_MMC_REQUEST
-
-static DECLARE_FAULT_ATTR(fail_mmc_request);
-
-#ifdef KERNEL
-/*
- * Internal function. Pass the boot param fail_mmc_request to
- * the setup fault injection attributes routine.
- */
-static int __init setup_fail_mmc_request(char *str)
-{
-	return setup_fault_attr(&fail_mmc_request, str);
-}
-__setup("fail_mmc_request=", setup_fail_mmc_request);
-#endif /* KERNEL */
-#endif /* CONFIG_FAIL_MMC_REQUEST */
-
 DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
 
@@ -207,7 +209,7 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 		goto err_node;
 #endif
 #ifdef CONFIG_FAIL_MMC_REQUEST
-	host->fail_mmc_request = fail_mmc_request;
+	host->fail_mmc_request = fail_default_attr;
 	if (IS_ERR(fault_create_debugfs_attr("fail_mmc_request",
 					     root,
 					     &host->fail_mmc_request)))
-- 
1.7.4.1
