From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: failure of block read wait for long time
Date: Wed, 22 Sep 2010 11:02:08 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B031610E332@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026ED@dbde02.ent.ti.com>
 <4C8A19E7.30706@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026F6@dbde02.ent.ti.com>
 <4C8A2C5D.2050408@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0315F0318B@dbde02.ent.ti.com>
 <4C971320.7050906@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03160624F6@dbde02.ent.ti.com>
 <4C974A5D.5050608@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03160626B5@dbde02.ent.ti.com>
 <4C975CFB.6070907@nokia.com> <20100920133703.GC30793@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_2A3DCF3DA181AD40BDE86A3150B27B6B031610E332dbde02enttico_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43564 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0IVFce (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2010 01:32:34 -0400
In-Reply-To: <20100920133703.GC30793@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

--_002_2A3DCF3DA181AD40BDE86A3150B27B6B031610E332dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Chris,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, September 20, 2010 7:07 PM
> To: Adrian Hunter
> Cc: Ghorai, Sukumar; linux-mmc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] mmc: failure of block read wait for long time
>=20
> On Mon, Sep 20, 2010 at 04:09:15PM +0300, Adrian Hunter wrote:
> > The SD/MMC protocol does not indicate which sector has the error.
> > There is no possibility of trying the ith+1-segment because i is
> > unknown.
>=20
> Not entirely true.
>=20
> I seem to remember that the MMC protocol (and probably SD protocol)
> provides an ack at the end of each data block to say whether the data
> block was correct or not.
>=20
> Some hosts tell you when they receive this ack, and you can track how
> many blocks have been successfully read without error.  The ARM MMCI
> primecell does this.
>=20
> However, some hosts don't give you this information, in which case you
> don't know where the error occurred in the read - so when a read fails,
> you can only safely report that no bytes were read successfully.  This
> means that even if the error was on the last block, there's no way to
> know this.
[Ghorai]
Would you please review and merge this patch [1] (attached too)?
[1] http://comments.gmane.org/gmane.linux.kernel.mmc/2714



--_002_2A3DCF3DA181AD40BDE86A3150B27B6B031610E332dbde02enttico_
Content-Type: application/octet-stream;
	name="0001-mmc-failure-of-block-read-wait-for-long-time.patch"
Content-Description: 0001-mmc-failure-of-block-read-wait-for-long-time.patch
Content-Disposition: attachment;
	filename="0001-mmc-failure-of-block-read-wait-for-long-time.patch";
	size=1114; creation-date="Wed, 22 Sep 2010 11:00:02 GMT";
	modification-date="Wed, 22 Sep 2010 11:01:54 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1MDZjMGM0M2M4OGRhMzFmZTU2NDU1Yzg5ZjkyOTRjYzIzMWZjNGVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdWt1bWFyIEdob3JhaSA8cy1naG9yYWlAdGkuY29tPgpEYXRl
OiBXZWQsIDIyIFNlcCAyMDEwIDEwOjU4OjUzICswNTMwClN1YmplY3Q6IFtQQVRDSF0gbW1jOiBm
YWlsdXJlIG9mIGJsb2NrIHJlYWQgd2FpdCBmb3IgbG9uZyB0aW1lCgogbXVsdGktYmxvY2sgcmVh
ZCBmYWlsdXJlIHJldHJpZXMgaW4gc2luZ2xlIGJsb2NrIHJlYWQgb25lIGJ5IG9uZS4gSXQgY29u
dGludWVzCiByZXRyeSBvZiBzdWJzZXF1ZW50IGJsb2NrcywgZXZlbiBhZnRlciBmYWlsdXJlLiBB
cHBsaWNhdGlvbiB3aWxsIG5vdCBiZSBhYmxlCiB0byBkZWNvZGUgdGhlIGludGVybGVhdmUgZGF0
YSAoZXZlbiBpZiBmZXcgc2luZ2xlIGJsb2NrIHJlYWQgc3VjY2VzcykuCiBUaGlzIHBhdGNoIGZp
eGVzIHRoaXMgcHJvYmxlbSBieSByZXR1cm5pbmcgYXQgdGhlIGZpcnN0IGZhaWx1cmUgaW5zdGVh
ZCBvZgogd2FpdGluZyBmb3IgbG9uZyBkdXJhdGlvbi4KClNpZ25lZC1vZmYtYnk6IFN1a3VtYXIg
R2hvcmFpIDxzLWdob3JhaUB0aS5jb20+Ci0tLQogZHJpdmVycy9tbWMvY2FyZC9ibG9jay5jIHwg
ICAgMSAtCiAxIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jYXJkL2Jsb2NrLmMgYi9kcml2ZXJzL21tYy9jYXJk
L2Jsb2NrLmMKaW5kZXggZDU0NWY3OS4uMGVjMzRhZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMv
Y2FyZC9ibG9jay5jCisrKyBiL2RyaXZlcnMvbW1jL2NhcmQvYmxvY2suYwpAQCAtNDkzLDcgKzQ5
Myw2IEBAIHN0YXRpYyBpbnQgbW1jX2Jsa19pc3N1ZV9yd19ycShzdHJ1Y3QgbW1jX3F1ZXVlICpt
cSwgc3RydWN0IHJlcXVlc3QgKnJlcSkKIAkJCQlzcGluX2xvY2tfaXJxKCZtZC0+bG9jayk7CiAJ
CQkJcmV0ID0gX19ibGtfZW5kX3JlcXVlc3QocmVxLCAtRUlPLCBicnEuZGF0YS5ibGtzeik7CiAJ
CQkJc3Bpbl91bmxvY2tfaXJxKCZtZC0+bG9jayk7Ci0JCQkJY29udGludWU7CiAJCQl9CiAJCQln
b3RvIGNtZF9lcnI7CiAJCX0KLS0gCjEuNy4wLjQKCg==

--_002_2A3DCF3DA181AD40BDE86A3150B27B6B031610E332dbde02enttico_--
