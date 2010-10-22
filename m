From: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
Subject: [PATCH 1/1] powerpc: Fix initramfs size in PPC32 build
Date: Fri, 22 Oct 2010 12:17:55 +0200
Message-ID: <1287742675-7614-1-git-send-email-kerstin.jonsson@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw10.se.ericsson.net ([193.180.251.61]:59289 "EHLO
	mailgw10.se.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0JVKSD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 06:18:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org
Cc: Kerstin Jonsson <kerstin.jonsson@ericsson.com>, Paul Mackerras <paulus@samba.org>

commit ffe8018c3424892c9590048fc36caa6c3e0c8a76 of the -mm tree
fixes the initramfs size calculation for e.g. s390 but breaks it
for 32bit architectures which do not define CONFIG_32BIT.

This patch fix the problem for PPC32 which will elsewise end up
with a __initramfs_size of 0.

Signed-off-by: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 50cc5d9..d536fe4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -4,6 +4,10 @@ config PPC32
 	bool
 	default y if !PPC64
 
+config 32BIT
+	bool
+	default y if PPC32
+
 config 64BIT
 	bool
 	default y if PPC64
-- 
1.7.1

