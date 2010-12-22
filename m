From: Frank Hsieh <fhsieh@marvell.com>
Subject: FW: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Tue, 21 Dec 2010 23:48:01 -0800
Message-ID: <689C75E0D210324F8BE88961219F681618934B2321@SC-VEXCH2.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_689C75E0D210324F8BE88961219F681618934B2321SCVEXCH2marve_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:56830 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752396Ab0LVHwD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:52:03 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

--_002_689C75E0D210324F8BE88961219F681618934B2321SCVEXCH2marve_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: zhangfei gao <zhangfei.gao@gmail.com>
Date: Tue, Dec 21, 2010 at 8:37 PM
Subject: [patch]: sdhci support emmc ddr50 mode [v3]
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>


v3: sync to mmc-next

Emmc speed could double if using ddr50 mode, help check

>From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Tue, 21 Dec 2010 19:51:38 -0500
Subject: [PATCH] mmc: sdhci support emmc ddr50 mode

=A0 =A0 =A0 =A01. spec sdhc 3.0 does not claim support 1.2v ddr mode
=A0 =A0 =A0 =A02. Call back function set_power is added, since some control=
ler count
on external pmic to provide power
=A0 =A0 =A0 =A03. According to spec sdhc 3.0, uhs mode, including emmc ddr5=
0 takes
effect only when 1.8v Signaling Enable bit, which used for providing
1.8v.
=A0 =A0 =A0 =A0 =A0 So emmc ddr50 mode works after 1.8v switching process, =
though emmc
ddr50 could work at high voltage such as 3.3v if external pmic provide
voltage.
=A0 =A0 =A0 =A0 =A0 Limitation: emmc ddr50 mode only workable when both hos=
t and emmc
card support 1.70-1.90v
=A0 =A0 =A0 =A04. According to JESD84, power down and power up is required =
to
provide low voltage 1.70-1.90v to mmc.

=A0 =A0 =A0 =A0Verified: toshiba emmc on mmp2, with io voltage at 1.8v prov=
ided by
external pmic.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Tested-by: Frank Hsieh <fhsieh@marvell.com>
---
=A0drivers/mmc/core/core.c =A0| =A0 13 +++++++++++++
=A0drivers/mmc/core/core.h =A0| =A0 =A01 +
=A0drivers/mmc/core/mmc.c =A0 | =A0 =A06 +++++-
=A0drivers/mmc/host/sdhci.c | =A0 44 ++++++++++++++++++++++++++++++++++++++=
+++---
=A0drivers/mmc/host/sdhci.h | =A0 14 +++++++++++++-
=A05 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8e89f3..fd657f1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host *host)
=A0}

=A0/*
+ * mmc select low voltage 1.70-1.95v
+ */
+void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
+{
+ =A0 =A0 =A0 if (!(ocr & MMC_VDD_165_195))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+
+ =A0 =A0 =A0 mmc_power_off(host);
+ =A0 =A0 =A0 host->ocr =3D ocr & host->ocr_avail;
+ =A0 =A0 =A0 mmc_power_up(host);
+}
+
+/*
=A0* Cleanup when the last reference to the bus operator is dropped.
=A0*/
=A0static void __mmc_release_bus(struct mmc_host *host)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..b05c20a 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
unsigned int width);
=A0void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ddr);
=A0u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
+void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
=A0void mmc_set_timing(struct mmc_host *host, unsigned int timing);

=A0static inline void mmc_delay(unsigned int ms)
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 86cac0d..8779339 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~0x7F;
=A0 =A0 =A0 =A0}

- =A0 =A0 =A0 host->ocr =3D mmc_select_voltage(host, ocr);
+ =A0 =A0 =A0 if ((ocr & MMC_VDD_165_195)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->ocr_avail & MMC_VDD=
_165_195))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_select_low_voltage(host, ocr);
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ocr =3D mmc_select_voltage(host, ocr);

