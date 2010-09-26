From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch] sdhci-pltfm: add call back function
Date: Sun, 26 Sep 2010 04:52:06 -0400
Message-ID: <AANLkTi=tkP2O+EaY5xSQ8EZAR0rP9gTz34cipC-WTHjf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=005045017239fb2de5049125b9ed
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34402 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab0IZIwH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 04:52:07 -0400
Received: by iwn5 with SMTP id 5so3753906iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 01:52:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Richard Zhu <r65037@freescale.com>

--005045017239fb2de5049125b9ed
Content-Type: text/plain; charset=ISO-8859-1

Add several call back to sdhci-pltfm.c, help give suggestion
1. struct sdhci_host *(*alloc_host)(struct device *dev), since
specific driver need some private variable to allocate and free,
including clk.
2. unsigned int  (*get_quirk)(struct sdhci_host *host); add this
because one driver may serve several device, each one may require
different quirk, and specific driver is right one to know.
3. void (*set_max_speed)(struct sdhci_host *host); this should be done
after add_host, which impact f_max.
4. int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data
*pdata, void* priv_pdata); copy from Wolfram Sang's patch to transfer
platform data, copy here for test.

>From 8c59d0b917f434d7c424ce1e0896af45c3e5fbba Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Sun, 26 Sep 2010 16:37:11 -0400
Subject: [PATCH 2/2] sdhci-pltfm: add call back function


Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   24 ++++++++++++++++++------
 include/linux/sdhci-pltfm.h    |    5 ++++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e045e3c..e06f047 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -54,12 +54,17 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
 {
 	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	void *priv_pdata = NULL;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	int ret;

-	if (!pdata && platid && platid->driver_data)
+	if (platid && platid->driver_data) {
 		pdata = (void *)platid->driver_data;
+		priv_pdata = pdev->dev.platform_data;
+	} else {
+		pdata = pdev->dev.platform_data;
+	}

 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
@@ -71,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");

-	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
+	if (pdata && pdata->alloc_host)
+		host = pdata->alloc_host(&pdev->dev);
 	else
 		host = sdhci_alloc_host(&pdev->dev, 0);

@@ -86,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
 		host->ops = pdata->ops;
 	else
 		host->ops = &sdhci_pltfm_ops;
-	if (pdata)
-		host->quirks = pdata->quirks;
+
 	host->irq = platform_get_irq(pdev, 0);

 	if (!request_mem_region(iomem->start, resource_size(iomem),
@@ -105,15 +109,23 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
 	}

 	if (pdata && pdata->init) {
-		ret = pdata->init(host);
+		ret = pdata->init(host, pdata, priv_pdata);
 		if (ret)
 			goto err_plat_init;
 	}

+	if (pdata && pdata->get_quirk)
+		host->quirks = pdata->get_quirk(host);
+	else if (pdata)
+		host->quirks = pdata->quirks;
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_add_host;

+	if (pdata && pdata->set_max_speed)
+		pdata->set_max_speed(host);
+
 	platform_set_drvdata(pdev, host);

 	return 0;
diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
index 0239bd7..0d8e8f6 100644
--- a/include/linux/sdhci-pltfm.h
+++ b/include/linux/sdhci-pltfm.h
@@ -28,8 +28,11 @@ struct sdhci_host;
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
-	int (*init)(struct sdhci_host *host);
+	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata,
void* priv_pdata);
 	void (*exit)(struct sdhci_host *host);
+	void (*set_max_speed)(struct sdhci_host *host);
+	unsigned int  (*get_quirk)(struct sdhci_host *host);
+	struct sdhci_host *(*alloc_host)(struct device *dev);
 };

 #endif /* _SDHCI_PLTFM_H */
-- 
1.7.0.4

--005045017239fb2de5049125b9ed
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-sdhci-pltfm-add-call-back-function.patch"
Content-Disposition: attachment;
	filename="0002-sdhci-pltfm-add-call-back-function.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gekdloba0

