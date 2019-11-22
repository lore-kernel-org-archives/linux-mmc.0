From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH v1 1/4] arm64: dts: ls1028a-rdb: enable emmc hs400 mode
Date: Fri, 22 Nov 2019 03:31:14 +0000
Message-ID: <VI1PR04MB41589D01E1733E63E261CA2FE9490@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Leo Li <leoyang.li@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "Amit Jain (aj)" <amit.jain_1@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ashish Kumar <ashish.kumar@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Alison Wang <alison.wang@nxp.com>, Alexandru Marginean <alexandru.marginean@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Catalin Horghidan <catalin.horghidan@nxp.com>, Rajat Srivastava <rajat.srivastava@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-mmc@vger.kernel.org

SGkgDQoNCk15IGhzNDAwIHNlcmllcyBwYXRjaGVzIGZvciBsczEwMjggbmVlZCBkbyBhbnkgY2hh
bmdlcz8gDQogIA0KUmVnYXJkcywNCllpbmJvIFpodS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+IA0KU2VudDogMjAxOcTq
ONTCMTTI1SAxNToyNw0KVG86IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJr
IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGlu
Lm1hcmluYXNAYXJtLmNvbT47IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPjsgQWRy
aWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgQ2xhdWRpdSBN
YW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBBbWl0IEphaW4gKGFqKSA8YW1pdC5qYWlu
XzFAbnhwLmNvbT47IFkuYi4gTHUgPHlhbmdiby5sdUBueHAuY29tPjsgVmFiaGF2IFNoYXJtYSA8
dmFiaGF2LnNoYXJtYUBueHAuY29tPjsgUmFqZXNoIEJoYWdhdCA8cmFqZXNoLmJoYWdhdEBueHAu
Y29tPjsgQXNoaXNoIEt1bWFyIDxhc2hpc2gua3VtYXJAbnhwLmNvbT47IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcNCkNjOiBZ
aW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPjsgWGlhb2JvIFhpZSA8eGlhb2JvLnhpZUBueHAu
Y29tPjsgSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAuY29tPjsgQWxpc29uIFdhbmcgPGFsaXNv
bi53YW5nQG54cC5jb20+OyBBbGV4YW5kcnUgTWFyZ2luZWFuIDxhbGV4YW5kcnUubWFyZ2luZWFu
QG54cC5jb20+OyBDYXRhbGluIEhvcmdoaWRhbiA8Y2F0YWxpbi5ob3JnaGlkYW5AbnhwLmNvbT47
IFJhamF0IFNyaXZhc3RhdmEgPHJhamF0LnNyaXZhc3RhdmFAbnhwLmNvbT47IGxpbnV4cHBjLWRl
dkBsaXN0cy5vemxhYnMub3JnDQpTdWJqZWN0OiBbUEFUQ0ggdjEgMS80XSBhcm02NDogZHRzOiBs
czEwMjhhLXJkYjogZW5hYmxlIGVtbWMgaHM0MDAgbW9kZQ0KDQpUaGlzIHBhdGNoIGlzIHRvIGVu
YWJsZSBlbW1jIGhzNDAwIG1vZGUgZm9yIGxzMTAyOGFyZGINCg0KU2lnbmVkLW9mZi1ieTogWWlu
Ym8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMgfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KaW5kZXggOGE3MjU0MDllODgxLi5mMWU0
NmNjNGNlYTEgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDI4YS1yZGIuZHRzDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDI4YS1yZGIuZHRzDQpAQCAtOTIsOCArOTIsMTAgQEANCiAJfTsNCiANCiAmZXNkaGMxIHsN
Ci0Jc3RhdHVzID0gIm9rYXkiOw0KIAltbWMtaHMyMDAtMV84djsNCisJbW1jLWhzNDAwLTFfOHY7
DQorCWJ1cy13aWR0aCA9IDw4PjsNCisJc3RhdHVzID0gIm9rYXkiOw0KIAl9Ow0KIA0KICZpMmMw
IHsNCi0tIA0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
