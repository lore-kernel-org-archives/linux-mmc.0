From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 1/2] mmc move sdhci_ops and sdhci_priv to header
Date: Fri, 3 Dec 2010 01:29:35 -0500
Message-ID: <AANLkTi=gij9Wjm_q_1MhdAaxDC2mM70CoUhVTQMkzaT0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a6e97d00a404967ba985
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62583 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab0LCG3g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2010 01:29:36 -0500
Received: by fxm20 with SMTP id 20so1901607fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2010 22:29:35 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, niej0001@gmail.com, Philip Rakity <prakity@marvell.com>, Mark Brown <markb@marvell.com>, xywu@marvell.com, njun@marvell.com

--20cf3054a6e97d00a404967ba985
Content-Type: text/plain; charset=ISO-8859-1

>From 9ae40c28754f1034abad9d07c0c86725a0a3f4b8 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Tue, 30 Nov 2010 05:37:27 -0500
Subject: [PATCH 1/2] mmc: move sdhci_ops and sdhci_priv to header

	Soc specific function under /arch would access private via sdhci_priv.
	Different controller may have different ops, which transfered from platform.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.h  |   28 ----------------------------
 include/linux/mmc/sdhci.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e42d7f0..b689cc6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -200,29 +200,6 @@
 #define SDHCI_MAX_DIV_SPEC_200	256
 #define SDHCI_MAX_DIV_SPEC_300	2046

-struct sdhci_ops {
-#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-	u32		(*read_l)(struct sdhci_host *host, int reg);
-	u16		(*read_w)(struct sdhci_host *host, int reg);
-	u8		(*read_b)(struct sdhci_host *host, int reg);
-	void		(*write_l)(struct sdhci_host *host, u32 val, int reg);
-	void		(*write_w)(struct sdhci_host *host, u16 val, int reg);
-	void		(*write_b)(struct sdhci_host *host, u8 val, int reg);
-#endif
-
-	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
-
-	int		(*enable_dma)(struct sdhci_host *host);
-	unsigned int	(*get_max_clock)(struct sdhci_host *host);
-	unsigned int	(*get_min_clock)(struct sdhci_host *host);
-	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
-	int		(*platform_8bit_width)(struct sdhci_host *host,
-					       int width);
-	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
-					     u8 power_mode);
-	unsigned int    (*get_ro)(struct sdhci_host *host);
-};
-
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

 static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
@@ -311,11 +288,6 @@ extern struct sdhci_host *sdhci_alloc_host(struct
device *dev,
 	size_t priv_size);
 extern void sdhci_free_host(struct sdhci_host *host);

-static inline void *sdhci_priv(struct sdhci_host *host)
-{
-	return (void *)host->private;
-}
-
 extern void sdhci_card_detect(struct sdhci_host *host);
 extern int sdhci_add_host(struct sdhci_host *host);
 extern void sdhci_remove_host(struct sdhci_host *host, int dead);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..86e8380 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -141,4 +141,34 @@ struct sdhci_host {

 	unsigned long private[0] ____cacheline_aligned;
 };
+
+struct sdhci_ops {
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+	u32		(*read_l)(struct sdhci_host *host, int reg);
+	u16		(*read_w)(struct sdhci_host *host, int reg);
+	u8		(*read_b)(struct sdhci_host *host, int reg);
+	void		(*write_l)(struct sdhci_host *host, u32 val, int reg);
+	void		(*write_w)(struct sdhci_host *host, u16 val, int reg);
+	void		(*write_b)(struct sdhci_host *host, u8 val, int reg);
+#endif
+
+	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+
+	int		(*enable_dma)(struct sdhci_host *host);
+	unsigned int	(*get_max_clock)(struct sdhci_host *host);
+	unsigned int	(*get_min_clock)(struct sdhci_host *host);
+	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	int		(*platform_8bit_width)(struct sdhci_host *host,
+					       int width);
+	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
+					     u8 power_mode);
+	unsigned int    (*get_ro)(struct sdhci_host *host);
+};
+
+
+static inline void *sdhci_priv(struct sdhci_host *host)
+{
+	return (void *)host->private;
+}
+
 #endif /* __SDHCI_H */
