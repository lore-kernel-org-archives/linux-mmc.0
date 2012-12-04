From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: sdhci-s3c: Fix compilation warning
Date: Tue,  4 Dec 2012 17:03:07 +0530
Message-ID: <1354620787-20575-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38270 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2LDLjy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 06:39:54 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2778207pbc.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Dec 2012 03:39:53 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, ben-linux@fluff.org, sachin.kamat@linaro.org, patches@linaro.org

'sc' is used only when CONFIG_PM_RUNTIME is defined. Hence define it
conditionally.

Silences the following warning:
drivers/mmc/host/sdhci-s3c.c: In function =E2=80=98sdhci_s3c_notify_cha=
nge=E2=80=99:
drivers/mmc/host/sdhci-s3c.c:378:20: warning: unused variable =E2=80=98=
sc=E2=80=99 [-Wunused-variable]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.=
c
index 7ea3aea..82a8de1 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -375,7 +375,9 @@ static struct sdhci_ops sdhci_s3c_ops =3D {
 static void sdhci_s3c_notify_change(struct platform_device *dev, int s=
tate)
 {
 	struct sdhci_host *host =3D platform_get_drvdata(dev);
+#ifdef CONFIG_PM_RUNTIME
 	struct sdhci_s3c *sc =3D sdhci_priv(host);
+#endif
 	unsigned long flags;
=20
 	if (host) {
--=20
1.7.4.1