=A0 =A0 =A0 =A0/*
=A0 =A0 =A0 =A0 * Can we support the voltage of the card?
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d5febe5..aafbb42 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_host *ho=
st)
=A0 =A0 =A0 =A0host->cmd =3D NULL;
=A0}

+static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
+{
+ =A0 =A0 =A0 u16 con;
+
+ =A0 =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+
+ =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
+ =A0 =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~SDHCI_CTRL2_UHS_MASK;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_DDR50;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+ =A0 =A0 =A0 }
+}
+
=A0static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
=A0{
=A0 =A0 =A0 =A0int div;
@@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_host
*host, unsigned short power)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
=A0 =A0 =A0 =A0}

+ =A0 =A0 =A0 if ((pwr =3D=3D SDHCI_POWER_180) &&
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->mmc->caps & MMC_CAP_1_8V_DDR)) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2=
);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->set_power)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_power(host, pw=
r);
+ =A0 =A0 =A0 }
+
=A0 =A0 =A0 =A0/*
=A0 =A0 =A0 =A0 * Spec says that we should clear the power reg before setti=
ng
=A0 =A0 =A0 =A0 * a new value. Some controllers don't seem to like this tho=
ugh.
@@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
=A0 =A0 =A0 =A0}

=A0 =A0 =A0 =A0sdhci_set_clock(host, ios->clock);
+ =A0 =A0 =A0 sdhci_set_ddr(host, ios->ddr);

=A0 =A0 =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
@@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
=A0int sdhci_add_host(struct sdhci_host *host)
=A0{
=A0 =A0 =A0 =A0struct mmc_host *mmc;
- =A0 =A0 =A0 unsigned int caps, ocr_avail;
+ =A0 =A0 =A0 unsigned int caps, caps_h =3D 0, ocr_avail;
=A0 =A0 =A0 =A0int ret;

=A0 =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
@@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *host)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
=A0 =A0 =A0 =A0}

- =A0 =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->ca=
ps :
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES);
+ =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps =3D host->caps;
+ =A0 =A0 =A0 else {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps =3D sdhci_readl(host, SDHCI_CAPABILITIES=
);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps_h =3D sdhci_readl(host, SDHCI_CAPABILITI=
ES_1);
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 if (caps & SDHCI_CAN_VDD_180) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (caps_h & SDHCI_CAN_SDR50)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_1_8V_=
DDR);
+ =A0 =A0 =A0 }

=A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..c4bd5dd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -145,7 +145,14 @@

=A0#define SDHCI_ACMD12_ERR =A0 =A0 =A0 0x3C

-/* 3E-3F reserved */
+#define SDHCI_HOST_CONTROL2 =A0 =A00x3E
+#define =A0SDHCI_CTRL2_UHS_MASK =A00x0007
+#define =A0 SDHCI_CTRL2_SDR12 =A0 =A00x0000
+#define =A0 SDHCI_CTRL2_SDR25 =A0 =A00x0001
+#define =A0 SDHCI_CTRL2_SDR50 =A0 =A00x0002
+#define =A0 SDHCI_CTRL2_SDR104 =A0 0x0003
+#define =A0 SDHCI_CTRL2_DDR50 =A0 =A00x0004
+#define =A0SDHCI_CTRL2_1_8V =A0 =A0 =A00x0008

=A0#define SDHCI_CAPABILITIES =A0 =A0 0x40
=A0#define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 =A00x0000003F
@@ -167,6 +174,9 @@
=A0#define =A0SDHCI_CAN_64BIT =A0 =A0 =A0 0x10000000

=A0#define SDHCI_CAPABILITIES_1 =A0 0x44
+#define =A0SDHCI_CAN_SDR50 =A0 =A0 =A0 0x00000001
+#define =A0SDHCI_CAN_SDR104 =A0 =A0 =A00x00000002
+#define =A0SDHCI_CAN_DDR50 =A0 =A0 =A0 0x00000004

=A0#define SDHCI_MAX_CURRENT =A0 =A0 =A00x48

@@ -222,6 +232,8 @@ struct sdhci_ops {
=A0 =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_host *host=
,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 u8 power_mode);
=A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host);
+ =A0 =A0 =A0 unsigned int =A0 =A0(*set_power)(struct sdhci_host *host,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned shor=
t power);
=A0};

=A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--
1.7.0.4

--_002_689C75E0D210324F8BE88961219F681618934B2321SCVEXCH2marve_
Content-Type: text/x-patch;
	name="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Description: 0001-mmc-sdhci-support-emmc-ddr50-mode.patch