-- 
1.7.0.4

--20cf3054a6e97d00a404967ba985
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-move-sdhci_ops-and-sdhci_priv-to-header.patch"
Content-Disposition: attachment;
	filename="0001-mmc-move-sdhci_ops-and-sdhci_priv-to-header.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh8r5gtq0

RnJvbSA5YWU0MGMyODc1NGYxMDM0YWJhZDlkMDdjMGM4NjcyNWEwYTNmNGI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVHVlLCAzMCBOb3YgMjAxMCAwNTozNzoyNyAtMDUwMApTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBtbWM6IG1vdmUgc2RoY2lfb3BzIGFuZCBzZGhjaV9wcml2IHRvIGhlYWRlcgoKCVNvYyBz
cGVjaWZpYyBmdW5jdGlvbiB1bmRlciAvYXJjaCB3b3VsZCBhY2Nlc3MgcHJpdmF0ZSB2aWEgc2Ro
Y2lfcHJpdi4KCURpZmZlcmVudCBjb250cm9sbGVyIG1heSBoYXZlIGRpZmZlcmVudCBvcHMsIHdo
aWNoIHRyYW5zZmVyZWQgZnJvbSBwbGF0Zm9ybS4KClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVpIEdh
byA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ku
aCAgfCAgIDI4IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGluY2x1ZGUvbGludXgvbW1j
L3NkaGNpLmggfCAgIDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBj
aGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKaW5kZXgg
ZTQyZDdmMC4uYjY4OWNjNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCisr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtMjAwLDI5ICsyMDAsNiBAQAogI2RlZmlu
ZSBTREhDSV9NQVhfRElWX1NQRUNfMjAwCTI1NgogI2RlZmluZSBTREhDSV9NQVhfRElWX1NQRUNf
MzAwCTIwNDYKIAotc3RydWN0IHNkaGNpX29wcyB7Ci0jaWZkZWYgQ09ORklHX01NQ19TREhDSV9J
T19BQ0NFU1NPUlMKLQl1MzIJCSgqcmVhZF9sKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgaW50
IHJlZyk7Ci0JdTE2CQkoKnJlYWRfdykoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIGludCByZWcp
OwotCXU4CQkoKnJlYWRfYikoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIGludCByZWcpOwotCXZv
aWQJCSgqd3JpdGVfbCkoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHUzMiB2YWwsIGludCByZWcp
OwotCXZvaWQJCSgqd3JpdGVfdykoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHUxNiB2YWwsIGlu
dCByZWcpOwotCXZvaWQJCSgqd3JpdGVfYikoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHU4IHZh
bCwgaW50IHJlZyk7Ci0jZW5kaWYKLQotCXZvaWQJKCpzZXRfY2xvY2spKHN0cnVjdCBzZGhjaV9o
b3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgY2xvY2spOwotCi0JaW50CQkoKmVuYWJsZV9kbWEpKHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKLQl1bnNpZ25lZCBpbnQJKCpnZXRfbWF4X2Nsb2NrKShz
dHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7Ci0JdW5zaWduZWQgaW50CSgqZ2V0X21pbl9jbG9jayko
c3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpOwotCXVuc2lnbmVkIGludAkoKmdldF90aW1lb3V0X2Ns
b2NrKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7Ci0JaW50CQkoKnBsYXRmb3JtXzhiaXRfd2lk
dGgpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAotCQkJCQkgICAgICAgaW50IHdpZHRoKTsKLQl2
b2lkICgqcGxhdGZvcm1fc2VuZF9pbml0Xzc0X2Nsb2Nrcykoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QsCi0JCQkJCSAgICAgdTggcG93ZXJfbW9kZSk7Ci0JdW5zaWduZWQgaW50ICAgICgqZ2V0X3Jv
KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7Ci19OwotCiAjaWZkZWYgQ09ORklHX01NQ19TREhD
SV9JT19BQ0NFU1NPUlMKIAogc3RhdGljIGlubGluZSB2b2lkIHNkaGNpX3dyaXRlbChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCwgdTMyIHZhbCwgaW50IHJlZykKQEAgLTMxMSwxMSArMjg4LDYgQEAg
ZXh0ZXJuIHN0cnVjdCBzZGhjaV9ob3N0ICpzZGhjaV9hbGxvY19ob3N0KHN0cnVjdCBkZXZpY2Ug
KmRldiwKIAlzaXplX3QgcHJpdl9zaXplKTsKIGV4dGVybiB2b2lkIHNkaGNpX2ZyZWVfaG9zdChz
dHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CiAKLXN0YXRpYyBpbmxpbmUgdm9pZCAqc2RoY2lfcHJp
dihzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKLXsKLQlyZXR1cm4gKHZvaWQgKilob3N0LT5wcml2
YXRlOwotfQotCiBleHRlcm4gdm9pZCBzZGhjaV9jYXJkX2RldGVjdChzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCk7CiBleHRlcm4gaW50IHNkaGNpX2FkZF9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpo
b3N0KTsKIGV4dGVybiB2b2lkIHNkaGNpX3JlbW92ZV9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpo
b3N0LCBpbnQgZGVhZCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYy9zZGhjaS5oIGIv
aW5jbHVkZS9saW51eC9tbWMvc2RoY2kuaAppbmRleCAxZmRjNjczLi44NmU4MzgwIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L21tYy9zZGhjaS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW1jL3Nk
aGNpLmgKQEAgLTE0MSw0ICsxNDEsMzQgQEAgc3RydWN0IHNkaGNpX2hvc3QgewogCiAJdW5zaWdu
ZWQgbG9uZyBwcml2YXRlWzBdIF9fX19jYWNoZWxpbmVfYWxpZ25lZDsKIH07CisKK3N0cnVjdCBz
ZGhjaV9vcHMgeworI2lmZGVmIENPTkZJR19NTUNfU0RIQ0lfSU9fQUNDRVNTT1JTCisJdTMyCQko
KnJlYWRfbCkoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIGludCByZWcpOworCXUxNgkJKCpyZWFk
X3cpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBpbnQgcmVnKTsKKwl1OAkJKCpyZWFkX2IpKHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBpbnQgcmVnKTsKKwl2b2lkCQkoKndyaXRlX2wpKHN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0LCB1MzIgdmFsLCBpbnQgcmVnKTsKKwl2b2lkCQkoKndyaXRlX3cp
KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1MTYgdmFsLCBpbnQgcmVnKTsKKwl2b2lkCQkoKndy
aXRlX2IpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1OCB2YWwsIGludCByZWcpOworI2VuZGlm
CisKKwl2b2lkCSgqc2V0X2Nsb2NrKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQg
aW50IGNsb2NrKTsKKworCWludAkJKCplbmFibGVfZG1hKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9z
dCk7CisJdW5zaWduZWQgaW50CSgqZ2V0X21heF9jbG9jaykoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QpOworCXVuc2lnbmVkIGludAkoKmdldF9taW5fY2xvY2spKHN0cnVjdCBzZGhjaV9ob3N0ICpo
b3N0KTsKKwl1bnNpZ25lZCBpbnQJKCpnZXRfdGltZW91dF9jbG9jaykoc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QpOworCWludAkJKCpwbGF0Zm9ybV84Yml0X3dpZHRoKShzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCwKKwkJCQkJICAgICAgIGludCB3aWR0aCk7CisJdm9pZCAoKnBsYXRmb3JtX3NlbmRf
aW5pdF83NF9jbG9ja3MpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAorCQkJCQkgICAgIHU4IHBv
d2VyX21vZGUpOworCXVuc2lnbmVkIGludCAgICAoKmdldF9ybykoc3RydWN0IHNkaGNpX2hvc3Qg
Kmhvc3QpOworfTsKKworCitzdGF0aWMgaW5saW5lIHZvaWQgKnNkaGNpX3ByaXYoc3RydWN0IHNk
aGNpX2hvc3QgKmhvc3QpCit7CisJcmV0dXJuICh2b2lkICopaG9zdC0+cHJpdmF0ZTsKK30KKwog
I2VuZGlmIC8qIF9fU0RIQ0lfSCAqLwotLSAKMS43LjAuNAoK
--20cf3054a6e97d00a404967ba985--
