From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] MMC: OMAP MSDI: fix broken PIO mode
Date: Fri, 24 Aug 2012 06:00:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1208240555210.25436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-2101401518-1345788018=:25436"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60200 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab2HXGHA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Aug 2012 02:07:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, =?ISO-8859-15?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@nokia.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, Russell King <rmk+kernel@arm.linux.org.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-2101401518-1345788018=:25436
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


After commit 26b88520b80695a6fa5fd95b5d97c03f4daf87e0 ("mmc:
omap_hsmmc: remove private DMA API implementation"), the Nokia N800
here stopped booting:

[    2.086181] Waiting for root device /dev/mmcblk0p1...
[    2.324066] Unhandled fault: imprecise external abort (0x406) at 0x00000=
000
[    2.331451] Internal error: : 406 [#1] ARM
[    2.335784] Modules linked in:
[    2.339050] CPU: 0    Not tainted  (3.6.0-rc3 #60)
[    2.344146] PC is at default_idle+0x28/0x30
[    2.348602] LR is at trace_hardirqs_on_caller+0x15c/0x1b0

=2E..

This turned out to be due to memory corruption caused by long-broken
PIO code in drivers/mmc/host/omap.c.  (Previously, this driver had
been using DMA; but the above commit caused the MMC driver to fall
back to PIO mode with an unmodified Kconfig.)

The PIO code, added with the rest of the driver in commit
730c9b7e6630f786fcec026fb11d2e6f2c90fdcb ("[MMC] Add OMAP MMC host
driver"), confused bytes with 16-bit words.  This bug caused memory
located after the PIO transfer buffer to be corrupted with transfers
larger than 32 bytes.  The driver also did not increment the buffer
pointer after the transfer occurred.  This bug resulted in data
corruption during any transfer larger than 64 bytes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 50e08f0..a5999a7 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -668,7 +668,7 @@ mmc_omap_clk_timer(unsigned long data)
 static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
-=09int n;
+=09int n, nwords;
=20
 =09if (host->buffer_bytes_left =3D=3D 0) {
 =09=09host->sg_idx++;
@@ -678,15 +678,23 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int wr=
ite)
 =09n =3D 64;
 =09if (n > host->buffer_bytes_left)
 =09=09n =3D host->buffer_bytes_left;
+
+=09nwords =3D n / 2;
+=09nwords +=3D n & 1; /* handle odd number of bytes to transfer */
+
 =09host->buffer_bytes_left -=3D n;
 =09host->total_bytes_left -=3D n;
 =09host->data->bytes_xfered +=3D n;
=20
 =09if (write) {
-=09=09__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buff=
er, n);
+=09=09__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA),
+=09=09=09      host->buffer, nwords);
 =09} else {
-=09=09__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffe=
r, n);
+=09=09__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA),
+=09=09=09     host->buffer, nwords);
 =09}
+
+=09host->buffer +=3D nwords;
 }
=20
 static inline void mmc_omap_report_irq(u16 status)
--=20
1.7.10.4

--843723315-2101401518-1345788018=:25436--
