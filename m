From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: sdhci-sirf: Fix build breakage
Date: Tue, 18 Jun 2013 14:24:54 +0530
Message-ID: <1371545694-31877-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:49763 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495Ab3FRJJm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2013 05:09:42 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3714163pbb.36
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2013 02:09:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, Christian Daudt <csd@broadcom.com>, Barry Song <Baohua.Song@csr.com>

Commit 0e74823429 ("mmc: sdhci: Add size for caller in init+register")
introduced size parameter to sdhci_pltfm_init(). This driver probably
got left out during the conversion. Passing in zero as done for other
drivers to avoid the following build error:

drivers/mmc/host/sdhci-sirf.c: In function =E2=80=98sdhci_sirf_probe=E2=
=80=99:
drivers/mmc/host/sdhci-sirf.c:78:2: error: too few arguments to functio=
n
=E2=80=98sdhci_pltfm_init=E2=80=99
  host =3D sdhci_pltfm_init(pdev, &sdhci_sirf_pdata);

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Christian Daudt <csd@broadcom.com>
Cc: Barry Song <Baohua.Song@csr.com>
---
Compile tested on linux-next (20130618)
---
 drivers/mmc/host/sdhci-sirf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sir=
f.c
index 09805af..1a149eb 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -75,7 +75,7 @@ static int sdhci_sirf_probe(struct platform_device *p=
dev)
 		priv->gpio_cd =3D -EINVAL;
 	}
=20
-	host =3D sdhci_pltfm_init(pdev, &sdhci_sirf_pdata);
+	host =3D sdhci_pltfm_init(pdev, &sdhci_sirf_pdata, 0);
 	if (IS_ERR(host)) {
 		ret =3D PTR_ERR(host);
 		goto err_sdhci_pltfm_init;
--=20
1.7.9.5

