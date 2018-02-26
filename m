From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Date: Mon, 26 Feb 2018 15:14:21 +0000
Message-ID: <1519658060.31245.4.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
 <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
Content-Language: en-US
Content-ID: <FEEEA117F9F34B4FA13761F6BF868230@internal.synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "dianders@chromium.org" <dianders@chromium.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

T24gTW9uLCAyMDE4LTAyLTI2IGF0IDE2OjM5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI2LCAyMDE4IGF0IDQ6MzQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPEV2
Z2VuaXkuRGlkaW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBJbiBjb21taXQgNGMyMzU3ZjU3
ZGQ1ICgibW1jOiBkd19tbWM6IEZpeCB0aGUgQ1RPIHRpbWVvdXQgY2FsY3VsYXRpb24iKQ0KPiA+
IGhhdmUgYmVlbiBtYWRlIGNoYW5nZXMgd2hpY2ggY2FuIGNhdXNlIG11bHRpcGx5IG92ZXJmbG93
IGZvciAzMi1iaXQgc3lzdGVtcy4NCj4gPiBUaGUgdmFsdWUgb2YgY3RvX21zIGlzIGxvd2VyIHRo
ZSBkcnRvX21zLCBidXQgbmV2ZXJ0aGVsZXNzIG92ZXJmbG93IGNhbiBvY2N1ci4NCj4gPiBMZXRz
IGNhc3QgdGhpcyBtdWx0aXBseSB0byB1NjQgdHlwZSB3aGljaCBwcmV2ZW50cyBvdmVyZmxvdy4N
Cj4gPiAtwqDCoMKgwqDCoMKgwqBjdG9fbXMgPSBESVZfUk9VTkRfVVAoTVNFQ19QRVJfU0VDICog
Y3RvX2Nsa3MgKiBjdG9fZGl2LCBob3N0LT5idXNfaHopOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqBjdG9fbXMgPSBESVZfUk9VTkRfVVAoKHU2NClNU0VDX1BFUl9TRUMgKiBjdG9fY2xrcyAq
IGN0b19kaXYsIGhvc3QtPmJ1c19oeik7DQo+IA0KPiBJSVJDLCBzb21lb25lIGNvbW1lbnRlZCBv
biB0aGlzIG9yIHNpbWlsYXIsIGkuZS4NCj4gDQo+IERJVl9ST1VORF9VUF9VTEwoKSA/DQpTd2l0
Y2ggRElWX1JPVU5EX1VQIG1hY3JvIHRvIERJVl9ST1VORF9VUF9VTEwgaXMgbm90IHJlYXNvbmFi
bGUNCmJlY2F1c2Ugb3ZlcmZsb3cgaGFwcGVucyBvbiBtdWx0aXBseSBhbmQgRElWX1JPVU5EX1VQ
X1VMTCBoZWxwcw0Kd2l0aCBzdW0gb3ZlcmZsb3cuDQoNCi0tDQpCZXN0IHJlZ2FyZHMsDQpFdmdl
bml5IERpZGluCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LXNucHMtYXJjIG1haWxpbmcgbGlzdApsaW51eC1zbnBzLWFyY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
c25wcy1hcmM=
