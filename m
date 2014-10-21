From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH RESEND 05/12] mmc: sdhci-pxav3: Remove checks for mandatory host clock
Date: Tue, 21 Oct 2014 11:22:37 +0200
Message-ID: <1413883364-681-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

NULL-checking a struct clk it not only wrong but also not required as
for PXAv3 driver the corresponding clock is mandatory. Remove the
checks from sdhci_pxav3_runtime_{suspend,resume}.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Antoine T=C3=A9nart" <antoine.tenart@free-electrons.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mmc/host/sdhci-pxav3.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-px=
av3.c
index d1f63d32b2cd..e52bbbb09d88 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -448,13 +448,11 @@ static int sdhci_pxav3_runtime_suspend(struct dev=
ice *dev)
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
 	unsigned long flags;
=20
-	if (pltfm_host->clk) {
-		spin_lock_irqsave(&host->lock, flags);
-		host->runtime_suspended =3D true;
-		spin_unlock_irqrestore(&host->lock, flags);
+	spin_lock_irqsave(&host->lock, flags);
+	host->runtime_suspended =3D true;
+	spin_unlock_irqrestore(&host->lock, flags);
=20
-		clk_disable_unprepare(pltfm_host->clk);
-	}
+	clk_disable_unprepare(pltfm_host->clk);
=20
 	return 0;
 }
@@ -465,13 +463,11 @@ static int sdhci_pxav3_runtime_resume(struct devi=
ce *dev)
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
 	unsigned long flags;
=20
-	if (pltfm_host->clk) {
-		clk_prepare_enable(pltfm_host->clk);
+	clk_prepare_enable(pltfm_host->clk);
=20
-		spin_lock_irqsave(&host->lock, flags);
-		host->runtime_suspended =3D false;
-		spin_unlock_irqrestore(&host->lock, flags);
-	}
+	spin_lock_irqsave(&host->lock, flags);
+	host->runtime_suspended =3D false;
+	spin_unlock_irqrestore(&host->lock, flags);
=20
 	return 0;
 }
--=20
2.1.1
