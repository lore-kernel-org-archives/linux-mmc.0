From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH mmc 2/4] mmc: TMIO: Fix I/O mapping leak on error using
 devm_ioremap()
Date: Mon, 27 Apr 2015 00:01:17 +0100
Message-ID: <1430089277.5802.19.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34168 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbDZXBV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Apr 2015 19:01:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk

From: Ian Molton <ian.molton@codethink.co.uk>

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
[bwh: Forward-ported to 4.0]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/mmc/host/tmio_mmc_pio.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index dba7e1c19dd7..e3dcf31a8bd6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1108,7 +1108,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (ret < 0)
 		goto host_free;
 
-	_host->ctl = ioremap(res_ctl->start, resource_size(res_ctl));
+	_host->ctl = devm_ioremap(&pdev->dev,
+				  res_ctl->start, resource_size(res_ctl));
 	if (!_host->ctl) {
 		ret = -ENOMEM;
 		goto host_free;
@@ -1230,8 +1231,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	iounmap(host->ctl);
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
 
-- 
1.7.10.4




