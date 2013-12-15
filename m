From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20drivers=3A=20mmc=3A=20Mark=20the=20function=20sdhci=5Fdisable=5Firq=5Fwakeups=28=29=20as=20static=20in=20sdhci=2Ec?=
Date: Mon, 16 Dec 2013 00:59:16 +0530
Message-ID: <1387135756-27057-1-git-send-email-rashika.kheria@gmail.com>
References: <20131214131631.GA8543@rashika>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60028 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab3LOT31 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Dec 2013 14:29:27 -0500
In-Reply-To: <20131214131631.GA8543@rashika>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, josh@joshtriplett.org

This patch marks the function sdhci_disable_irq_wakeups() as static in
host/sdhci.c because it is not used outside this file. It also removes
the EXPORT_SYMBOL_GPL because no other file in kernel uses this
function.

Thus, it also eliminates the following warning in host/sdhci.c:
drivers/mmc/host/sdhci.c:2553:6: warning: no previous prototype for =E2=
=80=98sdhci_disable_irq_wakeups=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/mmc/host/sdhci.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bd8a098..5fcf200 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2550,7 +2550,7 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *=
host)
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
=20
-void sdhci_disable_irq_wakeups(struct sdhci_host *host)
+static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask =3D SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
@@ -2560,7 +2560,6 @@ void sdhci_disable_irq_wakeups(struct sdhci_host =
*host)
 	val &=3D ~mask;
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
-EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
=20
 int sdhci_suspend_host(struct sdhci_host *host)
 {
--=20
1.7.9.5

