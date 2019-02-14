From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v2 3/3] mmc: core: Add discard support to sd
Date: Thu, 14 Feb 2019 11:12:52 +0000
Message-ID: <SN6PR04MB492532246A5968F6C60F84F3FC670@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
 <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
 <CAPDyKFqrS+f4K-t6i0ZxAivtATddYepXLguX5svrQub-zH2JEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqrS+f4K-t6i0ZxAivtATddYepXLguX5svrQub-zH2JEw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <Avi.Shchislowski@wdc.com>, Alex Lemberg <Alex.Lemberg@wdc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

PiANCj4gT24gV2VkLCA2IEZlYiAyMDE5IGF0IDEyOjI5LCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRt
YW5Ad2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTRCBzcGVjIHY1LjEgYWRkcyBkaXNjYXJkIHN1
cHBvcnQuIFRoZSBmbG93cyBhbmQgY29tbWFuZHMgYXJlIHNpbWlsYXIgdG8NCj4gPiBtbWMsIHNv
IGp1c3Qgc2V0IHRoZSBkaXNjYXJkIGFyZyBpbiBDTUQzOC4NCj4gPg0KPiA+IEFjdHVhbGx5LCB0
aGVyZSBpcyBubyBuZWVkIHRvIGNoZWNrIGZvciB0aGUgc3BlYyB2ZXJzaW9uIGxpa2Ugd2UgYXJl
DQo+ID4gZG9pbmcsIGFzIGl0IGlzIGFzc3VyZWQgdGhhdCB0aGUgcmVzZXJ2ZWQgYml0cyBpbiBl
YXJsaWVyIHZlcnNpb25zIGFyZQ0KPiA+IG51bGwuIERvIHRoYXQgYW55d2F5IHRvIGRvY3VtZW50
IHRoZSBzcGVjIHZlcnNpb24gdGhhdCBpbnRyb2R1Y2UgaXQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gDQo+IERlZmVycmluZyB0
aGlzIGEgYml0LCBuZWVkIHNvbWUgbW9yZSB0aW1lIHRvIHJldmlldy4NCkEga2luZCByZW1pbmRl
ci4NClRoYW5rcywNCkF2cmkNCg==
