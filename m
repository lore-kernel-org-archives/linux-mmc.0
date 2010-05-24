From: Greg KH <gregkh@suse.de>
Subject: [07/34] mmc: atmel-mci: fix two parameters swapped
Date: Mon, 24 May 2010 15:59:39 -0700
Message-ID: <20100524230349.967773989@clark.site>
References: <20100524230418.GA12770@kroah.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:36391 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758928Ab0EXXJT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 May 2010 19:09:19 -0400
In-Reply-To: <20100524230418.GA12770@kroah.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-mmc@vger.kernel.org

2.6.34-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Nicolas Ferre <nicolas.ferre@atmel.com>

commit ebb1fea9b3adf25d7e2f643c614163af4f93a17f upstream.

Two parameters were swapped in the calls to atmci_init_slot().

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reported-by: Anders Grahn <anders.grahn@hd-wireless.se>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1669,13 +1669,13 @@ static int __init atmci_probe(struct pla
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


