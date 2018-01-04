From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
Date: Thu, 04 Jan 2018 14:52:54 +0000
Message-ID: <20289.1515077574@warthog.procyon.org.uk>
References: <CAK8P3a3i0bKvG56ha9_hzO=z80sVxCQhaeFn6QW3AwbwZs3HPg@mail.gmail.com>
 <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
 <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
 <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAK8P3a3i0bKvG56ha9_hzO=z80sVxCQhaeFn6QW3AwbwZs3HPg@mail.gmail.com>
Content-ID: <20288.1515077574.1@warthog.procyon.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, linux-mips@linux-mips.org, Ulf Hansson <ulf.hansson@linaro.org>, Jakub Kicinski <jakub.kicinski@netronome.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, David Airlie <airlied@linux.ie>, linux-wireless <linux-wireless@vger.kernel.org>, alsa-devel@alsa-project.org, dri-devel <dri-devel@lists.freedesktop.org>, Liam Girdwood <lgirdwood@gmail.com>, dhowells@redhat.com, IDE-ML <linux-ide@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Networking <netdev@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Daniel Vetter <daniel.vetter@intel.com>, Dan Williams <dan.j.williams@intel.com>, Jason Cooper <jason@lakedaemon.net>, linux-rtc@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Richar
List-Id: linux-mmc@vger.kernel.org

QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6Cgo+IC0gbW4xMDMwMCBhcHBlYXJz
IHRvIGJlIHdyb25nLCBicm9rZW4gYnkgRGF2aWQgSG93ZWxscyBpbgo+ICAgY29tbWl0IDgzYzJk
YzE1Y2U4MiAoIk1OMTAzMDA6IEhhbmRsZSBjYWNoZWFibGUgUENJIHJlZ2lvbnMKPiAgIGluIHBj
aV9pb21hcCgpIikgZm9yIGFueSBkcml2ZXIgY2FsbGluZyBpb3JlbWFwKCkgYnkgdG8gZ2V0IHVu
Y2FjaGVkCj4gICBtZW1vcnksCgpJdCdzIG5vdCBjbGVhciB3aGF0IHRoZSByaWdodCB0aGluZyB0
byBkbyB3YXMsIGdpdmVuIHRoYXQgdGhlcmUncyBhbiBpb3JlbWFwKCkKYW5kIGFuIGlvcmVtYXBf
dW5jYWNoZWQoKS4KCkJ1dCB0aGUgYXNiMjMwNSdzIHBjaV9pb21hcCgpIHdpbGwgdXNlIGlvcmVt
YXAoKSAodGhlIGNhY2hlYWJsZSB3aW5kb3cpIGlmCklPUkVTT1VSQ0VfQ0FDSEVBQkxFIGlzIHNl
dCwgYnV0IElPUkVTT1VSQ0VfSU8gaXMgbm90IGFuZCBpb3JlbWFwX3VuY2FjaGVkKCkKb3RoZXJ3
aXNlLgoKVGhlIG90aGVyIHN1cHBvcnRlZCB1bml0cyBkb24ndCBoYXZlIFBDSSBidXNlcy4KCj4g
aWYgSSB1bmRlcnN0YW5kIHRoZSBjb21tZW50IGZvciBjb21taXQgMzRmMWJkZWUxOTEwICgibW4x
MDMwMDogc3dpdGNoIHRvCj4gR0VORVJJQ19QQ0lfSU9NQVAiKSBjb3JyZWN0bHk6IGl0IHNlZW1z
IHRoYXQgUENJIGFkZHJlc3NlcyBpbmNsdWRlIHRoZQo+ICd1bmNhY2hlZCcgYml0IGJ5IGRlZmF1
bHQgdG8gZ2V0IHRoZSByaWdodCBiZWhhdmlvciwgYnV0IGRyb3BwaW5nIHRoYXQgYml0Cj4gYnJl
YWtzIGl0LgoKTm90IGV4YWN0bHkuICBUaGUgQ1BVIGhhcyBhIHdpbmRvdyBpbiB0aGUgcmFuZ2Ug
MHhhMDAwMDAwMC0weGJmZmZmZmZmIHdoaWNoIGlzCmFuIHVuY2FjaGVkIHZpZXcgb2YgaXRzIGhh
cmR3YXJlIGJ1c2VzLiAgSXQgaGFzIGFub3RoZXIgd2luZG93IGluIHRoZSByYW5nZQoweDgwMDAw
MDAwLTB4OWZmZmZmZmYgd2hpY2ggaXMgYSBjYWNoZWQgdmlldyBvZiB0aGF0IHJlZ2lvbi4gIFRo
ZXNlIHdpbmRvd3MKY2Fubm90IGJlIGNoYW5nZWQgYW5kIGFkZHJlc3NlcyBhYm92ZSAweDgwMDAw
MDAwIGFyZSBzdGF0aWNhbGx5IG1hcHBlZCBhbmQgYXJlCm9ubHkgYWNjZXNzaWJsZSBieSB0aGUg
a2VybmVsICh0aGlzIGlzIGhhcmR3aXJlZCBpbiB0aGUgTU1VKS4KClNvIHRoZSBhcmNoIGhhcyB0
d28gc3Vid2luZG93cyB0byB0aGUgUENJIGJ1cywgb25lIGNhY2hlZCBhbmQgb25lIHVuY2FjaGVk
LgpUaGVzZSBzdWJ3aW5kb3dzIGFyZSBmdXJ0aGVyIHN1YmRpdmlkZWQgaW50byBpb3BvcnQgYW5k
IGlvbWVtIHNwYWNlcywgYW4gU1JBTQphbmQgc29tZSBjb250cm9sIHJlZ2lzdGVycyBmb3IgdGhl
IENQVS1QQ0kgYnJpZGdlLgoKRGF2aWQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
