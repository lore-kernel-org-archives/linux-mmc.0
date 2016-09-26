From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH 0/3] mmc: Check BKOPS Level On Runtime Suspend
Date: Mon, 26 Sep 2016 15:10:20 +0000
Message-ID: <36E1868F-E766-4B13-B31B-7488BE342069@sandisk.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:44620
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965099AbcIZPKX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Sep 2016 11:10:23 -0400
In-Reply-To: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Content-Language: en-US
Content-ID: <3FF270884BACCE4D9DB0B9414A8ED164@namprd02.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>

SGkgVWxmLA0KDQpDb3VsZCB5b3UgcGxlYXNlIHJldmlldyB0aGlzPw0KDQpUaGFua3MsDQpBbGV4
DQoNCk9uIDkvMS8xNiwgNToyNCBQTSwgIkFsZXggTGVtYmVyZyIgPEFsZXguTGVtYmVyZ0BzYW5k
aXNrLmNvbT4gd3JvdGU6DQoNCj5GbGFzaCBiYXNlZCBzdG9yYWdlIGRldmljZXMgbWlnaHQgbmVl
ZCB0byBwZXJmb3JtIHRoZSBpbnRlcm5hbA0KPkJhY2tncm91bmQgT3BlcmF0aW9ucyAoQktPUFMp
IGluIG9yZGVyIHRvIGluc3VyZSBiZXR0ZXIgcGVyZm9ybWFuY2UNCj5mb3IgdGhlIG5leHQgY29t
aW5nIElPLg0KPkZvbGxvd2luZyB0aGUgZGlzY3Vzc2lvbiBpbiB0aGUgbW1jIHRocmVhZDoNCj53
d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtbW1jL21zZzM3Nzc5Lmh0bWwNCj5UbyBsZXQgdGhl
IGRldmljZSBjb21wbGV0ZSBpdHMgQktPUFMgZHVyaW5nIFJ1bnRpbWUgU3VzcGVuZCwNCj53ZSBz
dWdnZXN0IHRvIGNoZWNrIHRoZSBCS09QUyBsZXZlbC4NCj5JbiBjYXNlIHRoZSBkZXZpY2UgbmVl
ZCB0byBjb21wbGV0ZSBpdHMgQktPUFMsIHJlc2NoZWR1bGUgdGhlIFJ1bnRpbWUNCj5TdXNwZW5k
Lg0KPg0KPmFsZXggbGVtYmVyZyAoMyk6DQo+ICBtbWM6IHJlcGxhY2luZyBoYXJkY29kZWQgdmFs
dWUgZm9yIHJ1bnRpbWUgUE0gc3VzcGVuZA0KPiAgbW1jOiBBZGRpbmcgQVVUT19CS09QU19FTiBi
aXQgc2V0IGZvciBBdXRvIEJLT1BTIHN1cHBvcnQNCj4gIG1tYzogQ2hlY2tpbmcgQktPUFMgc3Rh
dHVzIHByaW9yIHRvIFN1c3BlbmQNCj4NCj4gZHJpdmVycy9tbWMvY2FyZC9ibG9jay5jIHwgIDMg
KystDQo+IGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMgICB8IDM2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLQ0KPiBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggfCAgMSArDQo+IGlu
Y2x1ZGUvbGludXgvbW1jL2hvc3QuaCB8ICAyICsrDQo+IGluY2x1ZGUvbGludXgvbW1jL21tYy5o
ICB8ICAyICsrDQo+IDUgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4NCj4tLSANCj4xLjkuMQ0KPg0KDQo=
