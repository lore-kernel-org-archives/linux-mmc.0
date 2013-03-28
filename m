From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] mmc: dw_mmc: Check return value of regulator_enable
Date: Thu, 28 Mar 2013 09:55:46 +0530
Message-ID: <1364444747-16777-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:44065 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab3C1EhN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Mar 2013 00:37:13 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so3245974dal.26
        for <linux-mmc@vger.kernel.org>; Wed, 27 Mar 2013 21:37:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

regulator_enable() is declared with __must_check attribute.
Hence check the return value to ensure that the regulator is enabled.
=46ixes the following warning:
drivers/mmc/host/dw_mmc.c:2461:19: warning:
ignoring return value of =E2=80=98regulator_enable=E2=80=99, declared w=
ith attribute
warn_unused_result [-Wunused-result]
drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_init_slot=E2=80=99=
:
drivers/mmc/host/dw_mmc.c:1994:19: warning:
ignoring return value of =E2=80=98regulator_enable=E2=80=99, declared w=
ith attribute
warn_unused_result [-Wunused-result]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a443820..1ba09d0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1990,8 +1990,14 @@ static int dw_mci_init_slot(struct dw_mci *host,=
 unsigned int id)
 	if (IS_ERR(host->vmmc)) {
 		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc =3D NULL;
-	} else
-		regulator_enable(host->vmmc);
+	} else {
+		ret =3D regulator_enable(host->vmmc);
+		if (ret !=3D 0) {
+			dev_err(host->dev,
+				"failed to enable regulator: %d\n", ret);
+			goto err_setup_bus;
+		}
+	}
=20
 	if (dw_mci_get_cd(mmc))
 		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
@@ -2457,8 +2463,14 @@ int dw_mci_resume(struct dw_mci *host)
 {
 	int i, ret;
=20
-	if (host->vmmc)
-		regulator_enable(host->vmmc);
+	if (host->vmmc) {
+		ret =3D regulator_enable(host->vmmc);
+		if (ret !=3D 0) {
+			dev_err(host->dev,
+				"failed to enable regulator: %d\n", ret);
+			return ret;
+		}
+	}
=20
 	if (!mci_wait_reset(host->dev, host)) {
 		ret =3D -ENODEV;
--=20
1.7.4.1

