From: <Eugen.Hristev@microchip.com>
Subject: [PATCH] mmc: sdhci-of-at91: fix quirk2 overwrite
Date: Thu, 14 Nov 2019 12:59:26 +0000
Message-ID: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, Ludovic.Desroches@microchip.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Eugen.Hristev@microchip.com
List-Id: linux-mmc@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The quirks2 are parsed and set (e.g. from DT) before the quirk for broken
HS200 is set in the driver.
The driver needs to enable just this flag, not rewrite the whole quirk set.

Fixes: 7871aa60ae00 ("mmc: sdhci-of-at91: add quirk for broken HS200")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

 drivers/mmc/host/sdhci-of-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-a=
t91.c
index 496844a..5fe6684 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -389,7 +389,7 @@ static int sdhci_at91_probe(struct platform_device *pde=
v)
 	pm_runtime_use_autosuspend(&pdev->dev);
=20
 	/* HS200 is broken at this moment */
-	host->quirks2 =3D SDHCI_QUIRK2_BROKEN_HS200;
+	host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_HS200;
=20
 	ret =3D sdhci_add_host(host);
 	if (ret)
--=20
2.7.4
