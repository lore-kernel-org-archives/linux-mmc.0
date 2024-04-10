Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8F15EFC4
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757961; cv=none; b=ardTPmmUaf+cmfob90iVkejQDOEKiD2S5wQmnSMKoinywFPg0Nq4QVAmql203RHxxBUEMjcpo6BShBuAlpBZTXp8PVRDyYr8GSdfE5miHVYV/x6Clkt8pN79U/UBpzklOYRA+qcXIe75oT151ZJEn25SOpEtJQdfjVexGG4WiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757961; c=relaxed/simple;
	bh=3A/6Eaj4uCA3Cr1QhNJwOOLCNTpFf29DT7iOOUZG5y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QavAyLjqUdycQLqc09gqKdVkM5koPHZvga3ceEPxNzpkkf7Y/NkXp9RSAfhnhGFkN5meonhUScg0h5cEhlEfQnNkBxaRTvGd9TQWpEIazwvs0bV4THwlY+2Wwr5lIEYorvboYx8wwoWxOXUSAxDyw6GAUuMl5nIBHGz1COuBRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaJ-0000R0-7l; Wed, 10 Apr 2024 16:05:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaI-00BVRx-KC; Wed, 10 Apr 2024 16:05:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaI-00Hb2e-1l;
	Wed, 10 Apr 2024 16:05:54 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/3] memstick: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 16:05:47 +0200
Message-ID: <cover.1712757795.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3A/6Eaj4uCA3Cr1QhNJwOOLCNTpFf29DT7iOOUZG5y8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpy8voL1PGnAy2NIcXkyM881JXtv38+7sKDnp gkRFcFHi+mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhacvAAKCRCPgPtYfRL+ TqfwB/49l7Vo1XIsMqjAM+/EDqCis9Mi4bWih3Q8B4f4D5r2h+5de0T6vNh0NbsMshUi6nqcSp/ hijwV22qHTbuk3xkCLWVy+9mSzklotD0axyW+5BxYIrlRUdsuagUsMpxz4JdhroVM/7TedWgE6S IX9rBoLE7SSdIBbBjyknqE9yud9uFWhJq3HhUEhy4vNqK+iuhhtx3dXzHmh98Nx+gax5iG/XFAJ xCDAhwdUbI9demF2MAna1M1xAJH9nyjSUJz0YH+Jz6Xc5ZaqD15KHySNCtk608B4twKsYEYDEOS 3QxUHCPvWvFRxUBGCv8v0W+egKVfi/FWwBo2oDPQejLkme2k
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/memstick/ to not
use struct platform_device::remove() any more. See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

All conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they can be
applied independently if needed. This is merge window material.

Best regards
Uwe

Uwe Kleine-König (3):
  memstick: rtsx_pci_ms: Drop if block with always false condition
  memstick: rtsx_pci_ms: Convert to platform remove callback returning
    void
  memstick: rtsx_usb_ms: Convert to platform remove callback returning
    void

 drivers/memstick/host/rtsx_pci_ms.c | 9 ++-------
 drivers/memstick/host/rtsx_usb_ms.c | 6 ++----
 2 files changed, 4 insertions(+), 11 deletions(-)

base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
-- 
2.43.0

