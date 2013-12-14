From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH] drivers: mmc: Mark the function sdhci_disable_irq_wakeups()
 as static in sdhci.c
Date: Sat, 14 Dec 2013 18:46:31 +0530
Message-ID: <20131214131631.GA8543@rashika>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63034 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab3LNNQj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Dec 2013 08:16:39 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, josh@joshtriplett.org

This patch marks the function sdhci_disable_irq_wakeups() as static in
host/sdhci.c because it is not used outside this file.

Thus, it also eliminates the following warning in host/sdhci.c:
drivers/mmc/host/sdhci.c:2553:6: warning: no previous prototype for =E2=
=80=98sdhci_disable_irq_wakeups=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bd8a098..8de50e8 100644
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
--=20
1.7.9.5

