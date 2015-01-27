From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/2] mmc: host: arasan: Add addition of-arasan quirks
 and IOMMU support for arasan SDHCI driver.
Date: Tue, 27 Jan 2015 21:12:39 +0100
Message-ID: <2889598.XIWjCcRL7e@wuerfel>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1422379260-10139-2-git-send-email-stripathi@apm.com>
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
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com, jcm@redhat.com, anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net, patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

T24gVHVlc2RheSAyNyBKYW51YXJ5IDIwMTUgMjI6NTA6NTkgU3VtYW4gVHJpcGF0aGkgd3JvdGU6
Cj4gQEAgLTE3NCw2ICsxNzYsMTMgQEAgc3RhdGljIGludCBzZGhjaV9hcmFzYW5fcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgICAgICAgIHBsdGZtX2hvc3QtPnByaXYgPSBz
ZGhjaV9hcmFzYW47Cj4gICAgICAgICBwbHRmbV9ob3N0LT5jbGsgPSBjbGtfeGluOwo+IAo+ICsg
ICAgICAgcmV0ID0geGdlbmVfYWhiY19pb21tdV9hdHRhY2hfZGV2aWNlKCZwZGV2LT5kZXYpOwo+
ICsgICAgICAgaWYgKHJldCA8IDAgJiYgSVNfRU5BQkxFRChDT05GSUdfWEdFTkVfQUhCQ19JT01N
VSkpIHsKPiArICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LAo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICJ1bmFibGUgdG8gYXR0YWNoIGRldmljZSB0byBpb21tdSAleFxuIiwgcmV0
KTsKPiArICAgICAgICAgICAgICAgZ290byBjbGtfZGlzYWJsZV9hbGw7Cj4gKyAgICAgICB9Cj4g
Kwo+ICAgICAgICAgcmV0ID0gc2RoY2lfYWRkX2hvc3QoaG9zdCk7Cj4gICAgICAgICBpZiAocmV0
KSB7Cj4gICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgInBsYXRmb3JtIHJlZ2lz
dGVyIGZhaWxlZCAoJXUpXG4iLCByZXQpOwo+IAoKVGhpcyBsb29rcyB3cm9uZzogdGhlIGlvbW11
IHNob3VsZCBiZSBhdXRvbWF0aWNhbGx5IGNvbmZpZ3VyZWQgZm9yIGRldmljZXMKdGhhdCBuZWVk
IGl0LCB3aXRob3V0IGFueSBpbnRlcmFjdGlvbiBmcm9tIHRoZSBkcml2ZXIuCgoJQXJuZApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYg
bWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMu
b3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
