From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] Revert "mmc: bcm2835: Terminate timeout work synchronously"
Date: Sun,  8 Sep 2019 09:45:52 +0200
Message-ID: <1567928752-2557-1-git-send-email-wahrenst@gmx.net>
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Lukas Wunner <lukas@wunner.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The commit 37fefadee8bb ("mmc: bcm2835: Terminate timeout work
synchronously") causes lockups in case of hardware timeouts due the
timeout work also calling cancel_delayed_work_sync() on its own.
So revert it.

Fixes: 37fefadee8bb ("mmc: bcm2835: Terminate timeout work synchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/mmc/host/bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 7e0d3a4..bb31e13 100644
=2D-- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -597,7 +597,7 @@ static void bcm2835_finish_request(struct bcm2835_host=
 *host)
 	struct dma_chan *terminate_chan =3D NULL;
 	struct mmc_request *mrq;

-	cancel_delayed_work_sync(&host->timeout_work);
+	cancel_delayed_work(&host->timeout_work);

 	mrq =3D host->mrq;

=2D-
2.7.4
