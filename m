From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] regulator: add missing prototype for regulator_is_supported_voltage
Date: Wed, 21 Nov 2012 17:45:57 +0800
Message-ID: <CAMPhdO_FoZ6f6twvvse56JVA-J5hB7fQ21LisTCN2hKYdL0fyg@mail.gmail.com>
References: <CAMPhdO8uuNmdiaejcypOH77rsU2ZR+dov73KXyAsbAfW0tKmcA@mail.gmail.com>
 <20121121094350.GQ4673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d04071167d1c51e04cefe38f8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:47559 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2KUJqS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 04:46:18 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2657887lag.19
        for <linux-mmc@vger.kernel.org>; Wed, 21 Nov 2012 01:46:17 -0800 (PST)
In-Reply-To: <20121121094350.GQ4673@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Philip Rakity <prakity@gmail.com>, Philip Rakity <prakity@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

--f46d04071167d1c51e04cefe38f8
Content-Type: text/plain; charset=UTF-8

git-send-email stopped working so I have to use the web interface.
Could you help
try the attached one?

On Wed, Nov 21, 2012 at 5:43 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Nov 21, 2012 at 05:22:02PM +0800, Eric Miao wrote:
>
>> +static inline int regulator_count_voltages(struct regulator *regulator)
>> +{
>> + return 0;
>> +}
>
> Looks like your mailer has mangled everything so this won't apply.

--f46d04071167d1c51e04cefe38f8
Content-Type: application/octet-stream;
	name="0001-regulator-add-missing-prototype-for-regulator_is_sup.patch"
Content-Disposition: attachment;
	filename="0001-regulator-add-missing-prototype-for-regulator_is_sup.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h9s9ok0b1

RnJvbSBkMDE1MTM5YWM2MjFlMTBkNWQ5YzBkM2U0MjdlOTUxN2IwOGZlNzcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG52aWRpYS5jb20+CkRh
dGU6IFR1ZSwgMjAgTm92IDIwMTIgMTg6MDc6NDEgKzAxMDAKU3ViamVjdDogW1BBVENIXSByZWd1
bGF0b3I6IGFkZCBtaXNzaW5nIHByb3RvdHlwZSBmb3IgcmVndWxhdG9yX2lzX3N1cHBvcnRlZF92
b2x0YWdlCgphdm9pZHMgbmVlZHMgZm9yIENPTkZJR19SRUdVTEFUT1IgaW4gc2RoY2kuYwoKU2ln
bmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBudmlkaWEuY29tPgpSZXZpZXdlZC1i
eTogRXJpYyBNaWFvIDxlcmljLnkubWlhb0BnbWFpbC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9y
ZWd1bGF0b3IvY29uc3VtZXIuaCB8ICAgIDQgKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9yZWd1
bGF0b3IvY29uc3VtZXIuaCBiL2luY2x1ZGUvbGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmgKaW5k
ZXggYzQzY2QzNS4uNGUzZWM5MSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9yZWd1bGF0b3Iv
Y29uc3VtZXIuaAorKysgYi9pbmNsdWRlL2xpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oCkBAIC0z
NTgsNiArMzU4LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCByZWd1bGF0b3Jfc2V0X2RydmRhdGEo
c3RydWN0IHJlZ3VsYXRvciAqcmVndWxhdG9yLAogewogfQogCitzdGF0aWMgaW5saW5lIGludCBy
ZWd1bGF0b3JfY291bnRfdm9sdGFnZXMoc3RydWN0IHJlZ3VsYXRvciAqcmVndWxhdG9yKQorewor
CXJldHVybiAwOworfQogI2VuZGlmCiAKIHN0YXRpYyBpbmxpbmUgaW50IHJlZ3VsYXRvcl9zZXRf
dm9sdGFnZV90b2woc3RydWN0IHJlZ3VsYXRvciAqcmVndWxhdG9yLAotLSAKMS43LjAuNAoK
--f46d04071167d1c51e04cefe38f8--
