From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Date: Sun, 4 Mar 2018 19:15:15 +0100 (CET)
Message-ID: <1331293394.179376.1520187315077@email.1und1.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
 <166274019.307112.1520085525833@email.1und1.de>
 <20180304173653.78adac53@naga.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180304173653.78adac53@naga.suse.cz>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Ray Jui <rjui@broadcom.com>, Phil Elwell <phil@raspberrypi.org>, linux-kernel@vger.kernel.org, Stefan Schake <stschake@gmail.com>, Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-arm-kernel@lists.infradead.org, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-mmc@vger.kernel.org

SGkgTWljaGFsLAoKPiBNaWNoYWwgU3VjaMOhbmVrIDxtc3VjaGFuZWtAc3VzZS5kZT4gaGF0IGFt
IDQuIE3DpHJ6IDIwMTggdW0gMTc6MzYgZ2VzY2hyaWViZW46Cj4gCj4gCj4gT24gU2F0LCAzIE1h
ciAyMDE4IDE0OjU4OjQ1ICswMTAwIChDRVQpCj4gU3RlZmFuIFdhaHJlbiA8c3RlZmFuLndhaHJl
bkBpMnNlLmNvbT4gd3JvdGU6Cj4gCj4gPiBJbiBhIGdpdGh1YiBpc3N1ZSwgaSd2ZSByZWFkIHRo
YXQgYmFkYmxvY2tzIGNvdWxkIHJlcHJvZHVjZSB0aGUgaXNzdWUKPiA+IG1vcmUgbGlrZWx5Lgo+
IAo+IEhvdyBtYW55IGl0ZXJhdGlvbnMgb2YgYmFkYmxvY2tzPyBJdCBkb2Ugc25vdCByZXByb2R1
Y2UgdGhlIGlzc3VlIGZvcgo+IG1lLgoKaSBhc2tlZCBmb3IgdGhlIHBhcmFtZXRlcnMgaGVyZToK
Cmh0dHBzOi8vZ2l0aHViLmNvbS9yYXNwYmVycnlwaS9saW51eC9pc3N1ZXMvMjM5MgoKU3RlZmFu
Cgo+IAo+IFRoYW5rcwo+IAo+IE1pY2hhbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
