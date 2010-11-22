From: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Subject: RE: [PATCH 2.6.32]: Add new device IDs and registers forMULTIMEDIACARD (MMC), SECURE DIGITAL (SD) cards.
Date: Mon, 22 Nov 2010 15:58:50 +0800
Message-ID: <FC57104DF444434A9D1D8A7B4EBB292307ED4F8B@HC-EXCHANGE.nt-fsrvr.o2micro.com>
References: <20101118041559.GE23555@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----_=_NextPart_001_01CB8A1B.1AC433A7"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [203.127.153.66] ([203.127.153.66]:5253 "EHLO
	sg-mxserver-01.nt-fsrvr.o2micro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752038Ab0KVH7S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 02:59:18 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20101118041559.GE23555@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Mario_Limonciello@Dell.com, Joseph_Yeh@Dell.com, Chris Van Hoof <vanhoof@canonical.com>, Rezwanul_Kabir@Dell.com, "Shirley Her (SC)" <shirley.her@o2micro.com>, "Rich Lin (TP)" <RichLin@o2micro.com>, "Samuel Guan(WH)" <samuel.guan@o2micro.com>, "Hardys Lv(WH)" <hardys.lv@o2micro.com>, "William Lian (TP)" <William.Lian@o2micro.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB8A1B.1AC433A7
Content-Type: text/plain;charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

I have modified the PATCH file as your suggestions. It has been sent
today.

1. I didn't add " SDHCI_QUIRK_BROKEN_ADMA ".
=3D Because of O2 SD function has ADMA, ADMA2 and the other related
registers. It can't be controlled by the normal ADMA flag. So, the "
SDHCI_QUIRK_BROKEN_ADMA " flag isn't suitable for O2 chip.

2. I have removed the redundancy " pci_read_config_byte" routines as
your suggestions.
=3D For safety, we has suggested that we need those " pci_read_config_byte
" routines. If the chip was broken, the " pci_read_config_byte " can
protect the Linux OS crash. But we still remove the "
pci_read_config_byte " routines as your suggestions.

Best regards,
Jennifer
-----Original Message-----
From: Chris Ball [mailto:cjb@laptop.org] 
Sent: Thursday, November 18, 2010 12:16 PM
To: Jennifer Li (TP)
Cc: linux-mmc@vger.kernel.org; Mario_Limonciello@Dell.com;
Joseph_Yeh@Dell.com; Chris Van Hoof; Rezwanul_Kabir@Dell.com; Shirley
Her (SC); Rich Lin (TP); Samuel Guan(WH); Hardys Lv(WH); William Lian
(TP)
Subject: Re: [PATCH 2.6.32]: Add new device IDs and registers
forMULTIMEDIACARD (MMC), SECURE DIGITAL (SD) cards.

Hi Jennifer,

This is looking better, thanks -- just a few more questions:

On Tue, Nov 16, 2010 at 02:05:16PM +0800, Jennifer Li (TP) wrote:
> Root cause:
> O2Micro's ADMA and related functions can't work by default Linux SD
> driver. We need mark those related registers.

If the goal is to disable ADMA, have you tried using the BROKEN_ADMA
quirk?  Like this:

static const struct sdhci_pci_fixes sdhci_o2 =3D {
        .probe          =3D o2_probe,
        .quirks         =3D SDHCI_QUIRK_BROKEN_ADMA,
};

If you do this, do you still need to perform the PCI writes?

> +		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_MULTI_VCC3V, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch =3D 0x08;
> +		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_MULTI_VCC3V, scratch);

Here you read in a value to scratch, but then you go ahead and write
0x08 to the register regardless.  We can skip the read here, right?

> +		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch |=3D 0x01;
> +		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);
> +
> +		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch =3D 0x73;
> +		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);

Here you write a value to O2_SDMMC_CAPABILITIES that's dependent on the
read value, but then after that you immediately overwrite the register
with 0x73 regardless of what was in it before.  Why perform the first
read-and-write cycle and the second read, if you're just going to write
0x73 in the end?

> +
> +		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_ADMA1,
&scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch =3D 0x39;
> +		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA1,
scratch);
> +
> +		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_ADMA2,
&scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch =3D 0x08;
> +		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA2,
scratch);

Same as above -- if the write isn't dependent on the read, I don't see
why to bother with the read.  Also, you can avoid assigning the return
value of pci_write_config_byte() to "ret" now that we aren't testing
that.

