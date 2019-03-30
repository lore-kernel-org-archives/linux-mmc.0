From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 0/7] mmc: Several fixes for bcm2835 driver
Date: Sat, 30 Mar 2019 16:15:14 +0100 (CET)
Message-ID: <1920951985.237156.1553958914902@email.ionos.de>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
 <20190321210307.58e33ea4@kitsune.suse.cz>
 <1ff03f96-2575-f65e-c96e-6dc52de00c3a@i2se.com>
 <20190322170643.2e56d220@naga.suse.cz>
 <1210065308.73665.1553274611385@email.ionos.de>
 <20190328214351.358e615a@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190328214351.358e615a@kitsune.suse.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Phil Elwell <phil@raspberrypi.org>, linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

SGkgTWljaGFsLAoKPiBNaWNoYWwgU3VjaMOhbmVrIDxtc3VjaGFuZWtAc3VzZS5kZT4gaGF0IGFt
IDI4LiBNw6RyeiAyMDE5IHVtIDIxOjQzIGdlc2NocmllYmVuOgo+IAo+IAo+IE9uIEZyaSwgMjIg
TWFyIDIwMTkgMTg6MTA6MTEgKzAxMDAgKENFVCkKPiBTdGVmYW4gV2FocmVuIDxzdGVmYW4ud2Fo
cmVuQGkyc2UuY29tPiB3cm90ZToKPiAKPiA+IEhpIE1pY2hhbCwKPiA+IAo+ID4gPiBNaWNoYWwg
U3VjaMOhbmVrIDxtc3VjaGFuZWtAc3VzZS5kZT4gaGF0IGFtIDIyLiBNw6RyeiAyMDE5IHVtIDE3
OjA2IGdlc2NocmllYmVuOgo+ID4gPiAKPiA+ID4gCj4gPiA+IE9uIEZyaSwgMjIgTWFyIDIwMTkg
MTU6NDU6MTMgKzAxMDAKPiA+ID4gU3RlZmFuIFdhaHJlbiA8c3RlZmFuLndhaHJlbkBpMnNlLmNv
bT4gd3JvdGU6Cj4gPiA+ICAgCj4gPiA+ID4gSGkgTWljaGFsLAo+ID4gPiA+IAo+ID4gPiA+IEFt
IDIxLjAzLjE5IHVtIDIxOjAzIHNjaHJpZWIgTWljaGFsIFN1Y2jDoW5lazoKPiA+ID4gPiAKPiA+
ID4gPiBjb3VsZCB5b3UgcGxlYXNlIHJldHJ5IHdpdGggbWFpbmxpbmUga2VybmVsIDUuMD8gIAo+
ID4gPiAKPiA+ID4gSSBjYW4gdHJ5IHRoYXQuIFdoYXQgSSBoYXZlIGlzIHByZXR0eSBtdWNoIDUu
MCBhbnl3YXkgc28gSSBkb24ndCBleHBlY3QKPiA+ID4gbXVjaCBkaWZmZXJlbmNlOgo+ID4gPiAg
IAo+ID4gCj4gPiBhcyBsb25nIGFzIHRoZSBpc3N1ZSBsaWVzIGluIHRoZSBzZGhvc3QgZHJpdmVy
IGNvZGUuIFRoZXJlIGFsc28gaGFzIGJlZW4gYSBsb3Qgb2YgZml4ZXMgYnkgTHVrYXMgV3VubmVy
IHRvIHRoZSBETUEgZW5naW5lIGRyaXZlci4gSSBwcmVmZXIgYSB3ZWxsIGRlZmluZWQgc291cmNl
IGJhc2UuCj4gPiAKPiA+ID4gCj4gPiA+IEkgc3VzcGVjdCB0aGF0IG9uZSBvZiB0aGUgbG9ja2lu
ZyBmaXhlcyB0aGF0IHdlbnQgaW50byBtYWlubGluZQo+ID4gPiByZWNlbnRseSBwcmV2ZW50cyBy
ZWNvdmVyaW5nIGZyb20gdGhlIGVycm9yIGJ1dCBJIGRpZCBub3QgdHJ5Cj4gPiA+IHJldmVydGlu
ZyB0aGVtIHlldC4gIAo+ID4gCgpjb3VsZCB5b3UgcGxlYXNlIHRyeSB0aGlzIHBhdGNoOgoKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXJwaS1rZXJuZWwvMjAxOS1N
YXJjaC8wMDg2MjcuaHRtbAoKU3RlZmFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
