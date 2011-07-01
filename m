From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH] mmc: avoid unnecessary rescan in PM_POST_SUSPEND
Date: Fri, 1 Jul 2011 10:27:04 +0800
Message-ID: <BANLkTikkqFiKWK1GdBtS5mKrE=vsfawnag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3071cc8ee1a39d04a6f8c012
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42556 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab1GAC1R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 22:27:17 -0400
Received: by vxb39 with SMTP id 39so2067954vxb.19
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jun 2011 19:27:17 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, zhangfei gao <zhangfei.gao@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>

--20cf3071cc8ee1a39d04a6f8c012
Content-Type: text/plain; charset=ISO-8859-1

With this patch, we call rescan only when card insert/remove
happens during rescan_disabled is set to avoid unnecessary mmc
command transaction and realted wakelock holding.

This patch fix below suspend retry issue on Android:
1. System trigger suspend procedure for all wakelock are released
2. A wakelock is hold again and suspend is aborted as a result.
3. pm subsystem post PM_POST_SUSPEND event when exiting suspend.
4. mmc rescan is schedlued on every mmc host when handling the event
5. The wakelock is released just after it block suspend
6. System trigger another suspend retry
7. mmc rescan thread hold wakelock to dectect card
8. System go to state 2 and enter suspend retry loop

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/mmc/core/core.c  |   16 ++++++++++++++--
 include/linux/mmc/host.h |    1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7843efe..ded7686 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1568,9 +1568,15 @@ void mmc_rescan(struct work_struct *work)
 	struct mmc_host *host =
 		container_of(work, struct mmc_host, detect.work);
 	int i;
+	unsigned long flags;

-	if (host->rescan_disable)
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->rescan_disable) {
+		host->rescan_delayed = 1;
+		spin_unlock_irqrestore(&host->lock, flags);
 		return;
+	}
+	spin_unlock_irqrestore(&host->lock, flags);

 	mmc_bus_get(host);

@@ -1836,6 +1842,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 	struct mmc_host *host = container_of(
 		notify_block, struct mmc_host, pm_notify);
 	unsigned long flags;
