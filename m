From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v5 05/13] mmc: sdhci-of-arasan: fix clk issue in sdhci_arasan_remove()
Date: Tue, 16 Feb 2016 21:08:23 +0800
Message-ID: <1455628111-5583-6-git-send-email-jszhang@marvell.com>
References: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, kernel@stlinux.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

sdhci_pltfm_unregister() could operate host's registers, it will cause
problems if the clk is already disabled and unprepared. Fix this issue
by moving the clk_disable_unprepare() call to the end of remove
function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhc=
i-of-arasan.c
index 5d9fdb3..8b4f8f7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -201,13 +201,16 @@ clk_dis_ahb:
=20
 static int sdhci_arasan_remove(struct platform_device *pdev)
 {
+	int ret;
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan =3D pltfm_host->priv;
=20
+	ret =3D sdhci_pltfm_unregister(pdev);
+
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
=20
-	return sdhci_pltfm_unregister(pdev);
+	return ret;
 }
=20
 static const struct of_device_id sdhci_arasan_of_match[] =3D {
--=20
2.7.0
