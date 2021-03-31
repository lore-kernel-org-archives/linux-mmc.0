Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D76BC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9BA60C3D
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 10:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhCaKfC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:35:02 -0400
Received: from gli-ex.genesyslogic.com.tw ([60.251.58.171]:50696 "EHLO
        gli-ex.genesyslogic.com.tw" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234855AbhCaKeo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 06:34:44 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2021 06:34:43 EDT
Received: from GLI-MBX02.genesyslogic.com.tw ([fe80::a40e:dfe0:3e41:3fd8]) by
 Gli-CASHT02.genesyslogic.com.tw ([fe80::ad9a:493d:feca:6cb7%10]) with mapi id
 14.02.0387.000; Wed, 31 Mar 2021 18:26:57 +0800
From:   =?utf-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <Renius.Chen@genesyslogic.com.tw>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        =?utf-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <Greg.Tu@genesyslogic.com.tw>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        =?utf-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?= 
        <Ben.Chuang@genesyslogic.com.tw>,
        Renius Chen <reniuschengl@gmail.com>
Subject: RE: [PATCH 0/4] mmc: core: Preparations to support SD UHS-II cards
Thread-Topic: [PATCH 0/4] mmc: core: Preparations to support SD UHS-II cards
Thread-Index: AQHXC5hCBaLnPEhAx02zG+hoO5yy16qdiysAgACJIJA=
Date:   Wed, 31 Mar 2021 10:26:55 +0000
Message-ID: <FDA815A8963C6B43ABF06E8A34984F99F9B709BB@Gli-MBX02.genesyslogic.com.tw>
References: <20210225170352.76872-1-ulf.hansson@linaro.org>
 <CAPDyKFp0+jBDcJnxbvdkZWo6jmSa-CdT6RNbH2hmrWnXEqU0=w@mail.gmail.com>
In-Reply-To: <CAPDyKFp0+jBDcJnxbvdkZWo6jmSa-CdT6RNbH2hmrWnXEqU0=w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.107.84]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQoNCkknbSBjdXJyZW50bHkgdHJ5aW5nIHRvIHRha2Ugb3ZlciBhbmQgcmVmYWN0
b3IgdGhlIHRhc2sgcmVmZXIgdG8geW91ciBzZXJpZXMuDQpBbmQgdGhlcmUgaGFzbid0IGJlZW4g
bXVjaCBwcm9ncmVzcyByZWNlbnRseSBiZWNhdXNlIEknbSBidXN5IHdpdGggb3RoZXIgd29yay4N
Cg0KDQpSZWdhcmRzLA0KDQpSZW5pdXMNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
RnJvbTogVWxmIEhhbnNzb24gW21haWx0bzp1bGYuaGFuc3NvbkBsaW5hcm8ub3JnXQ0KPlNlbnQ6
IFdlZG5lc2RheSwgTWFyY2ggMzEsIDIwMjEgNTo1NyBQTQ0KPlRvOiBCZW5DaHVhbmdb6I6K5pm6
6YePXTsgUmVuaXVzIENoZW4NCj5DYzogQUtBU0hJIFRha2FoaXJvOyBHcmVnVHVb5p2c5ZWf6LuS
XTsgTWFzYW1pIEhpcmFtYXRzdTsgVGFrYW8gT3JpdG87IExpbnV4DQo+S2VybmVsIE1haWxpbmcg
TGlzdDsgVWxmIEhhbnNzb247IEFkcmlhbiBIdW50ZXI7IGxpbnV4LW1tYw0KPlN1YmplY3Q6IFJl
OiBbUEFUQ0ggMC80XSBtbWM6IGNvcmU6IFByZXBhcmF0aW9ucyB0byBzdXBwb3J0IFNEIFVIUy1J
SSBjYXJkcw0KPg0KPkhpIEJlbiwgUmVuaXVzLA0KPg0KPk9uIFRodSwgMjUgRmViIDIwMjEgYXQg
MTg6MDQsIFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPiB3cm90ZToNCj4+DQo+
PiBBIHNlcmllcyBbMV0gdGhhdCBoYXMgYmVlbiBjb2xsYWJvcmF0aXZlIHdvcmtlZCB1cG9uIGJ5
IFRha2FoaXJvIEFrYXNoaQ0KPj4gKExpbmFybykgYW5kIEJlbiBDaHVhbmcgKEdlbmVzeXMgTG9n
aWMpIGlzIHRhcmdldGluZyB0byBhZGQgU0QgVUhTLUlJIHN1cHBvcnQNCj4+IHRvIHRoZSBtbWMg
c3Vic3lzdGVtLg0KPj4NCj4+IFRocm91Z2hvdXQgdGhlIHJldmlld3MsIHdlIHJlYWxpemVkIHRo
YXQgdGhlIGNoYW5nZXMgYWZmZWN0aW5nIHRoZSBtbWMgY29yZQ0KPnRvDQo+PiBzdXBwb3J0IHRo
ZSBVSFMtSUkgaW50ZXJmYWNlL3Byb3RvY29sIG1pZ2h0IG5vdCBiZSBlbnRpcmVseSBzdHJhaWdo
dGZvcndhcmQgdG8NCj4+IGltcGxlbWVudC4gRXNwZWNpYWxseSwgSSBleHByZXNzZWQgc29tZSBj
b25jZXJucyBhYm91dCB0aGUgY29kZSB0aGF0DQo+bWFuYWdlcw0KPj4gcG93ZXIgb24vb2ZmLCBp
bml0aWFsaXphdGlvbiBhbmQgcG93ZXIgbWFuYWdlbWVudCBvZiBhIFNEIFVIUy1JSSBjYXJkLg0K
Pj4NCj4+IFRoZXJlZm9yZSwgSSBoYXZlIHBvc3RlZCB0aGlzIHNtYWxsIHNlcmllcyB0byB0cnkg
dG8gaGVscCB0byBwdXQgc29tZSBvZiB0aGUNCj4+IGZvdW5kYXRpb24gaW4gdGhlIG1tYyBjb3Jl
IGluIHBsYWNlLiBIb3BlZnVsbHkgdGhpcyBjYW4gcHJvdmlkZSBzb21lDQo+Z3VpZGFuY2UNCj4+
IGFuZCBhbiBvdmVyYWxsIHN0cnVjdHVyZSwgb2YgaG93IEkgdGhpbmsgdGhlIGNvZGUgY291bGQg
ZXZvbHZlLg0KPj4NCj4+IE1vcmUgZGV0YWlscyBhcmUgYXZhaWxhYmxlIGluIHRoZSBjb21taXQg
bWVzc2FnZXMgYW5kIHRocm91Z2ggY29tbWVudHMgaW4NCj50aGUNCj4+IGNvZGUsIGZvciBlYWNo
IHBhdGguDQo+Pg0KPj4gS2luZCByZWdhcmRzDQo+PiBVZmZlDQo+DQo+SSBqdXN0IHdhbnRlZCB0
byBnZXQgYW4gdXBkYXRlIGZyb20geW91ciBzaWRlLiBEaWQgJHN1YmplY3Qgc2VyaWVzDQo+aGVs
cCB0byBtb3ZlIHRoaW5ncyBmb3J3YXJkPw0KPg0KPklmIHRoZXJlIGlzIGFueXRoaW5nIGVsc2Ug
SSBjYW4gaGVscCB3aXRoLCB0aGVuIHBsZWFzZSBwaW5nIG1lLg0KPg0KPktpbmQgcmVnYXJkcw0K
PlVmZmUNCj4NCj4+DQo+PiBbMV0NCj4+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzExLzUv
MTQ3Mg0KPj4NCj4+DQo+PiBVbGYgSGFuc3NvbiAoNCk6DQo+PiAgIG1tYzogY29yZTogQ2xlYW51
cCBwcmludGluZyBvZiBzcGVlZCBtb2RlIGF0IGNhcmQgaW5zZXJ0aW9uDQo+PiAgIG1tYzogY29y
ZTogUHJlcGFyZSB0byBzdXBwb3J0IFNEIFVIUy1JSSBjYXJkcw0KPj4gICBtbWM6IGNvcmU6IEFu
bm91bmNlIHN1Y2Nlc3NmdWwgaW5zZXJ0aW9uIG9mIGFuIFNEIFVIUy1JSSBjYXJkDQo+PiAgIG1t
YzogY29yZTogRXh0ZW5kIHN1cHBvcnQgZm9yIG1tYyByZWd1bGF0b3JzIHdpdGggYSB2cW1tYzIN
Cj4+DQo+PiAgZHJpdmVycy9tbWMvY29yZS9NYWtlZmlsZSAgICB8ICAgMiArLQ0KPj4gIGRyaXZl
cnMvbW1jL2NvcmUvYnVzLmMgICAgICAgfCAgMzggKysrLS0NCj4+ICBkcml2ZXJzL21tYy9jb3Jl
L2NvcmUuYyAgICAgIHwgIDE3ICsrLQ0KPj4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5oICAgICAg
fCAgIDEgKw0KPj4gIGRyaXZlcnMvbW1jL2NvcmUvaG9zdC5oICAgICAgfCAgIDUgKw0KPj4gIGRy
aXZlcnMvbW1jL2NvcmUvcmVndWxhdG9yLmMgfCAgMzQgKysrKysNCj4+ICBkcml2ZXJzL21tYy9j
b3JlL3NkX3VoczIuYyAgIHwgMjg5DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggICAgIHwgICA2ICsNCj4+ICBpbmNsdWRl
L2xpbnV4L21tYy9ob3N0LmggICAgIHwgIDMwICsrKysNCj4+ICA5IGZpbGVzIGNoYW5nZWQsIDQw
NCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9tbWMvY29yZS9zZF91aHMyLmMNCj4+DQo+PiAtLQ0KPj4gMi4yNS4xDQo+Pg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KR2VuZXN5cyBMb2dpYyBFbWFpbCBDb25m
aWRlbnRpYWxpdHkgTm90aWNlOg0KVGhpcyBtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNv
bnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2
aWxlZ2VkIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQgYnkgbGF3LiBUaGUgbWFpbCBpcyBpbnRlbmRl
ZCBzb2xlbHkgZm9yIHRoZSBuYW1lZCBhZGRyZXNzZWUgKG9yIGEgcGVyc29uIHJlc3BvbnNpYmxl
IGZvciBkZWxpdmVyaW5nIGl0IHRvIHRoZSBhZGRyZXNzZWUpLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgbWFpbCwgeW91IGFyZSBub3QgYXV0aG9yaXplZCB0
byByZWFkLCBwcmludCwgY29weSBvciBkaXNzZW1pbmF0ZSB0aGlzIG1haWwuDQoNCklmIHlvdSBo
YXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdXMgaW1tZWRp
YXRlbHkgYnkgcmVwbHkgZW1haWwgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGlzIG1lc3NhZ2Ug
YW5kIGFueSBhdHRhY2htZW50cyBmcm9tIHlvdXIgc3lzdGVtLiBQbGVhc2UgYmUgbm90ZWQgdGhh
dCBhbnkgdW5hdXRob3JpemVkIHVzZSwgZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uIG9yIGNv
cHlpbmcgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCg==
