From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [PATCH v3 1/2] Documentation: dt: Add new compatible to sunxi mmc
 driver bindings
Date: Mon, 22 Aug 2016 16:47:51 +0800
Message-ID: <370671471855671@web30j.yandex.ru>
References: <20160801151351.51854-1-icenowy@aosc.xyz>
 <20160801151351.51854-2-icenowy@aosc.xyz> <20160822075847.GD7104@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160822075847.GD7104@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michal Suchanek <hramrach@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

CgoyMi4wOC4yMDE2LCAxNTo1OCwgIk1heGltZSBSaXBhcmQiIDxtYXhpbWUucmlwYXJkQGZyZWUt
ZWxlY3Ryb25zLmNvbT46Cj4gSGkgSWNlbm93eSwKPgo+IE9uIE1vbiwgQXVnIDAxLCAyMDE2IGF0
IDExOjEzOjUwUE0gKzA4MDAsIEljZW5vd3kgWmhlbmcgd3JvdGU6Cj4+IMKgU2lnbmVkLW9mZi1i
eTogSWNlbm93eSBaaGVuZyA8aWNlbm93eUBhb3NjLnh5ej4KPj4gwqAtLS0KPj4gwqBDaGFuZ2Vz
IGluIHYyOgo+PiDCoC0gUmViYXNlZCBvbiBIYW5zIGRlIEdvZWRlJ3MgcGF0Y2hzZXQuCj4+Cj4+
IMKgwqBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N1bnhpLW1tYy50eHQg
fCAxICsKPj4gwqDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Pgo+PiDCoGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N1bnhpLW1tYy50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N1bnhpLW1tYy50eHQK
Pj4gwqBpbmRleCA5MDRmZjlmLi41NWNkZDgwIDEwMDY0NAo+PiDCoC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3VueGktbW1jLnR4dAo+PiDCoCsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3VueGktbW1jLnR4dAo+PiDCoEBAIC0x
Myw2ICsxMyw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6Cj4+IMKgwqDCoMKgwqAqICJhbGx3aW5u
ZXIsc3VuNWktYTEzLW1tYyIKPj4gwqDCoMKgwqDCoCogImFsbHdpbm5lcixzdW43aS1hMjAtbW1j
Igo+PiDCoMKgwqDCoMKgKiAiYWxsd2lubmVyLHN1bjlpLWE4MC1tbWMiCj4+IMKgKyAqICJhbGx3
aW5uZXIsc3VuNTBpLWE2NC1tbWMiCj4+IMKgwqDCoC0gcmVnIDogbW1jIGNvbnRyb2xsZXIgYmFz
ZSByZWdpc3RlcnMKPj4gwqDCoMKgLSBjbG9ja3MgOiBhIGxpc3Qgd2l0aCA0IHBoYW5kbGUgKyBj
bG9jayBzcGVjaWZpZXIgcGFpcnMKPj4gwqDCoMKgLSBjbG9jay1uYW1lcyA6IG11c3QgY29udGFp
biAiYWhiIiwgIm1tYyIsICJvdXRwdXQiIGFuZCAic2FtcGxlIgo+Cj4gWW91IG5lZWQgdG8gZG9j
dW1lbnQgdGhhdCB0aGUgb3V0cHV0IGFuZCBzYW1wbGUgY2xvY2tzIGFyZSBub3QKPiBtYW5kYXRv
cnkgaW4gdGhlIEE2NCBjYXNlLgoKT2gsIHNvcnJ5LgoKVGhpcyBzZXJpZXMgb2YgcGF0Y2ggaXMg
ZHJvcHBlZCBub3cuLi4KCkF0IGxlYXN0IEkgYW5kIEFuZHJlIGhhdmUgbm8gU0QgQ2FyZCBzdWl0
YWJsZSBmb3IgRERSIG1vZGUuLi4KCk1heWJlIHRoZSBwYXRjaGVzIGNhbiBvbmx5IGJlIHRlc3Rl
ZCBvbiBlTU1DLgoKSG93ZXZlciwgYXQgbGVhc3Qgb24gUGluZTY0LCBvdXIgU0QgQ2FyZHMgYXJl
IHdvcmtpbmcgc3RlYWlseS4KCj4KPiBUaGFua3MhCj4gTWF4aW1lCj4KPiAtLQo+IE1heGltZSBS
aXBhcmQsIEZyZWUgRWxlY3Ryb25zCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVl
cmluZwo+IGh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
