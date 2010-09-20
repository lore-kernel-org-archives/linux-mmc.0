From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch] mmc: fix init f_min
Date: Mon, 20 Sep 2010 15:25:54 +0800
Message-ID: <AANLkTi=8ScP4Lm-an7bjXhj8doUVu+nM0KnVTa3WK4p3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0050450141b09bf5b60490abd25d
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49050 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0ITHZy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 03:25:54 -0400
Received: by iwn5 with SMTP id 5so4044699iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 00:25:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

--0050450141b09bf5b60490abd25d
Content-Type: text/plain; charset=ISO-8859-1

>From fa357144df43e6c1a9e5e36af497c53437cd41e1 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 15:12:26 -0400
Subject: [PATCH 3/4] mmc: fix init f_min

Change-Id: I7fab1a1a162d9f26fc92c497078f26912c04a3fc

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/core/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5db49b1..9114c87 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -910,9 +910,9 @@ static void mmc_power_up(struct mmc_host *host)
 	if (host->f_min > 400000) {
 		pr_warning("%s: Minimum clock frequency too high for "
 				"identification mode\n", mmc_hostname(host));
-		host->ios.clock = host->f_min;
-	} else
 		host->ios.clock = 400000;
+	} else
+		host->ios.clock = host->f_min;

 	host->ios.power_mode = MMC_POWER_ON;
 	mmc_set_ios(host);
-- 
1.7.0.4

--0050450141b09bf5b60490abd25d
Content-Type: application/octet-stream; name="0003-mmc-fix-init-f_min.patch"
Content-Disposition: attachment; filename="0003-mmc-fix-init-f_min.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geb060zo0

RnJvbSBmYTM1NzE0NGRmNDNlNmMxYTllNWUzNmFmNDk3YzUzNDM3Y2Q0MWUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxNToxMjoyNiAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
My80XSBtbWM6IGZpeCBpbml0IGZfbWluCgpDaGFuZ2UtSWQ6IEk3ZmFiMWExYTE2MmQ5ZjI2ZmM5
MmM0OTcwNzhmMjY5MTJjMDRhM2ZjCgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5n
ZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9jb3JlL2NvcmUuYyB8ICAgIDQg
KystLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Nv
cmUuYwppbmRleCA1ZGI0OWIxLi45MTE0Yzg3IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9jb3Jl
L2NvcmUuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYwpAQCAtOTEwLDkgKzkxMCw5IEBA
IHN0YXRpYyB2b2lkIG1tY19wb3dlcl91cChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCiAJaWYgKGhv
c3QtPmZfbWluID4gNDAwMDAwKSB7CiAJCXByX3dhcm5pbmcoIiVzOiBNaW5pbXVtIGNsb2NrIGZy
ZXF1ZW5jeSB0b28gaGlnaCBmb3IgIgogCQkJCSJpZGVudGlmaWNhdGlvbiBtb2RlXG4iLCBtbWNf
aG9zdG5hbWUoaG9zdCkpOwotCQlob3N0LT5pb3MuY2xvY2sgPSBob3N0LT5mX21pbjsKLQl9IGVs
c2UKIAkJaG9zdC0+aW9zLmNsb2NrID0gNDAwMDAwOworCX0gZWxzZQorCQlob3N0LT5pb3MuY2xv
Y2sgPSBob3N0LT5mX21pbjsKIAogCWhvc3QtPmlvcy5wb3dlcl9tb2RlID0gTU1DX1BPV0VSX09O
OwogCW1tY19zZXRfaW9zKGhvc3QpOwotLSAKMS43LjAuNAoK
--0050450141b09bf5b60490abd25d--
