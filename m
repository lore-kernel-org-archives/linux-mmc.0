From: <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
Date: Thu, 8 Aug 2019 08:35:40 +0000
Message-ID: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, alexandre.belloni@bootlin.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Eugen.Hristev@microchip.com
List-Id: linux-mmc@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

HS200 is not implemented in the driver, but the controller claims it
through caps.
Remove it via quirk.
Without this quirk, the mmc core will try to enable hs200, which will fail,
and the eMMC initialization will fail.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-a=
t91.c
index 57fe3b2..3a8c6d8 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -370,6 +370,9 @@ static int sdhci_at91_probe(struct platform_device *pde=
v)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
=20
+	/* HS200 is broken at this moment */
+	host->quirks2 =3D SDHCI_QUIRK2_BROKEN_HS200;
+
 	ret =3D sdhci_add_host(host);
 	if (ret)
 		goto pm_runtime_disable;
--=20
2.7.4
