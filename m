From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Tue, 26 May 2015 14:36:49 +0200
Message-ID: <CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
 <1432197817-22110-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1432197817-22110-3-git-send-email-stripathi@apm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Suman Tripathi <stripathi@apm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

T24gMjEgTWF5IDIwMTUgYXQgMTA6NDMsIFN1bWFuIFRyaXBhdGhpIDxzdHJpcGF0aGlAYXBtLmNv
bT4gd3JvdGU6Cj4gVGhlIHNkaGNpIGZyYW1ld29yayBkaXNhYmxlcyBTRFIxMDQvU0RSNTAvRERS
NTAgYmFzZWQgb24gb25seSBxdWlyay4KPiBUaGlzIHBhdGNoIGFkZHMgdGhlIHN1cHBvcnQgdG8g
ZGlzYWJsZSBTRFIxMDQvU0RSNTAvRERSNTAgYmFzZWQgb24KPiByZWFkaW5nIHRoZSBjYXBhYmls
aXR5IHJlZ2lzdGVyIDAuCj4KPiBTaWduZWQtb2ZmLWJ5OiBTdW1hbiBUcmlwYXRoaSA8c3RyaXBh
dGhpQGFwbS5jb20+Cj4gLS0tCj4gLS0tCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8IDMg
KystCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLmMKPiBpbmRleCA1OGMxNzcwLi5hM2Q5YjhhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kuYwo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwo+IEBAIC0z
MTE4LDcgKzMxMTgsOCBAQCBpbnQgc2RoY2lfYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QpCj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPgo+IC0gICAgICAgaWYgKGhvc3Qt
PnF1aXJrczIgJiBTREhDSV9RVUlSSzJfTk9fMV84X1YpCj4gKyAgICAgICBpZiAoaG9zdC0+cXVp
cmtzMiAmIFNESENJX1FVSVJLMl9OT18xXzhfViB8fAo+ICsgICAgICAgICAgICEoY2Fwc1swXSAm
IFNESENJX0NBTl9WRERfMTgwKSkKPiAgICAgICAgICAgICAgICAgY2Fwc1sxXSAmPSB+KFNESENJ
X1NVUFBPUlRfU0RSMTA0IHwgU0RIQ0lfU1VQUE9SVF9TRFI1MCB8Cj4gICAgICAgICAgICAgICAg
ICAgICAgICBTREhDSV9TVVBQT1JUX0REUjUwKTsKPgo+IC0tCj4gMS44LjIuMQo+CgpJIGhhdmUg
bm8gcHJvYmxlbSB3aXRoIHRoaXMgcGF0Y2gsIGV4Y2VwdCB0aGF0IGl0IHdvdWxkIGJlIG5pY2Ug
dG8gZ2V0CmEgZmV3ICJ0ZXN0ZWQgYnkiIHRvIG1ha2Ugc3VyZSBpdCBkb2Vzbid0IGJyZWFrIFVI
UyBzdXBwb3J0IGZvciBzb21lClNvQ3MuCgpLaW5kIHJlZ2FyZHMKVWZmZQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBs
aXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9y
Zy9saXN0aW5mby9saW51eHBwYy1kZXY=
