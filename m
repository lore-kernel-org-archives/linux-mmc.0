From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 08:29:44 -0700
Message-ID: <20160825152944.GP16583@xsjsorenbubuntu>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825151047.GO16583@xsjsorenbubuntu>
 <d5dd97b1-f58f-2e45-5c95-17a77a46b30c@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d5dd97b1-f58f-2e45-5c95-17a77a46b30c@metafoo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, Zach Brown <zach.brown@ni.com>
List-Id: linux-mmc@vger.kernel.org

T24gVGh1LCAyMDE2LTA4LTI1IGF0IDE3OjIzOjQ3ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4g
d3JvdGU6Cj4gT24gMDgvMjUvMjAxNiAwNToxMCBQTSwgU8O2cmVuIEJyaW5rbWFubiB3cm90ZToK
PiA+IE9uIFdlZCwgMjAxNi0wOC0yNCBhdCAxODoyMzowMyAtMDUwMCwgWmFjaCBCcm93biB3cm90
ZToKPiA+PiBUaGUgc2RoY2kgY29udHJvbGxlciBvbiB4aWxpbnggenlucSBkZXZpY2VzIHdpbGwg
bm90IGZ1bmN0aW9uIHVubGVzcwo+ID4+IHRoZSBjZCBiaXQgaXMgcHJvdmlkZWQuIGh0dHA6Ly93
d3cueGlsaW54LmNvbS9zdXBwb3J0L2Fuc3dlcnMvNjEwNjQuaHRtbAo+ID4+IEluIGNhc2VzIHdo
ZXJlIGl0IGlzIGltcG9zc2libGUgdG8gcHJvdmlkZSB0aGUgY2QgYml0IGluIGhhcmR3YXJlLAo+
ID4+IHNldHRpbmcgdGhlIGNvbnRyb2xsZXIgdG8gdGVzdCBtb2RlIGFuZCB0aGVuIHNldHRpbmcg
aW5zZXJ0ZWQgdG8gdHJ1ZQo+ID4+IHdpbGwgZ2V0IHRoZSBjb250cm9sbGVyIHRvIGZ1bmN0aW9u
IHdpdGggb3V0IHRoZSBjZCBiaXQuCj4gPj4KPiA+PiBUaGUgZGV2aWNlIHByb3BlcnR5ICJmYWtl
LWNkIiB3aWxsIGxldCB0aGUgYXJhc2FuIGRyaXZlciBrbm93IGl0IG5lZWRzCj4gPj4gdG8gZmFr
ZSB0aGUgY2QgYml0IGZvciB0aGUgY29udHJvbGxlciBpbm9yZGVyIGZvciB0aGUgY29udHJvbGxl
ciB0bwo+ID4+IGZ1bmN0aW9uIHdpdGggYSBTRCBjYXJkIHRoYXQgZG9lcyBub3QgcHJvdmlkZSB0
aGUgQ0QgYml0Lgo+ID4gCj4gPiBJIHRob3VnaHQgdGhlIENEIGlzLCBpZiBub3QgcGlubmVkIG91
dCwgdGllZCBvZmYgdG8gc29tZSB2YWxpZCBsb2dpYwo+ID4gbGV2ZWwuIElzbid0IGl0IGVub3Vn
aCB0byBzcGVjaWZ5IGNkLWludmVydGVkIGlmIG5lZWRlZCB0byBtYWtlIGl0IHdvcmsKPiA+IGlu
IHRob3NlIGNhc2VzPwo+IAo+IEl0IGlzIGFsd2F5cyBicm91Z2h0IG91dCB0byBzb21lIHBpbiwg
dGhhdCBpcyB0aGUgcHJvYmxlbSBvbiB0aGUgWnlucS4gVGhpcwo+IG1lYW5zIHlvdSdkIGhhdmUg
dG8gc2V0IGF0IGxlYXN0IG9uZSBwaW4gYXNpZGUgYXMgZHVtbXkgQ0Qgb3IgV1AgcGluLiBXaGlj
aAo+IGlzIG5vdCBhbHdheXMgcG9zc2libGUgd2hlbiB5b3UgYXJlIHRpZ2h0IG9uIGF2YWlsYWJs
ZSBwaW5zLgoKSSBoYXZlIHRvIGFkbWl0IHRoYXQgSSBoYXZlbid0IGxvb2tlZCBhdCBWaXZhZG8g
Zm9yIHF1aXRlIGEgd2hpbGUuIElzIGl0CnBvc3NpYmxlIHRvIHNlbGVjdCBFTUlPIGZvciB0aG9z
ZSBwaW5zPyBJZiB0aG9zZSBhcmUgbm90IHJvdXRlZCBhbnl0aGluZwp0aGV5IHNob3VsZCBiZSB0
aWVkIHRvIHNvbWUgbG9naWMgbGV2ZWwsIEkgYmVsaWV2ZS4KSWYgdGhleSBhcmUgYWx3YXlzIGZv
cmNlZCB0byBiZSBvbiBhIHBoeXNpY2FsIHBpbiwgZG8geW91IGxldCB0aGF0IHBpbgpqdXN0IGZs
b2F0PyBPdGhlcndpc2UsIHRoZSBsb2dpYyBsZXZlbCBzaG91bGQgYWxzbyBiZSBkZWZpbmVkLCBn
aXZlIGFuZAp0YWtlIGEgbG9naWMgaW52ZXJzaW9uLgoKCVPDtnJlbgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
