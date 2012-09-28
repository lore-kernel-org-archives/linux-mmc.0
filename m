From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH Resend 2/2] mmc: sdhci-spear: Add clk_{un}prepare() support
Date: Fri, 28 Sep 2012 10:48:09 +0530
Message-ID: <4c4801cf7e901a14f2a98764a9478cd75d5b1010.1348809217.git.viresh.kumar2@arm.com>
References: <viresh.kumar@linaro.org>
 <a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48596 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2I1FSX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 01:18:23 -0400
In-Reply-To: <a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
In-Reply-To: <a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
References: <a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de, Viresh Kumar <viresh.kumar@linaro.org>

clk_{un}prepare is mandatory for platforms using common clock framework. Si=
nce
this driver is used by SPEAr platform, which supports common clock framewor=
k,
add clk_{un}prepare() support for it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mmc/host/sdhci-spear.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.=
c
index 1e82d0f..df96663 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -154,7 +154,7 @@ static int __devinit sdhci_probe(struct platform_device=
 *pdev)
 =09=09goto err;
 =09}
=20
-=09ret =3D clk_enable(sdhci->clk);
+=09ret =3D clk_prepare_enable(sdhci->clk);
 =09if (ret) {
 =09=09dev_dbg(&pdev->dev, "Error enabling clock\n");
 =09=09goto put_clk;
@@ -274,7 +274,7 @@ set_drvdata:
 free_host:
 =09sdhci_free_host(host);
 disable_clk:
-=09clk_disable(sdhci->clk);
+=09clk_disable_unprepare(sdhci->clk);
 put_clk:
 =09clk_put(sdhci->clk);
 err:
@@ -296,7 +296,7 @@ static int __devexit sdhci_remove(struct platform_devic=
e *pdev)
=20
 =09sdhci_remove_host(host, dead);
 =09sdhci_free_host(host);
-=09clk_disable(sdhci->clk);
+=09clk_disable_unprepare(sdhci->clk);
 =09clk_put(sdhci->clk);
=20
 =09return 0;
@@ -311,7 +311,7 @@ static int sdhci_suspend(struct device *dev)
=20
 =09ret =3D sdhci_suspend_host(host);
 =09if (!ret)
-=09=09clk_disable(sdhci->clk);
+=09=09clk_disable_unprepare(sdhci->clk);
=20
 =09return ret;
 }
@@ -322,7 +322,7 @@ static int sdhci_resume(struct device *dev)
 =09struct spear_sdhci *sdhci =3D dev_get_platdata(dev);
 =09int ret;
=20
-=09ret =3D clk_enable(sdhci->clk);
+=09ret =3D clk_prepare_enable(sdhci->clk);
 =09if (ret) {
 =09=09dev_dbg(dev, "Resume: Error enabling clock\n");
 =09=09return ret;
--=20
1.7.12.rc2.18.g61b472e


