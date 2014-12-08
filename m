From: =?utf-8?B?5pWs6ZSQ?= <micky_ching@realsil.com.cn>
Subject: Re: [PATCH v4 1/6] mfd: rtsx: add func to split u32 into register
Date: Mon, 8 Dec 2014 09:59:04 +0000
Message-ID: <54857668.4040902@realsil.com.cn>
References: <cover.1417758564.git.micky_ching@realsil.com.cn>
 <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1417758564.git.micky_ching@realsil.com.cn>
 <20141208084941.GC3951@x1> <54857429.5060108@realsil.com.cn>
 <20141208095719.GF3951@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20141208095719.GF3951@x1>
Content-Language: zh-CN
Content-ID: <42C28E244E978A46B8E5E4D4AF9914B0@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, =?utf-8?B?546L54Kc?= <wei_wang@realsil.com.cn>, "rogerable@realtek.com" <rogerable@realtek.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

DQpPbiAxMi8wOC8yMDE0IDA1OjU3IFBNLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9uIE1vbiwgMDgg
RGVjIDIwMTQsIOaVrOmUkCB3cm90ZToNCj4NCj4+IE9uIDEyLzA4LzIwMTQgMDQ6NDkgUE0sIExl
ZSBKb25lcyB3cm90ZToNCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWZkL3J0c3hf
cGNpLmggYi9pbmNsdWRlL2xpbnV4L21mZC9ydHN4X3BjaS5oDQo+Pj4+PiBpbmRleCA3NDM0NmQ1
Li45MjM0NDQ5IDEwMDY0NA0KPj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvcnRzeF9wY2ku
aA0KPj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvcnRzeF9wY2kuaA0KPj4+Pj4gQEAgLTU1
OCw2ICs1NTgsNyBAQA0KPj4+Pj4gICAjZGVmaW5lIFNEX1NBTVBMRV9QT0lOVF9DVEwJCTB4RkRB
Nw0KPj4+Pj4gICAjZGVmaW5lIFNEX1BVU0hfUE9JTlRfQ1RMCQkweEZEQTgNCj4+Pj4+ICAgI2Rl
ZmluZSBTRF9DTUQwCQkJCTB4RkRBOQ0KPj4+Pj4gKyNkZWZpbmUgICBTRF9DTURfU1RBUlQJCQkw
eDQwDQo+Pj4gVGhpcyBpcyBhIGRpZmZlcmVudCBmb3JtYXQgYXQgdGhlIG90aGVycyBpbiB0aGUg
Z3JvdXAgb24gdHdvIGNvdW50czsNCj4+PiBmaXJzdGx5IHlvdSBoYXZlIDMgd2hpdGVzcGFjZSBj
aGFyYWN0ZXJzIGFmdGVyIHRoZSAjZGVmaW5lIGFuZA0KPj4+IHNlY29uZGx5IGFsbCBvZiB0aGUg
b3RoZXIgaGV4IGRpZ2l0cyBpbiB0aGUgc2V0IGFyZSA0IGEgYnJlYXN0Lg0KPj4+IFBsZWFzZSBh
ZGQgdGhlIGxlYWRpbmcgemVyb3MgdG8gY29uZm9ybSB0byB0aGlzIGZvcm1hdC4NCj4+Pg0KPj4g
SGkgbGVlLA0KPj4NCj4+IFRoaXMgZm9ybWF0IGlzIG1vcmUgcmVhZGFibGUsIGFkZCAyIHNwYWNl
IG1lYW5zIHRoaXMgdmFsdWUgaXMNCj4+IGluIGdyb3VwcyB1bmRlciByZWdpc3RlciBTRF9DTUQw
LCBhbmQgZWFjaCByZWdpc3RlciB2YWx1ZSBpcyB1OCB0eXBlLA0KPj4gc28gdXNlIDIgaGV4IGRp
Z2l0cyBpcyByaWdodC4NCj4+DQo+PiBUaGUgb3JpZ2luYWwgZmlsZSBtYWtlIHJlZ2lzdGVyIGFk
ZHJlc3MgYW5kIGl0cyByZWxhdGVkIHZhbHVlIHNlcGFyYXRlZCwNCj4+IGFuZCBncm91cCByZWdp
c3RlciB0b2dldGhlci4NCj4+DQo+PiBCdXQgSSBsaWtlIHRvIHdyaXRlIHJlZ2lzdGVyIGFkZHJl
c3MgYW5kIHZhbHVlIHRvZ2V0aGVyLA0KPj4gYWRkIDIgc3BhY2UgZm9yIHZhbHVlIHRvIGluZGlj
YXRlIHRoaXMgdmFsdWUgaXMgcmVsYXRlZCB0byBhYm92ZSByZWdpc3Rlci4NCj4+DQo+PiBJZiB3
ZSBhZGQgbmV3IGFkZHJlc3MvdmFsdWUsIEkgcmVjb21tZW5kIHdyaXRlIHJlZ2lzdGVyIGRlZmlu
ZSBmb3JtYXQgYXMNCj4+IGJlbG93Og0KPj4NCj4+ICNkZWZpbmUgUkVHSVNURVIgICAgICAgIGFk
ZHINCj4+ICNkZWZpbmUgICBSRUdfVkFMMSAgICAgIHZhbDENCj4+ICNkZWZpbmUgICBSRUdfVkFM
MiAgICAgIHZhbDINCj4gT2theSwgSSBzZWUgdGhhdCB0aGVyZSBhcmUgb3RoZXIgb2NjdXJyZW5j
ZXMgdXNpbmcgdGhpcyBmb3JtYXQgaW4gdGhhdA0KPiBmaWxlLiAgUGxlYXNlIGNvbnNpZGVyIGNv
bnZlcnRpbmcgdGhlIGVudGlyZSBmaWxlIGludG8gdGhpcyBmb3JtYXQuICBJDQo+IGRvbid0IG1p
bmQgaXQgZWl0aGVyIHdheSwgYnV0IGl0IGxvb2tzIG9kZCBpZiB0aGV5IGFyZSBtaXhlZC4NCj4N
CndlIHdpbGwgcmVmb3JtYXQgaXQgaW4gdGhlIG5lYXIgZnV0dXJlLg0KDQpyZWdhcmRzLg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51
eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
