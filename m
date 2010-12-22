From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 19/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:10:51 -0800
Message-ID: <218538DE-5DB1-4BCA-96F1-6FA5A58A1EFC@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_218538DE5DB14BCA96F16FA5A58A1EFCmarvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43484 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752007Ab0LVHPR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:15:17 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_218538DE5DB14BCA96F16FA5A58A1EFCmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 257752f549ec1ffff4029eb1030745b04010029e Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 21:42:38 -0800
Subject: [PATCH] sdhci: added register defintions for sd host 3.0 HOST CONT=
ROL 2

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci.h |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 91749dc..84292e0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -145,7 +145,22 @@
=20
 #define SDHCI_ACMD12_ERR	0x3C
=20
-/* 3E-3F reserved */
+#define HOST_CTRL_2             0x3E
+#define SDCTRL_2_UHS_MODE_SEL_SDR12		0x0000
+#define SDCTRL_2_UHS_MODE_SEL_SDR25		0x0001
+#define SDCTRL_2_UHS_MODE_SEL_SDR50		0x0002
+#define SDCTRL_2_UHS_MODE_SEL_SDR104		0x0003
+#define SDCTRL_2_UHS_MODE_SEL_DDR50		0x0004
+#define SDCTRL_2_UHS_MODE_MASK			7
+#define SDCTRL_2_SDH_V18_EN			0x0008
+#define SDCTRL_2_DRV_STRENGTH_SEL_B		0x0000
+#define SDCTRL_2_DRV_STRENGTH_SEL_A		0x0010
+#define SDCTRL_2_DRV_STRENGTH_SEL_C		0x0020
+#define SDCTRL_2_DRV_STRENGTH_SEL_D		0x0030
+#define SDCTRL_2_EXE_TUNING			0x0040
+#define SDCTRL_2_SAMPLING_CLK_SEL		0x0080
+#define SDCTRL_2_ASYNC_INT_EN			0x4000
+#define SDCTRL_2_PRESET_VAL_EN			0x8000
=20
 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
--=20
1.6.0.4

--_002_218538DE5DB14BCA96F16FA5A58A1EFCmarvellcom_
Content-Type: application/octet-stream;
	name="0019-sdhci-added-register-defintions-for-sd-host-3.0-HOS.patch"
Content-Description: 0019-sdhci-added-register-defintions-for-sd-host-3.0-HOS.patch
Content-Disposition: attachment;
	filename="0019-sdhci-added-register-defintions-for-sd-host-3.0-HOS.patch";
	size=1447; creation-date="Tue, 21 Dec 2010 23:10:52 GMT";
	modification-date="Tue, 21 Dec 2010 23:10:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNTc3NTJmNTQ5ZWMxZmZmZjQwMjllYjEwMzA3NDViMDQwMTAwMjllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDIxOjQyOjM4IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IGFkZGVkIHJlZ2lzdGVyIGRlZmludGlvbnMgZm9yIHNkIGhvc3QgMy4wIEhPU1QgQ09OVFJP
TCAyCgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBNYXJrIEYuIEJyb3duIDxtYXJrYkBtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2
ZXJzL21tYy9ob3N0L3NkaGNpLmggfCAgIDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGVzIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCmluZGV4IDkx
NzQ5ZGMuLjg0MjkyZTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaAorKysg
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKQEAgLTE0NSw3ICsxNDUsMjIgQEAKIAogI2RlZmlu
ZSBTREhDSV9BQ01EMTJfRVJSCTB4M0MKIAotLyogM0UtM0YgcmVzZXJ2ZWQgKi8KKyNkZWZpbmUg
SE9TVF9DVFJMXzIgICAgICAgICAgICAgMHgzRQorI2RlZmluZSBTRENUUkxfMl9VSFNfTU9ERV9T
RUxfU0RSMTIJCTB4MDAwMAorI2RlZmluZSBTRENUUkxfMl9VSFNfTU9ERV9TRUxfU0RSMjUJCTB4
MDAwMQorI2RlZmluZSBTRENUUkxfMl9VSFNfTU9ERV9TRUxfU0RSNTAJCTB4MDAwMgorI2RlZmlu
ZSBTRENUUkxfMl9VSFNfTU9ERV9TRUxfU0RSMTA0CQkweDAwMDMKKyNkZWZpbmUgU0RDVFJMXzJf
VUhTX01PREVfU0VMX0REUjUwCQkweDAwMDQKKyNkZWZpbmUgU0RDVFJMXzJfVUhTX01PREVfTUFT
SwkJCTcKKyNkZWZpbmUgU0RDVFJMXzJfU0RIX1YxOF9FTgkJCTB4MDAwOAorI2RlZmluZSBTRENU
UkxfMl9EUlZfU1RSRU5HVEhfU0VMX0IJCTB4MDAwMAorI2RlZmluZSBTRENUUkxfMl9EUlZfU1RS
RU5HVEhfU0VMX0EJCTB4MDAxMAorI2RlZmluZSBTRENUUkxfMl9EUlZfU1RSRU5HVEhfU0VMX0MJ
CTB4MDAyMAorI2RlZmluZSBTRENUUkxfMl9EUlZfU1RSRU5HVEhfU0VMX0QJCTB4MDAzMAorI2Rl
ZmluZSBTRENUUkxfMl9FWEVfVFVOSU5HCQkJMHgwMDQwCisjZGVmaW5lIFNEQ1RSTF8yX1NBTVBM
SU5HX0NMS19TRUwJCTB4MDA4MAorI2RlZmluZSBTRENUUkxfMl9BU1lOQ19JTlRfRU4JCQkweDQw
MDAKKyNkZWZpbmUgU0RDVFJMXzJfUFJFU0VUX1ZBTF9FTgkJCTB4ODAwMAogCiAjZGVmaW5lIFNE
SENJX0NBUEFCSUxJVElFUwkweDQwCiAjZGVmaW5lICBTREhDSV9USU1FT1VUX0NMS19NQVNLCTB4
MDAwMDAwM0YKLS0gCjEuNi4wLjQKCg==

--_002_218538DE5DB14BCA96F16FA5A58A1EFCmarvellcom_--