+	unsigned long rescan_needed = 0;


 	switch (mode) {
@@ -1866,8 +1873,13 @@ int mmc_pm_notify(struct notifier_block *notify_block,

 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 0;
+		if (host->rescan_delayed) {
+			rescan_needed = 1;
+			host->rescan_delayed = 0;
+		}
 		spin_unlock_irqrestore(&host->lock, flags);
-		mmc_detect_change(host, 0);
+		if (rescan_needed)
+			mmc_detect_change(host, 0);

 	}

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1ee4424..f05e619 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -249,6 +249,7 @@ struct mmc_host {
 	/* Only used with MMC_CAP_DISABLE */
 	int			enabled;	/* host is enabled */
 	int			rescan_disable;	/* disable card detection */
+	int			rescan_delayed;	/* card detection is delayed */
 	int			nesting_cnt;	/* "enable" nesting count */
 	int			en_dis_recurs;	/* detect recursion */
 	unsigned int		disable_delay;	/* disable delay in msecs */
-- 
1.7.0.4

--20cf3071cc8ee1a39d04a6f8c012
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-avoid-unnecessary-rescan-in-PM_POST_SUSPEND.patch"
Content-Disposition: attachment;
	filename="0001-mmc-avoid-unnecessary-rescan-in-PM_POST_SUSPEND.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpkik9fk0

RnJvbSA4OTc2ZTY3YzUwZmVlOWVhYWQ3NDJhZDA5N2I4NGZkNTUyM2VmZmVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBGcmks
IDEgSnVsIDIwMTEgMTA6MDE6NTEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBtbWM6IGF2b2lkIHVu
bmVjZXNzYXJ5IHJlc2NhbiBpbiBQTV9QT1NUX1NVU1BFTkQKCldpdGggdGhpcyBwYXRjaCwgd2Ug
Y2FsbCByZXNjYW4gb25seSB3aGVuIGNhcmQgaW5zZXJ0L3JlbW92ZQpoYXBwZW5zIGR1cmluZyBy
ZXNjYW5fZGlzYWJsZWQgaXMgc2V0IHRvIGF2b2lkIHVubmVjZXNzYXJ5IG1tYwpjb21tYW5kIHRy
YW5zYWN0aW9uIGFuZCByZWFsdGVkIHdha2Vsb2NrIGhvbGRpbmcuCgpUaGlzIHBhdGNoIGZpeCBi
ZWxvdyBzdXNwZW5kIHJldHJ5IGlzc3VlIG9uIEFuZHJvaWQ6CjEuIFN5c3RlbSB0cmlnZ2VyIHN1
c3BlbmQgcHJvY2VkdXJlIGZvciBhbGwgd2FrZWxvY2sgYXJlIHJlbGVhc2VkCjIuIEEgd2FrZWxv
Y2sgaXMgaG9sZCBhZ2FpbiBhbmQgc3VzcGVuZCBpcyBhYm9ydGVkIGFzIGEgcmVzdWx0LgozLiBw
bSBzdWJzeXN0ZW0gcG9zdCBQTV9QT1NUX1NVU1BFTkQgZXZlbnQgd2hlbiBleGl0aW5nIHN1c3Bl
bmQuCjQuIG1tYyByZXNjYW4gaXMgc2NoZWRsdWVkIG9uIGV2ZXJ5IG1tYyBob3N0IHdoZW4gaGFu
ZGxpbmcgdGhlIGV2ZW50CjUuIFRoZSB3YWtlbG9jayBpcyByZWxlYXNlZCBqdXN0IGFmdGVyIGl0
IGJsb2NrIHN1c3BlbmQKNi4gU3lzdGVtIHRyaWdnZXIgYW5vdGhlciBzdXNwZW5kIHJldHJ5Cjcu
IG1tYyByZXNjYW4gdGhyZWFkIGhvbGQgd2FrZWxvY2sgdG8gZGVjdGVjdCBjYXJkCjguIFN5c3Rl
bSBnbyB0byBzdGF0ZSAyIGFuZCBlbnRlciBzdXNwZW5kIHJldHJ5IGxvb3AKClNpZ25lZC1vZmYt
Ynk6IEp1biBOaWUgPG5qdW5AbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvY29yZS9jb3Jl
LmMgIHwgICAxNiArKysrKysrKysrKysrKy0tCiBpbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggfCAg
ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBiL2RyaXZlcnMvbW1jL2NvcmUv
Y29yZS5jCmluZGV4IDc4NDNlZmUuLmRlZDc2ODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2Nv
cmUvY29yZS5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jCkBAIC0xNTY4LDkgKzE1Njgs
MTUgQEAgdm9pZCBtbWNfcmVzY2FuKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAlzdHJ1Y3Qg
bW1jX2hvc3QgKmhvc3QgPQogCQljb250YWluZXJfb2Yod29yaywgc3RydWN0IG1tY19ob3N0LCBk
ZXRlY3Qud29yayk7CiAJaW50IGk7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAotCWlmIChob3N0
LT5yZXNjYW5fZGlzYWJsZSkKKwlzcGluX2xvY2tfaXJxc2F2ZSgmaG9zdC0+bG9jaywgZmxhZ3Mp
OworCWlmIChob3N0LT5yZXNjYW5fZGlzYWJsZSkgeworCQlob3N0LT5yZXNjYW5fZGVsYXllZCA9
IDE7CisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhvc3QtPmxvY2ssIGZsYWdzKTsKIAkJcmV0
dXJuOworCX0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZob3N0LT5sb2NrLCBmbGFncyk7CiAK
IAltbWNfYnVzX2dldChob3N0KTsKIApAQCAtMTgzNiw2ICsxODQyLDcgQEAgaW50IG1tY19wbV9u
b3RpZnkoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpub3RpZnlfYmxvY2ssCiAJc3RydWN0IG1tY19o
b3N0ICpob3N0ID0gY29udGFpbmVyX29mKAogCQlub3RpZnlfYmxvY2ssIHN0cnVjdCBtbWNfaG9z
dCwgcG1fbm90aWZ5KTsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOworCXVuc2lnbmVkIGxvbmcgcmVz
Y2FuX25lZWRlZCA9IDA7CiAKIAogCXN3aXRjaCAobW9kZSkgewpAQCAtMTg2Niw4ICsxODczLDEz
IEBAIGludCBtbWNfcG1fbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbm90aWZ5X2Jsb2Nr
LAogCiAJCXNwaW5fbG9ja19pcnFzYXZlKCZob3N0LT5sb2NrLCBmbGFncyk7CiAJCWhvc3QtPnJl
c2Nhbl9kaXNhYmxlID0gMDsKKwkJaWYgKGhvc3QtPnJlc2Nhbl9kZWxheWVkKSB7CisJCQlyZXNj
YW5fbmVlZGVkID0gMTsKKwkJCWhvc3QtPnJlc2Nhbl9kZWxheWVkID0gMDsKKwkJfQogCQlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZob3N0LT5sb2NrLCBmbGFncyk7Ci0JCW1tY19kZXRlY3RfY2hh
bmdlKGhvc3QsIDApOworCQlpZiAocmVzY2FuX25lZWRlZCkKKwkJCW1tY19kZXRlY3RfY2hhbmdl
KGhvc3QsIDApOwogCiAJfQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0Lmgg
Yi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmgKaW5kZXggMWVlNDQyNC4uZjA1ZTYxOSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oCisrKyBiL2luY2x1ZGUvbGludXgvbW1jL2hv
c3QuaApAQCAtMjQ5LDYgKzI0OSw3IEBAIHN0cnVjdCBtbWNfaG9zdCB7CiAJLyogT25seSB1c2Vk
IHdpdGggTU1DX0NBUF9ESVNBQkxFICovCiAJaW50CQkJZW5hYmxlZDsJLyogaG9zdCBpcyBlbmFi
bGVkICovCiAJaW50CQkJcmVzY2FuX2Rpc2FibGU7CS8qIGRpc2FibGUgY2FyZCBkZXRlY3Rpb24g
Ki8KKwlpbnQJCQlyZXNjYW5fZGVsYXllZDsJLyogY2FyZCBkZXRlY3Rpb24gaXMgZGVsYXllZCAq
LwogCWludAkJCW5lc3RpbmdfY250OwkvKiAiZW5hYmxlIiBuZXN0aW5nIGNvdW50ICovCiAJaW50
CQkJZW5fZGlzX3JlY3VyczsJLyogZGV0ZWN0IHJlY3Vyc2lvbiAqLwogCXVuc2lnbmVkIGludAkJ
ZGlzYWJsZV9kZWxheTsJLyogZGlzYWJsZSBkZWxheSBpbiBtc2VjcyAqLwotLSAKMS43LjAuNAoK
--20cf3071cc8ee1a39d04a6f8c012--
