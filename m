From: Colin King <colin.king@canonical.com>
Subject: [PATCH][mmc-next][RESEND] mmc: sdhci-pci: make guid intel_dsm_guid static
Date: Mon, 19 Jun 2017 11:55:21 +0100
Message-ID: <20170619105521.19071-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40561 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753650AbdFSKz0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2017 06:55:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The guid intel_dsm_guid does not need to be in global scope, so make
it static.

Cleans up sparse warning:
"symbol 'intel_dsm_guid' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 3c02c5b394d6..f1d8385d91f0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -404,7 +404,7 @@ struct intel_host {
 	bool	d3_retune;
 };
 
-const guid_t intel_dsm_guid =
+static const guid_t intel_dsm_guid =
 	GUID_INIT(0xF6C13EA5, 0x65CD, 0x461F,
 		  0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61);
 
-- 
2.11.0

