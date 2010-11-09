From: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Subject: [PATCH 2.6.35]: Add new device IDs and registers for MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.
Date: Tue, 9 Nov 2010 14:28:00 +0800
Message-ID: <FC57104DF444434A9D1D8A7B4EBB292307BD1F6D@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----_=_NextPart_001_01CB7FD7.42D98E36"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sg-mxserver.o2micro.com ([203.126.184.123]:18428 "EHLO
	sg-mxserver-01.nt-fsrvr.o2micro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751273Ab0KIG2O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 01:28:14 -0500
Content-class: urn:content-classes:message
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "Shirley Her (SC)" <shirley.her@o2micro.com>, "Hardys Lv(WH)" <hardys.lv@o2micro.com>, "Rich Lin (TP)" <RichLin@o2micro.com>, "Samuel Guan(WH)" <samuel.guan@o2micro.com>, Rezwanul_Kabir@Dell.com, Mario_Limonciello@Dell.com, Joseph_Yeh@Dell.com, Chris Van Hoof <vanhoof@canonical.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB7FD7.42D98E36
Content-Type: text/plain;charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

This can make MMC/SD driver work on O2 chip.

Best regards,
Jennifer

--- /home/j/Desktop/kernel_source_1104/linux-2.6.35/drivers/mmc/host/sdhci-p=
ci.c=A0=A0=A0 2010-08-02 06:11:14.000000000 +0800
+++ /home/j/Desktop/SD_ADMAissue_8220_8320/20101020_sdhci_pci_c/sdhci-pci.c =
2010-10-20 23:44:50.000000000 +0800
@@ -39,6 +39,26 @@
=A0
=A0#define MAX_SLOTS=A0=A0=A0=A0=A0=A0=A0=A0=A0 8
=A0
+#ifndef PCI_DEVICE_ID_O2_8120
+#define PCI_DEVICE_ID_O2_8120=A0=A0=A0=A0=A0 0x8120
+#endif
+
+#ifndef PCI_DEVICE_ID_O2_8220
+#define PCI_DEVICE_ID_O2_8220=A0=A0=A0=A0=A0 0x8220
+#endif
+
+#ifndef PCI_DEVICE_ID_O2_8320
+#define PCI_DEVICE_ID_O2_8320=A0=A0=A0=A0=A0 0x8320
+#endif
+
+#ifndef PCI_DEVICE_ID_O2_8321
+#define PCI_DEVICE_ID_O2_8321=A0=A0=A0=A0=A0 0x8321
+#endif
+
+#ifndef PCI_DEVICE_ID_O2_8221
+#define PCI_DEVICE_ID_O2_8221=A0=A0=A0=A0=A0 0x8221
+#endif
+
=A0struct sdhci_pci_chip;
=A0struct sdhci_pci_slot;
=A0
@@ -112,6 +132,118 @@ static const struct sdhci_pci_fixes sdhc
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
=A0};
=A0
+static int o2_probe(struct sdhci_pci_chip *chip)
+{
+=A0=A0 int ret;
+=A0=A0 u8 scratch;
+
+=A0=A0 if ((chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8220) ||
+=A0=A0 =A0=A0=A0 (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8320) ||
+=A0=A0 =A0=A0=A0 (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8321) ||
+=A0=A0 =A0=A0=A0 (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_8221))
+=A0=A0 =A0=A0=A0 {
+=A0=A0=A0=A0=A0=A0 //set D3 to 0x7f
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xD3, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch &=3D 0x7f;=A0=A0=A0 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xD3, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 // set EE to 08 
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xEE, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch =3D 0x08; 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xEE, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 // set Ec to 0x20
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xEC, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch |=3D 0x20;=A0=A0=A0 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xEC, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 // set E0 to 0x01
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xE0, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch |=3D 0x01;=A0=A0=A0 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xE0, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 // set E0 to 0x73
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xE0, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch =3D 0x73; 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xE0, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 // set E2 to 0x39
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xE2, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch =3D 0x39; 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xE2, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 // set E7 to 0x08
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xE7, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch =3D 0x08; 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xE7, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 // set f1 to 0x08
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xF1, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 scratch |=3D 0x08;=A0=A0=A0 
+
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xF1, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 //set D3 to 80
+=A0=A0=A0=A0=A0=A0 ret =3D pci_read_config_byte(chip->pdev, 0xD3, &scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+
+=A0=A0=A0=A0=A0=A0 scratch |=3D 0x80;=A0=A0=A0 
+=A0=A0 
+=A0=A0=A0=A0=A0=A0 ret =3D pci_write_config_byte(chip->pdev, 0xD3, scratch)=
;
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
+=A0=A0=A0=A0=A0=A0 }
+=A0=A0 return 0;
+}
+
=A0static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
=A0{
=A0=A0=A0 u8 scratch;
@@ -275,6 +407,11 @@ static int jmicron_resume(struct sdhci_p
=A0=A0=A0 return 0;
=A0}
=A0
+static const struct sdhci_pci_fixes sdhci_o2 =3D {
+=A0=A0 .probe=A0=A0=A0=A0=A0 =3D o2_probe,
+// .quirks=A0=A0=A0=A0 =3D SDHCI_QUICK_ADMA_TABLE_ENTRY,
+};
+
=A0static const struct sdhci_pci_fixes sdhci_jmicron =3D {
=A0=A0=A0 .probe=A0=A0=A0=A0=A0 =3D jmicron_probe,
=A0
@@ -445,6 +582,46 @@ static const struct pci_device_id pci_id
=A0=A0=A0=A0=A0=A0=A0 .driver_data=A0=A0=A0 =3D (kernel_ulong_t)&sdhci_via,
=A0=A0=A0 },
=A0
+=A0=A0 {
+=A0=A0=A0=A0=A0=A0 .vendor=A0=A0=A0=A0 =3D PCI_VENDOR_ID_O2,
+=A0=A0=A0=A0=A0=A0 .device=A0=A0=A0=A0 =3D PCI_DEVICE_ID_O2_8120,
+=A0=A0=A0=A0=A0=A0 .subvendor=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .subdevice=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .driver_data=A0=A0=A0 =3D (kernel_ulong_t)&sdhci_o2,
+=A0=A0 },
+
+=A0=A0 {
+=A0=A0=A0=A0=A0=A0 .vendor=A0=A0=A0=A0 =3D PCI_VENDOR_ID_O2,
+=A0=A0=A0=A0=A0=A0 .device=A0=A0=A0=A0 =3D PCI_DEVICE_ID_O2_8220,
+=A0=A0=A0=A0=A0=A0 .subvendor=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .subdevice=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .driver_data=A0=A0=A0 =3D (kernel_ulong_t)&sdhci_o2,
+=A0=A0 },
+
+=A0=A0 {
+=A0=A0=A0=A0=A0=A0 .vendor=A0=A0=A0=A0 =3D PCI_VENDOR_ID_O2,
+=A0=A0=A0=A0=A0=A0 .device=A0=A0=A0=A0 =3D PCI_DEVICE_ID_O2_8320,
+=A0=A0=A0=A0=A0=A0 .subvendor=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .subdevice=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .driver_data=A0=A0=A0 =3D (kernel_ulong_t)&sdhci_o2,
+=A0=A0 },
+
+=A0=A0 {
+=A0=A0=A0=A0=A0=A0 .vendor=A0=A0=A0=A0 =3D PCI_VENDOR_ID_O2,
+=A0=A0=A0=A0=A0=A0 .device=A0=A0=A0=A0 =3D PCI_DEVICE_ID_O2_8221,
+=A0=A0=A0=A0=A0=A0 .subvendor=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .subdevice=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .driver_data=A0=A0=A0 =3D (kernel_ulong_t)&sdhci_o2,
+=A0=A0 },
+
+=A0=A0 {
+=A0=A0=A0=A0=A0=A0 .vendor=A0=A0=A0=A0 =3D PCI_VENDOR_ID_O2,
+=A0=A0=A0=A0=A0=A0 .device=A0=A0=A0=A0 =3D PCI_DEVICE_ID_O2_8321,
+=A0=A0=A0=A0=A0=A0 .subvendor=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .subdevice=A0 =3D PCI_ANY_ID,
+=A0=A0=A0=A0=A0=A0 .driver_data=A0=A0=A0 =3D (kernel_ulong_t)&sdhci_o2,
+=A0=A0 },
+
=A0=A0=A0 {=A0=A0 /* Generic SD host controller */
=A0=A0=A0=A0=A0=A0=A0 PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF=
00)
=A0=A0=A0 },






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



------_=_NextPart_001_01CB7FD7.42D98E36
Content-Type: application/octet-stream;name="patch"
Content-Transfer-Encoding: base64
Content-Description: patch
Content-Disposition: attachment;filename="patch"

LS0tIC9ob21lL2ovRGVza3RvcC9rZXJuZWxfc291cmNlXzExMDQvbGludXgtMi42LjM1L2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktcGNpLmMJMjAxMC0wOC0wMiAwNjoxMToxNC4wMDAwMDAwMDAgKzA4
MDAKKysrIC9ob21lL2ovRGVza3RvcC9TRF9BRE1BaXNzdWVfODIyMF84MzIwLzIwMTAxMDIwX3Nk
aGNpX3BjaV9jL3NkaGNpLXBjaS5jCTIwMTAtMTAtMjAgMjM6NDQ6NTAuMDAwMDAwMDAwICswODAw
CkBAIC0zOSw2ICszOSwyNiBAQAogCiAjZGVmaW5lIE1BWF9TTE9UUwkJCTgKIAorI2lmbmRlZiBQ
Q0lfREVWSUNFX0lEX08yXzgxMjAKKyNkZWZpbmUgUENJX0RFVklDRV9JRF9PMl84MTIwCQkweDgx
MjAKKyNlbmRpZgorCisjaWZuZGVmIFBDSV9ERVZJQ0VfSURfTzJfODIyMAorI2RlZmluZSBQQ0lf
REVWSUNFX0lEX08yXzgyMjAJCTB4ODIyMAorI2VuZGlmCisKKyNpZm5kZWYgUENJX0RFVklDRV9J
RF9PMl84MzIwCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTzJfODMyMAkJMHg4MzIwCisjZW5kaWYK
KworI2lmbmRlZiBQQ0lfREVWSUNFX0lEX08yXzgzMjEKKyNkZWZpbmUgUENJX0RFVklDRV9JRF9P
Ml84MzIxCQkweDgzMjEKKyNlbmRpZgorCisjaWZuZGVmIFBDSV9ERVZJQ0VfSURfTzJfODIyMQor
I2RlZmluZSBQQ0lfREVWSUNFX0lEX08yXzgyMjEJCTB4ODIyMQorI2VuZGlmCisKIHN0cnVjdCBz
ZGhjaV9wY2lfY2hpcDsKIHN0cnVjdCBzZGhjaV9wY2lfc2xvdDsKIApAQCAtMTEyLDYgKzEzMiwx
MTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9wY2lfZml4ZXMgc2RoYwogCQkJICBTREhD
SV9RVUlSS19CUk9LRU5fVElNRU9VVF9WQUwsCiB9OwogCitzdGF0aWMgaW50IG8yX3Byb2JlKHN0
cnVjdCBzZGhjaV9wY2lfY2hpcCAqY2hpcCkKK3sKKwlpbnQgcmV0OworCXU4IHNjcmF0Y2g7CisK
KwlpZiAoKGNoaXAtPnBkZXYtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX08yXzgyMjApIHx8CisJ
ICAgIChjaGlwLT5wZGV2LT5kZXZpY2UgPT0gUENJX0RFVklDRV9JRF9PMl84MzIwKSB8fAorCSAg
ICAoY2hpcC0+cGRldi0+ZGV2aWNlID09IFBDSV9ERVZJQ0VfSURfTzJfODMyMSkgfHwKKwkgICAg
KGNoaXAtPnBkZXYtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX08yXzgyMjEpKQorCSAgICB7CisJ
CS8vc2V0IEQzIHRvIDB4N2YKKwkJcmV0ID0gcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+cGRl
diwgMHhEMywgJnNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwkKKwkJc2Ny
YXRjaCAmPSAweDdmOwkKKworCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRl
diwgMHhEMywgc2NyYXRjaCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCisJCS8vIHNl
dCBFRSB0byAwOCAKKwkJcmV0ID0gcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgMHhF
RSwgJnNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwkKKwkJc2NyYXRjaCA9
IDB4MDg7CQorCisJCXJldCA9IHBjaV93cml0ZV9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCAweEVF
LCBzY3JhdGNoKTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CisKKwkJLy8gc2V0IEVjIHRv
IDB4MjAKKwkJcmV0ID0gcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgMHhFQywgJnNj
cmF0Y2gpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwkKKwkJc2NyYXRjaCB8PSAweDIw
OwkKKworCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgMHhFQywgc2Ny
YXRjaCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCisJCS8vIHNldCBFMCB0byAweDAx
CisJCXJldCA9IHBjaV9yZWFkX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIDB4RTAsICZzY3JhdGNo
KTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CisJCisJCXNjcmF0Y2ggfD0gMHgwMTsJCisK
KwkJcmV0ID0gcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIDB4RTAsIHNjcmF0Y2gp
OworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKworCQkvLyBzZXQgRTAgdG8gMHg3MworCQly
ZXQgPSBwY2lfcmVhZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCAweEUwLCAmc2NyYXRjaCk7CisJ
CWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCQorCQlzY3JhdGNoID0gMHg3MzsJCisKKwkJcmV0
ID0gcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIDB4RTAsIHNjcmF0Y2gpOworCQlp
ZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKworCQkvLyBzZXQgRTIgdG8gMHgzOQorCQlyZXQgPSBw
Y2lfcmVhZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCAweEUyLCAmc2NyYXRjaCk7CisJCWlmIChy
ZXQpCisJCQlyZXR1cm4gcmV0OworCQorCQlzY3JhdGNoID0gMHgzOTsJCisKKwkJcmV0ID0gcGNp
X3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIDB4RTIsIHNjcmF0Y2gpOworCQlpZiAocmV0
KQorCQkJcmV0dXJuIHJldDsKKworCQkvLyBzZXQgRTcgdG8gMHgwOAorCQlyZXQgPSBwY2lfcmVh
ZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCAweEU3LCAmc2NyYXRjaCk7CisJCWlmIChyZXQpCisJ
CQlyZXR1cm4gcmV0OworCQorCQlzY3JhdGNoID0gMHgwODsJCisKKwkJcmV0ID0gcGNpX3dyaXRl
X2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIDB4RTcsIHNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJ
cmV0dXJuIHJldDsKKworCQkvLyBzZXQgZjEgdG8gMHgwOAorCQlyZXQgPSBwY2lfcmVhZF9jb25m
aWdfYnl0ZShjaGlwLT5wZGV2LCAweEYxLCAmc2NyYXRjaCk7CisJCWlmIChyZXQpCisJCQlyZXR1
cm4gcmV0OworCQorCQlzY3JhdGNoIHw9IDB4MDg7CQorCisJCXJldCA9IHBjaV93cml0ZV9jb25m
aWdfYnl0ZShjaGlwLT5wZGV2LCAweEYxLCBzY3JhdGNoKTsKKwkJaWYgKHJldCkKKwkJCXJldHVy
biByZXQ7CisKKwkJLy9zZXQgRDMgdG8gODAKKwkJcmV0ID0gcGNpX3JlYWRfY29uZmlnX2J5dGUo
Y2hpcC0+cGRldiwgMHhEMywgJnNjcmF0Y2gpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsK
KworCQlzY3JhdGNoIHw9IDB4ODA7CQorCQorCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUo
Y2hpcC0+cGRldiwgMHhEMywgc2NyYXRjaCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0Owor
CQl9CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgam1pY3Jvbl9wbW9zKHN0cnVjdCBzZGhj
aV9wY2lfY2hpcCAqY2hpcCwgaW50IG9uKQogewogCXU4IHNjcmF0Y2g7CkBAIC0yNzUsNiArNDA3
LDExIEBAIHN0YXRpYyBpbnQgam1pY3Jvbl9yZXN1bWUoc3RydWN0IHNkaGNpX3AKIAlyZXR1cm4g
MDsKIH0KIAorc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9wY2lfZml4ZXMgc2RoY2lfbzIgPSB7
CisJLnByb2JlCQk9IG8yX3Byb2JlLAorLy8JLnF1aXJrcwkJPSBTREhDSV9RVUlDS19BRE1BX1RB
QkxFX0VOVFJZLAorfTsKKwogc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9wY2lfZml4ZXMgc2Ro
Y2lfam1pY3JvbiA9IHsKIAkucHJvYmUJCT0gam1pY3Jvbl9wcm9iZSwKIApAQCAtNDQ1LDYgKzU4
Miw0NiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgcGNpX2lkCiAJCS5kcml2
ZXJfZGF0YQk9IChrZXJuZWxfdWxvbmdfdCkmc2RoY2lfdmlhLAogCX0sCiAKKwl7CisJCS52ZW5k
b3IJCT0gUENJX1ZFTkRPUl9JRF9PMiwKKwkJLmRldmljZQkJPSBQQ0lfREVWSUNFX0lEX08yXzgx
MjAsCisJCS5zdWJ2ZW5kb3IJPSBQQ0lfQU5ZX0lELAorCQkuc3ViZGV2aWNlCT0gUENJX0FOWV9J
RCwKKwkJLmRyaXZlcl9kYXRhCT0gKGtlcm5lbF91bG9uZ190KSZzZGhjaV9vMiwKKwl9LAorCisJ
eworCQkudmVuZG9yCQk9IFBDSV9WRU5ET1JfSURfTzIsCisJCS5kZXZpY2UJCT0gUENJX0RFVklD
RV9JRF9PMl84MjIwLAorCQkuc3VidmVuZG9yCT0gUENJX0FOWV9JRCwKKwkJLnN1YmRldmljZQk9
IFBDSV9BTllfSUQsCisJCS5kcml2ZXJfZGF0YQk9IChrZXJuZWxfdWxvbmdfdCkmc2RoY2lfbzIs
CisJfSwKKworCXsKKwkJLnZlbmRvcgkJPSBQQ0lfVkVORE9SX0lEX08yLAorCQkuZGV2aWNlCQk9
IFBDSV9ERVZJQ0VfSURfTzJfODMyMCwKKwkJLnN1YnZlbmRvcgk9IFBDSV9BTllfSUQsCisJCS5z
dWJkZXZpY2UJPSBQQ0lfQU5ZX0lELAorCQkuZHJpdmVyX2RhdGEJPSAoa2VybmVsX3Vsb25nX3Qp
JnNkaGNpX28yLAorCX0sCisKKwl7CisJCS52ZW5kb3IJCT0gUENJX1ZFTkRPUl9JRF9PMiwKKwkJ
LmRldmljZQkJPSBQQ0lfREVWSUNFX0lEX08yXzgyMjEsCisJCS5zdWJ2ZW5kb3IJPSBQQ0lfQU5Z
X0lELAorCQkuc3ViZGV2aWNlCT0gUENJX0FOWV9JRCwKKwkJLmRyaXZlcl9kYXRhCT0gKGtlcm5l
bF91bG9uZ190KSZzZGhjaV9vMiwKKwl9LAorCisJeworCQkudmVuZG9yCQk9IFBDSV9WRU5ET1Jf
SURfTzIsCisJCS5kZXZpY2UJCT0gUENJX0RFVklDRV9JRF9PMl84MzIxLAorCQkuc3VidmVuZG9y
CT0gUENJX0FOWV9JRCwKKwkJLnN1YmRldmljZQk9IFBDSV9BTllfSUQsCisJCS5kcml2ZXJfZGF0
YQk9IChrZXJuZWxfdWxvbmdfdCkmc2RoY2lfbzIsCisJfSwKKwogCXsJLyogR2VuZXJpYyBTRCBo
b3N0IGNvbnRyb2xsZXIgKi8KIAkJUENJX0RFVklDRV9DTEFTUygoUENJX0NMQVNTX1NZU1RFTV9T
REhDSSA8PCA4KSwgMHhGRkZGMDApCiAJfSwK
------_=_NextPart_001_01CB7FD7.42D98E36--