> Signed-off-by: Jennifer Li Developer <Jennifer.li@o2micro.com>

I don't think "Developer" should be here, since the text should just be
your name.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child




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



------_=_NextPart_001_01CB8A1B.1AC433A7
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit

Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_002_01CB8A19.4E242C00"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: FW: [PATCH 2.6.32]: Add new device IDs and registers forMULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.
Date: Mon, 22 Nov 2010 15:46:09 +0800
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.32]: Add new device IDs and registers forMULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.
Thread-Index: AcuFVD1SLDzxNxjNS8umloTistT4fgExAzeA
From: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
To: <linux-mmc@vger.kernel.org>
Cc: "Chris Ball" <cjb@laptop.org>,
	<Mario_Limonciello@Dell.com>,
	<Joseph_Yeh@Dell.com>,
	"Chris Van Hoof" <vanhoof@canonical.com>,
	<Rezwanul_Kabir@Dell.com>,
	"Shirley Her (SC)" <shirley.her@o2micro.com>,
	"Rich Lin (TP)" <RichLin@o2micro.com>,
	"Samuel Guan(WH)" <samuel.guan@o2micro.com>,
	"Hardys Lv(WH)" <hardys.lv@o2micro.com>,
	"William Lian (TP)" <William.Lian@o2micro.com>

This is a multi-part message in MIME format.

------_=_NextPart_002_01CB8A19.4E242C00
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

Issue Description:
SD/MMC card can't be recognized by O2 chip.

Root cause:
O2Micro's ADMA and related functions can't work by default Linux SD
driver. We need mark those related registers.
       =20
Patch description:=20
  - SET MULTI 3 to VCC3V#=20
  - Disable CLK_REQ# support after media DET.
  - Choose programmable settings=20
  - Enable SDMA
  - Disable ADMA1
  - Disable ADMA2
  - Disable the infinite transfer mode
=20
Linux Kernel version:
This patch was based on Linux Kernel version 2.6.32. It should be added
from Linux kernel 2.6.32 and the newer kernel versions.

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

--- linux-2.6.32/drivers/mmc/host/sdhci-pci.c	2009-12-03
11:51:21.000000000 +0800
+++ Q20101122sdhci-pci/sdhci-pci.c	2010-11-18 07:59:38.119873198
+0800
@@ -38,6 +38,14 @@
=20
 #define MAX_SLOTS			8
=20
+#define O2_SDMMC_LOCK_WP 0xD3
+#define O2_SDMMC_MULTI_VCC3V 0xEE
+#define O2_SDMMC_CLKREQ 0xEC
+#define O2_SDMMC_CAPABILITIES 0xE0
+#define O2_SDMMC_ADMA1 0xE2
+#define O2_SDMMC_ADMA2 0xE7
+#define O2_SDMMC_INFINIT_MODE 0xF1
+
 struct sdhci_pci_chip;
 struct sdhci_pci_slot;
=20
@@ -112,6 +120,78 @@ static const struct sdhci_pci_fixes sdhc
 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
=20
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
+         * - SET MULTI 3 to VCC3V#=20
+         * - Disable CLK_REQ# support after media DET.
+         * - Choose programmable settings=20
+         * - Enable SDMA
+         * - Disable ADMA1
+         * - Disable ADMA2
+         * - Disable the infinit transfer mode
+         */
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_LOCK_WP,
&scratch);
+		if (ret)
+			return ret;
+=09
+		scratch &=3D 0x7f;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_LOCK_WP, scratch);
+=09
+		scratch =3D 0x08;=09
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_MULTI_VCC3V, scratch);
+
+
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_CLKREQ,
&scratch);
+		if (ret)
+			return ret;
+=09
+		scratch |=3D 0x20;=09
+		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_CLKREQ,
scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, &scratch);
+		if (ret)
+			return ret;
+=09
+		scratch |=3D 0x01;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);
+=09
+		scratch =3D 0x73;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);
+=09
+		scratch =3D 0x39;=09
+		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA1,
scratch);
+
+		scratch =3D 0x08;=09
+		ret =3D pci_write_config_byte(chip->pdev, O2_SDMMC_ADMA2,
scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev,
O2_SDMMC_INFINIT_MODE, &scratch);
+		if (ret)
+			return ret;
+=09
+		scratch |=3D 0x08;
+		ret =3D pci_write_config_byte(chip->pdev,
O2_SDMMC_INFINIT_MODE, scratch);
+
+		ret =3D pci_read_config_byte(chip->pdev, O2_SDMMC_LOCK_WP,
&scratch);
+		if (ret)
+			return ret;
+
+		scratch |=3D 0x80;=09
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
@@ -275,6 +355,10 @@ static int jmicron_resume(struct sdhci_p
 	return 0;
 }
