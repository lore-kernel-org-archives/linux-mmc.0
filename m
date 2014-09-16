From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] mmc: dw_mmc: Remove unused function for !CONFIG_OF
Date: Tue, 16 Sep 2014 09:54:55 +0200
Message-ID: <1410854095-10460-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:48387 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428AbaIPHzF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Sep 2014 03:55:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

dw_mci_of_find_slot_node() is only used in dw_mci_of_get_slot_quirks()
if CONFIG_OF is defined, thus there is no need to have a !CONFIG_OF
version of it. Fixes the following compile warning with !CONFIG_OF:

  CC [M]  drivers/mmc/host/dw_mmc.o
drivers/mmc/host/dw_mmc.c:2223:28: warning: =E2=80=98dw_mci_of_find_slo=
t_node=E2=80=99 defined but not used [-Wunused-function]

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/mmc/host/dw_mmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 835e913..109fefe 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2220,10 +2220,6 @@ static int dw_mci_of_get_slot_quirks(struct devi=
ce *dev, u8 slot)
 {
 	return 0;
 }
-static struct device_node *dw_mci_of_find_slot_node(struct device *dev=
, u8 slot)
-{
-	return NULL;
-}
 #endif /* CONFIG_OF */
=20
 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
--=20
2.0.1


