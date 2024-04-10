Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4B15EFBD
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757960; cv=none; b=tyxIyZUg3gqYay11kDRa6NjA2KlKbQfRdlZCenaQ7z+rOqOQRI9Y0PB6KFqiz2gsJvJmCliEFF2LLjNzumW31WPnwNGfNDnTSJfroRqtJpPNs5sDZbMPJ626LLuMaGSpz+h72aSIr0++ShtftxC2BpylVgpJBxjhWvi9+ggNECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757960; c=relaxed/simple;
	bh=21Ve1Bd2bxZcQ2r8/M48JFMLT9OT3eTRNvl2PwLQgic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4VPjzIzGK6CGtVw/efENCRvQpFpqCwDPkQaUxFm2zQE7qh/Ua7jrvkqEiSjImcSFojn6tVs3RNGniwlhCvRMc3vZ87Jb6IlvHKwl8Z7DWog3J81fkjfKRAkPxne3O6SGb/aD5AgVB+K/PDmKoMCDKwqmL4MlfQXuUv/Xti6hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaJ-0000R1-7i; Wed, 10 Apr 2024 16:05:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaI-00BVS0-Pl; Wed, 10 Apr 2024 16:05:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaI-00Hb2i-2J;
	Wed, 10 Apr 2024 16:05:54 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/3] memstick: rtsx_pci_ms: Drop if block with always false condition
Date: Wed, 10 Apr 2024 16:05:48 +0200
Message-ID:  <dd0d06ca9388fd8f6a3a8bb57354baaeaf56800a.1712757795.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712757795.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712757795.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=21Ve1Bd2bxZcQ2r8/M48JFMLT9OT3eTRNvl2PwLQgic=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpy9tgb9rifsC8wcA/UUzgaL/zKJNwuiY1x2W CO5zaubRdKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhacvQAKCRCPgPtYfRL+ ThvxB/9DjZ59T3zvcHXg/KFKN0ZSgMe4qX6fqSNrwiNlDNNr0EYY+lh32E4mH30Ju/XSRV8LiJp vmI/L7GlHHv+ANC3Yz1sdIZ2cUBF89t+j5bCdAqAUQryB34bc7P0UHdoX7pf2fxI34uGDb27L41 1vNQU8DbsbcboOl15vxZX20C+az7PItle7mIfIzujNMO6PiM9bcdayokyLputbM8Mx+0TyytY2S Kg/zA9d8FRmR2oaDgMzemH8Fks4Zr1otardtU8MceMK+3Y8nONttFAGlpxCe1t+nMH4dQ6qPQzg 7OIPjCg4DFHdVpXGSVUPIHgO/NSfC3NZ88LNpgAt2J3drWR/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

rtsx_pci_ms_drv_remove() is only called after rtsx_pci_ms_drv_probe()
completed successfully. In this case platform_set_drvdata() was called
with a non-NULL argument and so platform_get_drvdata() won't return
NULL.

Simplify by removing the if block with the always false condition.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/memstick/host/rtsx_pci_ms.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/memstick/host/rtsx_pci_ms.c b/drivers/memstick/host/rtsx_pci_ms.c
index 15720a4afac2..7c6dba6de230 100644
--- a/drivers/memstick/host/rtsx_pci_ms.c
+++ b/drivers/memstick/host/rtsx_pci_ms.c
@@ -581,9 +581,6 @@ static int rtsx_pci_ms_drv_remove(struct platform_device *pdev)
 	struct memstick_host *msh;
 	int rc;
 
-	if (!host)
-		return 0;
-
 	pcr = host->pcr;
 	pcr->slots[RTSX_MS_CARD].p_dev = NULL;
 	pcr->slots[RTSX_MS_CARD].card_event = NULL;
-- 
2.43.0

