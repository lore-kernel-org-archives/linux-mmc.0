From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
Date: Thu, 21 Mar 2019 15:22:47 +0000
Message-ID: <BYAPR12MB3398F91B190D9B1C56FDC4F7C2420@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Harjani Ritesh <riteshh@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Aniruddha Tvs Rao <anrao@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

PiA+DQo+ID4gRGVmYXVsdCB0YXAgYW5kIHRyaW0gdmFsdWVzIGFyZSBpbmNvcnJlY3QgZm9yIFRl
Z3JhMTg2IFNETU1DNC4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIGl0Lg0KPiA+DQo+ID4gVGVzdGVk
LWJ5OiBKb24gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPg0KPiBJcyB0
aGlzIGEgZml4IGFuZC9vciBmb3Igc3RhYmxlPw0KPg0KPiBJbiBlaXRoZXIgY2FzZSwgSSBhbSBs
ZWF2aW5nIHRoaXMgZm9yIGFybS1zb2MuDQo+DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+DQoN
ClRoYW5rcyBVZmZlLiBZZXMgdGhpcyBpcyBhcHBsaWNhYmxlIGZvciBzdGFibGUuDQoNCj4gPiAt
LS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmExODYuZHRzaSB8IDQgKyst
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2
LmR0c2kgDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTE4Ni5kdHNpDQo+
ID4gaW5kZXggOTdhZWI5NDZlZDVlLi40NzJmNTVmZTk0ODggMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmExODYuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2LmR0c2kNCj4gPiBAQCAtMzE3LDggKzMxNyw4IEBA
DQo+ID4gICAgICAgICAgICAgICAgIG52aWRpYSxwYWQtYXV0b2NhbC1wdWxsLWRvd24tb2Zmc2V0
LTF2OC10aW1lb3V0ID0gPDB4MGE+Ow0KPiA+ICAgICAgICAgICAgICAgICBudmlkaWEscGFkLWF1
dG9jYWwtcHVsbC11cC1vZmZzZXQtM3YzLXRpbWVvdXQgPSA8MHgwYT47DQo+ID4gICAgICAgICAg
ICAgICAgIG52aWRpYSxwYWQtYXV0b2NhbC1wdWxsLWRvd24tb2Zmc2V0LTN2My10aW1lb3V0ID0g
PDB4MGE+Ow0KPiA+IC0gICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10YXAgPSA8MHg1PjsN
Cj4gPiAtICAgICAgICAgICAgICAgbnZpZGlhLGRlZmF1bHQtdHJpbSA9IDwweDk+Ow0KPiA+ICsg
ICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10YXAgPSA8MHg5PjsNCj4gPiArICAgICAgICAg
ICAgICAgbnZpZGlhLGRlZmF1bHQtdHJpbSA9IDwweDU+Ow0KPiA+ICAgICAgICAgICAgICAgICBu
dmlkaWEsZHFzLXRyaW0gPSA8NjM+Ow0KPiA+ICAgICAgICAgICAgICAgICBtbWMtaHM0MDAtMV84
djsNCj4gPiAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAtLQ0KPiA+
IDIuNy40DQo+ID4NCg==
