From: Will Newton <will.newton@gmail.com>
Subject: [RFC PATCH] MAINTAINERS: Add an orphaned entry for the dw_mmc driver.
Date: Fri, 11 Jan 2013 17:26:38 +0000
Message-ID: <CAFbHwiRX19Zm=O2dNZrbTDGZxnXDOx0zJ3pvTkfC1q8m5DBFug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d04088f7b1d771a04d306997f
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64512 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209Ab3AKR0l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jan 2013 12:26:41 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1491953lbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jan 2013 09:26:40 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

--f46d04088f7b1d771a04d306997f
Content-Type: text/plain; charset=ISO-8859-1

I submitted this driver but will shortly no longer have access
to hardware that uses it. The driver is quite widely used so
there may be someone out there that feels strongly enough to
step up and maintain it.
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f940e81..88329bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6558,6 +6558,12 @@ F:	include/linux/dw_dmac.h
 F:	drivers/dma/dw_dmac_regs.h
 F:	drivers/dma/dw_dmac.c

+SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
+L:	linux-mmc@vger.kernel.org
+S:	Orphaned
+F:	include/linux/mmc/dw_mmc.h
+F:	drivers/mmc/host/dw_mmc*
+
 TIMEKEEPING, NTP
 M:	John Stultz <johnstul@us.ibm.com>
 M:	Thomas Gleixner <tglx@linutronix.de>
-- 
1.7.1

--f46d04088f7b1d771a04d306997f
Content-Type: application/octet-stream;
	name="0001-MAINTAINERS-Add-an-orphaned-entry-for-the-dw_mmc-dri.patch"
Content-Disposition: attachment;
	filename="0001-MAINTAINERS-Add-an-orphaned-entry-for-the-dw_mmc-dri.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbtll8xc0

RnJvbSBkYjBhZTE1ZTU4OWUxMmI0ZWJhOWY5YjA2MjBjNzE5MWZjMDIzNGI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXaWxsIE5ld3RvbiA8d2lsbC5uZXd0b25AaW1ndGVjLmNvbT4K
RGF0ZTogRnJpLCAxMSBKYW4gMjAxMyAxNzoxOTo0MSArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIE1B
SU5UQUlORVJTOiBBZGQgYW4gb3JwaGFuZWQgZW50cnkgZm9yIHRoZSBkd19tbWMgZHJpdmVyLgoK
SSBzdWJtaXR0ZWQgdGhpcyBkcml2ZXIgYnV0IHdpbGwgc2hvcnRseSBubyBsb25nZXIgaGF2ZSBh
Y2Nlc3MKdG8gaGFyZHdhcmUgdGhhdCB1c2VzIGl0LiBUaGUgZHJpdmVyIGlzIHF1aXRlIHdpZGVs
eSB1c2VkIHNvCnRoZXJlIG1heSBiZSBzb21lb25lIG91dCB0aGVyZSB0aGF0IGZlZWxzIHN0cm9u
Z2x5IGVub3VnaCB0bwpzdGVwIHVwIGFuZCBtYWludGFpbiBpdC4KLS0tCiBNQUlOVEFJTkVSUyB8
ICAgIDYgKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IGY5NDBl
ODEuLjg4MzI5YmMgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBA
IC02NTU4LDYgKzY1NTgsMTIgQEAgRjoJaW5jbHVkZS9saW51eC9kd19kbWFjLmgKIEY6CWRyaXZl
cnMvZG1hL2R3X2RtYWNfcmVncy5oCiBGOglkcml2ZXJzL2RtYS9kd19kbWFjLmMKIAorU1lOT1BT
WVMgREVTSUdOV0FSRSBNTUMvU0QvU0RJTyBEUklWRVIKK0w6CWxpbnV4LW1tY0B2Z2VyLmtlcm5l
bC5vcmcKK1M6CU9ycGhhbmVkCitGOglpbmNsdWRlL2xpbnV4L21tYy9kd19tbWMuaAorRjoJZHJp
dmVycy9tbWMvaG9zdC9kd19tbWMqCisKIFRJTUVLRUVQSU5HLCBOVFAKIE06CUpvaG4gU3R1bHR6
IDxqb2huc3R1bEB1cy5pYm0uY29tPgogTToJVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+Ci0tIAoxLjcuMQoK
--f46d04088f7b1d771a04d306997f--
