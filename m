From: Greg KH <gregkh@suse.de>
Subject: [10/39] mmc: atmel-mci: fix two parameters swapped
Date: Mon, 24 May 2010 16:15:22 -0700
Message-ID: <20100524231814.097165007@clark.site>
References: <20100524231840.GA17857@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100524231840.GA17857@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


2.6.33-stable review patch.  If anyone has any objections, please let us know.

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
@@ -1750,13 +1750,13 @@ static int __init atmci_probe(struct pla
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
