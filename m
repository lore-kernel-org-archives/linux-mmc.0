From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 2/3] mmc: Add a new mmc_is_io_op helper function
Date: Wed, 25 Nov 2015 12:28:46 +0100
Message-ID: <1448450927-13682-3-git-send-email-carlo@caione.org>
References: <1448450927-13682-1-git-send-email-carlo@caione.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33205 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbbKYL3U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 06:29:20 -0500
Received: by wmec201 with SMTP id c201so251659949wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 03:29:19 -0800 (PST)
In-Reply-To: <1448450927-13682-1-git-send-email-carlo@caione.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, hdegoede@redhat.com, linux-mmc@vger.kernel.org, drake@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>

From: Carlo Caione <carlo@endlessm.com>

Add a helper function to check if an opcode is a sd-io-* opcode.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/mmc/core/sdio_ops.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index e4b5ceb..9b614b2 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -26,5 +26,10 @@ static inline bool mmc_is_rw_io_op(u32 opcode)
 	return opcode == SD_IO_RW_DIRECT || opcode == SD_IO_RW_EXTENDED;
 }
 
+static inline bool mmc_is_io_op(u32 opcode)
+{
+	return mmc_is_rw_io_op(opcode) || opcode == SD_IO_SEND_OP_COND;
+}
+
 #endif
 
-- 
2.5.0

