From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 18/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:10:43 -0800
Message-ID: <2892BF36-424E-4620-93B9-000CA5222F82@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_2892BF36424E462093B9000CA5222F82marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49941 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752418Ab0LVHNS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:13:18 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_2892BF36424E462093B9000CA5222F82marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>From 64b1814102b52c8b354d75e58b2ffb12119eb54d Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 15:27:29 -0800
Subject: [PATCH] mmc: add support for H/W clock gating of SD controller

This code extends software clock gating in the MMC layer by adding the abil=
ity
to indicate that the SD controller supports hardware clock gating.

Hardware clock gating is enabled by setting the MMC capability
MMC_CAP_HW_CLOCK_GATING in the SD driver.

eg: host->mmc->caps |=3D MMC_CAP_HW_CLOCK_GATING

The approach follows the suggestion of Nico Pitre.

SD/MMC/eMMC cards use dynamic clocks
SDIO uses continuous clocks to properly detect SDIO card interrupts

The code has been tested using marvell linux for MMP2.  The Marvell
controller support H/W clock gating.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/core/core.c  |   33 +++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |   13 +++++++++++++
 drivers/mmc/core/host.c  |   17 ++++++++++++++++-
 include/linux/mmc/host.h |    1 +
 4 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8e89f3..259bd0d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -683,10 +683,35 @@ void mmc_ungate_clock(struct mmc_host *host)
 	}
 }
=20
+/*
+ * Let hardware automatically gate the clock when the card becomes idle
+ */
+void mmc_hwgate_clock(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING) {
+		host->clk_gated =3D true;
+		mmc_set_ios(host);
+	}
+}
+
+/*
+ * This ungates the clock by turning off h/w gating
+ */
+void mmc_hwungate_clock(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING) {
+		host->clk_gated =3D false;
+		mmc_set_ios(host);
+	}
+}
+
+
 void mmc_set_ungated(struct mmc_host *host)
 {
 	unsigned long flags;
=20
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
 	/*
 	 * We've been given a new frequency while the clock is gated,
 	 * so make sure we regard this as ungating it.
@@ -1553,6 +1578,7 @@ void mmc_rescan(struct work_struct *work)
 			mmc_hostname(host), __func__, host->f_init);
 #endif
 		mmc_power_up(host);
+		mmc_hwungate_clock(host);
 		sdio_reset(host);
 		mmc_go_idle(host);
=20
@@ -1577,6 +1603,9 @@ void mmc_rescan(struct work_struct *work)
 				if (mmc_send_app_op_cond(host, 0, &ocr))
 					goto out_fail;
=20
+				/* hw clock gating is off when we get here */
+				/* do not enable clock gating for sdio cards */
+				/* sdio cards can miss interrupts */
 				if (mmc_attach_sd(host, ocr))
 					mmc_power_off(host);
 			}
@@ -1590,6 +1619,8 @@ void mmc_rescan(struct work_struct *work)
 		if (!err) {
 			if (mmc_attach_sd(host, ocr))
 				mmc_power_off(host);
+			else
+				mmc_hwgate_clock(host);
 			goto out;
 		}
=20
@@ -1600,6 +1631,8 @@ void mmc_rescan(struct work_struct *work)
 		if (!err) {
 			if (mmc_attach_mmc(host, ocr))
 				mmc_power_off(host);
+			else
+				mmc_hwgate_clock(host);
 			goto out;
 		}
=20
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..3810e28 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -35,6 +35,19 @@ void mmc_set_chip_select(struct mmc_host *host, int mode=
);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
 void mmc_gate_clock(struct mmc_host *host);
 void mmc_ungate_clock(struct mmc_host *host);
