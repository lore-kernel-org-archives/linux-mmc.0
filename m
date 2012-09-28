From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/2] mmc: sdhci-spear: Add clk_{un}prepare() support
Date: Fri, 28 Sep 2012 15:58:23 +0530
Message-ID: <a5ffa125606bf00e558145364281e9ea8551ff77.1348828070.git.viresh.kumar@linaro.org>
References: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48166 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2I1K2l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 06:28:41 -0400
In-Reply-To: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
In-Reply-To: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
References: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
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
index ecad282..6be89c0 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -140,7 +140,7 @@ static int __devinit sdhci_probe(struct platform_device=
 *pdev)
 =09=09goto err;
 =09}
=20
-=09ret =3D clk_enable(sdhci->clk);
+=09ret =3D clk_prepare_enable(sdhci->clk);
 =09if (ret) {
 =09=09dev_dbg(&pdev->dev, "Error enabling clock\n");
 =09=09goto put_clk;
@@ -260,7 +260,7 @@ set_drvdata:
 free_host:
 =09sdhci_free_host(host);
 disable_clk:
-=09clk_disable(sdhci->clk);
+=09clk_disable_unprepare(sdhci->clk);
 put_clk:
 =09clk_put(sdhci->clk);
 err:
@@ -282,7 +282,7 @@ static int __devexit sdhci_remove(struct platform_devic=
e *pdev)
=20
 =09sdhci_remove_host(host, dead);
 =09sdhci_free_host(host);
-=09clk_disable(sdhci->clk);
+=09clk_disable_unprepare(sdhci->clk);
 =09clk_put(sdhci->clk);
=20
 =09return 0;
@@ -297,7 +297,7 @@ static int sdhci_suspend(struct device *dev)
=20
 =09ret =3D sdhci_suspend_host(host);
 =09if (!ret)
-=09=09clk_disable(sdhci->clk);
+=09=09clk_disable_unprepare(sdhci->clk);
=20
 =09return ret;
 }
@@ -308,7 +308,7 @@ static int sdhci_resume(struct device *dev)
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


