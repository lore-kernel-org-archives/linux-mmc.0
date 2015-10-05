From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 2/2] mmc: sdhci-pci: Make sdhci_pci_o2_fujin2_pci_init()
 static
Date: Mon, 05 Oct 2015 20:31:58 +0100
Message-ID: <1444073518.2730.309.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6Tw6CHuoNvHvR1DkKIL+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46751 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751160AbbJETcF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 15:32:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Guo <peter.guo@bayhubtech.com>, linux-mmc@vger.kernel.org


--=-6Tw6CHuoNvHvR1DkKIL+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It has no external callers.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
 drivers/mmc/host/sdhci-pci-o2micro.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9a5e191..d48f031 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -60,7 +60,7 @@ static void o2_pci_led_enable(struct sdhci_pci_chip *chip=
)
=20
 }
=20
-void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
+static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
 {
 	u32 scratch_32;
 	int ret;
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.h b/drivers/mmc/host/sdhci-=
pci-o2micro.h
index f7ffc90..770f538 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.h
+++ b/drivers/mmc/host/sdhci-pci-o2micro.h
@@ -64,8 +64,6 @@
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
=20
-extern void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip);
-
 extern int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
=20
 extern int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
--=20
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source
--=-6Tw6CHuoNvHvR1DkKIL+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVhLQLue/yOyVhhEJAQpz3g/+I5ElYJtYfi/DrQzd9mUq9tMAs3sBOmQa
3Tj7IK71+Nyj4gdBVSbHMn83hCEBvunCxqDBeWZOyDUOmkjGFENiws/EATvBXUnO
hq+uyq78TH5dOR0I/WAyVNTxEVhcq8xiFw0GIU+tpaCk9AAT24PC/QEa8/0qtTN5
2KgsG+gD0aQBxDaP8UzdvsqUuNGF63ornrSauocUbPc7xVSLkB93fwJaiFtrJDdO
ipzKC1D5CXeH2ns3ajfD/Q0/ajY5nAyVQhpiOf1cFwiuVJL9MeUwija+SY718M/U
pIxra8dmZu5nrO49pHKfZI3HSi9m+KYNp0ZXguNCZnlSvCQ9lRjtuHmNZNfWi+C7
QAp/rBKrqVfVi5bD28CZS+fLR8l9biDi7iZzbL0WUNhwYkXtgzeaR90rKEFydq0g
o0qbAvrKu0GD5insGQg8dN+XQp2onTeW1YBowDO72Yr9hB2UnQ9YsKoOZlFEd6Nf
83mA8prJfzISSNKjZ9JtrvwGwbGmwSDVF1NHPjD5kzrDxnw47Nhd4TPi291oPqfO
SxQJXm3GilM5qNcPwiOJRagaG6rQ9uGRsmqsHSd2ko7bS6k6JTQL9ydIx2XKa8gt
pmb5vXODU7ycIWrkhz/Wt1ErKkQEOH7LpVxjFmjdJ/bkef8JLcSRm0WfGdSGpi4U
WOe1BSb9DJ8=
=mXWt
-----END PGP SIGNATURE-----

--=-6Tw6CHuoNvHvR1DkKIL+--
