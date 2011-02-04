From: Will Newton <will.newton@gmail.com>
Subject: [PATCH 1/2] dw_mmc: Run card detect tasklet during slot initialisation.
Date: Fri, 4 Feb 2011 11:17:54 +0000
Message-ID: <AANLkTikwVAKaiAy+0Vpcu97qxX3ZKgZ8k_LyNfOU9Ws=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c59a299648c6049b7308bb
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60945 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1BDLRz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Feb 2011 06:17:55 -0500
Received: by bwz15 with SMTP id 15so2595721bwz.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Feb 2011 03:17:54 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--001636c59a299648c6049b7308bb
Content-Type: text/plain; charset=ISO-8859-1

We need to run the card detect tasklet at the end of slot initialisation
as it is possible that a card has been inserted prior to boot, so we miss
the insertion interrupt and now the card is sitting there inserted but with
no power to it.

Signed-off-by: Neil Jones <neil.jones@imgtec.com>
Signed-off-by: Will Newton <will.newton@imgtec.com>
---
 drivers/mmc/host/dw_mmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2fcc825..0b0bedd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1441,6 +1441,13 @@ static int __init dw_mci_init_slot(struct
dw_mci *host, unsigned int id)
 	/* Card initially undetected */
 	slot->last_detect_state = 0;

+
+	/*
+	 * Card may have been plugged in prior to boot so we
+	 * need to run the detect tasklet
+	 */
+	tasklet_schedule(&host->card_tasklet);
+
 	return 0;
 }

-- 
1.7.3.4

--001636c59a299648c6049b7308bb
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-dw_mmc-Run-card-detect-tasklet-during-slot-initialis.patch"
Content-Disposition: attachment;
	filename="0001-dw_mmc-Run-card-detect-tasklet-during-slot-initialis.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjr00sxi0

RnJvbSA1MzA5NGFhYTRjZDhiNWRhNzhhY2ZiZjdkYTZjNDg0OGZiNzIwNDEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXaWxsIE5ld3RvbiA8d2lsbC5uZXd0b25AaW1ndGVjLmNvbT4K
RGF0ZTogRnJpLCA0IEZlYiAyMDExIDExOjA3OjQ2ICswMDAwClN1YmplY3Q6IFtQQVRDSCAxLzJd
IGR3X21tYzogIFJ1biBjYXJkIGRldGVjdCB0YXNrbGV0IGR1cmluZyBzbG90IGluaXRpYWxpc2F0
aW9uLgoKV2UgbmVlZCB0byBydW4gdGhlIGNhcmQgZGV0ZWN0IHRhc2tsZXQgYXQgdGhlIGVuZCBv
ZiBzbG90IGluaXRpYWxpc2F0aW9uCmFzIGl0IGlzIHBvc3NpYmxlIHRoYXQgYSBjYXJkIGhhcyBi
ZWVuIGluc2VydGVkIHByaW9yIHRvIGJvb3QsIHNvIHdlIG1pc3MKdGhlIGluc2VydGlvbiBpbnRl
cnJ1cHQgYW5kIG5vdyB0aGUgY2FyZCBpcyBzaXR0aW5nIHRoZXJlIGluc2VydGVkIGJ1dCB3aXRo
Cm5vIHBvd2VyIHRvIGl0LgoKU2lnbmVkLW9mZi1ieTogTmVpbCBKb25lcyA8bmVpbC5qb25lc0Bp
bWd0ZWMuY29tPgpTaWduZWQtb2ZmLWJ5OiBXaWxsIE5ld3RvbiA8d2lsbC5uZXd0b25AaW1ndGVj
LmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jIHwgICAgNyArKysrKysrCiAxIGZp
bGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYwpp
bmRleCAyZmNjODI1Li4wYjBiZWRkIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L2R3X21t
Yy5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLmMKQEAgLTE0NDEsNiArMTQ0MSwxMyBA
QCBzdGF0aWMgaW50IF9faW5pdCBkd19tY2lfaW5pdF9zbG90KHN0cnVjdCBkd19tY2kgKmhvc3Qs
IHVuc2lnbmVkIGludCBpZCkKIAkvKiBDYXJkIGluaXRpYWxseSB1bmRldGVjdGVkICovCiAJc2xv
dC0+bGFzdF9kZXRlY3Rfc3RhdGUgPSAwOwogCisKKwkvKgorCSAqIENhcmQgbWF5IGhhdmUgYmVl
biBwbHVnZ2VkIGluIHByaW9yIHRvIGJvb3Qgc28gd2UKKwkgKiBuZWVkIHRvIHJ1biB0aGUgZGV0
ZWN0IHRhc2tsZXQKKwkgKi8KKwl0YXNrbGV0X3NjaGVkdWxlKCZob3N0LT5jYXJkX3Rhc2tsZXQp
OworCiAJcmV0dXJuIDA7CiB9CiAKLS0gCjEuNy4zLjQKCg==
--001636c59a299648c6049b7308bb--