Content-Disposition: attachment;
	filename="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"; size=6462;
	creation-date="Tue, 21 Dec 2010 20:05:33 GMT";
	modification-date="Tue, 21 Dec 2010 20:05:33 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4OTVjM2QxNWEyMDBkNWY1ODAzZjk5MmRhYjQ2ZmYxMTRhZDI2ZjkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVHVlLCAyMSBEZWMgMjAxMCAxOTo1MTozOCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IG1tYzogc2RoY2kgc3VwcG9ydCBlbW1jIGRkcjUwIG1vZGUKCgkxLiBzcGVjIHNkaGMgMy4wIGRv
ZXMgbm90IGNsYWltIHN1cHBvcnQgMS4ydiBkZHIgbW9kZQoJMi4gQ2FsbCBiYWNrIGZ1bmN0aW9u
IHNldF9wb3dlciBpcyBhZGRlZCwgc2luY2Ugc29tZSBjb250cm9sbGVyIGNvdW50IG9uIGV4dGVy
bmFsIHBtaWMgdG8gcHJvdmlkZSBwb3dlcgoJMy4gQWNjb3JkaW5nIHRvIHNwZWMgc2RoYyAzLjAs
IHVocyBtb2RlLCBpbmNsdWRpbmcgZW1tYyBkZHI1MCB0YWtlcyBlZmZlY3Qgb25seSB3aGVuIDEu
OHYgU2lnbmFsaW5nIEVuYWJsZSBiaXQsIHdoaWNoIHVzZWQgZm9yIHByb3ZpZGluZyAxLjh2LgoJ
ICAgU28gZW1tYyBkZHI1MCBtb2RlIHdvcmtzIGFmdGVyIDEuOHYgc3dpdGNoaW5nIHByb2Nlc3Ms
IHRob3VnaCBlbW1jIGRkcjUwIGNvdWxkIHdvcmsgYXQgaGlnaCB2b2x0YWdlIHN1Y2ggYXMgMy4z
diBpZiBleHRlcm5hbCBwbWljIHByb3ZpZGUgdm9sdGFnZS4KCSAgIExpbWl0YXRpb246IGVtbWMg
ZGRyNTAgbW9kZSBvbmx5IHdvcmthYmxlIHdoZW4gYm90aCBob3N0IGFuZCBlbW1jIGNhcmQgc3Vw
cG9ydCAxLjcwLTEuOTB2Cgk0LiBBY2NvcmRpbmcgdG8gSkVTRDg0LCBwb3dlciBkb3duIGFuZCBw
b3dlciB1cCBpcyByZXF1aXJlZCB0byBwcm92aWRlIGxvdyB2b2x0YWdlIDEuNzAtMS45MHYgdG8g
bW1jLgoKCVZlcmlmaWVkOiB0b3NoaWJhIGVtbWMgb24gbW1wMiwgd2l0aCBpbyB2b2x0YWdlIGF0
IDEuOHYgcHJvdmlkZWQgYnkgZXh0ZXJuYWwgcG1pYy4KClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVp
IEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2NvcmUvY29y
ZS5jICB8ICAgMTMgKysrKysrKysrKysrKwogZHJpdmVycy9tbWMvY29yZS9jb3JlLmggIHwgICAg
MSArCiBkcml2ZXJzL21tYy9jb3JlL21tYy5jICAgfCAgICA2ICsrKysrLQogZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS5jIHwgICA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIHwgICAxNCArKysrKysrKysrKysrLQog
NSBmaWxlcyBjaGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMK
aW5kZXggYThlODlmMy4uZmQ2NTdmMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3Jl
LmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMKQEAgLTEwMTIsNiArMTAxMiwxOSBAQCBz
dGF0aWMgdm9pZCBtbWNfcG93ZXJfb2ZmKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKIH0KIAogLyoK
KyAqIG1tYyBzZWxlY3QgbG93IHZvbHRhZ2UgMS43MC0xLjk1dgorICovCit2b2lkIG1tY19zZWxl
Y3RfbG93X3ZvbHRhZ2Uoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1MzIgb2NyKQoreworCWlmICgh
KG9jciAmIE1NQ19WRERfMTY1XzE5NSkpCisJCXJldHVybjsKKworCW1tY19wb3dlcl9vZmYoaG9z
dCk7CisJaG9zdC0+b2NyID0gb2NyICYgaG9zdC0+b2NyX2F2YWlsOworCW1tY19wb3dlcl91cCho
b3N0KTsKK30KKworLyoKICAqIENsZWFudXAgd2hlbiB0aGUgbGFzdCByZWZlcmVuY2UgdG8gdGhl
IGJ1cyBvcGVyYXRvciBpcyBkcm9wcGVkLgogICovCiBzdGF0aWMgdm9pZCBfX21tY19yZWxlYXNl
X2J1cyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3Jl
L2NvcmUuaCBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCmluZGV4IDAyNmM5NzUuLmIwNWMyMGEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCisrKyBiL2RyaXZlcnMvbW1jL2Nv
cmUvY29yZS5oCkBAIC00MSw2ICs0MSw3IEBAIHZvaWQgbW1jX3NldF9idXNfd2lkdGgoc3RydWN0
IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgd2lkdGgpOwogdm9pZCBtbWNfc2V0X2J1c193
aWR0aF9kZHIoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgd2lkdGgsCiAJCQkg
ICB1bnNpZ25lZCBpbnQgZGRyKTsKIHUzMiBtbWNfc2VsZWN0X3ZvbHRhZ2Uoc3RydWN0IG1tY19o
b3N0ICpob3N0LCB1MzIgb2NyKTsKK3ZvaWQgbW1jX3NlbGVjdF9sb3dfdm9sdGFnZShzdHJ1Y3Qg
bW1jX2hvc3QgKmhvc3QsIHUzMiBvY3IpOwogdm9pZCBtbWNfc2V0X3RpbWluZyhzdHJ1Y3QgbW1j
X2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCB0aW1pbmcpOwogCiBzdGF0aWMgaW5saW5lIHZvaWQg
bW1jX2RlbGF5KHVuc2lnbmVkIGludCBtcykKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUv
bW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jCmluZGV4IDg2Y2FjMGQuLjg3NzkzMzkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9t
bWMuYwpAQCAtNzkwLDcgKzc5MCwxMSBAQCBpbnQgbW1jX2F0dGFjaF9tbWMoc3RydWN0IG1tY19o
b3N0ICpob3N0LCB1MzIgb2NyKQogCQlvY3IgJj0gfjB4N0Y7CiAJfQogCi0JaG9zdC0+b2NyID0g
bW1jX3NlbGVjdF92b2x0YWdlKGhvc3QsIG9jcik7CisJaWYgKChvY3IgJiBNTUNfVkREXzE2NV8x
OTUpCisJCQkmJiAoaG9zdC0+b2NyX2F2YWlsICYgTU1DX1ZERF8xNjVfMTk1KSkKKwkJbW1jX3Nl
bGVjdF9sb3dfdm9sdGFnZShob3N0LCBvY3IpOworCWVsc2UKKwkJaG9zdC0+b2NyID0gbW1jX3Nl
bGVjdF92b2x0YWdlKGhvc3QsIG9jcik7CiAKIAkvKgogCSAqIENhbiB3ZSBzdXBwb3J0IHRoZSB2
b2x0YWdlIG9mIHRoZSBjYXJkPwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmluZGV4IGQ1ZmViZTUuLmFhZmJiNDIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLmMKQEAgLTk4Niw2ICs5ODYsMjIgQEAgc3RhdGljIHZvaWQgc2RoY2lfZmluaXNoX2NvbW1h
bmQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAJaG9zdC0+Y21kID0gTlVMTDsKIH0KIAorc3Rh
dGljIHZvaWQgc2RoY2lfc2V0X2RkcihzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQg
aW50IGRkcikKK3sKKwl1MTYgY29uOworCisJaWYgKGRkciA9PSBNTUNfU0RSX01PREUpCisJCXJl
dHVybjsKKworCWNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hPU1RfQ09OVFJPTDIpOwor
CWlmIChjb24gJiBTREhDSV9DVFJMMl8xXzhWKSB7CisJCWNvbiAmPSB+U0RIQ0lfQ1RSTDJfVUhT
X01BU0s7CisJCWlmIChkZHIgJiBNTUNfMV84Vl9ERFJfTU9ERSkKKwkJCWNvbiB8PSBTREhDSV9D
VFJMMl9ERFI1MDsKKwkJc2RoY2lfd3JpdGV3KGhvc3QsIGNvbiwgU0RIQ0lfSE9TVF9DT05UUk9M
Mik7CisJfQorfQorCiBzdGF0aWMgdm9pZCBzZGhjaV9zZXRfY2xvY2soc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QsIHVuc2lnbmVkIGludCBjbG9jaykKIHsKIAlpbnQgZGl2OwpAQCAtMTA4NCw2ICsx
MTAwLDE4IEBAIHN0YXRpYyB2b2lkIHNkaGNpX3NldF9wb3dlcihzdHJ1Y3Qgc2RoY2lfaG9zdCAq
aG9zdCwgdW5zaWduZWQgc2hvcnQgcG93ZXIpCiAJCXJldHVybjsKIAl9CiAKKwlpZiAoKHB3ciA9
PSBTREhDSV9QT1dFUl8xODApICYmCisJCShob3N0LT5tbWMtPmNhcHMgJiBNTUNfQ0FQXzFfOFZf
RERSKSkgeworCQl1MTYgY29uOworCisJCWNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hP
U1RfQ09OVFJPTDIpOworCQljb24gfD0gU0RIQ0lfQ1RSTDJfMV84VjsKKwkJc2RoY2lfd3JpdGV3
KGhvc3QsIGNvbiwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisKKwkJaWYgKGhvc3QtPm9wcy0+c2V0
X3Bvd2VyKQorCQkJaG9zdC0+b3BzLT5zZXRfcG93ZXIoaG9zdCwgcHdyKTsKKwl9CisKIAkvKgog
CSAqIFNwZWMgc2F5cyB0aGF0IHdlIHNob3VsZCBjbGVhciB0aGUgcG93ZXIgcmVnIGJlZm9yZSBz
ZXR0aW5nCiAJICogYSBuZXcgdmFsdWUuIFNvbWUgY29udHJvbGxlcnMgZG9uJ3Qgc2VlbSB0byBs
aWtlIHRoaXMgdGhvdWdoLgpAQCAtMTE4MCw2ICsxMjA4LDcgQEAgc3RhdGljIHZvaWQgc2RoY2lf
c2V0X2lvcyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykKIAl9CiAK
IAlzZGhjaV9zZXRfY2xvY2soaG9zdCwgaW9zLT5jbG9jayk7CisJc2RoY2lfc2V0X2Rkcihob3N0
LCBpb3MtPmRkcik7CiAKIAlpZiAoaW9zLT5wb3dlcl9tb2RlID09IE1NQ19QT1dFUl9PRkYpCiAJ
CXNkaGNpX3NldF9wb3dlcihob3N0LCAtMSk7CkBAIC0xNzQ0LDcgKzE3NzMsNyBAQCBFWFBPUlRf
U1lNQk9MX0dQTChzZGhjaV9hbGxvY19ob3N0KTsKIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCkKIHsKIAlzdHJ1Y3QgbW1jX2hvc3QgKm1tYzsKLQl1bnNpZ25lZCBp
bnQgY2Fwcywgb2NyX2F2YWlsOworCXVuc2lnbmVkIGludCBjYXBzLCBjYXBzX2ggPSAwLCBvY3Jf
YXZhaWw7CiAJaW50IHJldDsKIAogCVdBUk5fT04oaG9zdCA9PSBOVUxMKTsKQEAgLTE3NjcsOCAr
MTc5NiwxNyBAQCBpbnQgc2RoY2lfYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAJ
CQlob3N0LT52ZXJzaW9uKTsKIAl9CiAKLQljYXBzID0gKGhvc3QtPnF1aXJrcyAmIFNESENJX1FV
SVJLX01JU1NJTkdfQ0FQUykgPyBob3N0LT5jYXBzIDoKLQkJc2RoY2lfcmVhZGwoaG9zdCwgU0RI
Q0lfQ0FQQUJJTElUSUVTKTsKKwlpZiAoaG9zdC0+cXVpcmtzICYgU0RIQ0lfUVVJUktfTUlTU0lO
R19DQVBTKQorCQljYXBzID0gaG9zdC0+Y2FwczsKKwllbHNlIHsKKwkJY2FwcyA9IHNkaGNpX3Jl
YWRsKGhvc3QsIFNESENJX0NBUEFCSUxJVElFUyk7CisJCWNhcHNfaCA9IHNkaGNpX3JlYWRsKGhv
c3QsIFNESENJX0NBUEFCSUxJVElFU18xKTsKKwl9CisKKwlpZiAoY2FwcyAmIFNESENJX0NBTl9W
RERfMTgwKSB7CisJCWlmIChjYXBzX2ggJiBTREhDSV9DQU5fU0RSNTApCisJCQltbWMtPmNhcHMg
fD0gKE1NQ19DQVBfMV84Vl9ERFIpOworCX0KIAogCWlmIChob3N0LT5xdWlya3MgJiBTREhDSV9R
VUlSS19GT1JDRV9ETUEpCiAJCWhvc3QtPmZsYWdzIHw9IFNESENJX1VTRV9TRE1BOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5o
CmluZGV4IDZlMDk2OWUuLmM0YmQ1ZGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuaAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKQEAgLTE0NSw3ICsxNDUsMTQgQEAK
IAogI2RlZmluZSBTREhDSV9BQ01EMTJfRVJSCTB4M0MKIAotLyogM0UtM0YgcmVzZXJ2ZWQgKi8K
KyNkZWZpbmUgU0RIQ0lfSE9TVF9DT05UUk9MMgkweDNFCisjZGVmaW5lICBTREhDSV9DVFJMMl9V
SFNfTUFTSwkweDAwMDcKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFIxMgkweDAwMDAKKyNkZWZp
bmUgICBTREhDSV9DVFJMMl9TRFIyNQkweDAwMDEKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFI1
MAkweDAwMDIKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFIxMDQJMHgwMDAzCisjZGVmaW5lICAg
U0RIQ0lfQ1RSTDJfRERSNTAJMHgwMDA0CisjZGVmaW5lICBTREhDSV9DVFJMMl8xXzhWCTB4MDAw
OAogCiAjZGVmaW5lIFNESENJX0NBUEFCSUxJVElFUwkweDQwCiAjZGVmaW5lICBTREhDSV9USU1F
T1VUX0NMS19NQVNLCTB4MDAwMDAwM0YKQEAgLTE2Nyw2ICsxNzQsOSBAQAogI2RlZmluZSAgU0RI
Q0lfQ0FOXzY0QklUCTB4MTAwMDAwMDAKIAogI2RlZmluZSBTREhDSV9DQVBBQklMSVRJRVNfMQkw
eDQ0CisjZGVmaW5lICBTREhDSV9DQU5fU0RSNTAJMHgwMDAwMDAwMQorI2RlZmluZSAgU0RIQ0lf
Q0FOX1NEUjEwNAkweDAwMDAwMDAyCisjZGVmaW5lICBTREhDSV9DQU5fRERSNTAJMHgwMDAwMDAw
NAogCiAjZGVmaW5lIFNESENJX01BWF9DVVJSRU5UCTB4NDgKIApAQCAtMjIyLDYgKzIzMiw4IEBA
IHN0cnVjdCBzZGhjaV9vcHMgewogCXZvaWQgKCpwbGF0Zm9ybV9zZW5kX2luaXRfNzRfY2xvY2tz
KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwKIAkJCQkJICAgICB1OCBwb3dlcl9tb2RlKTsKIAl1
bnNpZ25lZCBpbnQgICAgKCpnZXRfcm8pKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKKwl1bnNp
Z25lZCBpbnQgICAgKCpzZXRfcG93ZXIpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAorCQkJCXVu
c2lnbmVkIHNob3J0IHBvd2VyKTsKIH07CiAKICNpZmRlZiBDT05GSUdfTU1DX1NESENJX0lPX0FD
Q0VTU09SUwotLSAKMS43LjAuNAoK

--_002_689C75E0D210324F8BE88961219F681618934B2321SCVEXCH2marve_--
