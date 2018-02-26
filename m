From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Date: Mon, 26 Feb 2018 17:14:26 +0000
Message-ID: <1519665265.31245.6.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
         <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
         <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
         <1519658060.31245.4.camel@synopsys.com>
         <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
Content-Language: en-US
Content-ID: <CCD185991A9D7A469EF6B385638C80C0@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "dianders@chromium.org" <dianders@chromium.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

T24gTW9uLCAyMDE4LTAyLTI2IGF0IDE4OjUzICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI2LCAyMDE4IGF0IDU6MTQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPEV2
Z2VuaXkuRGlkaW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTgtMDItMjYg
YXQgMTY6MzkgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+IE9uIE1vbiwgRmVi
IDI2LCAyMDE4IGF0IDQ6MzQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPiA+IDxFdmdlbml5LkRpZGlu
QHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPiA+IEluIGNvbW1pdCA0YzIzNTdmNTdkZDUgKCJt
bWM6IGR3X21tYzogRml4IHRoZSBDVE8gdGltZW91dCBjYWxjdWxhdGlvbiIpDQo+ID4gPiA+IGhh
dmUgYmVlbiBtYWRlIGNoYW5nZXMgd2hpY2ggY2FuIGNhdXNlIG11bHRpcGx5IG92ZXJmbG93IGZv
ciAzMi1iaXQgc3lzdGVtcy4NCj4gPiA+ID4gVGhlIHZhbHVlIG9mIGN0b19tcyBpcyBsb3dlciB0
aGUgZHJ0b19tcywgYnV0IG5ldmVydGhlbGVzcyBvdmVyZmxvdyBjYW4gb2NjdXIuDQo+ID4gPiA+
IExldHMgY2FzdCB0aGlzIG11bHRpcGx5IHRvIHU2NCB0eXBlIHdoaWNoIHByZXZlbnRzIG92ZXJm
bG93Lg0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqBjdG9fbXMgPSBESVZfUk9VTkRfVVAoTVNFQ19Q
RVJfU0VDICogY3RvX2Nsa3MgKiBjdG9fZGl2LCBob3N0LT5idXNfaHopOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGN0b19tcyA9IERJVl9ST1VORF9VUCgodTY0KU1TRUNfUEVS
X1NFQyAqIGN0b19jbGtzICogY3RvX2RpdiwgaG9zdC0+YnVzX2h6KTsNCj4gPiA+IA0KPiA+ID4g
SUlSQywgc29tZW9uZSBjb21tZW50ZWQgb24gdGhpcyBvciBzaW1pbGFyLCBpLmUuDQo+ID4gPiAN
Cj4gPiA+IERJVl9ST1VORF9VUF9VTEwoKSA/DQo+ID4gDQo+ID4gU3dpdGNoIERJVl9ST1VORF9V
UCBtYWNybyB0byBESVZfUk9VTkRfVVBfVUxMIGlzIG5vdCByZWFzb25hYmxlDQo+ID4gYmVjYXVz
ZSBvdmVyZmxvdyBoYXBwZW5zIG9uIG11bHRpcGx5IGFuZCBESVZfUk9VTkRfVVBfVUxMIGhlbHBz
DQo+ID4gd2l0aCBzdW0gb3ZlcmZsb3cuDQo+IA0KPiBEaWQgeW91IHRyeSB0byBjb21waWxlIHlv
dXIgY29kZSBmb3IgMzItYml0IHRhcmdldD8NClllcywgd2UgaGF2ZSBjb21waWxlZCBjb2RlIGZv
ciAzMi1iaXQgc3lzdGVtLsKgDQpJIGFtIHdvbmRlcmluZyB3aHkgYXJlIHlvdSBhc2tpbmcgdGhh
dD8NCg0KLS0NCkJlc3QgcmVnYXJkcywNCkV2Z2VuaXkgRGlkaW4=
