From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v3 04/12] mmc: sdhci-msm: use sdhci_pltfm_init for private
 allocation
Date: Wed, 6 Jan 2016 18:31:35 +0800
Message-ID: <1452076303-1960-5-git-send-email-jszhang@marvell.com>
References: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: Jisheng Zhang <jszhang@marvell.com>, kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-msm
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-msm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index ffac9b4..8a8650b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -442,16 +442,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	u32 core_version, caps;
 	u8 core_major;
 
-	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
-	if (!msm_host)
-		return -ENOMEM;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = msm_host;
+	msm_host = sdhci_pltfm_priv(pltfm_host);
 	msm_host->mmc = host->mmc;
 	msm_host->pdev = pdev;
 
@@ -571,7 +567,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_msm_host *msm_host = pltfm_host->priv;
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int dead = (readl_relaxed(host->ioaddr + SDHCI_INT_STATUS) ==
 		    0xffffffff);
 
-- 
2.7.0.rc3
