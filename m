From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch] sdhci: correct f_min in sd 3.0
Date: Mon, 20 Sep 2010 03:32:58 -0400
Message-ID: <AANLkTimp+4V9zvQtOqHoVmpH-+Vmb+0Sr1MzM-cNHAiC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485e76e62ef9af80490abeb57
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48794 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab0ITHc7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 03:32:59 -0400
Received: by iwn5 with SMTP id 5so4049148iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 00:32:59 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

--001485e76e62ef9af80490abeb57
Content-Type: text/plain; charset=ISO-8859-1

>From 83140093bbcd325605135c23740b30b6eeec778f Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 15:15:18 -0400
Subject: [PATCH 4/4] sdhci: correct f_min in sd 3.0

Change-Id: Ie8604dbb5296b15da67071164564f21c60652b60

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f980fb7..5346803 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1835,6 +1835,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->ops = &sdhci_ops;
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
+	else if (host->version >= SDHCI_SPEC_300)
+		mmc->f_min = host->max_clk / 2046;
 	else
 		mmc->f_min = host->max_clk / 256;
 	mmc->f_max = host->max_clk;
-- 
1.7.0.4

--001485e76e62ef9af80490abeb57
Content-Type: text/x-patch; charset=US-ASCII;
	name="0004-sdhci-correct-f_min-in-sd-3.0.patch"
Content-Disposition: attachment;
	filename="0004-sdhci-correct-f_min-in-sd-3.0.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gebqdywq0

RnJvbSA4MzE0MDA5M2JiY2QzMjU2MDUxMzVjMjM3NDBiMzBiNmVlZWM3NzhmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxNToxNToxOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
NC80XSBzZGhjaTogY29ycmVjdCBmX21pbiBpbiBzZCAzLjAKCkNoYW5nZS1JZDogSWU4NjA0ZGJi
NTI5NmIxNWRhNjcwNzExNjQ1NjRmMjFjNjA2NTJiNjAKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVp
IEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuYyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kuYwppbmRleCBmOTgwZmI3Li41MzQ2ODAzIDEwMDY0NAotLS0gYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCkBAIC0x
ODM1LDYgKzE4MzUsOCBAQCBpbnQgc2RoY2lfYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QpCiAJbW1jLT5vcHMgPSAmc2RoY2lfb3BzOwogCWlmIChob3N0LT5vcHMtPmdldF9taW5fY2xv
Y2spCiAJCW1tYy0+Zl9taW4gPSBob3N0LT5vcHMtPmdldF9taW5fY2xvY2soaG9zdCk7CisJZWxz
ZSBpZiAoaG9zdC0+dmVyc2lvbiA+PSBTREhDSV9TUEVDXzMwMCkKKwkJbW1jLT5mX21pbiA9IGhv
c3QtPm1heF9jbGsgLyAyMDQ2OwogCWVsc2UKIAkJbW1jLT5mX21pbiA9IGhvc3QtPm1heF9jbGsg
LyAyNTY7CiAJbW1jLT5mX21heCA9IGhvc3QtPm1heF9jbGs7Ci0tIAoxLjcuMC40Cgo=
--001485e76e62ef9af80490abeb57--
