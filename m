From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add ocr_mask option
Date: Tue, 13 Sep 2016 15:59:25 +0000
Message-ID: <SG2PR06MB11655A641475D2E08A5A3DDC8AFE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-2-chris.brandt@renesas.com>
 <CAPDyKFqdznJ4xr5=L862uOfvqjsRpR3d+yRWtN1-8H5ZvP9GeQ@mail.gmail.com>
 <CAMuHMdVGgWaVcC4Pfuf0NSTpU4ahdEg6Q7iKZ1n+mb7KexE6yg@mail.gmail.com>
 <SG2PR06MB1165D0EE862CCCFD713181938AFE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAPDyKFp1eSyVAnn4JohR=Cx0VeE-5U8eY5GVQA+ae0P-vDJJ8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:39750 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754816AbcIMP7a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2016 11:59:30 -0400
In-Reply-To: <CAPDyKFp1eSyVAnn4JohR=Cx0VeE-5U8eY5GVQA+ae0P-vDJJ8w@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

SGVsbG8gVWZmZQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCk9uIDkvMTMvMjAxNiwg
VWxmIEhhbnNzb24gd3JvdGU6DQo+IEJlY2F1c2UsIGlmIHlvdSBoYXZlIGFuIGV4dGVybmFsIHJl
Z3VsYXRvciBmZWVkaW5nIHRoZSBtbWMgd2l0aCBwb3dlciB5b3UNCj4gc2hvdWxkIHNldCBpdCB1
cCBhbmQgdXNlIGl0Lg0KDQpCdXQgaW4gbWFueSBib2FyZCBkZXNpZ25zLCB0aGVyZSBpcyBubyBj
b250cm9sIG92ZXIgdGhlIHJlZ3VsYXRvciBzdXBwbHkgKG9yIHlvdSB3b3VsZCByYXRoZXIgaGF2
ZSB5b3VyIGJvb3Rsb2FkZXIgZG8gdGhhdCwgbm90IHRoZSBrZXJuZWwpLg0KDQpTbyB3aGF0IHRo
aXMgcGF0Y2ggaXMgZG9pbmcgaXMgc2V0dGluZyBpdCB0byBhIGRlZmF1bHQgb2YgMy4zdiAoZm9y
IGp1c3QgdGhpcyBTb0MpIGFuZCBpZiBzb21lb25lIHdhbnRzIHRvIGFkZCBhIHJlZ3VsYXRvciBp
biB0aGUgYm9hcmQncyBEVCBmaWxlLCB0aGF0IHdpbGwgb3ZlcnJpZGUgdGhlIG9jcl9tYXNrIHNl
dCBieSB0aGUgZHJpdmVyLg0KDQoNCkknbSBhc3N1bWluZyBJJ2xsIGhhdmUgdG8gZG8gdGhlIHNh
bWUgZm9yIE1NQyAoc2hfbW1jaWYuYykgb25jZSBJIGdldCB0byB0aGF0IGRyaXZlciAoSSBuZWVk
IHRvIGZpbmQgbXkgTU1DIFBMVVMgY2FyZCBmaXJzdCBmb3IgdGVzdGluZykuDQoNCg0KQ2hyaXMN
Cg0K
