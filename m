From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v8 1/6] mmc: core: Add helper to see if a host can be retuned
Date: Thu,  3 Nov 2016 15:15:59 +0100
Message-ID: <1478182564-18762-2-git-send-email-horms+renesas@verge.net.au>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49638 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757259AbcKCO6g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 10:58:36 -0400
In-Reply-To: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

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
index 0b2439441cc8..28e2f53c7c4d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -546,6 +546,11 @@ static inline void mmc_retune_recheck(struct mmc_host *host)
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

