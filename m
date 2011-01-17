From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH] mmc_test: Don't warn about not waiting for busy if controller can't do this
Date: Mon, 17 Jan 2011 17:00:31 +0000
Message-ID: <1295283631-7965-1-git-send-email-pawel.moll@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:51270 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751955Ab1AQRAk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jan 2011 12:00:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

If the MMC host controller does not support waiting for card signaling
busy state (MMC_CAP_WAIT_WHILE_BUSY cap), there is no point in prining
the relevant warning message.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mmc/card/mmc_test.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 21adc27..0131c6c 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -226,9 +226,10 @@ static int mmc_test_wait_busy(struct mmc_test_card *te=
st)
=20
 =09=09if (!busy && mmc_test_busy(&cmd)) {
 =09=09=09busy =3D 1;
-=09=09=09printk(KERN_INFO "%s: Warning: Host did not "
-=09=09=09=09"wait for busy state to end.\n",
-=09=09=09=09mmc_hostname(test->card->host));
+=09=09=09if (test->card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+=09=09=09=09printk(KERN_INFO "%s: Warning: Host did not "
+=09=09=09=09=09"wait for busy state to end.\n",
+=09=09=09=09=09mmc_hostname(test->card->host));
 =09=09}
 =09} while (mmc_test_busy(&cmd));
=20
--=20
1.6.3.3


