From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Tue, 26 May 2015 16:37:22 +0530
Message-ID: <CAOHikRC7p+wzgHXbEYkK56dJucahf6rk=x0sphQedtSKV0N0xQ@mail.gmail.com>
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
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Suman Tripathi <stripathi@apm.com>, Jon Masters <jcm@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

T24gVGh1LCBNYXkgMjEsIDIwMTUgYXQgMjoxMyBQTSwgU3VtYW4gVHJpcGF0aGkgPHN0cmlwYXRo
aUBhcG0uY29tPiB3cm90ZToKPiBUaGUgc2RoY2kgZnJhbWV3b3JrIGRpc2FibGVzIFNEUjEwNC9T
RFI1MC9ERFI1MCBiYXNlZCBvbiBvbmx5IHF1aXJrLgo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgc3Vw
cG9ydCB0byBkaXNhYmxlIFNEUjEwNC9TRFI1MC9ERFI1MCBiYXNlZCBvbgo+IHJlYWRpbmcgdGhl
IGNhcGFiaWxpdHkgcmVnaXN0ZXIgMC4KPgo+IFNpZ25lZC1vZmYtYnk6IFN1bWFuIFRyaXBhdGhp
IDxzdHJpcGF0aGlAYXBtLmNvbT4KPiAtLS0KPiAtLS0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jIHwgMyArKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kuYwo+IGluZGV4IDU4YzE3NzAuLmEzZDliOGEgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
Cj4gQEAgLTMxMTgsNyArMzExOCw4IEBAIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCkKPiAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgfQo+Cj4gLSAgICAgICBp
ZiAoaG9zdC0+cXVpcmtzMiAmIFNESENJX1FVSVJLMl9OT18xXzhfVikKPiArICAgICAgIGlmICho
b3N0LT5xdWlya3MyICYgU0RIQ0lfUVVJUksyX05PXzFfOF9WIHx8Cj4gKyAgICAgICAgICAgIShj
YXBzWzBdICYgU0RIQ0lfQ0FOX1ZERF8xODApKQo+ICAgICAgICAgICAgICAgICBjYXBzWzFdICY9
IH4oU0RIQ0lfU1VQUE9SVF9TRFIxMDQgfCBTREhDSV9TVVBQT1JUX1NEUjUwIHwKPiAgICAgICAg
ICAgICAgICAgICAgICAgIFNESENJX1NVUFBPUlRfRERSNTApOwo+Cj4gLS0KPiAxLjguMi4xCj4K
CkFueSBjb21tZW50cyBvbiB0aGlzIHBhdGNoID8KCgotLSAKVGhhbmtzLAp3aXRoIHJlZ2FyZHMs
ClN1bWFuIFRyaXBhdGhpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFi
cy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
