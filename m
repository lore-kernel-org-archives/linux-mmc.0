From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch 3/3] sdhci-pltfm: add call back set_max_speed
Date: Sun, 26 Sep 2010 22:59:04 -0400
Message-ID: <AANLkTimNAnA396gofvckwibOfsGb=11jDRzwHKuLUB4W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0022152d6e59465ea2049134e9fc
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50611 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621Ab0I0C7F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 22:59:05 -0400
Received: by iwn5 with SMTP id 5so4372722iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 19:59:04 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--0022152d6e59465ea2049134e9fc
Content-Type: text/plain; charset=ISO-8859-1

>From c75877463fb72e691e1547184f8e2783e5d1fe27 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 27 Sep 2010 10:39:18 -0400
Subject: [PATCH 3/3] dhci-pltfm: add call back set_max_speed

	set_max_speed should be done after add_host to change mmc->f_max,
which set max_clk in add_host by defalut

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 include/linux/sdhci-pltfm.h    |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 5c3c513..f25825b 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -123,6 +123,9 @@ static int __devinit sdhci_pltfm_probe(struct
platform_device *pdev)
 	if (ret)
 		goto err_add_host;

+	if (pdata && pdata->set_max_speed)
+		pdata->set_max_speed(host);
+
 	platform_set_drvdata(pdev, host);

 	return 0;
diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
index 0d20cb4..0d8e8f6 100644
--- a/include/linux/sdhci-pltfm.h
+++ b/include/linux/sdhci-pltfm.h
@@ -30,6 +30,7 @@ struct sdhci_pltfm_data {
 	unsigned int quirks;
 	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata,
void* priv_pdata);
 	void (*exit)(struct sdhci_host *host);
+	void (*set_max_speed)(struct sdhci_host *host);
 	unsigned int  (*get_quirk)(struct sdhci_host *host);
 	struct sdhci_host *(*alloc_host)(struct device *dev);
 };
-- 
1.7.0.4

--0022152d6e59465ea2049134e9fc
Content-Type: text/x-patch; charset=US-ASCII;
	name="0003-dhci-pltfm-add-call-back-set_max_speed.patch"
Content-Disposition: attachment;
	filename="0003-dhci-pltfm-add-call-back-set_max_speed.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gelgprbs0

RnJvbSBjNzU4Nzc0NjNmYjcyZTY5MWUxNTQ3MTg0ZjhlMjc4M2U1ZDFmZTI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyNyBTZXAgMjAxMCAxMDozOToxOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
My8zXSBkaGNpLXBsdGZtOiBhZGQgY2FsbCBiYWNrIHNldF9tYXhfc3BlZWQKCglzZXRfbWF4X3Nw
ZWVkIHNob3VsZCBiZSBkb25lIGFmdGVyIGFkZF9ob3N0IHRvIGNoYW5nZSBtbWMtPmZfbWF4LCB3
aGljaCBzZXQgbWF4X2NsayBpbiBhZGRfaG9zdCBieSBkZWZhbHV0CgpTaWduZWQtb2ZmLWJ5OiBa
aGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9o
b3N0L3NkaGNpLXBsdGZtLmMgfCAgICAzICsrKwogaW5jbHVkZS9saW51eC9zZGhjaS1wbHRmbS5o
ICAgIHwgICAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMKaW5kZXggNWMzYzUxMy4uZjI1ODI1YiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5jCisrKyBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktcGx0Zm0uYwpAQCAtMTIzLDYgKzEyMyw5IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0
IHNkaGNpX3BsdGZtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJaWYgKHJl
dCkKIAkJZ290byBlcnJfYWRkX2hvc3Q7CiAKKwlpZiAocGRhdGEgJiYgcGRhdGEtPnNldF9tYXhf
c3BlZWQpCisJCXBkYXRhLT5zZXRfbWF4X3NwZWVkKGhvc3QpOworCiAJcGxhdGZvcm1fc2V0X2Ry
dmRhdGEocGRldiwgaG9zdCk7CiAKIAlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvc2RoY2ktcGx0Zm0uaCBiL2luY2x1ZGUvbGludXgvc2RoY2ktcGx0Zm0uaAppbmRleCAwZDIw
Y2I0Li4wZDhlOGY2IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3NkaGNpLXBsdGZtLmgKKysr
IGIvaW5jbHVkZS9saW51eC9zZGhjaS1wbHRmbS5oCkBAIC0zMCw2ICszMCw3IEBAIHN0cnVjdCBz
ZGhjaV9wbHRmbV9kYXRhIHsKIAl1bnNpZ25lZCBpbnQgcXVpcmtzOwogCWludCAoKmluaXQpKHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSAqcGRhdGEsIHZv
aWQqIHByaXZfcGRhdGEpOwogCXZvaWQgKCpleGl0KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7
CisJdm9pZCAoKnNldF9tYXhfc3BlZWQpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKIAl1bnNp
Z25lZCBpbnQgICgqZ2V0X3F1aXJrKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CiAJc3RydWN0
IHNkaGNpX2hvc3QgKigqYWxsb2NfaG9zdCkoc3RydWN0IGRldmljZSAqZGV2KTsKIH07Ci0tIAox
LjcuMC40Cgo=
--0022152d6e59465ea2049134e9fc--
