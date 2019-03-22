From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 0/7] mmc: Several fixes for bcm2835 driver
Date: Fri, 22 Mar 2019 15:45:13 +0100
Message-ID: <1ff03f96-2575-f65e-c96e-6dc52de00c3a@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
 <20190321210307.58e33ea4@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190321210307.58e33ea4@kitsune.suse.cz>
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
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Phil Elwell <phil@raspberrypi.org>, linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

SGkgTWljaGFsLAoKQW0gMjEuMDMuMTkgdW0gMjE6MDMgc2NocmllYiBNaWNoYWwgU3VjaMOhbmVr
Ogo+IE9uIFN1biwgMTEgTm92IDIwMTggMjE6MjM6NTIgKzAxMDAKPiBTdGVmYW4gV2FocmVuIDxz
dGVmYW4ud2FocmVuQGkyc2UuY29tPiB3cm90ZToKPgo+PiBUaGlzIHBhdGNoIHNlcmllcyBmaXhl
cyBzZXZlcmFsIGlzc3VlcyB3aGljaCBoYXMgYmVlbiBkaXNjb3ZlcmVkIGFmdGVyCj4+IHN1Ym1p
c3Npb24uCj4+Cj4+IENoYW5nZXMgaW4gVjI6Cj4+IC0gYWRkIG15IG93biBzaWduZWQtb2ZmLWJ5
IHRvIHBhdGNoZXMgIzEgYW5kICMyCj4+Cj4+IE1pY2hhbCBTdWNoYW5layAoMSk6Cj4+ICAgbW1j
OiBiY20yODM1OiByZXNldCBob3N0IG9uIHRpbWVvdXQKPj4KPj4gUGhpbCBFbHdlbGwgKDEpOgo+
PiAgIG1tYzogYmNtMjgzNTogUmVjb3ZlciBmcm9tIE1NQ19TRU5EX0VYVF9DU0QKPj4KPj4gU3Rl
ZmFuIFdhaHJlbiAoNSk6Cj4+ICAgbW1jOiBiY20yODM1OiBSZWxlYXNlIERNQSBjaGFubmVsIG9u
IGRyaXZlciB1bmxvYWQKPj4gICBtbWM6IGJjbTI4MzU6IEF2b2lkIHBvc3NpYmxlIHJhY2VzIG9u
IGRhdGEgcmVxdWVzdHMKPj4gICBtbWM6IGJjbTI4MzU6IFRlcm1pbmF0ZSB0aW1lb3V0IHdvcmsg
c3luY2hyb25vdXNseQo+PiAgIG1tYzogYmNtMjgzNTogUmVmYWN0b3IgZG1hX21hcF9zZyBoYW5k
bGluZwo+PiAgIG1tYzogYmNtMjgzNTogUHJvcGVybHkgaGFuZGxlIGRtYWVuZ2luZV9wcmVwX3Ns
YXZlX3NnCj4+Cj4+ICBkcml2ZXJzL21tYy9ob3N0L2JjbTI4MzUuYyB8IDU4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAz
OCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPj4KPiBIZWxsbywKPgo+IHRoYW5rcyBm
b3IgdGhlIHBhdGNoZXMuCj4KPiBJIHRyaWVkIHRvIHJlcGxhY2UgdGhlIGJjbTI4MzUgc2Rob3N0
IGRyaXZlciBpbiBteSA0LjQga2VybmVsIHdpdGggdGhlCj4gdXBzdHJlYW0gZHJpdmVyICsgdGhl
c2UgdXBkYXRlcyBidXQgdGhlIDE2R0Igb3JhbmdlIEVWTyBjYXJkIHN0aWxsCj4gbG9ja3MgdXAg
dGhlIG1tYyBjb250cm9sbGVyLiBJdCBzZWVtcyBpdCBsb2NrcyB1cCBtdWNoIGxlc3MgYnV0IGlz
Cj4gY2VydGFpbmx5IG5vdCBzb2xpZC4KCmNvdWxkIHlvdSBwbGVhc2UgcmV0cnkgd2l0aCBtYWlu
bGluZSBrZXJuZWwgNS4wPwoKTWF5YmUgdGhpcyBpcyByZWxhdGVkOgoKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXJwaS1rZXJuZWwvMjAxOS1GZWJydWFyeS8wMDg1
NDIuaHRtbAoKPgo+IFRoYW5rcwo+Cj4gTWljaGFsCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
