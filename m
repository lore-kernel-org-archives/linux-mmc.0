From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: atmel-mci: fix incorrect setting of host->data to
 NULL
Date: Mon, 09 Jul 2012 23:18:33 -0400
Message-ID: <87sjd0tiba.fsf@octavius.laptop.org>
References: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
 <4FF6B831.5060005@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FF6B831.5060005@atmel.com> (ludovic desroches's message of
 "Fri, 6 Jul 2012 12:04:33 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "ludovic.desroches" <ludovic.desroches@atmel.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

SGksCgpPbiBGcmksIEp1bCAwNiAyMDEyLCBsdWRvdmljLmRlc3JvY2hlcyB3cm90ZToKPiBMZSAw
Ny8wNi8yMDEyIDExOjU4IEFNLCBOaWNvbGFzIEZlcnJlIGEgw6ljcml0IDoKPj4gU2V0dGluZyBo
b3N0LT5kYXRhIHRvIE5VTEwgaXMgaW5jb3JyZWN0IHNlcXVlbmNlIGluIFNUQVRFX1NFTkRJTkdf
U1RPUAo+PiBzdGF0ZSBvZiBGU006IFRoaXMgZWFybHkgc2V0dGluZyBsZWFkcyB0byB0aGUgc2tp
cCBvZiBkbWFfdW5tYXBfc2coKQo+PiBpbiBhdG1jaV9kbWFfY2xlYW51cCgpIHdoaWNoIGlzIGEg
YnVnLgo+Pgo+PiBJZGVhIHRha2VuIGZvcm0gZHdfbW1jIGJ5IFNldW5nd29uIEplb24uCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAYXRtZWwuY29tPgo+
PiBDYzogU2V1bmd3b24gSmVvbiA8dGdpaC5qdW5Ac2Ftc3VuZy5jb20+Cj4KPiBBY2tlZC1ieTog
THVkb3ZpYyBEZXNyb2NoZXMgPGx1ZG92aWMuZGVzcm9jaGVzQGF0bWVsLmNvbT4KClRoYW5rcywg
cHVzaGVkIHRvIG1tYy1uZXh0IGZvciAzLjYuCgotIENocmlzLgotLSAKQ2hyaXMgQmFsbCAgIDxj
amJAbGFwdG9wLm9yZz4gICA8aHR0cDovL3ByaW50Zi5uZXQvPgpPbmUgTGFwdG9wIFBlciBDaGls
ZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
