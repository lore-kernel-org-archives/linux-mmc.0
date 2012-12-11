From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: [PATCH/RESEND v4 2/2] block: compile ROW statically into the kernel
Date: Tue, 11 Dec 2012 15:41:20 +0200
Message-ID: <1355233280-25923-3-git-send-email-tlinder@codeaurora.org>
References: <1355233280-25923-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:14863 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab2LKNlu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 08:41:50 -0500
In-Reply-To: <1355233280-25923-1-git-send-email-tlinder@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jaxboe@fusionio.com
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, venkat@linaro.org, linux-mmc@vger.kernel.org, Tatyana Brokhman <tlinder@codeaurora.org>, open list <linux-kernel@vger.kernel.org>

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
