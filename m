From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] mmc: core: try to use an id from the devicetree
Date: Tue, 16 Apr 2019 15:39:30 +0200
Message-ID: <20190416133930.1819-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-mmc@vger.kernel.org

If there's a mmc* alias in the device tree, take the device number from
it, so that we end up with a device name that matches the alias.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mmc/core/host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3a4402a79904..9e2c31b9366e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -411,7 +411,12 @@ struct mmc_host *mmc_alloc_host(int extra, struct de=
vice *dev)
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable =3D 1;
=20
-	err =3D ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
+	/* prefer an alias */
+	err =3D of_alias_get_id(dev->of_node, "mmc");
+	if (err < 0)
+		err =3D 0;
+
+	err =3D ida_simple_get(&mmc_host_ida, err, 0, GFP_KERNEL);
 	if (err < 0) {
 		kfree(host);
 		return NULL;
--=20
2.21.0
