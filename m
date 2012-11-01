From: tlinder <tlinder@codeaurora.org>
Subject: [RFC/PATCH v3 2/2] block: compile ROW statically into the kernel
Date: Thu,  1 Nov 2012 14:00:02 +0200
Message-ID: <1351771203-31200-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:31343 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab2KAMAM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Nov 2012 08:00:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, Tatyana Brokhman <tlinder@codeaurora.org>, open list <linux-kernel@vger.kernel.org>

From: Tatyana Brokhman <tlinder@codeaurora.org>

ROW is a new scheduling algorithm. Similar to the existing scheduling
algorithms it should be compiled to the kernel statically giving the user
the ability to switch to it without kernel recompilation.

Signed-off-by: Tatyana Brokhman <tlinder@codeaurora.org>

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 5a747e2..401f42d 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -23,6 +23,7 @@ config IOSCHED_DEADLINE
 
 config IOSCHED_ROW
 	tristate "ROW I/O scheduler"
+	default y
 	---help---
 	  The ROW I/O scheduler gives priority to READ requests over the
 	  WRITE requests when dispatching, without starving WRITE requests.
-- 
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. 
Is a member of Code Aurora Forum, hosted by the Linux Foundation
