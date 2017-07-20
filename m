From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
Date: Thu, 20 Jul 2017 09:00:41 +0200
Message-ID: <CAMuHMdVxnqD-90fDH+dqo8iJ94etcLHih27cqdVppi_AbFzbbw@mail.gmail.com>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: USB list <linux-usb@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, DRI Development <dri-devel@lists.freedesktop.org>, linux-spi <linux-spi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

T24gVGh1LCBKdWwgMjAsIDIwMTcgYXQgODoyOCBBTSwgTWF0dCBCcm93biA8bWF0dGhldy5icm93
bi5kZXZAZ21haWwuY29tPiB3cm90ZToKPiBUaGUgY2FjaGVmbHVzaCBwcm90b3R5cGVzIGN1cnJl
bnRseSB1c2Ugc3RhcnQgYW5kIHN0b3AgdmFsdWVzIGFuZCBlYWNoCj4gY2FsbCByZXF1aXJlcyB0
eXBlY2FzdGluZyB0aGUgYWRkcmVzcyB0byBhbiB1bnNpZ25lZCBsb25nLgo+IFRoaXMgcGF0Y2gg
Y2hhbmdlcyB0aGUgY2FjaGVmbHVzaCBwcm90b3R5cGVzIHRvIGZvbGxvdyB0aGUgeDg2IHN0eWxl
IG9mCj4gdXNpbmcgYSBiYXNlIGFuZCBzaXplIHZhbHVlcywgd2l0aCBiYXNlIGJlaW5nIGEgdm9p
ZCBwb2ludGVyLgo+Cj4gQWxsIGNhbGxlcnMgb2YgdGhlIGNhY2hlZmx1c2ggZnVuY3Rpb25zLCBp
bmNsdWRpbmcgZHJpdmVycywgaGF2ZSBiZWVuCj4gbW9kaWZpZWQgdG8gY29uZm9ybSB0byB0aGUg
bmV3IHByb3RvdHlwZXMuCj4KPiBUaGUgNjQgYml0IGNhY2hlZmx1c2ggZnVuY3Rpb25zIHdoaWNo
IHdlcmUgaW1wbGVtZW50ZWQgaW4gYXNzZW1ibHkgY29kZQo+IChmbHVzaF9kY2FjaGVfcmFuZ2Us
IGZsdXNoX2ludmFsX2RjYWNoZV9yYW5nZSkgaGF2ZSBiZWVuIHRyYW5zbGF0ZWQgaW50bwo+IEMg
Zm9yIHJlYWRhYmlsaXR5IGFuZCBjb2hlcmVuY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0IEJy
b3duIDxtYXR0aGV3LmJyb3duLmRldkBnbWFpbC5jb20+Cgo+ICBkcml2ZXJzL3NwaS9zcGktYmZp
bjV4eC5jICAgICAgICAgICAgICAgICAgICB8IDEwICsrKy0tLQo+ICBkcml2ZXJzL3VzYi9tdXNi
L2JsYWNrZmluLmMgICAgICAgICAgICAgICAgICB8ICA2ICsrLS0KClRoZXNlIGFyZSB1c2VkIG9u
IGJsYWNrZmluLCBzbyBjaGFuZ2luZyB0aGVtIHdpdGhvdXQgY2hhbmdpbmcgdGhlIGJsYWNrZmlu
CmNhY2hlIG9wcyB3aWxsIGJyZWFrIHRoZSBidWlsZC4KCkdye29ldGplLGVldGluZ31zLAoKICAg
ICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVy
ZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCklu
IHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlz
ZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qg
c2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
