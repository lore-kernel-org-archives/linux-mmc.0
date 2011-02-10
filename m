From: Will Newton <will.newton@gmail.com>
Subject: [PATCH 1/2] dw_mmc: Run card detect tasklet during slot initialisation.
Date: Thu, 10 Feb 2011 10:40:42 +0000
Message-ID: <AANLkTi=NFjSaGFOrJm24nHB_ngEyqA6eQ4g835yQDMdX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52996 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab1BJKko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 05:40:44 -0500
Received: by bwz15 with SMTP id 15so1947000bwz.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Feb 2011 02:40:43 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Matt Fleming <matt@console-pimps.org>

We need to run the card detect tasklet at the end of slot initialisation
as it is possible that a card has been inserted prior to boot, so we don't
see an insertion interrupt and now the card is sitting there inserted but with
no power to it.

Signed-off-by: Neil Jones <neil.jones@imgtec.com>
Signed-off-by: Will Newton <will.newton@imgtec.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/dw_mmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2fcc825..0b0bedd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1441,6 +1441,13 @@ static int __init dw_mci_init_slot(struct
dw_mci *host, unsigned int id)
 	/* Card initially undetected */
 	slot->last_detect_state = 0;

+
+	/*
+	 * Card may have been plugged in prior to boot so we
+	 * need to run the detect tasklet
+	 */
+	tasklet_schedule(&host->card_tasklet);
+
 	return 0;
 }

-- 
1.7.3.4
