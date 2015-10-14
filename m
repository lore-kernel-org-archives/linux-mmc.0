From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 1/2] mmc: skip reclaiming host on mmc_add_card() error
Date: Wed, 14 Oct 2015 23:53:03 +0300
Message-ID: <4835546.qgzOJFlmY8@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

There's little sense in releasing the host on mmc_add_card() error
immediately after reclaiming  it, so  reclaim the host  only in case
of success.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.

 drivers/mmc/core/mmc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: mmc/drivers/mmc/core/mmc.c
===================================================================
--- mmc.orig/drivers/mmc/core/mmc.c
+++ mmc/drivers/mmc/core/mmc.c
@@ -2009,14 +2009,13 @@ int mmc_attach_mmc(struct mmc_host *host
 
 	mmc_release_host(host);
 	err = mmc_add_card(host->card);
-	mmc_claim_host(host);
 	if (err)
 		goto remove_card;
 
+	mmc_claim_host(host);
 	return 0;
 
 remove_card:
-	mmc_release_host(host);
 	mmc_remove_card(host->card);
 	mmc_claim_host(host);
 	host->card = NULL;
