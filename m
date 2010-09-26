From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 1/2]sdhci-pltfm add sdhci-pxa
Date: Sun, 26 Sep 2010 06:53:59 -0400
Message-ID: <AANLkTin357VumrfSTaYPJD0fodOvz+YdXSqFYuCu_XxJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0022152d5d65db74f70491276d5a
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54031 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466Ab0IZKyB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 06:54:01 -0400
Received: by iwn5 with SMTP id 5so3807641iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 03:54:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--0022152d5d65db74f70491276d5a
Content-Type: text/plain; charset=ISO-8859-1

>From 29b0255431e3d635ae32214b223daef823433885 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Sun, 26 Sep 2010 18:32:27 -0400
Subject: [PATCH 1/2] sdhci-pltfm: add sdhci-pxa

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e06f047..7511fb7 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -173,6 +173,9 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
 #ifdef CONFIG_MMC_SDHCI_CNS3XXX
 	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
 #endif
+#ifdef CONFIG_MMC_SDHCI_PXA
+	{ "sdhci-pxa", (kernel_ulong_t)&sdhci_pxa_pdata },
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 900f329..0747f42 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -14,5 +14,6 @@
 #include <linux/sdhci-pltfm.h>

 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
+extern struct sdhci_pltfm_data sdhci_pxa_pdata;

 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
1.7.0.4

--0022152d5d65db74f70491276d5a
Content-Type: text/x-patch; charset=US-ASCII; name="0001-sdhci-pltfm-add-sdhci-pxa.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-pltfm-add-sdhci-pxa.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geki7ffa0

RnJvbSAyOWIwMjU1NDMxZTNkNjM1YWUzMjIxNGIyMjNkYWVmODIzNDMzODg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogU3VuLCAyNiBTZXAgMjAxMCAxODozMjoyNyAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBzZGhjaS1wbHRmbTogYWRkIHNkaGNpLXB4YQoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkg
R2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1wbHRmbS5jIHwgICAgMyArKysKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGx0Zm0uaCB8ICAg
IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5jIGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1wbHRmbS5jCmluZGV4IGUwNmYwNDcuLjc1MTFmYjcgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGx0Zm0uYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LXBsdGZtLmMKQEAgLTE3Myw2ICsxNzMsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3Jt
X2RldmljZV9pZCBzZGhjaV9wbHRmbV9pZHNbXSA9IHsKICNpZmRlZiBDT05GSUdfTU1DX1NESENJ
X0NOUzNYWFgKIAl7ICJzZGhjaS1jbnMzeHh4IiwgKGtlcm5lbF91bG9uZ190KSZzZGhjaV9jbnMz
eHh4X3BkYXRhIH0sCiAjZW5kaWYKKyNpZmRlZiBDT05GSUdfTU1DX1NESENJX1BYQQorCXsgInNk
aGNpLXB4YSIsIChrZXJuZWxfdWxvbmdfdCkmc2RoY2lfcHhhX3BkYXRhIH0sCisjZW5kaWYKIAl7
IH0sCiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShwbGF0Zm9ybSwgc2RoY2lfcGx0Zm1faWRzKTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGx0Zm0uaCBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktcGx0Zm0uaAppbmRleCA5MDBmMzI5Li4wNzQ3ZjQyIDEwMDY0NAotLS0gYS9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmgKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1wbHRmbS5oCkBAIC0xNCw1ICsxNCw2IEBACiAjaW5jbHVkZSA8bGludXgvc2RoY2ktcGx0Zm0u
aD4KIAogZXh0ZXJuIHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRhIHNkaGNpX2NuczN4eHhfcGRhdGE7
CitleHRlcm4gc3RydWN0IHNkaGNpX3BsdGZtX2RhdGEgc2RoY2lfcHhhX3BkYXRhOwogCiAjZW5k
aWYgLyogX0RSSVZFUlNfTU1DX1NESENJX1BMVEZNX0ggKi8KLS0gCjEuNy4wLjQKCg==
--0022152d5d65db74f70491276d5a--