RnJvbSA4YzU5ZDBiOTE3ZjQzNGQ3YzQyNGNlMWUwODk2YWY0NWMzZTVmYmJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogU3VuLCAyNiBTZXAgMjAxMCAxNjozNzoxMSAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8yXSBzZGhjaS1wbHRmbTogYWRkIGNhbGwgYmFjayBmdW5jdGlvbgoKClNpZ25lZC1vZmYtYnk6
IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktcGx0Zm0uYyB8ICAgMjQgKysrKysrKysrKysrKysrKysrLS0tLS0tCiBpbmNs
dWRlL2xpbnV4L3NkaGNpLXBsdGZtLmggICAgfCAgICA1ICsrKystCiAyIGZpbGVzIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1wbHRmbS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5jCmlu
ZGV4IGUwNDVlM2MuLmUwNmYwNDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
cGx0Zm0uYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMKQEAgLTU0LDEyICs1
NCwxNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzZGhjaV9wbHRmbV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogewogCXN0cnVjdCBzZGhjaV9wbHRmbV9kYXRhICpwZGF0YSA9
IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhOwogCWNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Vf
aWQgKnBsYXRpZCA9IHBsYXRmb3JtX2dldF9kZXZpY2VfaWQocGRldik7CisJdm9pZCAqcHJpdl9w
ZGF0YSA9IE5VTEw7CiAJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Q7CiAJc3RydWN0IHJlc291cmNl
ICppb21lbTsKIAlpbnQgcmV0OwogCi0JaWYgKCFwZGF0YSAmJiBwbGF0aWQgJiYgcGxhdGlkLT5k
cml2ZXJfZGF0YSkKKwlpZiAocGxhdGlkICYmIHBsYXRpZC0+ZHJpdmVyX2RhdGEpIHsKIAkJcGRh
dGEgPSAodm9pZCAqKXBsYXRpZC0+ZHJpdmVyX2RhdGE7CisJCXByaXZfcGRhdGEgPSBwZGV2LT5k
ZXYucGxhdGZvcm1fZGF0YTsKKwl9IGVsc2UgeworCQlwZGF0YSA9IHBkZXYtPmRldi5wbGF0Zm9y
bV9kYXRhOworCX0KIAogCWlvbWVtID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVT
T1VSQ0VfTUVNLCAwKTsKIAlpZiAoIWlvbWVtKSB7CkBAIC03MSw4ICs3Niw4IEBAIHN0YXRpYyBp
bnQgX19kZXZpbml0IHNkaGNpX3BsdGZtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCiAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkludmFsaWQgaW9tZW0gc2l6ZS4gWW91IG1heSAi
CiAJCQkiZXhwZXJpZW5jZSBwcm9ibGVtcy5cbiIpOwogCi0JaWYgKHBkZXYtPmRldi5wYXJlbnQp
Ci0JCWhvc3QgPSBzZGhjaV9hbGxvY19ob3N0KHBkZXYtPmRldi5wYXJlbnQsIDApOworCWlmIChw
ZGF0YSAmJiBwZGF0YS0+YWxsb2NfaG9zdCkKKwkJaG9zdCA9IHBkYXRhLT5hbGxvY19ob3N0KCZw
ZGV2LT5kZXYpOwogCWVsc2UKIAkJaG9zdCA9IHNkaGNpX2FsbG9jX2hvc3QoJnBkZXYtPmRldiwg
MCk7CiAKQEAgLTg2LDggKzkxLDcgQEAgc3RhdGljIGludCBfX2RldmluaXQgc2RoY2lfcGx0Zm1f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJaG9zdC0+b3BzID0gcGRhdGEt
Pm9wczsKIAllbHNlCiAJCWhvc3QtPm9wcyA9ICZzZGhjaV9wbHRmbV9vcHM7Ci0JaWYgKHBkYXRh
KQotCQlob3N0LT5xdWlya3MgPSBwZGF0YS0+cXVpcmtzOworCiAJaG9zdC0+aXJxID0gcGxhdGZv
cm1fZ2V0X2lycShwZGV2LCAwKTsKIAogCWlmICghcmVxdWVzdF9tZW1fcmVnaW9uKGlvbWVtLT5z
dGFydCwgcmVzb3VyY2Vfc2l6ZShpb21lbSksCkBAIC0xMDUsMTUgKzEwOSwyMyBAQCBzdGF0aWMg
aW50IF9fZGV2aW5pdCBzZGhjaV9wbHRmbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQogCX0KIAogCWlmIChwZGF0YSAmJiBwZGF0YS0+aW5pdCkgewotCQlyZXQgPSBwZGF0YS0+
aW5pdChob3N0KTsKKwkJcmV0ID0gcGRhdGEtPmluaXQoaG9zdCwgcGRhdGEsIHByaXZfcGRhdGEp
OwogCQlpZiAocmV0KQogCQkJZ290byBlcnJfcGxhdF9pbml0OwogCX0KIAorCWlmIChwZGF0YSAm
JiBwZGF0YS0+Z2V0X3F1aXJrKQorCQlob3N0LT5xdWlya3MgPSBwZGF0YS0+Z2V0X3F1aXJrKGhv
c3QpOworCWVsc2UgaWYgKHBkYXRhKQorCQlob3N0LT5xdWlya3MgPSBwZGF0YS0+cXVpcmtzOwor
CiAJcmV0ID0gc2RoY2lfYWRkX2hvc3QoaG9zdCk7CiAJaWYgKHJldCkKIAkJZ290byBlcnJfYWRk
X2hvc3Q7CiAKKwlpZiAocGRhdGEgJiYgcGRhdGEtPnNldF9tYXhfc3BlZWQpCisJCXBkYXRhLT5z
ZXRfbWF4X3NwZWVkKGhvc3QpOworCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgaG9zdCk7
CiAKIAlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2RoY2ktcGx0Zm0uaCBi
L2luY2x1ZGUvbGludXgvc2RoY2ktcGx0Zm0uaAppbmRleCAwMjM5YmQ3Li4wZDhlOGY2IDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L3NkaGNpLXBsdGZtLmgKKysrIGIvaW5jbHVkZS9saW51eC9z
ZGhjaS1wbHRmbS5oCkBAIC0yOCw4ICsyOCwxMSBAQCBzdHJ1Y3Qgc2RoY2lfaG9zdDsKIHN0cnVj
dCBzZGhjaV9wbHRmbV9kYXRhIHsKIAlzdHJ1Y3Qgc2RoY2lfb3BzICpvcHM7CiAJdW5zaWduZWQg
aW50IHF1aXJrczsKLQlpbnQgKCppbml0KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CisJaW50
ICgqaW5pdCkoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRh
ICpwZGF0YSwgdm9pZCogcHJpdl9wZGF0YSk7CiAJdm9pZCAoKmV4aXQpKHN0cnVjdCBzZGhjaV9o
b3N0ICpob3N0KTsKKwl2b2lkICgqc2V0X21heF9zcGVlZCkoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QpOworCXVuc2lnbmVkIGludCAgKCpnZXRfcXVpcmspKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0
KTsKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqKCphbGxvY19ob3N0KShzdHJ1Y3QgZGV2aWNlICpkZXYp
OwogfTsKIAogI2VuZGlmIC8qIF9TREhDSV9QTFRGTV9IICovCi0tIAoxLjcuMC40Cgo=
--005045017239fb2de5049125b9ed--
