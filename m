From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] mmc/sdhci-spear: Fix compilation error
Date: Wed, 4 Jan 2012 11:48:42 +0530
Message-ID: <e3d642d24dc29bb018f1a81d422490957b23cd32.1325657740.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:48191 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753935Ab2ADGTB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 01:19:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

With the inclusion of following patch:
"mmc: sdhci: remove "state" argument from sdhci_suspend_host"

we get a compilation error for sdhci-spear:
drivers/mmc/host/sdhci-spear.c:283:2: error: too many arguments to func=
tion
=E2=80=98sdhci_suspend_host=E2=80=99

This patch fixes this error.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/mmc/host/sdhci-spear.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-sp=
ear.c
index dee70b6..4e1130e 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -277,10 +277,9 @@ static int sdhci_suspend(struct device *dev)
 {
 	struct sdhci_host *host =3D dev_get_drvdata(dev);
 	struct spear_sdhci *sdhci =3D dev_get_platdata(dev);
-	pm_message_t state =3D {.event =3D 0};
 	int ret;
=20
-	ret =3D sdhci_suspend_host(host, state);
+	ret =3D sdhci_suspend_host(host);
 	if (!ret)
 		clk_disable(sdhci->clk);
=20
--=20
1.7.8.110.g4cb5d

