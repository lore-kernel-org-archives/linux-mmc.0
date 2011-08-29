From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH 2/2] mmc: mmci: simplify err check in mmci_post_request
Date: Mon, 29 Aug 2011 15:35:59 +0200
Message-ID: <1314624959-4634-3-git-send-email-per.forlin@linaro.org>
References: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33306 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab1H2Ngr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2011 09:36:47 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so4160433bke.19
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2011 06:36:47 -0700 (PDT)
In-Reply-To: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santo
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

The error condition indicates that mmci_post_request() should cleanup
after the mmci_pre_request(). In this case the resources allocated by
device_prep_slave_sg() are freed by calling dmaengine_terminate_all().
dma_unmap_sg() should always be performed if the host_cookie is set.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/host/mmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 56e9a41..40e4c05 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -529,7 +529,7 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (chan) {
 		if (err)
 			dmaengine_terminate_all(chan);
-		if (err || data->host_cookie)
+		if (data->host_cookie)
 			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
 				     data->sg_len, dir);
 		mrq->data->host_cookie = 0;
-- 
1.7.4.1

