From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 14/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:09:48 -0800
Message-ID: <E9DF4A50-CA7D-4A92-B912-F399667CB7A0@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_E9DF4A50CA7D4A92B912F399667CB7A0marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49703 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752301Ab0LVHMp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:12:45 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_E9DF4A50CA7D4A92B912F399667CB7A0marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From dbf8c6d4752e076691cf75b39a242a64303a383d Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sun, 19 Dec 2010 15:35:00 -0800
Subject: [PATCH] sdhci: add ops to force delay in operations due to silicon=
 issues

PXA168 controller needs at least 8 clocks before it can start the
next transaction.  When the bus speed is slow the CPU can get back
to the controller before the 8 clocks causing SD CRC errors.

Add a new host->op to call into platform specific code to delay
the operation until the time has expired

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6486009..ff9d5f0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -922,6 +922,14 @@ static void sdhci_send_command(struct sdhci_host *host=
, struct mmc_command *cmd)
 		mdelay(1);
 	}
=20
+	/*
+	 * we cannot talk to controller for 8 bus cycles according to sdio spec
+	 * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
+	 * which is quite a LONG TIME on a fast cpu -- so delay if needed
+	 */
+	if (host->ops->platform_specific_delay)
+		host->ops->platform_specific_delay(host);
+
 	mod_timer(&host->timer, jiffies + 10 * HZ);
=20
 	host->cmd =3D cmd;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a8c43c9..91749dc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -225,6 +225,7 @@ struct sdhci_ops {
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
+	void	(*platform_specific_delay)(struct sdhci_host *host);
 };
=20
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--=20
1.6.0.4

--_002_E9DF4A50CA7D4A92B912F399667CB7A0marvellcom_
Content-Type: application/octet-stream;
	name="0014-sdhci-add-ops-to-force-delay-in-operations-due-to-s.patch"
Content-Description: 0014-sdhci-add-ops-to-force-delay-in-operations-due-to-s.patch
Content-Disposition: attachment;
	filename="0014-sdhci-add-ops-to-force-delay-in-operations-due-to-s.patch";
	size=1879; creation-date="Tue, 21 Dec 2010 23:09:48 GMT";
	modification-date="Tue, 21 Dec 2010 23:09:48 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkYmY4YzZkNDc1MmUwNzY2OTFjZjc1YjM5YTI0MmE2NDMwM2EzODNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDE1OjM1OjAwIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IGFkZCBvcHMgdG8gZm9yY2UgZGVsYXkgaW4gb3BlcmF0aW9ucyBkdWUgdG8gc2lsaWNvbiBp
c3N1ZXMKClBYQTE2OCBjb250cm9sbGVyIG5lZWRzIGF0IGxlYXN0IDggY2xvY2tzIGJlZm9yZSBp
dCBjYW4gc3RhcnQgdGhlCm5leHQgdHJhbnNhY3Rpb24uICBXaGVuIHRoZSBidXMgc3BlZWQgaXMg
c2xvdyB0aGUgQ1BVIGNhbiBnZXQgYmFjawp0byB0aGUgY29udHJvbGxlciBiZWZvcmUgdGhlIDgg
Y2xvY2tzIGNhdXNpbmcgU0QgQ1JDIGVycm9ycy4KCkFkZCBhIG5ldyBob3N0LT5vcCB0byBjYWxs
IGludG8gcGxhdGZvcm0gc3BlY2lmaWMgY29kZSB0byBkZWxheQp0aGUgb3BlcmF0aW9uIHVudGls
IHRoZSB0aW1lIGhhcyBleHBpcmVkCgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFr
aXR5QG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8ICAgIDggKysr
KysrKysKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCB8ICAgIDEgKwogMiBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmluZGV4IDY0ODYwMDku
LmZmOWQ1ZjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYworKysgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTkyMiw2ICs5MjIsMTQgQEAgc3RhdGljIHZvaWQgc2Ro
Y2lfc2VuZF9jb21tYW5kKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBzdHJ1Y3QgbW1jX2NvbW1h
bmQgKmNtZCkKIAkJbWRlbGF5KDEpOwogCX0KIAorCS8qCisJICogd2UgY2Fubm90IHRhbGsgdG8g
Y29udHJvbGxlciBmb3IgOCBidXMgY3ljbGVzIGFjY29yZGluZyB0byBzZGlvIHNwZWMKKwkgKiBh
dCBsb3dlc3Qgc3BlZWQgdGhpcyBpcyAxMDAsMDAwIEhaIHBlciBjeWNsZSBvciA4MDAsMDAwIGN5
Y2xlcworCSAqIHdoaWNoIGlzIHF1aXRlIGEgTE9ORyBUSU1FIG9uIGEgZmFzdCBjcHUgLS0gc28g
ZGVsYXkgaWYgbmVlZGVkCisJICovCisJaWYgKGhvc3QtPm9wcy0+cGxhdGZvcm1fc3BlY2lmaWNf
ZGVsYXkpCisJCWhvc3QtPm9wcy0+cGxhdGZvcm1fc3BlY2lmaWNfZGVsYXkoaG9zdCk7CisKIAlt
b2RfdGltZXIoJmhvc3QtPnRpbWVyLCBqaWZmaWVzICsgMTAgKiBIWik7CiAKIAlob3N0LT5jbWQg
PSBjbWQ7CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmgKaW5kZXggYThjNDNjOS4uOTE3NDlkYyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS5oCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtMjI1
LDYgKzIyNSw3IEBAIHN0cnVjdCBzZGhjaV9vcHMgewogCXZvaWQJKCpwbGF0Zm9ybV9yZXNldF9l
bnRlcikoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHU4IG1hc2spOwogCXZvaWQJKCpwbGF0Zm9y
bV9yZXNldF9leGl0KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzayk7CiAJdW5zaWdu
ZWQgaW50CSgqZ2V0X2ZfbWF4X2Nsb2NrKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CisJdm9p
ZAkoKnBsYXRmb3JtX3NwZWNpZmljX2RlbGF5KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CiB9
OwogCiAjaWZkZWYgQ09ORklHX01NQ19TREhDSV9JT19BQ0NFU1NPUlMKLS0gCjEuNi4wLjQKCg==

--_002_E9DF4A50CA7D4A92B912F399667CB7A0marvellcom_--
