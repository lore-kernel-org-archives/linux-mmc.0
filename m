From: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Subject: [PATCH 2.6.32]: Add new device IDs and registers forMULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.
Date: Tue, 16 Nov 2010 14:05:16 +0800
Message-ID: <FC57104DF444434A9D1D8A7B4EBB292307D13E8A@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----_=_NextPart_001_01CB8554.3F345FA6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [203.127.153.66] ([203.127.153.66]:19235 "EHLO
	sg-mxserver-01.nt-fsrvr.o2micro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755529Ab0KPGVO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 01:21:14 -0500
Content-class: urn:content-classes:message
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Mario_Limonciello@Dell.com, Joseph_Yeh@Dell.com, Chris Van Hoof <vanhoof@canonical.com>, Rezwanul_Kabir@Dell.com, "Shirley Her (SC)" <shirley.her@o2micro.com>, "Rich Lin (TP)" <RichLin@o2micro.com>, "Samuel Guan(WH)" <samuel.guan@o2micro.com>, "Hardys Lv(WH)" <hardys.lv@o2micro.com>, "William Lian (TP)" <William.Lian@o2micro.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB8554.3F345FA6
Content-Type: text/plain;charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

Issue Description:
SD/MMC card can't be recognized by O2 chip.

Root cause:
O2Micro's ADMA and related functions can't work by default Linux SD
driver. We need mark those related registers.
        
Patch description: 
  - SET MULTI 3 to VCC3V# 
  - Disable CLK_REQ# support after media DET.
  - Choose programmable settings 
  - Enable SDMA
  - Disable ADMA1
  - Disable ADMA2
  - Disable the infinite transfer mode
 
Supplement:
We are trying to add the enable ADMA patch later.

PATCH content:

Pci_ids.h

--- ../untitled folder/linux-2.6.32/include/linux/pci_ids.h
2009-12-03 11:51:21.000000000 +0800
+++ ./pci_ids.h	2010-11-15 17:56:26.103132569 +0800
@@ -2694,3 +2694,14 @@
 #define PCI_DEVICE_ID_RME_DIGI32	0x9896
 #define PCI_DEVICE_ID_RME_DIGI32_PRO	0x9897
 #define PCI_DEVICE_ID_RME_DIGI32_8	0x9898
+
+#define PCI_VENDOR_ID_O2		0x1217
+#define PCI_DEVICE_ID_O2_6729		0x6729
+#define PCI_DEVICE_ID_O2_6730		0x673a
+#define PCI_DEVICE_ID_O2_6832		0x6832
+#define PCI_DEVICE_ID_O2_6836		0x6836
+#define PCI_DEVICE_ID_O2_8120		0x8120
+#define PCI_DEVICE_ID_O2_8220		0x8220
+#define PCI_DEVICE_ID_O2_8320		0x8320
+#define PCI_DEVICE_ID_O2_8321		0x8321
+#define PCI_DEVICE_ID_O2_8221		0x8221


Sdhci-pci.c

--- ../linux-2.6.32/drivers/mmc/host/sdhci-pci.c	2009-12-03
11:51:21.000000000 +0800
+++ sdhci-pci.c	2010-11-16 11:42:00.000000000 +0800
@@ -38,6 +38,13 @@
 
 #define MAX_SLOTS			8
 
+#define O2_SDMMC_LOCK_WP 0xD3
+#define O2_SDMMC_MULTI_VCC3V 0xEE
+#define O2_SDMMC_CLKREQ 0xEC
+#define O2_SDMMC_CAPABILITIES 0xE0
+#define O2_SDMMC_ADMA1 0xE2
+#define O2_SDMMC_ADMA2 0xE7
+#define O2_SDMMC_INFINITE_MODE 0xF1
 struct sdhci_pci_chip;
 struct sdhci_pci_slot;
 
@@ -112,6 +119,94 @@ static const struct sdhci_pci_fixes sdhc
 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
+static int o2_probe(struct sdhci_pci_chip *chip)
+{
+	int ret;
+	u8 scratch;
+
+	if ((chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8220) ||
+	    (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8320) ||
+	    (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8321) ||
+	    (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8221))
+	    {
+		/* O2Micro's ADMA and releated function can't work on
default Linux SD driver.
+         * We need mark those related registers.
+         * - SET MULTI 3 to VCC3V# 
+         * - Disable CLK_REQ# support after media DET.
+         * - Choose programmable settings 
+         * - Enable SDMA
+         * - Disable ADMA1
+         * - Disable ADMA2
+         * - Disable the infinite transfer mode
+         */
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_LOCK_WP,
&scratch);
+		if (ret)
+			return ret;
+	
+		scratch &=3D 0x7f;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_LOCK_WP, scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_MULTI_VCC3V, &scratch);
+		if (ret)
+			return ret;
+	
+		scratch =3D 0x08;	
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_MULTI_VCC3V, scratch);
+
+
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_CLKREQ,
&scratch);
+		if (ret)
+			return ret;
+	
+		scratch |=3D 0x20;	
+		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_CLKREQ,
scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, &scratch);
+		if (ret)
+			return ret;
+	
+		scratch |=3D 0x01;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, &scratch);
+		if (ret)
+			return ret;
+	
+		scratch =3D 0x73;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_ADMA1,
&scratch);
+		if (ret)
+			return ret;
+	
+		scratch =3D 0x39;	
+		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA1,
scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_ADMA2,
&scratch);
+		if (ret)
+			return ret;
+	
+		scratch =3D 0x08;	
+		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA2,
scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_INFINITE_MODE, &scratch);
+		if (ret)
+			return ret;
+	
+		scratch |=3D 0x08;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_INFINITE_MODE, scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_LOCK_WP,
&scratch);
+		if (ret)
+			return ret;
+
+		scratch |=3D 0x80;	
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_LOCK_WP, scratch);
+
+		}
+	return 0;
+}
+
 static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 {
 	u8 scratch;
@@ -275,6 +370,10 @@ static int jmicron_resume(struct sdhci_p
 	return 0;
 }
 
+static const struct sdhci_pci_fixes sdhci_o2 =3D {
+	.probe		=3D o2_probe,
+};
+
 static const struct sdhci_pci_fixes sdhci_jmicron =3D {
 	.probe		=3D jmicron_probe,
 
@@ -370,6 +469,46 @@ static const struct pci_device_id pci_id
 		.driver_data	=3D (kernel_ulong_t)&sdhci_via,
 	},
 
+	{
+		.vendor		=3D PCI_VENDOR_ID_O2,
+		.device		=3D PCI_DEVICE_ID_O2_8120,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.driver_data	=3D (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		=3D PCI_VENDOR_ID_O2,
+		.device		=3D PCI_DEVICE_ID_O2_8220,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.driver_data	=3D (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		=3D PCI_VENDOR_ID_O2,
+		.device		=3D PCI_DEVICE_ID_O2_8320,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.driver_data	=3D (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		=3D PCI_VENDOR_ID_O2,
+		.device		=3D PCI_DEVICE_ID_O2_8221,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.driver_data	=3D (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		=3D PCI_VENDOR_ID_O2,
+		.device		=3D PCI_DEVICE_ID_O2_8321,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.driver_data	=3D (kernel_ulong_t)&sdhci_o2,
+	},
+
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8),
0xFFFF00)
 	},



Signed-off-by: Jennifer Li Developer <Jennifer.li@o2micro.com>


Best regards,
Jennifer




Unless otherwise stated, this e-mail message does not constitute a solicitat=
ion to buy or sell any products or services, or to participate in any partic=
ular trading strategy. This e-mail message and any attachments are intended =
solely for the use of the individual or entity to which it is addressed and =
may contain information that is confidential or legally privileged. If you a=
re not the intended recipient, you are hereby notified that any disseminatio=
n, distribution, copying or other use of this message or its attachments is =
strictly prohibited. If you have received this message in error, please noti=
fy the sender immediately and permanently delete this message and any attach=
ments. O2Micro International Ltd., and its subsidiaries and affiliates, are =
neither liable for the proper and complete transmission of the information c=
ontained in this communication, the accuracy of the information contained th=
erein, nor for any delay in its receipt.  






Unless otherwise stated, this e-mail message does not constitute a solicitat=
ion to buy or sell any products or services, or to participate in any partic=
ular trading strategy. This e-mail message and any attachments are intended =
solely for the use of the individual or entity to which it is addressed and =
may contain information that is confidential or legally privileged. If you a=
re not the intended recipient, you are hereby notified that any disseminatio=
n, distribution, copying or other use of this message or its attachments is =
strictly prohibited. If you have received this message in error, please noti=
fy the sender immediately and permanently delete this message and any attach=
ments. O2Micro International Ltd., and its subsidiaries and affiliates, are =
neither liable for the proper and complete transmission of the information c=
ontained in this communication, the accuracy of the information contained th=
erein, nor for any delay in its receipt.  



------_=_NextPart_001_01CB8554.3F345FA6
Content-Type: application/octet-stream;name="sdhci-pci_patch"
Content-Transfer-Encoding: base64
Content-Description: sdhci-pci_patch
Content-Disposition: attachment;filename="sdhci-pci_patch"

LS0tIC4uL2xpbnV4LTIuNi4zMi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS5jCTIwMDktMTIt
MDMgMTE6NTE6MjEuMDAwMDAwMDAwICswODAwCisrKyBzZGhjaS1wY2kuYwkyMDEwLTExLTE2IDEx
OjQyOjAwLjAwMDAwMDAwMCArMDgwMApAQCAtMzgsNiArMzgsMTMgQEAKIAogI2RlZmluZSBNQVhf
U0xPVFMJCQk4CiAKKyNkZWZpbmUgTzJfU0RNTUNfTE9DS19XUCAweEQzCisjZGVmaW5lIE8yX1NE
TU1DX01VTFRJX1ZDQzNWIDB4RUUKKyNkZWZpbmUgTzJfU0RNTUNfQ0xLUkVRIDB4RUMKKyNkZWZp
bmUgTzJfU0RNTUNfQ0FQQUJJTElUSUVTIDB4RTAKKyNkZWZpbmUgTzJfU0RNTUNfQURNQTEgMHhF
MgorI2RlZmluZSBPMl9TRE1NQ19BRE1BMiAweEU3CisjZGVmaW5lIE8yX1NETU1DX0lORklOSVRF
X01PREUgMHhGMQogc3RydWN0IHNkaGNpX3BjaV9jaGlwOwogc3RydWN0IHNkaGNpX3BjaV9zbG90
OwogCkBAIC0xMTIsNiArMTE5LDk0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGNpX2Zp
eGVzIHNkaGMKIAkJCSAgU0RIQ0lfUVVJUktfQlJPS0VOX1RJTUVPVVRfVkFMLAogfTsKIAorc3Rh
dGljIGludCBvMl9wcm9iZShzdHJ1Y3Qgc2RoY2lfcGNpX2NoaXAgKmNoaXApCit7CisJaW50IHJl
dDsKKwl1OCBzY3JhdGNoOworCisJaWYgKChjaGlwLT5wZGV2LT5kZXZpY2UgPT0gUENJX0RFVklD
RV9JRF9PMl84MjIwKSB8fAorCSAgICAoY2hpcC0+cGRldi0+ZGV2aWNlID09IFBDSV9ERVZJQ0Vf
SURfTzJfODMyMCkgfHwKKwkgICAgKGNoaXAtPnBkZXYtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lE
X08yXzgzMjEpIHx8CisJICAgIChjaGlwLT5wZGV2LT5kZXZpY2UgPT0gUENJX0RFVklDRV9JRF9P
Ml84MjIxKSkKKwkgICAgeworCQkvKiBPMk1pY3JvJ3MgQURNQSBhbmQgcmVsZWF0ZWQgZnVuY3Rp
b24gY2FuJ3Qgd29yayBvbiBkZWZhdWx0IExpbnV4IFNEIGRyaXZlci4KKyAgICAgICAgICogV2Ug
bmVlZCBtYXJrIHRob3NlIHJlbGF0ZWQgcmVnaXN0ZXJzLgorICAgICAgICAgKiAtIFNFVCBNVUxU
SSAzIHRvIFZDQzNWIyAKKyAgICAgICAgICogLSBEaXNhYmxlIENMS19SRVEjIHN1cHBvcnQgYWZ0
ZXIgbWVkaWEgREVULgorICAgICAgICAgKiAtIENob29zZSBwcm9ncmFtbWFibGUgc2V0dGluZ3Mg
CisgICAgICAgICAqIC0gRW5hYmxlIFNETUEKKyAgICAgICAgICogLSBEaXNhYmxlIEFETUExCisg
ICAgICAgICAqIC0gRGlzYWJsZSBBRE1BMgorICAgICAgICAgKiAtIERpc2FibGUgdGhlIGluZmlu
aXRlIHRyYW5zZmVyIG1vZGUKKyAgICAgICAgICovCisJCXJldCA9IHBjaV9yZWFkX2NvbmZpZ19i
eXRlKGNoaXAtPnBkZXYsIE8yX1NETU1DX0xPQ0tfV1AsICZzY3JhdGNoKTsKKwkJaWYgKHJldCkK
KwkJCXJldHVybiByZXQ7CisJCisJCXNjcmF0Y2ggJj0gMHg3ZjsKKwkJcmV0ID0gcGNpX3dyaXRl
X2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NETU1DX0xPQ0tfV1AsIHNjcmF0Y2gpOworCisJ
CXJldCA9IHBjaV9yZWFkX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NETU1DX01VTFRJX1ZD
QzNWLCAmc2NyYXRjaCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCQorCQlzY3JhdGNo
ID0gMHgwODsJCisJCXJldCA9IHBjaV93cml0ZV9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9T
RE1NQ19NVUxUSV9WQ0MzViwgc2NyYXRjaCk7CisKKworCQlyZXQgPSBwY2lfcmVhZF9jb25maWdf
Ynl0ZShjaGlwLT5wZGV2LCBPMl9TRE1NQ19DTEtSRVEsICZzY3JhdGNoKTsKKwkJaWYgKHJldCkK
KwkJCXJldHVybiByZXQ7CisJCisJCXNjcmF0Y2ggfD0gMHgyMDsJCisJCXJldCA9IHBjaV93cml0
ZV9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRE1NQ19DTEtSRVEsIHNjcmF0Y2gpOworCisJ
CXJldCA9IHBjaV9yZWFkX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NETU1DX0NBUEFCSUxJ
VElFUywgJnNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwkKKwkJc2NyYXRj
aCB8PSAweDAxOworCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJf
U0RNTUNfQ0FQQUJJTElUSUVTLCBzY3JhdGNoKTsKKworCQlyZXQgPSBwY2lfcmVhZF9jb25maWdf
Ynl0ZShjaGlwLT5wZGV2LCBPMl9TRE1NQ19DQVBBQklMSVRJRVMsICZzY3JhdGNoKTsKKwkJaWYg
KHJldCkKKwkJCXJldHVybiByZXQ7CisJCisJCXNjcmF0Y2ggPSAweDczOworCQlyZXQgPSBwY2lf
d3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNfQ0FQQUJJTElUSUVTLCBzY3Jh
dGNoKTsKKworCQlyZXQgPSBwY2lfcmVhZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRE1N
Q19BRE1BMSwgJnNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwkKKwkJc2Ny
YXRjaCA9IDB4Mzk7CQorCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwg
TzJfU0RNTUNfQURNQTEsIHNjcmF0Y2gpOworCisJCXJldCA9IHBjaV9yZWFkX2NvbmZpZ19ieXRl
KGNoaXAtPnBkZXYsIE8yX1NETU1DX0FETUEyLCAmc2NyYXRjaCk7CisJCWlmIChyZXQpCisJCQly
ZXR1cm4gcmV0OworCQorCQlzY3JhdGNoID0gMHgwODsJCisJCXJldCA9IHBjaV93cml0ZV9jb25m
aWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRE1NQ19BRE1BMiwgc2NyYXRjaCk7CisKKwkJcmV0ID0g
cGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNfSU5GSU5JVEVfTU9ERSwg
JnNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwkKKwkJc2NyYXRjaCB8PSAw
eDA4OworCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNf
SU5GSU5JVEVfTU9ERSwgc2NyYXRjaCk7CisKKwkJcmV0ID0gcGNpX3JlYWRfY29uZmlnX2J5dGUo
Y2hpcC0+cGRldiwgTzJfU0RNTUNfTE9DS19XUCwgJnNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJ
cmV0dXJuIHJldDsKKworCQlzY3JhdGNoIHw9IDB4ODA7CQorCQlyZXQgPSBwY2lfd3JpdGVfY29u
ZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNfTE9DS19XUCwgc2NyYXRjaCk7CisKKwkJfQor
CXJldHVybiAwOworfQorCiBzdGF0aWMgaW50IGptaWNyb25fcG1vcyhzdHJ1Y3Qgc2RoY2lfcGNp
X2NoaXAgKmNoaXAsIGludCBvbikKIHsKIAl1OCBzY3JhdGNoOwpAQCAtMjc1LDYgKzM3MCwxMCBA
QCBzdGF0aWMgaW50IGptaWNyb25fcmVzdW1lKHN0cnVjdCBzZGhjaV9wCiAJcmV0dXJuIDA7CiB9
CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGNpX2ZpeGVzIHNkaGNpX28yID0geworCS5w
cm9iZQkJPSBvMl9wcm9iZSwKK307CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGNpX2Zp
eGVzIHNkaGNpX2ptaWNyb24gPSB7CiAJLnByb2JlCQk9IGptaWNyb25fcHJvYmUsCiAKQEAgLTM3
MCw2ICs0NjksNDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHBjaV9pZAog
CQkuZHJpdmVyX2RhdGEJPSAoa2VybmVsX3Vsb25nX3QpJnNkaGNpX3ZpYSwKIAl9LAogCisJewor
CQkudmVuZG9yCQk9IFBDSV9WRU5ET1JfSURfTzIsCisJCS5kZXZpY2UJCT0gUENJX0RFVklDRV9J
RF9PMl84MTIwLAorCQkuc3VidmVuZG9yCT0gUENJX0FOWV9JRCwKKwkJLnN1YmRldmljZQk9IFBD
SV9BTllfSUQsCisJCS5kcml2ZXJfZGF0YQk9IChrZXJuZWxfdWxvbmdfdCkmc2RoY2lfbzIsCisJ
fSwKKworCXsKKwkJLnZlbmRvcgkJPSBQQ0lfVkVORE9SX0lEX08yLAorCQkuZGV2aWNlCQk9IFBD
SV9ERVZJQ0VfSURfTzJfODIyMCwKKwkJLnN1YnZlbmRvcgk9IFBDSV9BTllfSUQsCisJCS5zdWJk
ZXZpY2UJPSBQQ0lfQU5ZX0lELAorCQkuZHJpdmVyX2RhdGEJPSAoa2VybmVsX3Vsb25nX3QpJnNk
aGNpX28yLAorCX0sCisKKwl7CisJCS52ZW5kb3IJCT0gUENJX1ZFTkRPUl9JRF9PMiwKKwkJLmRl
dmljZQkJPSBQQ0lfREVWSUNFX0lEX08yXzgzMjAsCisJCS5zdWJ2ZW5kb3IJPSBQQ0lfQU5ZX0lE
LAorCQkuc3ViZGV2aWNlCT0gUENJX0FOWV9JRCwKKwkJLmRyaXZlcl9kYXRhCT0gKGtlcm5lbF91
bG9uZ190KSZzZGhjaV9vMiwKKwl9LAorCisJeworCQkudmVuZG9yCQk9IFBDSV9WRU5ET1JfSURf
TzIsCisJCS5kZXZpY2UJCT0gUENJX0RFVklDRV9JRF9PMl84MjIxLAorCQkuc3VidmVuZG9yCT0g
UENJX0FOWV9JRCwKKwkJLnN1YmRldmljZQk9IFBDSV9BTllfSUQsCisJCS5kcml2ZXJfZGF0YQk9
IChrZXJuZWxfdWxvbmdfdCkmc2RoY2lfbzIsCisJfSwKKworCXsKKwkJLnZlbmRvcgkJPSBQQ0lf
VkVORE9SX0lEX08yLAorCQkuZGV2aWNlCQk9IFBDSV9ERVZJQ0VfSURfTzJfODMyMSwKKwkJLnN1
YnZlbmRvcgk9IFBDSV9BTllfSUQsCisJCS5zdWJkZXZpY2UJPSBQQ0lfQU5ZX0lELAorCQkuZHJp
dmVyX2RhdGEJPSAoa2VybmVsX3Vsb25nX3QpJnNkaGNpX28yLAorCX0sCisKIAl7CS8qIEdlbmVy
aWMgU0QgaG9zdCBjb250cm9sbGVyICovCiAJCVBDSV9ERVZJQ0VfQ0xBU1MoKFBDSV9DTEFTU19T
WVNURU1fU0RIQ0kgPDwgOCksIDB4RkZGRjAwKQogCX0sCg==
------_=_NextPart_001_01CB8554.3F345FA6
Content-Type: application/octet-stream;name="pci_ids_patch"
Content-Transfer-Encoding: base64
Content-Description: pci_ids_patch
Content-Disposition: attachment;filename="pci_ids_patch"

LS0tIC4uL3VudGl0bGVkIGZvbGRlci9saW51eC0yLjYuMzIvaW5jbHVkZS9saW51eC9wY2lfaWRz
LmgJMjAwOS0xMi0wMyAxMTo1MToyMS4wMDAwMDAwMDAgKzA4MDAKKysrIC4vcGNpX2lkcy5oCTIw
MTAtMTEtMTUgMTc6NTY6MjYuMTAzMTMyNTY5ICswODAwCkBAIC0yNjk0LDMgKzI2OTQsMTQgQEAK
ICNkZWZpbmUgUENJX0RFVklDRV9JRF9STUVfRElHSTMyCTB4OTg5NgogI2RlZmluZSBQQ0lfREVW
SUNFX0lEX1JNRV9ESUdJMzJfUFJPCTB4OTg5NwogI2RlZmluZSBQQ0lfREVWSUNFX0lEX1JNRV9E
SUdJMzJfOAkweDk4OTgKKworI2RlZmluZSBQQ0lfVkVORE9SX0lEX08yCQkweDEyMTcNCisjZGVm
aW5lIFBDSV9ERVZJQ0VfSURfTzJfNjcyOQkJMHg2NzI5DQorI2RlZmluZSBQQ0lfREVWSUNFX0lE
X08yXzY3MzAJCTB4NjczYQ0KKyNkZWZpbmUgUENJX0RFVklDRV9JRF9PMl82ODMyCQkweDY4MzIN
CisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTzJfNjgzNgkJMHg2ODM2DQorI2RlZmluZSBQQ0lfREVW
SUNFX0lEX08yXzgxMjAJCTB4ODEyMA0KKyNkZWZpbmUgUENJX0RFVklDRV9JRF9PMl84MjIwCQkw
eDgyMjANCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTzJfODMyMAkJMHg4MzIwDQorI2RlZmluZSBQ
Q0lfREVWSUNFX0lEX08yXzgzMjEJCTB4ODMyMQ0KKyNkZWZpbmUgUENJX0RFVklDRV9JRF9PMl84
MjIxCQkweDgyMjEK
------_=_NextPart_001_01CB8554.3F345FA6--
