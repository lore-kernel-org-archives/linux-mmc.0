From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] MAINTAINERS: Add maintainer for the mmc subsystem
Date: Wed, 19 Feb 2014 00:01:05 +0100
Message-ID: <1392764465-14927-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:35375 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaBRXBM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 18:01:12 -0500
Received: by mail-la0-f45.google.com with SMTP id b8so12598724lan.4
        for <linux-mmc@vger.kernel.org>; Tue, 18 Feb 2014 15:01:10 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Put myself as a (co)maintainer of the mmc subsystem to help out Chris
Ball in a more official role.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Chris, if you are happy having me as your co-maintainer, the plan from
my side are to review and ack patches, but from a more official role
than what I have currently. Then let's see how things evolve.

---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2cf5cf..37d58a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5800,6 +5800,7 @@ F:	include/linux/mfd/
 
 MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
 M:	Chris Ball <chris@printf.net>
+M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-mmc@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
 S:	Maintained
-- 
1.7.9.5

