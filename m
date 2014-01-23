From: Vicente Olivert Riera <Vincent.Riera@imgtec.com>
Subject: [PATCH] mmc-utils: Fix 64-bit values redefinition
Date: Thu, 23 Jan 2014 15:20:55 +0000
Message-ID: <1390490455-8773-1-git-send-email-Vincent.Riera@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:1625 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbaAWPW1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jan 2014 10:22:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Vicente Olivert Riera <Vincent.Riera@imgtec.com>

Some toolchains include asm-generic/int-l64.h from their asm/types.h
file for certain 64-bit architectures. This causes a conflict between
types like this one:

asm-generic/int-l64.h:28:25: error: conflicting types for '__s64'
 typedef __signed__ long __s64;
	     ^
In file included from mmc.h:17:0,
	 from mmc_cmds.c:30:
asm-generic/int-ll64.h:29:44: note: previous declaration of '__s64' was
here
 __extension__ typedef __signed__ long long __s64;

Signed-off-by: Vicente Olivert Riera <Vincent.Riera@imgtec.com>
---
 mmc.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/mmc.h b/mmc.h
index 9871d62..2d54ec5 100644
--- a/mmc.h
+++ b/mmc.h
@@ -14,9 +14,11 @@
  * Boston, MA 021110-1307, USA.
  */
 
-#include <asm-generic/int-ll64.h>
 #include <linux/mmc/ioctl.h>
 #include <stdio.h>
+#ifndef _ASM_GENERIC_INT_L64_H
+#include <asm-generic/int-ll64.h>
+#endif
 
 #define CHECK(expr, msg, err_stmt) { if (expr) { fprintf(stderr, msg); err_stmt; } }
 
-- 
1.7.1


