From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] mmc: add module param to set fault injection attributes
Date: Tue, 13 Sep 2011 23:03:29 +0200
Message-ID: <1315947810-22714-3-git-send-email-per.forlin@linaro.org>
References: <1315947810-22714-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1315947810-22714-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
a simple module_param(). The module param mmc_core.fail_request
may be used to set the fault injection attributes during boot time
or module load time.

Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/debugfs.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 5acd707..bb72ba2 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -20,6 +20,14 @@
 #include "core.h"
 #include "mmc_ops.h"
 
+#ifdef CONFIG_FAIL_MMC_REQUEST
+
+static DECLARE_FAULT_ATTR(fail_default_attr);
+static char *fail_request;
+module_param(fail_request, charp, 0);
+
+#endif /* CONFIG_FAIL_MMC_REQUEST */
+
 /* The debugfs functions are optimized away when CONFIG_DEBUG_FS isn't set. */
 static int mmc_ios_show(struct seq_file *s, void *data)
 {
@@ -159,23 +167,6 @@ static int mmc_clock_opt_set(void *data, u64 val)
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
 
@@ -207,7 +198,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 		goto err_node;
 #endif
 #ifdef CONFIG_FAIL_MMC_REQUEST
-	host->fail_mmc_request = fail_mmc_request;
+	if (fail_request)
+		setup_fault_attr(&fail_default_attr, fail_request);
+	host->fail_mmc_request = fail_default_attr;
 	if (IS_ERR(fault_create_debugfs_attr("fail_mmc_request",
 					     root,
 					     &host->fail_mmc_request)))
-- 
1.7.4.1