=20
+static const struct sdhci_pci_fixes sdhci_o2 =3D {
+	.probe		=3D o2_probe,
+};
+
 static const struct sdhci_pci_fixes sdhci_jmicron =3D {
 	.probe		=3D jmicron_probe,
=20
@@ -370,6 +454,46 @@ static const struct pci_device_id pci_id
 		.driver_data	=3D (kernel_ulong_t)&sdhci_via,
 	},
=20
+        {
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


Signed-off-by: Jennifer Li <Jennifer.li@o2micro.com>

Best regards,
Jennifer

------_=_NextPart_002_01CB8A19.4E242C00
Content-Type: application/octet-stream;
	name="pci_ids_patch"
Content-Transfer-Encoding: base64
Content-Description: pci_ids_patch
Content-Disposition: attachment;
	filename="pci_ids_patch"

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

------_=_NextPart_002_01CB8A19.4E242C00
Content-Type: application/octet-stream;
	name="sdhci-pci_patch"
Content-Transfer-Encoding: base64
Content-Description: sdhci-pci_patch
Content-Disposition: attachment;
	filename="sdhci-pci_patch"

LS0tIGxpbnV4LTIuNi4zMi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS5jCTIwMDktMTItMDMg
MTE6NTE6MjEuMDAwMDAwMDAwICswODAwCisrKyBRMjAxMDExMjJzZGhjaS1wY2kvc2RoY2ktcGNp
LmMJMjAxMC0xMS0xOCAwNzo1OTozOC4xMTk4NzMxOTggKzA4MDAKQEAgLTM4LDYgKzM4LDE0IEBA
CiAKICNkZWZpbmUgTUFYX1NMT1RTCQkJOAogCisjZGVmaW5lIE8yX1NETU1DX0xPQ0tfV1AgMHhE
MworI2RlZmluZSBPMl9TRE1NQ19NVUxUSV9WQ0MzViAweEVFCisjZGVmaW5lIE8yX1NETU1DX0NM
S1JFUSAweEVDCisjZGVmaW5lIE8yX1NETU1DX0NBUEFCSUxJVElFUyAweEUwCisjZGVmaW5lIE8y
X1NETU1DX0FETUExIDB4RTIKKyNkZWZpbmUgTzJfU0RNTUNfQURNQTIgMHhFNworI2RlZmluZSBP
Ml9TRE1NQ19JTkZJTklUX01PREUgMHhGMQorCiBzdHJ1Y3Qgc2RoY2lfcGNpX2NoaXA7CiBzdHJ1
Y3Qgc2RoY2lfcGNpX3Nsb3Q7CiAKQEAgLTExMiw2ICsxMjAsNzggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBzZGhjaV9wY2lfZml4ZXMgc2RoYwogCQkJICBTREhDSV9RVUlSS19CUk9LRU5fVElNRU9V
VF9WQUwsCiB9OwogCitzdGF0aWMgaW50IG8yX3Byb2JlKHN0cnVjdCBzZGhjaV9wY2lfY2hpcCAq
Y2hpcCkKK3sKKwlpbnQgcmV0OworCXU4IHNjcmF0Y2g7CisKKwlpZiAoKGNoaXAtPnBkZXYtPmRl
dmljZSA9PSBQQ0lfREVWSUNFX0lEX08yXzgyMjApIHx8CisJICAgIChjaGlwLT5wZGV2LT5kZXZp
Y2UgPT0gUENJX0RFVklDRV9JRF9PMl84MzIwKSB8fAorCSAgICAoY2hpcC0+cGRldi0+ZGV2aWNl
ID09IFBDSV9ERVZJQ0VfSURfTzJfODMyMSkgfHwKKwkgICAgKGNoaXAtPnBkZXYtPmRldmljZSA9
PSBQQ0lfREVWSUNFX0lEX08yXzgyMjEpKQorCSAgICB7CisJCS8qIE8yTWljcm8ncyBBRE1BIGFu
ZCByZWxlYXRlZCBmdW5jdGlvbiBjYW4ndCB3b3JrIG9uIGRlZmF1bHQgTGludXggU0QgZHJpdmVy
LgorICAgICAgICAgKiBXZSBuZWVkIG1hcmsgdGhvc2UgcmVsYXRlZCByZWdpc3RlcnMuCisgICAg
ICAgICAqIC0gU0VUIE1VTFRJIDMgdG8gVkNDM1YjIAorICAgICAgICAgKiAtIERpc2FibGUgQ0xL
X1JFUSMgc3VwcG9ydCBhZnRlciBtZWRpYSBERVQuCisgICAgICAgICAqIC0gQ2hvb3NlIHByb2dy
YW1tYWJsZSBzZXR0aW5ncyAKKyAgICAgICAgICogLSBFbmFibGUgU0RNQQorICAgICAgICAgKiAt
IERpc2FibGUgQURNQTEKKyAgICAgICAgICogLSBEaXNhYmxlIEFETUEyCisgICAgICAgICAqIC0g
RGlzYWJsZSB0aGUgaW5maW5pdCB0cmFuc2ZlciBtb2RlCisgICAgICAgICAqLworCQlyZXQgPSBw
Y2lfcmVhZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRE1NQ19MT0NLX1dQLCAmc2NyYXRj
aCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCQorCQlzY3JhdGNoICY9IDB4N2Y7CisJ
CXJldCA9IHBjaV93cml0ZV9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRE1NQ19MT0NLX1dQ
LCBzY3JhdGNoKTsKKwkKKwkJc2NyYXRjaCA9IDB4MDg7CQorCQlyZXQgPSBwY2lfd3JpdGVfY29u
ZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNfTVVMVElfVkNDM1YsIHNjcmF0Y2gpOworCisK
KwkJcmV0ID0gcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNfQ0xLUkVR
LCAmc2NyYXRjaCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCQorCQlzY3JhdGNoIHw9
IDB4MjA7CQorCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RN
TUNfQ0xLUkVRLCBzY3JhdGNoKTsKKworCQlyZXQgPSBwY2lfcmVhZF9jb25maWdfYnl0ZShjaGlw
LT5wZGV2LCBPMl9TRE1NQ19DQVBBQklMSVRJRVMsICZzY3JhdGNoKTsKKwkJaWYgKHJldCkKKwkJ
CXJldHVybiByZXQ7CisJCisJCXNjcmF0Y2ggfD0gMHgwMTsKKwkJcmV0ID0gcGNpX3dyaXRlX2Nv
bmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NETU1DX0NBUEFCSUxJVElFUywgc2NyYXRjaCk7CisJ
CisJCXNjcmF0Y2ggPSAweDczOworCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+
cGRldiwgTzJfU0RNTUNfQ0FQQUJJTElUSUVTLCBzY3JhdGNoKTsKKwkKKwkJc2NyYXRjaCA9IDB4
Mzk7CQorCQlyZXQgPSBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNf
QURNQTEsIHNjcmF0Y2gpOworCisJCXNjcmF0Y2ggPSAweDA4OwkKKwkJcmV0ID0gcGNpX3dyaXRl
X2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NETU1DX0FETUEyLCBzY3JhdGNoKTsKKworCQly
ZXQgPSBwY2lfcmVhZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRE1NQ19JTkZJTklUX01P
REUsICZzY3JhdGNoKTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CisJCisJCXNjcmF0Y2gg
fD0gMHgwODsKKwkJcmV0ID0gcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NE
TU1DX0lORklOSVRfTU9ERSwgc2NyYXRjaCk7CisKKwkJcmV0ID0gcGNpX3JlYWRfY29uZmlnX2J5
dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNfTE9DS19XUCwgJnNjcmF0Y2gpOworCQlpZiAocmV0KQor
CQkJcmV0dXJuIHJldDsKKworCQlzY3JhdGNoIHw9IDB4ODA7CQorCQlyZXQgPSBwY2lfd3JpdGVf
Y29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RNTUNfTE9DS19XUCwgc2NyYXRjaCk7CisKKwkJ
fQorCXJldHVybiAwOworfQorCiBzdGF0aWMgaW50IGptaWNyb25fcG1vcyhzdHJ1Y3Qgc2RoY2lf
cGNpX2NoaXAgKmNoaXAsIGludCBvbikKIHsKIAl1OCBzY3JhdGNoOwpAQCAtMjc1LDYgKzM1NSwx
MCBAQCBzdGF0aWMgaW50IGptaWNyb25fcmVzdW1lKHN0cnVjdCBzZGhjaV9wCiAJcmV0dXJuIDA7
CiB9CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGNpX2ZpeGVzIHNkaGNpX28yID0gewor
CS5wcm9iZQkJPSBvMl9wcm9iZSwKK307CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGNp
X2ZpeGVzIHNkaGNpX2ptaWNyb24gPSB7CiAJLnByb2JlCQk9IGptaWNyb25fcHJvYmUsCiAKQEAg
LTM3MCw2ICs0NTQsNDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHBjaV9p
ZAogCQkuZHJpdmVyX2RhdGEJPSAoa2VybmVsX3Vsb25nX3QpJnNkaGNpX3ZpYSwKIAl9LAogCisg
ICAgICAgIHsKKwkJLnZlbmRvcgkJPSBQQ0lfVkVORE9SX0lEX08yLAorCQkuZGV2aWNlCQk9IFBD
SV9ERVZJQ0VfSURfTzJfODEyMCwKKwkJLnN1YnZlbmRvcgk9IFBDSV9BTllfSUQsCisJCS5zdWJk
ZXZpY2UJPSBQQ0lfQU5ZX0lELAorCQkuZHJpdmVyX2RhdGEJPSAoa2VybmVsX3Vsb25nX3QpJnNk
aGNpX28yLAorCX0sCisKKwl7CisJCS52ZW5kb3IJCT0gUENJX1ZFTkRPUl9JRF9PMiwKKwkJLmRl
dmljZQkJPSBQQ0lfREVWSUNFX0lEX08yXzgyMjAsCisJCS5zdWJ2ZW5kb3IJPSBQQ0lfQU5ZX0lE
LAorCQkuc3ViZGV2aWNlCT0gUENJX0FOWV9JRCwKKwkJLmRyaXZlcl9kYXRhCT0gKGtlcm5lbF91
bG9uZ190KSZzZGhjaV9vMiwKKwl9LAorCisJeworCQkudmVuZG9yCQk9IFBDSV9WRU5ET1JfSURf
TzIsCisJCS5kZXZpY2UJCT0gUENJX0RFVklDRV9JRF9PMl84MzIwLAorCQkuc3VidmVuZG9yCT0g
UENJX0FOWV9JRCwKKwkJLnN1YmRldmljZQk9IFBDSV9BTllfSUQsCisJCS5kcml2ZXJfZGF0YQk9
IChrZXJuZWxfdWxvbmdfdCkmc2RoY2lfbzIsCisJfSwKKworCXsKKwkJLnZlbmRvcgkJPSBQQ0lf
VkVORE9SX0lEX08yLAorCQkuZGV2aWNlCQk9IFBDSV9ERVZJQ0VfSURfTzJfODIyMSwKKwkJLnN1
YnZlbmRvcgk9IFBDSV9BTllfSUQsCisJCS5zdWJkZXZpY2UJPSBQQ0lfQU5ZX0lELAorCQkuZHJp
dmVyX2RhdGEJPSAoa2VybmVsX3Vsb25nX3QpJnNkaGNpX28yLAorCX0sCisKKwl7CisJCS52ZW5k
b3IJCT0gUENJX1ZFTkRPUl9JRF9PMiwKKwkJLmRldmljZQkJPSBQQ0lfREVWSUNFX0lEX08yXzgz
MjEsCisJCS5zdWJ2ZW5kb3IJPSBQQ0lfQU5ZX0lELAorCQkuc3ViZGV2aWNlCT0gUENJX0FOWV9J
RCwKKwkJLmRyaXZlcl9kYXRhCT0gKGtlcm5lbF91bG9uZ190KSZzZGhjaV9vMiwKKwl9LAorCiAJ
ewkvKiBHZW5lcmljIFNEIGhvc3QgY29udHJvbGxlciAqLwogCQlQQ0lfREVWSUNFX0NMQVNTKChQ
Q0lfQ0xBU1NfU1lTVEVNX1NESENJIDw8IDgpLCAweEZGRkYwMCkKIAl9LAo=

------_=_NextPart_002_01CB8A19.4E242C00--

------_=_NextPart_001_01CB8A1B.1AC433A7--
