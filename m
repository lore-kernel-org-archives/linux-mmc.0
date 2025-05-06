Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE68269B08
	for <linux-mmc@vger.kernel.org>; Tue,  6 May 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525091; cv=none; b=BJ2x/OvOYX2+IqoSWXYTDgyRcaQdh2vjP9Hn2BrXhgQSA57mlNjniB+VJaJERY0iIBm9sO9/w9Lqb2SrL78hnpXuRKEIvUHnTrv1WlZopI90Bf8QxsVya05oywOZUMKBouYYob1Ym9WYHAEp0mXjzWA9cKrkFLR6mr+6nkYBWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525091; c=relaxed/simple;
	bh=80O5u8b179eH58Et+IA2gc4fMJ6LX0ZeX0JLQgYt+lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GX1DOri8F9jsmCH5EXhhXFICt0t2YxOSp5QCawsTt/K/YXNCH6xDhNNS6V1PehIOKertIjK8pU+HspWybjulGCAeL8QzHftcH+IC/IHEc4hBIDoXkb2VMvmv0TIDlTV0Dq8/W61wvvzw6pwviBzAfayDmxtrjxuS/1hECkVZ4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExM-0005A0-Qw; Tue, 06 May 2025 11:51:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExL-001NB2-2i;
	Tue, 06 May 2025 11:51:19 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExL-009ObH-2M;
	Tue, 06 May 2025 11:51:19 +0200
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
Subject: [PATCH v5 2/4] mmc: core: Add MMC_POWEROFF_UNDERVOLTAGE support in _mmc_suspend()
Date: Tue,  6 May 2025 11:51:16 +0200
Message-Id: <20250506095118.2239459-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506095118.2239459-1-o.rempel@pengutronix.de>
References: <20250506095118.2239459-1-o.rempel@pengutronix.de>
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
index 5be9b42d5057..b67de2b62830 100644
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

