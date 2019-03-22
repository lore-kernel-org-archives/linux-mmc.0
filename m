From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 0/7] mmc: Several fixes for bcm2835 driver
Date: Fri, 22 Mar 2019 18:10:11 +0100 (CET)
Message-ID: <1210065308.73665.1553274611385@email.ionos.de>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
 <20190321210307.58e33ea4@kitsune.suse.cz>
 <1ff03f96-2575-f65e-c96e-6dc52de00c3a@i2se.com>
 <20190322170643.2e56d220@naga.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190322170643.2e56d220-yQW5Ri8AFK4NMLpHRKhSow@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek-l3A5Bk7waGM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

SGkgTWljaGFsLAoKPiBNaWNoYWwgU3VjaMOhbmVrIDxtc3VjaGFuZWtAc3VzZS5kZT4gaGF0IGFt
IDIyLiBNw6RyeiAyMDE5IHVtIDE3OjA2IGdlc2NocmllYmVuOgo+IAo+IAo+IE9uIEZyaSwgMjIg
TWFyIDIwMTkgMTU6NDU6MTMgKzAxMDAKPiBTdGVmYW4gV2FocmVuIDxzdGVmYW4ud2FocmVuQGky
c2UuY29tPiB3cm90ZToKPiAKPiA+IEhpIE1pY2hhbCwKPiA+IAo+ID4gQW0gMjEuMDMuMTkgdW0g
MjE6MDMgc2NocmllYiBNaWNoYWwgU3VjaMOhbmVrOgo+ID4gCj4gPiBjb3VsZCB5b3UgcGxlYXNl
IHJldHJ5IHdpdGggbWFpbmxpbmUga2VybmVsIDUuMD8KPiAKPiBJIGNhbiB0cnkgdGhhdC4gV2hh
dCBJIGhhdmUgaXMgcHJldHR5IG11Y2ggNS4wIGFueXdheSBzbyBJIGRvbid0IGV4cGVjdAo+IG11
Y2ggZGlmZmVyZW5jZToKPiAKCmFzIGxvbmcgYXMgdGhlIGlzc3VlIGxpZXMgaW4gdGhlIHNkaG9z
dCBkcml2ZXIgY29kZS4gVGhlcmUgYWxzbyBoYXMgYmVlbiBhIGxvdCBvZiBmaXhlcyBieSBMdWth
cyBXdW5uZXIgdG8gdGhlIERNQSBlbmdpbmUgZHJpdmVyLiBJIHByZWZlciBhIHdlbGwgZGVmaW5l
ZCBzb3VyY2UgYmFzZS4KCj4gCj4gSSBzdXNwZWN0IHRoYXQgb25lIG9mIHRoZSBsb2NraW5nIGZp
eGVzIHRoYXQgd2VudCBpbnRvIG1haW5saW5lCj4gcmVjZW50bHkgcHJldmVudHMgcmVjb3Zlcmlu
ZyBmcm9tIHRoZSBlcnJvciBidXQgSSBkaWQgbm90IHRyeQo+IHJldmVydGluZyB0aGVtIHlldC4K
CldvdWxkIGJlIG5pY2UgaWYgeW91IGNhbiBmaW5kIHRoaXMgcmVncmVzc2lvbi4KCj4gSXQgdGFr
ZXMgcXVpdGUgYSB3aGlsZSB0byByZWltYWdlLCBib290IGRpZmZlcmVudAo+IGtlcm5lbCwgcnVu
IHN5c3RlbSB1cGRhdGUgKHdoaWNoIG5vdyBpbnZhcmlhYmx5IGNyYXNoZXMvbG9ja3MgdXAgd2l0
aAo+IGFueSBrZXJuZWwpLiAKClRoYXQncyB3aHkgaSBwcmVmZXIgUmFzcGJpYW4gZHVyaW5nIGRl
dmVsb3BtZW50LCB3aGVyZSBpIGNhbiBzaW1wbHkgcmVwbGFjZSB0aGUga2VybmVsIC8gbW9kdWxl
cyB3aXRoIGEgc2QgY2FyZCByZWFkZXIgb24gYSBQQzoKCmh0dHBzOi8vZ2lzdC5naXRodWIuY29t
L2xhdGVnb29kYnllL2M3MzE3YTQyYmY3ZjljMDdmNWE5MWJhZWQ4YzY4Zjc1CgpUaGlzIHNob3Vs
ZCByZWR1Y2UgdGhlIHJvdW5kLXRyaXAsIGJ1dCB0aGlzIGNvdWxkIGFjY2lkZW50bHkgaGlkZSB0
aGUgcHJvYmxlbSBhcyB3ZWxsLgoKVGhhbmtzClN0ZWZhbgoKPiAKPiBUaGFua3MKPiAKPiBNaWNo
YWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LXJwaS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LXJwaS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJw
aS1rZXJuZWwK
