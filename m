Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941501E9B08
	for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037477; cv=none; b=YrJTjl2+MZtAU5MfL2vBmoS4KZRFfbin8lKdJWmk72wserHtzH02qBka4VAyVJgRS0h/l50M0gcuaNbdqho2eCAdxANRi7qUUGzXHrdyAewIgEUI7uZ+rMWotc7HOiP4RlK4qMO/ob8dbEitJ1udMCDdroORCemXVeot2G72ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037477; c=relaxed/simple;
	bh=e6uUNN/5YcOI8FAcrOwzJaNiC1Ml4nY7w/gShuB8HF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RFV2gnJJ4dJ5Yk5mK+p/1rRYc6/wx6UR9NuMhKPu0jZRI0XXKlKv4CtbJcgBH1B6rn8DZYrgmSUNOG9FzaunF/doK4CIT5NbyTJYC4po7Jp2YE1FTgIKIv6x8asC5MJ2t0h3Tbedv+rEeg061Hc04SwYs+MC9Zzw0xuAYMDFlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EV-0004TR-1C; Thu, 20 Feb 2025 08:44:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-001tqQ-21;
	Thu, 20 Feb 2025 08:44:30 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-00CC2E-1q;
	Thu, 20 Feb 2025 08:44:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 3/6] mmc: core: refactor _mmc_suspend() for undervoltage handling
Date: Thu, 20 Feb 2025 08:44:26 +0100
Message-Id: <20250220074429.2906141-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220074429.2906141-1-o.rempel@pengutronix.de>
References: <20250220074429.2906141-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Introduce an is_undervoltage parameter to _mmc_suspend() to apply a
short power-off sequence and optionally flush the cache. This refactoring
prepares for undervoltage support in a follow-up patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/mmc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6a23be214543..86b608843232 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2104,20 +2104,27 @@ static int _mmc_flush_cache(struct mmc_host *host)
 	return err;
 }
 
-static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
+static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
+			bool is_undervoltage)
 {
+	unsigned int notify_type;
 	int err = 0;
-	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
-					EXT_CSD_POWER_OFF_LONG;
+
+	if (is_undervoltage || is_suspend)
+		notify_type = EXT_CSD_POWER_OFF_SHORT;
+	else
+		notify_type = EXT_CSD_POWER_OFF_LONG;
 
 	mmc_claim_host(host);
 
 	if (mmc_card_suspended(host->card))
 		goto out;
 
-	err = _mmc_flush_cache(host);
-	if (err)
-		goto out;
+	if (is_undervoltage) {
+		err = _mmc_flush_cache(host);
+		if (err)
+			goto out;
+	}
 
 	if (mmc_can_poweroff_notify(host->card) &&
 	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
@@ -2144,7 +2151,7 @@ static int mmc_suspend(struct mmc_host *host)
 {
 	int err;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, false);
 	if (!err) {
 		pm_runtime_disable(&host->card->dev);
 		pm_runtime_set_suspended(&host->card->dev);
@@ -2191,7 +2198,7 @@ static int mmc_shutdown(struct mmc_host *host)
 		err = _mmc_resume(host);
 
 	if (!err)
-		err = _mmc_suspend(host, false);
+		err = _mmc_suspend(host, false, false);
 
 	return err;
 }
@@ -2215,7 +2222,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, false);
 	if (err)
 		pr_err("%s: error %d doing aggressive suspend\n",
 			mmc_hostname(host), err);
-- 
2.39.5

