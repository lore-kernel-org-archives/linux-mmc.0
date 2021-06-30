Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06545C11F69
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36E361992
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhF3KZE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:25:04 -0400
Received: from smtp2.axis.com ([195.60.68.18]:31664 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234112AbhF3KZE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Jun 2021 06:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1625048555;
  x=1656584555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E7NOZcl/eL2lJwiYK06wVi2k01weks9isLxuCWVZ/bI=;
  b=AIPy915Ajs8iR28oHX/1JQxacKqGi2YHXyCoAjd76SNRKBW66GBAvgET
   3eeNT0b9DabJnrayJHmDstW4+sv2/MQogLuQwrITzrObUdimYJECDVKCF
   ag3MZPAHwitmlDYIlUGdp74o91kF8TEZ7QRoq1aExniM0CwXGWv/ng3k6
   y4b8e9Mzu8yarwP5EmUyIBUeZKTqY4wvOCcRGV6bItVLIizLg7nxyS+y+
   RzhFSLA/l5D6ucjvfes5GdVGPDOFQ2EZAKZMCiJtM0AL/J6N+ZX7+Pbvo
   ytbJwcuVN/pcBxfTGLVNObbeGe02nITeoDfbmXmgkZLN39WVfDMkblHH9
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc: Fix hang on data CRC error
Date:   Wed, 30 Jun 2021 12:22:32 +0200
Message-ID: <20210630102232.16011-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When a Data CRC interrupt is received, the driver disables the DMA, then
sends the stop/abort command and then waits for Data Transfer Over.

However, sometimes, when a data CRC error is received in the middle of a
multi-block write transfer, the Data Transfer Over interrupt is never
received, and the driver hangs and never completes the request.

The driver sets the BMOD.SWR bit (SDMMC_IDMAC_SWRESET) when stopping the
DMA, but according to the manual CMD.STOP_ABORT_CMD should be programmed
"before assertion of SWR".  Do these operations in the recommended
order.  With this change the Data Transfer Over is always received
correctly in my tests.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mmc/host/dw_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f85271f5c4fa..845b0745ea37 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2083,8 +2083,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 					continue;
 				}
 
-				dw_mci_stop_dma(host);
 				send_stop_abort(host, data);
+				dw_mci_stop_dma(host);
 				state = STATE_SENDING_STOP;
 				break;
 			}
@@ -2108,10 +2108,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 			 */
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
-				dw_mci_stop_dma(host);
 				if (!(host->data_status & (SDMMC_INT_DRTO |
 							   SDMMC_INT_EBE)))
 					send_stop_abort(host, data);
+				dw_mci_stop_dma(host);
 				state = STATE_DATA_ERROR;
 				break;
 			}
@@ -2144,10 +2144,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
 			 */
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
-				dw_mci_stop_dma(host);
 				if (!(host->data_status & (SDMMC_INT_DRTO |
 							   SDMMC_INT_EBE)))
 					send_stop_abort(host, data);
+				dw_mci_stop_dma(host);
 				state = STATE_DATA_ERROR;
 				break;
 			}
-- 
2.28.0

