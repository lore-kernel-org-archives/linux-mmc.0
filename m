From: srinivas.kandagatla@linaro.org
Subject: [PATCH RFC 07/12] mmc: mmci: Qcomm: Add 3 clock cycle delay after each register write
Date: Mon, 21 Apr 2014 22:48:29 +0100
Message-ID: <1398116909-31517-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:38804 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbaDUVsi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Apr 2014 17:48:38 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so4104147wes.23
        for <linux-mmc@vger.kernel.org>; Mon, 21 Apr 2014 14:48:37 -0700 (PDT)
In-Reply-To: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds a 3 clock cycle delay required after writing to controller
registers on Qualcomm SOCs. Without this delay cards are either not detected
or fails as soon as card is put into data transfer mode.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/mmci.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 86bf330..2dc7581 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -168,6 +168,7 @@ static struct variant_data variant_qcom = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
+	.reg_write_delay	= 3,
 	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
 	.blksz_datactrl4	= true,
-- 
1.7.9.5

