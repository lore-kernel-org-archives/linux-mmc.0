From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Date: Tue, 15 Jan 2019 03:26:18 +0000
Message-ID: <BN7PR12MB2836B186E2AB62D58F6D08B1C2810@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
 <5722018a-7654-c6f9-c2aa-2817b39b1a35@intel.com>
 <BN7PR12MB2836750BAFFAEAF8436C7C58C2850@BN7PR12MB2836.namprd12.prod.outlook.com>
 <CABOV4+UkA48Jc9hTSkM=cEoH0zktmjazrcWVZZ1LMqRXSdjVuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABOV4+UkA48Jc9hTSkM=cEoH0zktmjazrcWVZZ1LMqRXSdjVuA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Chunyan Zhang <chunyan.zhang@unisoc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

DQo+Pg0KPj4gPj4gK3N0YXRpYyBpbnQgc2RoY2lfdGVncmFfYWRkX2hvc3Qoc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QpIHsNCj4+ID4+ICsgICAgc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZt
X2hvc3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPj4gPj4gKyAgICBzdHJ1Y3Qgc2RoY2lfdGVncmEg
KnRlZ3JhX2hvc3QgPSBzZGhjaV9wbHRmbV9wcml2KHBsdGZtX2hvc3QpOw0KPj4gPj4gKyAgICBz
dHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdDsNCj4+ID4+ICsgICAgYm9vbCBkbWE2NDsNCj4+ID4+
ICsgICAgaW50IHJldDsNCj4+ID4+ICsNCj4+ID4+ICsgICAgaWYgKCF0ZWdyYV9ob3N0LT5lbmFi
bGVfaHdjcSkNCj4+ID4+ICsgICAgICAgICAgICByZXR1cm4gc2RoY2lfYWRkX2hvc3QoaG9zdCk7
DQo+PiA+PiArDQo+PiA+PiArICAgIGhvc3QtPnY0X21vZGUgPSB0cnVlOw0KPj4gPg0KPj4gPkNh
biB5b3UgdXNlIHNkaGNpX2VuYWJsZV92NF9tb2RlKCkgaGVyZT8NCj4+DQo+PiBIaSBBZHJpYW4s
DQo+PiBzZGhjaV9yZWFkX2NhcHMgc2V0cyB2NCBtb2RlIHRocnUgc2RoY2lfZG9fZW5hYmxlX3Y0
X21vZGUgaWYgdjRfbW9kZSANCj4+IGlzIHRydWUgc2RoY2lfc2V0dXBfaG9zdCBjYWxscyBzZGhj
aV9yZWFkX2NhcHMgc28gSSB3YXMgc2V0dGluZyB2NF9tb2RlIHRvIHRydWUgc28gdjQgbW9kZSBn
ZXRzIGVuYWJsZWQgZHVyaW5nIHJlYWQgY2Fwcy4NCj4+DQo+DQo+SGkgc293amFueWEsIA0KPg0K
PkkgYWxzbyB3b3VsZCBzdWdnZXN0IHRvIHVzZSBzZGhjaV9lbmFibGVfdjRfbW9kZSgpIGluc3Rl
YWQgb2Ygc2V0dGluZw0KPmhvc3QtPnY0X21vZGUgZGlyZWN0bHkuDQo+RW5hYmxpbmcgdjRfbW9k
ZSBpbiByZWFkIGNhcHMgd2FzIGp1c3QgYmVjYXVzZSB0aGF0IEkgd2FzIHdvcnJpZWQgYWJvdXQg
djQgbW9kZSB3b3VsZCBiZSBjbGVhcmVkIGFmdGVyIHJlc2V0IGFsbCBvbiBzb21lIGNvbnRyb2xs
ZXJzLiBJZiB0aGF0J3Mgbm90IHRoZSBjYXNlIGZvciBhbGwgc2QgaG9zdCBjb250cm9sbGVycywg
SSBndWVzcyBpdCBjYW4gYmUgcmVtb3ZlZC4NCj4NCj5UaGFua3MsDQo+Q2h1bnlhbg0KDQpPSywg
V2lsbCBjaGFuZ2UgaXQgYW5kIHByb3ZpZGUgdXBkYXRlZCB2ZXJzaW9uLiBUaGFua3MgQW5kcmlh
biBhbmQgQ2h1bnlhbi4NClNvd2phbnlhDQo=
