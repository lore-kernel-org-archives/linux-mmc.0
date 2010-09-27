From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch 1/3] sdhci-pltfm: add call back get_quirk
Date: Sun, 26 Sep 2010 22:57:19 -0400
Message-ID: <AANLkTimjF_rL7CcPQDo=LUa6GfofmqM0uGRJ1ZjVMDZn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016362844d404b58d049134e332
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab0I0C5U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 22:57:20 -0400
Received: by iwn5 with SMTP id 5so4371473iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 19:57:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--0016362844d404b58d049134e332
Content-Type: text/plain; charset=ISO-8859-1

>From af7aa1232efd3bb3bf3eac151b71dba7d4a0c875 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 27 Sep 2010 10:33:38 -0400
Subject: [PATCH 2/3] dhci-pltfm: add call back get_quirk

	One driver may serve several device, each one may have different
quirks instead of the initial one.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    8 ++++++--
 include/linux/sdhci-pltfm.h    |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 82d3d05..5c3c513 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -91,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
 		host->ops = pdata->ops;
 	else
 		host->ops = &sdhci_pltfm_ops;
-	if (pdata)
-		host->quirks = pdata->quirks;
+
 	host->irq = platform_get_irq(pdev, 0);

 	if (!request_mem_region(iomem->start, resource_size(iomem),
@@ -115,6 +114,11 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
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
diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
index 80c415e..0d20cb4 100644
--- a/include/linux/sdhci-pltfm.h
+++ b/include/linux/sdhci-pltfm.h
@@ -30,6 +30,7 @@ struct sdhci_pltfm_data {
 	unsigned int quirks;
 	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata,
void* priv_pdata);
 	void (*exit)(struct sdhci_host *host);
+	unsigned int  (*get_quirk)(struct sdhci_host *host);
 	struct sdhci_host *(*alloc_host)(struct device *dev);
 };

-- 
1.7.0.4

--0016362844d404b58d049134e332
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-dhci-pltfm-add-call-back-get_quirk.patch"
Content-Disposition: attachment;
	filename="0002-dhci-pltfm-add-call-back-get_quirk.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gelgmz1s0

RnJvbSBhZjdhYTEyMzJlZmQzYmIzYmYzZWFjMTUxYjcxZGJhN2Q0YTBjODc1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyNyBTZXAgMjAxMCAxMDozMzozOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8zXSBkaGNpLXBsdGZtOiBhZGQgY2FsbCBiYWNrIGdldF9xdWlyawoKCU9uZSBkcml2ZXIgbWF5
IHNlcnZlIHNldmVyYWwgZGV2aWNlLCBlYWNoIG9uZSBtYXkgaGF2ZSBkaWZmZXJlbnQgcXVpcmtz
IGluc3RlYWQgb2YgdGhlIGluaXRpYWwgb25lLgoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkgR2Fv
IDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1w
bHRmbS5jIHwgICAgOCArKysrKystLQogaW5jbHVkZS9saW51eC9zZGhjaS1wbHRmbS5oICAgIHwg
ICAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLXBsdGZtLmMKaW5kZXggODJkM2QwNS4uNWMzYzUxMyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktcGx0Zm0uYwpAQCAtOTEsOCArOTEsNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzZGhjaV9w
bHRmbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlob3N0LT5vcHMgPSBw
ZGF0YS0+b3BzOwogCWVsc2UKIAkJaG9zdC0+b3BzID0gJnNkaGNpX3BsdGZtX29wczsKLQlpZiAo
cGRhdGEpCi0JCWhvc3QtPnF1aXJrcyA9IHBkYXRhLT5xdWlya3M7CisKIAlob3N0LT5pcnEgPSBw
bGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOwogCiAJaWYgKCFyZXF1ZXN0X21lbV9yZWdpb24oaW9t
ZW0tPnN0YXJ0LCByZXNvdXJjZV9zaXplKGlvbWVtKSwKQEAgLTExNSw2ICsxMTQsMTEgQEAgc3Rh
dGljIGludCBfX2RldmluaXQgc2RoY2lfcGx0Zm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKIAkJCWdvdG8gZXJyX3BsYXRfaW5pdDsKIAl9CiAKKwlpZiAocGRhdGEgJiYgcGRh
dGEtPmdldF9xdWlyaykKKwkJaG9zdC0+cXVpcmtzID0gcGRhdGEtPmdldF9xdWlyayhob3N0KTsK
KwllbHNlIGlmIChwZGF0YSkKKwkJaG9zdC0+cXVpcmtzID0gcGRhdGEtPnF1aXJrczsKKwogCXJl
dCA9IHNkaGNpX2FkZF9ob3N0KGhvc3QpOwogCWlmIChyZXQpCiAJCWdvdG8gZXJyX2FkZF9ob3N0
OwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zZGhjaS1wbHRmbS5oIGIvaW5jbHVkZS9saW51
eC9zZGhjaS1wbHRmbS5oCmluZGV4IDgwYzQxNWUuLjBkMjBjYjQgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvc2RoY2ktcGx0Zm0uaAorKysgYi9pbmNsdWRlL2xpbnV4L3NkaGNpLXBsdGZtLmgK
QEAgLTMwLDYgKzMwLDcgQEAgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGEgewogCXVuc2lnbmVkIGlu
dCBxdWlya3M7CiAJaW50ICgqaW5pdCkoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHN0cnVjdCBz
ZGhjaV9wbHRmbV9kYXRhICpwZGF0YSwgdm9pZCogcHJpdl9wZGF0YSk7CiAJdm9pZCAoKmV4aXQp
KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKKwl1bnNpZ25lZCBpbnQgICgqZ2V0X3F1aXJrKShz
dHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CiAJc3RydWN0IHNkaGNpX2hvc3QgKigqYWxsb2NfaG9z
dCkoc3RydWN0IGRldmljZSAqZGV2KTsKIH07CiAKLS0gCjEuNy4wLjQKCg==
--0016362844d404b58d049134e332--
