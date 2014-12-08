From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/6] mfd: rtsx: add func to split u32 into register
Date: Mon, 8 Dec 2014 13:01:03 +0000
Message-ID: <20141208130103.GM3951@x1>
References: <cover.1417758564.git.micky_ching@realsil.com.cn>
 <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1417758564.git.micky_ching@realsil.com.cn>
 <20141208095746.GG3951@x1>
 <CAPDyKFpt2yT2o159_uX+3RxxpnP=J1SotW58s220SkJSni7PHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpt2yT2o159_uX+3RxxpnP=J1SotW58s220SkJSni7PHw@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

T24gTW9uLCAwOCBEZWMgMjAxNCwgVWxmIEhhbnNzb24gd3JvdGU6Cgo+IE9uIDggRGVjZW1iZXIg
MjAxNCBhdCAxMDo1NywgTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4g
PiBPbiBGcmksIDA1IERlYyAyMDE0LCBtaWNreV9jaGluZ0ByZWFsc2lsLmNvbS5jbiB3cm90ZToK
PiA+PiBGcm9tOiBNaWNreSBDaGluZyA8bWlja3lfY2hpbmdAcmVhbHNpbC5jb20uY24+Cj4gPj4K
PiA+PiBBZGQgaGVscGVyIGZ1bmN0aW9uIHRvIHdyaXRlIHUzMiB0byByZWdpc3RlcnMsIGlmIHdl
IHdhbnQgdG8gcHV0IHUzMgo+ID4+IHZhbHVlIHRvIDQgY29udGludW91cyByZWdpc3RlciwgdGhp
cyBjYW4gaGVscCB1cyByZWR1Y2UgdGVkaW91cyB3b3JrLgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1i
eTogTWlja3kgQ2hpbmcgPG1pY2t5X2NoaW5nQHJlYWxzaWwuY29tLmNuPgo+ID4+IEFja2VkLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+ID4+IC0tLQo+ID4+ICBpbmNsdWRl
L2xpbnV4L21mZC9ydHN4X3BjaS5oIHwgOSArKysrKysrKysKPiA+PiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IEFwcGxpZWQsIHRoYW5rcy4KPiAKPiBMZWUsCj4gCj4g
SSBzdXBwb3NlIHlvdSBxdWV1ZWQgdGhpcyBmb3IgMy4xOT8KPiAKPiBJIGRvbid0IGludGVuZCB0
byBxdWV1ZSBhbnl0aGluZyBtb3JlIGJlZm9yZSB0aGUgbWVyZ2Ugd2luZG93IGFuZCB0aHVzCj4g
dGhlIG1tYyBwYXRjaGVzIGNhbiBsYXRlciBiZSBoYW5kbGVkIHdpdGhvdXQgYW55IGRlcGVuZGVu
Y2UgdG8gbWZkLCBJCj4gZ3Vlc3MhPwoKQWxsIGNvcnJlY3QuCgotLSAKTGVlIEpvbmVzCkxpbmFy
byBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0
cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
dmVyZGV2LWRldmVsCg==