+
+#ifdef CONFIG_MMC_CLKGATE
+void mmc_hwgate_clock(struct mmc_host *host);
+void mmc_hwungate_clock(struct mmc_host *host);
+#else
+static inline void mmc_hwgate_clock(struct mmc_host *host)
+{
+}
+
+static inline void mmc_hwungate_clock(struct mmc_host *host)
+{
+}
+#endif
 void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 92e3370..eebabde 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -130,6 +130,9 @@ void mmc_host_clk_ungate(struct mmc_host *host)
 {
 	unsigned long flags;
=20
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	mutex_lock(&host->clk_gate_mutex);
 	spin_lock_irqsave(&host->clk_lock, flags);
 	if (host->clk_gated) {
@@ -178,6 +181,9 @@ void mmc_host_clk_gate(struct mmc_host *host)
 {
 	unsigned long flags;
=20
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	spin_lock_irqsave(&host->clk_lock, flags);
 	host->clk_requests--;
 	if (mmc_host_may_gate_card(host->card) &&
@@ -198,7 +204,10 @@ unsigned int mmc_host_clk_rate(struct mmc_host *host)
 	unsigned long flags;
=20
 	spin_lock_irqsave(&host->clk_lock, flags);
-	if (host->clk_gated)
+		freq =3D host->ios.clock;
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		freq =3D host->ios.clock;
+	else if (host->clk_gated)
 		freq =3D host->clk_old;
 	else
 		freq =3D host->ios.clock;
@@ -212,6 +221,9 @@ unsigned int mmc_host_clk_rate(struct mmc_host *host)
  */
 static inline void mmc_host_clk_init(struct mmc_host *host)
 {
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	host->clk_requests =3D 0;
 	/* Hold MCI clock for 8 cycles by default */
 	host->clk_delay =3D 8;
@@ -227,6 +239,9 @@ static inline void mmc_host_clk_init(struct mmc_host *h=
ost)
  */
 static inline void mmc_host_clk_exit(struct mmc_host *host)
 {
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	/*
 	 * Wait for any outstanding gate and then make sure we're
 	 * ungated before exiting.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..4e4baff 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -173,6 +173,7 @@ struct mmc_host {
 						/* DDR mode at 1.2V */
 #define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
 #define MMC_CAP_BUS_WIDTH_TEST	(1 << 14)	/* CMD14/CMD19 bus width ok */
+#define MMC_CAP_HW_CLOCK_GATING	(1 << 15)	/* h/w supports clock gating */
=20
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
=20
--=20
1.6.0.4

--_002_2892BF36424E462093B9000CA5222F82marvellcom_
Content-Type: application/octet-stream;
	name="0018-mmc-add-support-for-H-W-clock-gating-of-SD-controll.patch"
Content-Description: 0018-mmc-add-support-for-H-W-clock-gating-of-SD-controll.patch
Content-Disposition: attachment;
	filename="0018-mmc-add-support-for-H-W-clock-gating-of-SD-controll.patch";
	size=6020; creation-date="Tue, 21 Dec 2010 23:10:44 GMT";
	modification-date="Tue, 21 Dec 2010 23:10:44 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2NGIxODE0MTAyYjUyYzhiMzU0ZDc1ZTU4YjJmZmIxMjExOWViNTRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDE1OjI3OjI5IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gbW1j
OiBhZGQgc3VwcG9ydCBmb3IgSC9XIGNsb2NrIGdhdGluZyBvZiBTRCBjb250cm9sbGVyCgpUaGlz
IGNvZGUgZXh0ZW5kcyBzb2Z0d2FyZSBjbG9jayBnYXRpbmcgaW4gdGhlIE1NQyBsYXllciBieSBh
ZGRpbmcgdGhlIGFiaWxpdHkKdG8gaW5kaWNhdGUgdGhhdCB0aGUgU0QgY29udHJvbGxlciBzdXBw
b3J0cyBoYXJkd2FyZSBjbG9jayBnYXRpbmcuCgpIYXJkd2FyZSBjbG9jayBnYXRpbmcgaXMgZW5h
YmxlZCBieSBzZXR0aW5nIHRoZSBNTUMgY2FwYWJpbGl0eQpNTUNfQ0FQX0hXX0NMT0NLX0dBVElO
RyBpbiB0aGUgU0QgZHJpdmVyLgoKZWc6IGhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQX0hXX0NM
T0NLX0dBVElORwoKVGhlIGFwcHJvYWNoIGZvbGxvd3MgdGhlIHN1Z2dlc3Rpb24gb2YgTmljbyBQ
aXRyZS4KClNEL01NQy9lTU1DIGNhcmRzIHVzZSBkeW5hbWljIGNsb2NrcwpTRElPIHVzZXMgY29u
dGludW91cyBjbG9ja3MgdG8gcHJvcGVybHkgZGV0ZWN0IFNESU8gY2FyZCBpbnRlcnJ1cHRzCgpU
aGUgY29kZSBoYXMgYmVlbiB0ZXN0ZWQgdXNpbmcgbWFydmVsbCBsaW51eCBmb3IgTU1QMi4gIFRo
ZSBNYXJ2ZWxsCmNvbnRyb2xsZXIgc3VwcG9ydCBIL1cgY2xvY2sgZ2F0aW5nLgoKU2lnbmVkLW9m
Zi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KU2lnbmVkLW9mZi1ieTog
TWFyayBGLiBCcm93biA8bWFya2JAbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvY29yZS9j
b3JlLmMgIHwgICAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMv
bW1jL2NvcmUvY29yZS5oICB8ICAgMTMgKysrKysrKysrKysrKwogZHJpdmVycy9tbWMvY29yZS9o
b3N0LmMgIHwgICAxNyArKysrKysrKysrKysrKysrLQogaW5jbHVkZS9saW51eC9tbWMvaG9zdC5o
IHwgICAgMSArCiA0IGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgYi9kcml2ZXJzL21tYy9j
b3JlL2NvcmUuYwppbmRleCBhOGU4OWYzLi4yNTliZDBkIDEwMDY0NAotLS0gYS9kcml2ZXJzL21t
Yy9jb3JlL2NvcmUuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYwpAQCAtNjgzLDEwICs2
ODMsMzUgQEAgdm9pZCBtbWNfdW5nYXRlX2Nsb2NrKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKIAl9
CiB9CiAKKy8qCisgKiBMZXQgaGFyZHdhcmUgYXV0b21hdGljYWxseSBnYXRlIHRoZSBjbG9jayB3
aGVuIHRoZSBjYXJkIGJlY29tZXMgaWRsZQorICovCit2b2lkIG1tY19od2dhdGVfY2xvY2soc3Ry
dWN0IG1tY19ob3N0ICpob3N0KQoreworCWlmIChob3N0LT5jYXBzICYgTU1DX0NBUF9IV19DTE9D
S19HQVRJTkcpIHsKKwkJaG9zdC0+Y2xrX2dhdGVkID0gdHJ1ZTsKKwkJbW1jX3NldF9pb3MoaG9z
dCk7CisJfQorfQorCisvKgorICogVGhpcyB1bmdhdGVzIHRoZSBjbG9jayBieSB0dXJuaW5nIG9m
ZiBoL3cgZ2F0aW5nCisgKi8KK3ZvaWQgbW1jX2h3dW5nYXRlX2Nsb2NrKHN0cnVjdCBtbWNfaG9z
dCAqaG9zdCkKK3sKKwlpZiAoaG9zdC0+Y2FwcyAmIE1NQ19DQVBfSFdfQ0xPQ0tfR0FUSU5HKSB7
CisJCWhvc3QtPmNsa19nYXRlZCA9IGZhbHNlOworCQltbWNfc2V0X2lvcyhob3N0KTsKKwl9Cit9
CisKKwogdm9pZCBtbWNfc2V0X3VuZ2F0ZWQoc3RydWN0IG1tY19ob3N0ICpob3N0KQogewogCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7CiAKKwlpZiAoaG9zdC0+Y2FwcyAmIE1NQ19DQVBfSFdfQ0xPQ0tf
R0FUSU5HKQorCQlyZXR1cm47CiAJLyoKIAkgKiBXZSd2ZSBiZWVuIGdpdmVuIGEgbmV3IGZyZXF1
ZW5jeSB3aGlsZSB0aGUgY2xvY2sgaXMgZ2F0ZWQsCiAJICogc28gbWFrZSBzdXJlIHdlIHJlZ2Fy
ZCB0aGlzIGFzIHVuZ2F0aW5nIGl0LgpAQCAtMTU1Myw2ICsxNTc4LDcgQEAgdm9pZCBtbWNfcmVz
Y2FuKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAkJCW1tY19ob3N0bmFtZShob3N0KSwgX19m
dW5jX18sIGhvc3QtPmZfaW5pdCk7CiAjZW5kaWYKIAkJbW1jX3Bvd2VyX3VwKGhvc3QpOworCQlt
bWNfaHd1bmdhdGVfY2xvY2soaG9zdCk7CiAJCXNkaW9fcmVzZXQoaG9zdCk7CiAJCW1tY19nb19p
ZGxlKGhvc3QpOwogCkBAIC0xNTc3LDYgKzE2MDMsOSBAQCB2b2lkIG1tY19yZXNjYW4oc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJCWlmIChtbWNfc2VuZF9hcHBfb3BfY29uZChob3N0LCAw
LCAmb2NyKSkKIAkJCQkJZ290byBvdXRfZmFpbDsKIAorCQkJCS8qIGh3IGNsb2NrIGdhdGluZyBp
cyBvZmYgd2hlbiB3ZSBnZXQgaGVyZSAqLworCQkJCS8qIGRvIG5vdCBlbmFibGUgY2xvY2sgZ2F0
aW5nIGZvciBzZGlvIGNhcmRzICovCisJCQkJLyogc2RpbyBjYXJkcyBjYW4gbWlzcyBpbnRlcnJ1
cHRzICovCiAJCQkJaWYgKG1tY19hdHRhY2hfc2QoaG9zdCwgb2NyKSkKIAkJCQkJbW1jX3Bvd2Vy
X29mZihob3N0KTsKIAkJCX0KQEAgLTE1OTAsNiArMTYxOSw4IEBAIHZvaWQgbW1jX3Jlc2Nhbihz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCWlmICghZXJyKSB7CiAJCQlpZiAobW1jX2F0dGFj
aF9zZChob3N0LCBvY3IpKQogCQkJCW1tY19wb3dlcl9vZmYoaG9zdCk7CisJCQllbHNlCisJCQkJ
bW1jX2h3Z2F0ZV9jbG9jayhob3N0KTsKIAkJCWdvdG8gb3V0OwogCQl9CiAKQEAgLTE2MDAsNiAr
MTYzMSw4IEBAIHZvaWQgbW1jX3Jlc2NhbihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCWlm
ICghZXJyKSB7CiAJCQlpZiAobW1jX2F0dGFjaF9tbWMoaG9zdCwgb2NyKSkKIAkJCQltbWNfcG93
ZXJfb2ZmKGhvc3QpOworCQkJZWxzZQorCQkJCW1tY19od2dhdGVfY2xvY2soaG9zdCk7CiAJCQln
b3RvIG91dDsKIAkJfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuaCBiL2Ry
aXZlcnMvbW1jL2NvcmUvY29yZS5oCmluZGV4IDAyNmM5NzUuLjM4MTBlMjggMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCkBA
IC0zNSw2ICszNSwxOSBAQCB2b2lkIG1tY19zZXRfY2hpcF9zZWxlY3Qoc3RydWN0IG1tY19ob3N0
ICpob3N0LCBpbnQgbW9kZSk7CiB2b2lkIG1tY19zZXRfY2xvY2soc3RydWN0IG1tY19ob3N0ICpo
b3N0LCB1bnNpZ25lZCBpbnQgaHopOwogdm9pZCBtbWNfZ2F0ZV9jbG9jayhzdHJ1Y3QgbW1jX2hv
c3QgKmhvc3QpOwogdm9pZCBtbWNfdW5nYXRlX2Nsb2NrKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCk7
CisKKyNpZmRlZiBDT05GSUdfTU1DX0NMS0dBVEUKK3ZvaWQgbW1jX2h3Z2F0ZV9jbG9jayhzdHJ1
Y3QgbW1jX2hvc3QgKmhvc3QpOwordm9pZCBtbWNfaHd1bmdhdGVfY2xvY2soc3RydWN0IG1tY19o
b3N0ICpob3N0KTsKKyNlbHNlCitzdGF0aWMgaW5saW5lIHZvaWQgbW1jX2h3Z2F0ZV9jbG9jayhz
dHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCit7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBtbWNfaHd1
bmdhdGVfY2xvY2soc3RydWN0IG1tY19ob3N0ICpob3N0KQoreworfQorI2VuZGlmCiB2b2lkIG1t
Y19zZXRfdW5nYXRlZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpOwogdm9pZCBtbWNfc2V0X2J1c19t
b2RlKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IG1vZGUpOwogdm9pZCBtbWNf
c2V0X2J1c193aWR0aChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCB3aWR0aCk7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2hvc3QuYyBiL2RyaXZlcnMvbW1jL2NvcmUv
aG9zdC5jCmluZGV4IDkyZTMzNzAuLmVlYmFiZGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2Nv
cmUvaG9zdC5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jCkBAIC0xMzAsNiArMTMwLDkg
QEAgdm9pZCBtbWNfaG9zdF9jbGtfdW5nYXRlKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKIHsKIAl1
bnNpZ25lZCBsb25nIGZsYWdzOwogCisJaWYgKGhvc3QtPmNhcHMgJiBNTUNfQ0FQX0hXX0NMT0NL
X0dBVElORykKKwkJcmV0dXJuOworCiAJbXV0ZXhfbG9jaygmaG9zdC0+Y2xrX2dhdGVfbXV0ZXgp
OwogCXNwaW5fbG9ja19pcnFzYXZlKCZob3N0LT5jbGtfbG9jaywgZmxhZ3MpOwogCWlmIChob3N0
LT5jbGtfZ2F0ZWQpIHsKQEAgLTE3OCw2ICsxODEsOSBAQCB2b2lkIG1tY19ob3N0X2Nsa19nYXRl
KHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKIHsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCisJaWYg
KGhvc3QtPmNhcHMgJiBNTUNfQ0FQX0hXX0NMT0NLX0dBVElORykKKwkJcmV0dXJuOworCiAJc3Bp
bl9sb2NrX2lycXNhdmUoJmhvc3QtPmNsa19sb2NrLCBmbGFncyk7CiAJaG9zdC0+Y2xrX3JlcXVl
c3RzLS07CiAJaWYgKG1tY19ob3N0X21heV9nYXRlX2NhcmQoaG9zdC0+Y2FyZCkgJiYKQEAgLTE5
OCw3ICsyMDQsMTAgQEAgdW5zaWduZWQgaW50IG1tY19ob3N0X2Nsa19yYXRlKHN0cnVjdCBtbWNf
aG9zdCAqaG9zdCkKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCiAJc3Bpbl9sb2NrX2lycXNhdmUo
Jmhvc3QtPmNsa19sb2NrLCBmbGFncyk7Ci0JaWYgKGhvc3QtPmNsa19nYXRlZCkKKwkJZnJlcSA9
IGhvc3QtPmlvcy5jbG9jazsKKwlpZiAoaG9zdC0+Y2FwcyAmIE1NQ19DQVBfSFdfQ0xPQ0tfR0FU
SU5HKQorCQlmcmVxID0gaG9zdC0+aW9zLmNsb2NrOworCWVsc2UgaWYgKGhvc3QtPmNsa19nYXRl
ZCkKIAkJZnJlcSA9IGhvc3QtPmNsa19vbGQ7CiAJZWxzZQogCQlmcmVxID0gaG9zdC0+aW9zLmNs
b2NrOwpAQCAtMjEyLDYgKzIyMSw5IEBAIHVuc2lnbmVkIGludCBtbWNfaG9zdF9jbGtfcmF0ZShz
dHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCiAgKi8KIHN0YXRpYyBpbmxpbmUgdm9pZCBtbWNfaG9zdF9j
bGtfaW5pdChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCiB7CisJaWYgKGhvc3QtPmNhcHMgJiBNTUNf
Q0FQX0hXX0NMT0NLX0dBVElORykKKwkJcmV0dXJuOworCiAJaG9zdC0+Y2xrX3JlcXVlc3RzID0g
MDsKIAkvKiBIb2xkIE1DSSBjbG9jayBmb3IgOCBjeWNsZXMgYnkgZGVmYXVsdCAqLwogCWhvc3Qt
PmNsa19kZWxheSA9IDg7CkBAIC0yMjcsNiArMjM5LDkgQEAgc3RhdGljIGlubGluZSB2b2lkIG1t
Y19ob3N0X2Nsa19pbml0KHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKICAqLwogc3RhdGljIGlubGlu
ZSB2b2lkIG1tY19ob3N0X2Nsa19leGl0KHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKIHsKKwlpZiAo
aG9zdC0+Y2FwcyAmIE1NQ19DQVBfSFdfQ0xPQ0tfR0FUSU5HKQorCQlyZXR1cm47CisKIAkvKgog
CSAqIFdhaXQgZm9yIGFueSBvdXRzdGFuZGluZyBnYXRlIGFuZCB0aGVuIG1ha2Ugc3VyZSB3ZSdy
ZQogCSAqIHVuZ2F0ZWQgYmVmb3JlIGV4aXRpbmcuCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L21tYy9ob3N0LmggYi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmgKaW5kZXggYmNiNzkzZS4uNGU0
YmFmZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oCisrKyBiL2luY2x1ZGUv
bGludXgvbW1jL2hvc3QuaApAQCAtMTczLDYgKzE3Myw3IEBAIHN0cnVjdCBtbWNfaG9zdCB7CiAJ
CQkJCQkvKiBERFIgbW9kZSBhdCAxLjJWICovCiAjZGVmaW5lIE1NQ19DQVBfUE9XRVJfT0ZGX0NB
UkQJKDEgPDwgMTMpCS8qIENhbiBwb3dlciBvZmYgYWZ0ZXIgYm9vdCAqLwogI2RlZmluZSBNTUNf
Q0FQX0JVU19XSURUSF9URVNUCSgxIDw8IDE0KQkvKiBDTUQxNC9DTUQxOSBidXMgd2lkdGggb2sg
Ki8KKyNkZWZpbmUgTU1DX0NBUF9IV19DTE9DS19HQVRJTkcJKDEgPDwgMTUpCS8qIGgvdyBzdXBw
b3J0cyBjbG9jayBnYXRpbmcgKi8KIAogCW1tY19wbV9mbGFnX3QJCXBtX2NhcHM7CS8qIHN1cHBv
cnRlZCBwbSBmZWF0dXJlcyAqLwogCi0tIAoxLjYuMC40Cgo=

--_002_2892BF36424E462093B9000CA5222F82marvellcom_--
