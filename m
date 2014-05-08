From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: usb backend needs LED support
Date: Thu, 8 May 2014 09:29:11 +0100
Message-ID: <20140508082911.GA5767@lee--X1>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
 <7208467.nZIXMIfPji@wuerfel>
 <CAPDyKFpJrrviaZo_L8MkLF=v7DqGEVj9=uSNsNtU-FXNwu-MmQ@mail.gmail.com>
 <201404300228.s3U2S7WA026782@rtits1.realtek.com>
 <53606F49.1000401@realtek.com>
 <CAPDyKFrA39eFnoy-sAGcAUeDqtB78cvAivV+mmRR5C-tov-9eg@mail.gmail.com>
 <536B3B6F.1010209@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <536B3B6F.1010209@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Roger <rogerable@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, devel@linuxdriverproject.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

PiA+PkZyb206IFJvZ2VyIFRzZW5nIDxyb2dlcmFibGVAcmVhbHRlay5jb20+Cj4gPj5EYXRlOiBX
ZWQsIDMwIEFwciAyMDE0IDExOjExOjI1ICswODAwCj4gPj5TdWJqZWN0OiBbUEFUQ0hdIG1tYzog
cnRzeDogZml4IHBvc3NpYmxlIGxpbmtpbmcgZXJyb3IgaWYgYnVpbHQtaW4KPiA+Pgo+ID4+cnRz
eF91c2Jfc2RtbWMgbW9kdWxlIHVzZXMgdGhlIExFRCBjbGFzc2RldiBpZiBhdmFpbGFibGUsIGJ1
dCB0aGUgY29kZQo+ID4+ZmFpbGVkCj4gPj50byBjb25zaWRlciB0aGUgc2l0dWF0aW9uIHRoYXQg
aXQgaXMgYnVpbHQtaW4gYW5kIHRoZSBMRUQgY2xhc3NkZXYgaXMgYQo+ID4+bW9kdWxlLAo+ID4+
bGVhZGluZyB0byBmb2xsb3dpbmcgbGlua2luZyBlcnJvcjoKPiA+Pgo+ID4+ICAgTEQgICAgICBp
bml0L2J1aWx0LWluLm8KPiA+PmRyaXZlcnMvYnVpbHQtaW4ubzogSW4gZnVuY3Rpb24gYHJ0c3hf
dXNiX3NkbW1jX2Rydl9yZW1vdmUnOgo+ID4+cnRzeF91c2Jfc2RtbWMuYzooLnRleHQrMHgyYTAx
OGUpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvCj4gPj5gbGVkX2NsYXNzZGV2X3VucmVnaXN0ZXIn
Cj4gPj5kcml2ZXJzL2J1aWx0LWluLm86IEluIGZ1bmN0aW9uIGBydHN4X3VzYl9zZG1tY19kcnZf
cHJvYmUnOgo+ID4+cnRzeF91c2Jfc2RtbWMuYzooLnRleHQrMHgyYTE5N2UpOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvCj4gPj5gbGVkX2NsYXNzZGV2X3JlZ2lzdGVyJwo+ID4+Cj4gPj5GaXggYnkg
ZXhjbHVkaW5nIHN1Y2ggY29uZGl0aW9uIHdoZW4gZGVmaW5pbmcgbWFjcm8gUlRTWF9VU0JfVVNF
X0xFRFNfQ0xBU1MuCj4gPj4KPiA+PlNpZ25lZC1vZmYtYnk6IFJvZ2VyIFRzZW5nIDxyb2dlcmFi
bGVAcmVhbHRlay5jb20+Cj4gPgo+ID5BY2tlZC1ieTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29u
QGxpbmFyby5vcmc+Cj4gCj4gV291bGQgdGhpcyBwYXRjaCBiZSBtZXJnZWQgaW50byBsaW51eC1u
ZXh0IG9yIExlZSdzIG1mZC5naXQKPiBpYi1tZmQtbW1jLW1lbXN0aWNrLTMuMTYgYnJhbmNoPwoK
VGhpcyBwYXRjaCBkb2Vzbid0IGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0aCBNRkQuCgotLSAKTGVl
IEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGluYXJv
Lm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86
IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJv
amVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
