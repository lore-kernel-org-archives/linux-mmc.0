From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 17:23:47 +0200
Message-ID: <d5dd97b1-f58f-2e45-5c95-17a77a46b30c@metafoo.de>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825151047.GO16583@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160825151047.GO16583@xsjsorenbubuntu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Zach Brown <zach.brown@ni.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

T24gMDgvMjUvMjAxNiAwNToxMCBQTSwgU8O2cmVuIEJyaW5rbWFubiB3cm90ZToKPiBPbiBXZWQs
IDIwMTYtMDgtMjQgYXQgMTg6MjM6MDMgLTA1MDAsIFphY2ggQnJvd24gd3JvdGU6Cj4+IFRoZSBz
ZGhjaSBjb250cm9sbGVyIG9uIHhpbGlueCB6eW5xIGRldmljZXMgd2lsbCBub3QgZnVuY3Rpb24g
dW5sZXNzCj4+IHRoZSBjZCBiaXQgaXMgcHJvdmlkZWQuIGh0dHA6Ly93d3cueGlsaW54LmNvbS9z
dXBwb3J0L2Fuc3dlcnMvNjEwNjQuaHRtbAo+PiBJbiBjYXNlcyB3aGVyZSBpdCBpcyBpbXBvc3Np
YmxlIHRvIHByb3ZpZGUgdGhlIGNkIGJpdCBpbiBoYXJkd2FyZSwKPj4gc2V0dGluZyB0aGUgY29u
dHJvbGxlciB0byB0ZXN0IG1vZGUgYW5kIHRoZW4gc2V0dGluZyBpbnNlcnRlZCB0byB0cnVlCj4+
IHdpbGwgZ2V0IHRoZSBjb250cm9sbGVyIHRvIGZ1bmN0aW9uIHdpdGggb3V0IHRoZSBjZCBiaXQu
Cj4+Cj4+IFRoZSBkZXZpY2UgcHJvcGVydHkgImZha2UtY2QiIHdpbGwgbGV0IHRoZSBhcmFzYW4g
ZHJpdmVyIGtub3cgaXQgbmVlZHMKPj4gdG8gZmFrZSB0aGUgY2QgYml0IGZvciB0aGUgY29udHJv
bGxlciBpbm9yZGVyIGZvciB0aGUgY29udHJvbGxlciB0bwo+PiBmdW5jdGlvbiB3aXRoIGEgU0Qg
Y2FyZCB0aGF0IGRvZXMgbm90IHByb3ZpZGUgdGhlIENEIGJpdC4KPiAKPiBJIHRob3VnaHQgdGhl
IENEIGlzLCBpZiBub3QgcGlubmVkIG91dCwgdGllZCBvZmYgdG8gc29tZSB2YWxpZCBsb2dpYwo+
IGxldmVsLiBJc24ndCBpdCBlbm91Z2ggdG8gc3BlY2lmeSBjZC1pbnZlcnRlZCBpZiBuZWVkZWQg
dG8gbWFrZSBpdCB3b3JrCj4gaW4gdGhvc2UgY2FzZXM/CgpJdCBpcyBhbHdheXMgYnJvdWdodCBv
dXQgdG8gc29tZSBwaW4sIHRoYXQgaXMgdGhlIHByb2JsZW0gb24gdGhlIFp5bnEuIFRoaXMKbWVh
bnMgeW91J2QgaGF2ZSB0byBzZXQgYXQgbGVhc3Qgb25lIHBpbiBhc2lkZSBhcyBkdW1teSBDRCBv
ciBXUCBwaW4uIFdoaWNoCmlzIG5vdCBhbHdheXMgcG9zc2libGUgd2hlbiB5b3UgYXJlIHRpZ2h0
IG9uIGF2YWlsYWJsZSBwaW5zLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
