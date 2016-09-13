From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v7 1/6] mmc: core: Add helper to see if a host can be retuned
Date: Tue, 13 Sep 2016 12:56:10 +0200
Message-ID: <1473764175-24580-2-git-send-email-horms+renesas@verge.net.au>
References: <1473764175-24580-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1473764175-24580-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This is in preparation for restoring saved tuning parameters
when resuming the TMIO driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v6
* New patch
---
 include/linux/mmc/host.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index aa4bfbf129e4..4a9b4db8f22b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -541,6 +541,11 @@ static inline void mmc_retune_recheck(struct mmc_host *host)
 		host->retune_now = 1;
 }
 
+static inline bool mmc_can_retune(struct mmc_host *host)
+{
+	return host->can_retune == 1;
+}
+
 void mmc_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
 
-- 
2.7.0.rc3.207.g0ac5344
