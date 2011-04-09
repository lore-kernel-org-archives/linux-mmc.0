From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: mmc_add_card(): fix missing break in switch statement
Date: Sat,  9 Apr 2011 08:16:47 +0200 (CEST)
Message-ID: <20110409061647.D5DAE13909@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:39644 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab1DIGQt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Apr 2011 02:16:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Prashanth Bhat <prashanth.bhat@manipal.net>

=46ixes a cosmetic bug that affects printk() for SD-combo cards.

Noticed-by: Prashanth Bhat <prashanth.bhat@manipal.net>
Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/core/bus.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 63667a8..d6d62fd 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -284,6 +284,7 @@ int mmc_add_card(struct mmc_card *card)
 		type =3D "SD-combo";
 		if (mmc_card_blockaddr(card))
 			type =3D "SDHC-combo";
+		break;
 	default:
 		type =3D "?";
 		break;
--=20
1.7.2.5

