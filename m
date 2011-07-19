From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH v2 1/3] fault-inject: make fault injection available for modules
Date: Tue, 19 Jul 2011 23:31:44 +0200
Message-ID: <1311111106-26814-2-git-send-email-per.forlin@linaro.org>
References: <1311111106-26814-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311111106-26814-1-git-send-email-per.forlin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.ke
Cc: Randy Dunlap <rdunlap@xenotime.net>, Per Forlin <per.forlin@linaro.org>
List-Id: linux-mmc@vger.kernel.org

export symbols should_fail() and init_fault_attr_dentries() in order
to make modules use the fault injection functionality

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 lib/fault-inject.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 7e65af7..cd28364 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -131,6 +131,7 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 
 	return true;
 }
+EXPORT_SYMBOL(should_fail);
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 
@@ -311,5 +312,6 @@ fail:
 	cleanup_fault_attr_dentries(attr);
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(init_fault_attr_dentries);
 
 #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
-- 
1.7.4.1
