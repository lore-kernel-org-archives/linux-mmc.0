From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] mfd: rtsx: add func to split u32 into register
Date: Fri, 28 Nov 2014 11:54:37 +0300
Message-ID: <20141128085436.GF4911@mwanda>
References: <cover.1417056337.git.micky_ching@realsil.com.cn>
 <51dde5250305623c420e78fa555800ef8fef0a09.1417056337.git.micky_ching@realsil.com.cn>
 <20141127152342.GA4860@mwanda> <5477D99C.3050903@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <5477D99C.3050903@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: =?utf-8?B?5pWs6ZSQ?= <micky_ching@realsil.com.cn>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?B?546L54Kc?= <wei_wang@realsil.com.cn>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "rogerable@realtek.com" <rogerable@realtek.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>
List-Id: linux-mmc@vger.kernel.org

T24gRnJpLCBOb3YgMjgsIDIwMTQgYXQgMDI6MTA6MzZBTSArMDAwMCwg5pWs6ZSQIHdyb3RlOgo+
IGVnLCBpbiBzZF9vcHMuYyB0aGUgY21kLmFyZyBpcyBjb25zdHJ1Y3RlZCBiaXQgYnkgYml0LCB3
ZSBjYW4gcHV0IHRoZSByaWdodAo+IGJ5dGUgdG8gdGhlIHJpZ2h0IHJlZ2lzdGVyIGJ5IHNoaWZ0
LCBzbyB0aGUgZW5kaWFuIGNoZWNrIGlzIG5vdCBuZWVkLgoKSSBsb29rZWQgYXQgZHJpdmVycy9t
bWMvY29yZS9zZF9vcHMuYyBhbmQgY21kLmFyZyBzZWVtcyB0byBiZSBjcHUKZW5kaWFuLgoKVGhl
IG5ldyBmdW5jdGlvbiBhc3N1bWVzIHRoYXQgdGhlIGNwdSBpcyBsaXR0bGUgZW5kaWFuIGFuZCBt
YW51YWxseQpjb252ZXJ0cyBpdCB0byBsaXR0bGUgZW5kaWFuLiAgVGhpcyBpcyBhbiBlbmRpYW4g
YnVnLiAgSSB0aGluayBteSBmaXggaXMKY29ycmVjdCBvciBzb21ldGhpbmcgc2ltaWxhci4KCnJl
Z2FyZHMsCmRhbiBjYXJwZW50ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5v
cmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpdmVyZGV2LWRldmVsCg==
