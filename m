From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH 3/4] mmc: pxamci: Disable DATA_TRAN_DONE interrupt sooner
Date: Wed, 19 Apr 2017 01:17:33 +0200
Message-ID: <04139c1a-cee8-f64c-4b0e-2e3c472169a3@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:32954 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758067AbdDRXRK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 19:17:10 -0400
In-Reply-To: <cover.1492492523.git.petr.cvek@tul.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robert.jarzmik@free.fr
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Disable the DATA_TRAN_DONE interrupt as soon as possible in the handler.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/mmc/host/pxamci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 48c26d848e9f..570735a10127 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -354,6 +354,8 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
 	struct mmc_data *data = host->data;
 	struct dma_chan *chan;
 
+	pxamci_disable_irq(host, DATA_TRAN_DONE);
+
 	if (!data) {
 		pr_err("%s: Missing data structure\n",
 			mmc_hostname(host->mmc));
@@ -389,8 +391,6 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
 	else
 		data->bytes_xfered = 0;
 
-	pxamci_disable_irq(host, DATA_TRAN_DONE);
-
 	host->data = NULL;
 	if (host->mrq->stop) {
 		pxamci_stop_clock(host);
-- 
2.11.0

