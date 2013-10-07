From: ALIM AKHTAR <alim.akhtar@samsung.com>
Subject: Re: Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD
 error flag
Date: Mon, 07 Oct 2013 04:22:07 +0000 (GMT)
Message-ID: <1254168.213051381119727256.JavaMail.weblogic@epml12>
Reply-To: alim.akhtar@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38323 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab3JGEWP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Oct 2013 00:22:15 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUA002YT6SY28H0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 07 Oct 2013 13:22:10 +0900 (KST)
MIME-version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, "cjb@laptop.org" <cjb@laptop.org>, "dianders@chromium.org" <dianders@chromium.org>

SGkgSmFlaG9vbiwKCj4tLS0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0tLQo+U2VuZGVyIDog
SmFlaG9vbiBDaHVuZzxqaDgwLmNodW5nQHNhbXN1bmcuY29tPiBTNC9FbmdpbmVlci9TeXN0ZW0g
Uy9XIExhYi4vU2Ftc3VuZyBFbGVjdHJvbmljcwo+RGF0ZSA6IE9jdCAwNiwgMjAxMyAxNzoyOCAo
R01UKzA5OjAwKQo+VGl0bGUgOiBSZTogW1BBVENIXSBtbWM6IGR3X21tYzogQWRkIGhhcmR3YXJl
IGxvY2sgZXJyb3IgKEhMRSkgdG8gdGhlIENNRCBlcnJvciBmbGFnCqAKPkhpIEFsaW0sCgo+T24g
MTAvMDMvMjAxMyAwNjoxOCBQTSwgYWxpbSBha2h0YXIgd3JvdGU6Cj4+IEZyb206IEFsaW0gQWto
dGFyIAo+PiAKPj4gSGFyZHdhcmUgbG9ja2VkIGVycm9yIHNldCB3aGVuIHRoZSBkd19tbWMgY29u
dHJvbGxlciBjYW5ub3QgbG9hZCBhCj4+IGNvbW1hbmQgaXNzdWVkIGJ5IHNvZnR3YXJlLiBXaGVu
IHNvZnR3YXJlIHNldHMgdGhlIHN0YXJ0X2NtZCBiaXQgaW4gdGhlCj4+IENNRCByZWdpc3Rlciwg
dGhlIGNvbnRyb2xsZXIgdHJpZXMgdG8gbG9hZCB0aGUgY29tbWFuZC4gSWYgdGhlIGNvbW1hbmQK
Pj4gYnVmZmVyIGlzIGFscmVhZHkgZmlsbGVkIHdpdGggYSBjb21tYW5kLCB0aGlzIGVycm9yIGlz
IHJhaXNlZC4gQ3VycmVudGx5Cj4+IGRyaXZlciBkb2VzIG5vdCBoYW5kbGUgSExFIGludGVycnVw
dCwgd2hpY2ggcmVzdWx0cyBpbiBhIHN5c3RlbSBoYW5nLgo+V2hlbiBTRE1NQ19JTlRfSExFIGlz
IHNldCBpbnRvIENNRF9FUlJPUl9GTEFHUywudGhlbiBjb3VsZCBkcml2ZXIgaGFuZGxlIHRoZSBI
TEUgaW50ZXJydXB0PwpZZXMsIHRoaXMgd2lsbCBiZSBoYW5kbGVkIGFzIGEgcGFydCBvZiBEV19N
Q0lfQ01EX0VSUk9SX0ZMQUdTIGVycm9yIGhhbmRsaW5nLgoKPkJlc3QgUmVnYXJkcywKPkphZWhv
b24gQ2h1bmcKPj4gCj4+IEhMRSBjYW4gYmUgc2ltdWxhdGVkIGJ5IHF1aWNrbHkgaW5zZXJ0aW5n
IGFuZCByZW1vdmluZyBzZCBjYXJkIGluIGNhcmQKPj4gc2xvdCAoMzAgfiA0MCB0aW1lcyBpbiBz
YXkgMjAgc2VjcykKPj4gCj4+IFJldmlld2VkLWJ5OiBEb3VnIEFuZGVyc29uIAo+PiBTaWduZWQt
b2ZmLWJ5OiBBbGltIEFraHRhciAKPj4gLS0tCj4+oKBkcml2ZXJzL21tYy9ob3N0L2R3X21tYy5j
IHwgMiArLQo+PqCgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYyBiL2RyaXZlcnMv
bW1jL2hvc3QvZHdfbW1jLmMKPj4gaW5kZXggMGE2YTUxMi4uMjRiNGE1MiAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYwo+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L2R3
X21tYy5jCj4+IEBAIC00NCw3ICs0NCw3IEBACj4+oKAJIFNETU1DX0lOVF9IVE8gfCBTRE1NQ19J
TlRfU0JFoKB8IFwKPj6goAkgU0RNTUNfSU5UX0VCRSkKPj6goCNkZWZpbmUgRFdfTUNJX0NNRF9F
UlJPUl9GTEFHUwkoU0RNTUNfSU5UX1JUTyB8IFNETU1DX0lOVF9SQ1JDIHwgXAo+PiAtCSBTRE1N
Q19JTlRfUkVTUF9FUlIpCj4+ICsJIFNETU1DX0lOVF9SRVNQX0VSUiB8IFNETU1DX0lOVF9ITEUp
Cj4+oKAjZGVmaW5lIERXX01DSV9FUlJPUl9GTEFHUwkoRFdfTUNJX0RBVEFfRVJST1JfRkxBR1Mg
fCBcCj4+oKAJIERXX01DSV9DTURfRVJST1JfRkxBR1OgoHwgU0RNTUNfSU5UX0hMRSkKPj6goCNk
ZWZpbmUgRFdfTUNJX1NFTkRfU1RBVFVTCTEKPj4=


