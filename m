From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch 1/3] sdhci-pltfm: add call back alloc_host
Date: Sun, 26 Sep 2010 22:55:46 -0400
Message-ID: <AANLkTin_BEE+LgZuJHeewvFDUQCipG98ZbkhMJGbnprC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b85746c6959049134dd7f
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61216 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab0I0Czq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 22:55:46 -0400
Received: by iwn5 with SMTP id 5so4370335iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 19:55:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--0016363b85746c6959049134dd7f
Content-Type: text/plain; charset=ISO-8859-1

>From 7a870a620fa868ed4ce0cffcbd6b0683a00ae2e5 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 27 Sep 2010 10:30:01 -0400
Subject: [PATCH 1/3] sdhci-pltfm: add call back alloc_host

	alloc_host could alloc specific structure of device to meet different
requirement

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    4 ++--
 include/linux/sdhci-pltfm.h    |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 9669f21..82d3d05 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -76,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");

-	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
+	if (pdata && pdata->alloc_host)
+		host = pdata->alloc_host(&pdev->dev);
 	else
 		host = sdhci_alloc_host(&pdev->dev, 0);

diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
index e14fce3..80c415e 100644
--- a/include/linux/sdhci-pltfm.h
+++ b/include/linux/sdhci-pltfm.h
@@ -30,6 +30,7 @@ struct sdhci_pltfm_data {
 	unsigned int quirks;
 	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata,
void* priv_pdata);
 	void (*exit)(struct sdhci_host *host);
+	struct sdhci_host *(*alloc_host)(struct device *dev);
 };

 #endif /* _SDHCI_PLTFM_H */
-- 
1.7.0.4

--0016363b85746c6959049134dd7f
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-pltfm-add-call-back-alloc_host.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-pltfm-add-call-back-alloc_host.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gelgke0i0

RnJvbSA3YTg3MGE2MjBmYTg2OGVkNGNlMGNmZmNiZDZiMDY4M2EwMGFlMmU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyNyBTZXAgMjAxMCAxMDozMDowMSAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
MS8zXSBzZGhjaS1wbHRmbTogYWRkIGNhbGwgYmFjayBhbGxvY19ob3N0CgoJYWxsb2NfaG9zdCBj
b3VsZCBhbGxvYyBzcGVjaWZpYyBzdHJ1Y3R1cmUgb2YgZGV2aWNlIHRvIG1lZXQgZGlmZmVyZW50
IHJlcXVpcmVtZW50CgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0Bt
YXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMgfCAgICA0ICsr
LS0KIGluY2x1ZGUvbGludXgvc2RoY2ktcGx0Zm0uaCAgICB8ICAgIDEgKwogMiBmaWxlcyBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5j
CmluZGV4IDk2NjlmMjEuLjgyZDNkMDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktcGx0Zm0uYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMKQEAgLTc2LDgg
Kzc2LDggQEAgc3RhdGljIGludCBfX2RldmluaXQgc2RoY2lfcGx0Zm1fcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiSW52YWxpZCBpb21l
bSBzaXplLiBZb3UgbWF5ICIKIAkJCSJleHBlcmllbmNlIHByb2JsZW1zLlxuIik7CiAKLQlpZiAo
cGRldi0+ZGV2LnBhcmVudCkKLQkJaG9zdCA9IHNkaGNpX2FsbG9jX2hvc3QocGRldi0+ZGV2LnBh
cmVudCwgMCk7CisJaWYgKHBkYXRhICYmIHBkYXRhLT5hbGxvY19ob3N0KQorCQlob3N0ID0gcGRh
dGEtPmFsbG9jX2hvc3QoJnBkZXYtPmRldik7CiAJZWxzZQogCQlob3N0ID0gc2RoY2lfYWxsb2Nf
aG9zdCgmcGRldi0+ZGV2LCAwKTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zZGhjaS1w
bHRmbS5oIGIvaW5jbHVkZS9saW51eC9zZGhjaS1wbHRmbS5oCmluZGV4IGUxNGZjZTMuLjgwYzQx
NWUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2RoY2ktcGx0Zm0uaAorKysgYi9pbmNsdWRl
L2xpbnV4L3NkaGNpLXBsdGZtLmgKQEAgLTMwLDYgKzMwLDcgQEAgc3RydWN0IHNkaGNpX3BsdGZt
X2RhdGEgewogCXVuc2lnbmVkIGludCBxdWlya3M7CiAJaW50ICgqaW5pdCkoc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QsIHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRhICpwZGF0YSwgdm9pZCogcHJpdl9w
ZGF0YSk7CiAJdm9pZCAoKmV4aXQpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKKwlzdHJ1Y3Qg
c2RoY2lfaG9zdCAqKCphbGxvY19ob3N0KShzdHJ1Y3QgZGV2aWNlICpkZXYpOwogfTsKIAogI2Vu
ZGlmIC8qIF9TREhDSV9QTFRGTV9IICovCi0tIAoxLjcuMC40Cgo=
--0016363b85746c6959049134dd7f--
