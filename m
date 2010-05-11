From: akpm@linux-foundation.org
Subject: [patch 04/17] mmc: atmel-mci: fix two parameters swapped
Date: Tue, 11 May 2010 14:06:48 -0700
Message-ID: <201005112106.o4BL6mj2023073@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44421 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751123Ab0EKVHA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2010 17:07:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, anders.grahn@hd-wireless.se, hskinnemoen@atmel.com, linux-mmc@vger.kernel.org, stable@kernel.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Two parameters were swapped in the calls to atmci_init_slot().

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reported-by: Anders Grahn <anders.grahn@hd-wireless.se>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-fix-two-parameters-swapped drivers/mmc/host/atmel-mci.c
--- a/drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-fix-two-parameters-swapped
+++ a/drivers/mmc/host/atmel-mci.c
@@ -1751,13 +1751,13 @@ static int __init atmci_probe(struct pla
 	ret = -ENODEV;
 	if (pdata->slot[0].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[0],
-				MCI_SDCSEL_SLOT_A, 0);
+				0, MCI_SDCSEL_SLOT_A);
 		if (!ret)
 			nr_slots++;
 	}
 	if (pdata->slot[1].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[1],
-				MCI_SDCSEL_SLOT_B, 1);
+				1, MCI_SDCSEL_SLOT_B);
 		if (!ret)
 			nr_slots++;
 	}
_
