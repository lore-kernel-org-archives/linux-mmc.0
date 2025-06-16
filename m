Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58929616A
	for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069763; cv=none; b=c0iDbC+NsyovO+PKMbRQgrgx4KKvXxD+f8cDu0U7A3c3A6HmRIP6edS/zVj7DXi5kacaiKRHDZs7rS90a3SXoT75zNuA//VLpLsvGmdJznbRr6AhEYJqoAp8BJ09Y7cDrXzesr2min6tlfYF4b1rb0rO7z1jRe/CVsJaPAxRJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069763; c=relaxed/simple;
	bh=qv0qCLd1/75bFRo3erSxMr7Y4wQHNfzx+FDc5u6nH3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJRY4/BDm7H8fBzj7Ro8Xps2r+bdnVFZuuKMZwIb/n/QyW+STWzJ8cqeX2nIBY/kFGkKNZHzjRX/x5cDvTXg1FAD2qXGBm6auClWFtLRnibM2/aMt7Frl5xuZD6gaQ3Vj2e8VtdoUdrUEo1lpc9ySAIMyRWw4icaVZZ8pF+0Eic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uR75b-0008T1-0A; Mon, 16 Jun 2025 12:29:19 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uR75a-003n2y-0S;
	Mon, 16 Jun 2025 12:29:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uR75a-0072J5-0F;
	Mon, 16 Jun 2025 12:29:18 +0200
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
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: [PATCH v6 2/4] mmc: core: Add MMC_POWEROFF_UNDERVOLTAGE support in _mmc_suspend()
Date: Mon, 16 Jun 2025 12:29:15 +0200
Message-Id: <20250616102917.1677116-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616102917.1677116-1-o.rempel@pengutronix.de>
References: <20250616102917.1677116-1-o.rempel@pengutronix.de>
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

Introduce MMC_POWEROFF_UNDERVOLTAGE as a new mmc_poweroff_type value and
adjust _mmc_suspend() to skip cache flush for this case. This prepares for
undervoltage handling in a follow-up patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v5:
- rebase against latest mmc/next
- use MMC_POWEROFF_UNDERVOLTAGE enum instead of function parameter.
changes v3:
- add comments
- make sure _mmc_flush_cache is not executed in the undervoltage case
---
 drivers/mmc/core/mmc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5689ab6eefe1..6812df679ba9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -36,6 +36,7 @@
 enum mmc_poweroff_type {
 	MMC_POWEROFF_SUSPEND,
 	MMC_POWEROFF_SHUTDOWN,
+	MMC_POWEROFF_UNDERVOLTAGE,
 	MMC_POWEROFF_UNBIND,
 };
 
@@ -2132,9 +2133,15 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 	if (mmc_card_suspended(host->card))
 		goto out;
 
-	err = _mmc_flush_cache(host);
-	if (err)
-		goto out;
+	/*
+	 * For the undervoltage case, we care more about device integrity.
+	 * Avoid cache flush and notify the device to power off quickly.
+	 */
+	if (pm_type != MMC_POWEROFF_UNDERVOLTAGE) {
+		err = _mmc_flush_cache(host);
+		if (err)
+			goto out;
+	}
 
 	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_host_can_poweroff_notify(host, pm_type))
-- 
2.39.5

