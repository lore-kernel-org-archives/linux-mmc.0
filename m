Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BA204681
	for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2025 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130772; cv=none; b=cUH77e8T6Vt7WuUIMomOgxbmfqnc/qu+4YbynAYfr15m8V+XS2n0ZbwzAVutgq9LZGcegSB7TPJDpPXwslaWoOggyoNlxNURDIZEp6tYrxuB3dRngqQjes0r5mWqdPP9puvatoQABSlubplI0m+3qRK/S+usLFH0pMGzHkfD8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130772; c=relaxed/simple;
	bh=1zTQWSGL+Vd20DghGEZXit+HSN/fKgkzETADVcskdyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWT15x8tVavETfysVuk1GVnfQr1uikAn/PpoE6e/VBKJHzeHd+wXl+uk7I6jmchhmSEl6ogr4sc9pykCmYek0da7MUSIPFz2Jd103c8eFbK/u79RQPIAJR2+GS1pkcLZoJs8K+bApY+QYsflcom//lXQM38hbVMHE037JJwm6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-0001zY-QE; Fri, 21 Feb 2025 10:39:19 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-0024v1-1V;
	Fri, 21 Feb 2025 10:39:19 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-00GXcE-1I;
	Fri, 21 Feb 2025 10:39:19 +0100
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
Subject: [PATCH v3 6/6] mmc: sdhci: prevent command execution after undervoltage shutdown
Date: Fri, 21 Feb 2025 10:39:18 +0100
Message-Id: <20250221093918.3942378-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221093918.3942378-1-o.rempel@pengutronix.de>
References: <20250221093918.3942378-1-o.rempel@pengutronix.de>
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

Introduce an emergency_stop flag in struct mmc_host to block further
MMC/SD commands after an undervoltage shutdown. If emergency_stop is
set, sdhci_send_command() will reject new requests with -EBUSY and log a
warning. This helps diagnose and identify code paths that may still
attempt writes after the undervoltage shutdown sequence has completed.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- add comments
---
 drivers/mmc/core/mmc.c   | 7 +++++++
 drivers/mmc/host/sdhci.c | 9 +++++++++
 include/linux/mmc/host.h | 1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a50cdd550a22..0cd6b81d0678 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2370,6 +2370,13 @@ static int _mmc_handle_undervoltage(struct mmc_host *host)
 	 */
 	mmc_card_set_removed(card);
 
+	/*
+	 * Signal the host controller driver that we are in emergency stop mode.
+	 * This prevents any new storage requests from being issued, ensuring
+	 * that no further operations take place while in this state.
+	 */
+	host->emergency_stop = true;
+
 	return err;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4a7733a8ad2..8d67f27e7d9e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1658,6 +1658,15 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	WARN_ON(host->cmd);
 
+	if (host->mmc->emergency_stop) {
+		pr_warn("%s: Ignoring normal request, emergency stop is active\n",
+			mmc_hostname(host->mmc));
+		WARN_ON_ONCE(1);
+
+		cmd->error = -EBUSY;
+		return true;
+	}
+
 	/* Initially, a command has no error */
 	cmd->error = 0;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4e147ad82804..5dfe2cdde59f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -501,6 +501,7 @@ struct mmc_host {
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
 	unsigned int		undervoltage:1;	 /* Undervoltage state */
+	unsigned int		emergency_stop:1; /* Emergency stop. No transfers are allowed. */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.39.5

