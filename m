From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCH v6 0/2] patch set about the MXS-DMA
Date: Sat, 3 Mar 2012 09:54:05 +0800
Message-ID: <CAMiH66G54BCoMrSTqnXyJy=C8w4RqVkv_qvQosUHWj4qd+Xh=Q@mail.gmail.com>
References: <1329373053-19494-1-git-send-email-b32955@freescale.com>
 <4F4D9725.3090100@freescale.com>
 <1330502098.3545.78.camel@sauron.fi.intel.com>
 <4F4DE0E5.8070808@freescale.com>
 <1330516974.3545.104.camel@sauron.fi.intel.com>
 <CAMiH66HmV+58w36DGCt+e=ihTrYUwXf1Cur+678YX2GKcB1-jA@mail.gmail.com>
 <m2mx7yn2we.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <m2mx7yn2we.fsf@bob.laptop.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Bityutskiy,
 Artem" <artem.bityutskiy@intel.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "LW@KARO-electronics.de" <LW@karo-electronics.de>
List-Id: linux-mmc@vger.kernel.org

aGksCgpPbiBTYXQsIE1hciAzLCAyMDEyIGF0IDQ6NTAgQU0sIENocmlzIEJhbGwgPGNqYkBsYXB0
b3Aub3JnPiB3cm90ZToKPiBIaSwKPgo+IE9uIFdlZCwgRmViIDI5IDIwMTIsIEh1YW5nIFNoaWpp
ZSB3cm90ZToKPj4+IFB1c2hlZCBib3RoIHRvIGwyLW10ZC5naXQgdHJlZSwgdGhhbmtzLiBJIGFt
IHdvcnJpZWQgdGhhdCBpdCB0b3VjaGVzCj4+PiBvdGhlciBzdWJzeXN0ZW1zIGxpa2UgZG1hLCBz
b3VuZCwgYW5kIG1tYyBhbmQgdGhlcmUgYXJlIG5vIGFja3MgZm9yCj4+PiB0aG9zZS4gV291bGQg
YmUgbmljZSB0byBnZXQgdGhlbSBzb21laG93Lgo+Pgo+PiBJIGV2ZXIgdGhvdWdodCBWaW5vZCBj
b3VsZCBhY2NlcHQgdGhpcyBwYXRjaCBzZXQuCj4+Cj4+IFRvIFZpbm9kICYgQ2hyaXM6Cj4+IMKg
IMKgIMKgIENvdWxkIHlvdSBnaXZlIHRoZSBhY2sgdG8gdGhlIGZpcnN0IHBhdGNoPwo+Cj4gWWVz
IC0tIGZvciB0aGUgZmlyc3QgcGF0Y2g6Cj4KPiBBY2tlZC1ieTogQ2hyaXMgQmFsbCA8Y2piQGxh
cHRvcC5vcmc+Cj4KCnRoYW5rcyBhIGxvdC4KCkh1YW5nIFNoaWppZQoKCj4gKEkgdGhpbmsgU2hh
d24ncyBBQ0sgaXMgc3VmZmljaWVudCBmb3IgdGhlIHNlY29uZCBwYXRjaC4pCj4KPiBUaGFua3Ms
Cj4KPiAtIENocmlzLgo+IC0tCj4gQ2hyaXMgQmFsbCDCoCA8Y2piQGxhcHRvcC5vcmc+IMKgIDxo
dHRwOi8vcHJpbnRmLm5ldC8+Cj4gT25lIExhcHRvcCBQZXIgQ2hpbGQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
