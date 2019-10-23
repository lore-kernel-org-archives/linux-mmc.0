From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 00/36] ARM: samsung platform cleanup
Date: Wed, 23 Oct 2019 15:10:49 +0200
Message-ID: <20191023131049.GG11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20191010202802.1132272-1-arnd@arndb.de>
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
Cc: linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Lihua Yao <ylhuajnu@outlook.com>, Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>, linux-pwm@vger.kernel.org, Sergio Prado <sergio.prado@e-labworks.com>, linux-pm@vger.kernel.org, Lihua Yao <ylhuajnu@163.com>, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

T24gVGh1LCBPY3QgMTAsIDIwMTkgYXQgMTA6Mjg6MDJQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3
cm90ZToKPiBJJ3ZlIHNwZW50IHNvbWUgdGltZSBsb29raW5nIGF0IHRoZSByZW1haW5pbmcgQVJN
djQvQVJNdjUgcGxhdGZvcm1zCj4gdGhhdCBhcmUgbm90IHBhcnQgb2YgQVJDSF9NVUxUSVBMQVRG
T1JNLCBhbmQgdHJpZWQgdG8gZ2V0IHRoZW0gY2xvc2VyCj4gdG8gdGhhdC4gSGVyZSBpcyB3aGF0
IGNhbWUgb3V0IG9mIHRoYXQgZm9yIHRoZSBzYW1zdW5nIHBsYXRmb3JtczoKPiAKPiAqIEV4eW5v
cyBhbmQgczVwdjIxMCBhcmUgbWFkZSBpbmRlcGVuZGVudCBvZiBwbGF0LXNhbXN1bmcKPiAqIGRl
dmljZSBkcml2ZXJzIHN0b3AgdXNpbmcgbWFjaC8qLmggaGVhZGVycyBmb3IgczNjMjR4eAo+ICAg
KGFuZCBvdGhlciBwbGF0Zm9ybXMgbm90IGluIHRoaXMgc2VyaWVzKQo+ICogczNjMjR4eCBhbmQg
czNjNjR4eCBnZXQgbWVyZ2VkIGludG8gbWFjaC1zM2MsIHJlbW92aW5nCj4gICB0aGUgbmVlZCBm
b3IgcGxhdC1zYW1zdW5nIChJIGhhdmUgb3RoZXIgcGF0Y2hlcyBmb3IgdGhlCj4gICByZW1haW5p
bmcgcGxhdC0qIGRpcmVjdG9yaWVzKQo+ICogbWFjaC9pby5oIGdldHMgY2xlYW5lZCB1cCB0byBv
bmx5IGJlIG5lZWRlZCBmb3IgQkFTVAo+ICAgUEMxMDQgbW9kZSAobG9va2luZyBmb3IgaWRlYXMg
dG8gcHJvY2VlZCkKPiAqIG1hY2gvaXJxcy5oIHJlbWFpbnMgZm9yIG5vdywgdGhpcyBzdGlsbCBu
ZWVkcyB0byBiZSBjb252ZXJ0ZWQKPiAgIHRvIHNwYXJzZSBJUlFzLgo+IAo+IFNvbWUgYml0cyBh
cmUgYSBsaXR0bGUgdWdseSwgYnV0IG92ZXJhbGwgSSB0aGluayB0aGlzIGEgYmlnCj4gaW1wcm92
ZW1lbnQuCj4gCj4gVGhlIGNvbnRlbnRzIGFyZSBhdmFpbGFibGUgZm9yIHRlc3RpbmcgaW4KPiAK
PiBnaXQ6Ly9rZXJuZWwub3JnOi9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJuZC9wbGF5Z3Jv
dW5kLmdpdCBzM2MtbXVsdGlwbGF0Zm9ybQoKV2hlbiBzZW5kaW5nIHYyLCBjYW4geW91IENjOgoK
UGF3ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgpMaWh1YSBZYW8g
PHlsaHVham51QG91dGxvb2suY29tPgoob3IgTGlodWEgWWFvIDx5bGh1YWpudUAxNjMuY29tPiBp
ZiBvdXRsb29rLmNvbSBib3VuY2VzKQpTZXJnaW8gUHJhZG8gPHNlcmdpby5wcmFkb0BlLWxhYndv
cmtzLmNvbT4KU3lsd2VzdGVyIE5hd3JvY2tpIDxzLm5hd3JvY2tpQHNhbXN1bmcuY29tPgoKVGhl
c2UgYXJlIGZvbGtzIHdoaWNoIHRvIG15IGtub3dsZWRnZSBoYWQgd29ya2luZyBTM0MgYW5kIFM1
UCBib2FyZHMKc28gbWF5YmUgdGhleSBjb3VsZCBwcm92aWRlIHRlc3RpbmcuCgpCZXN0IHJlZ2Fy
ZHMsCktyenlzenRvZgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVs
