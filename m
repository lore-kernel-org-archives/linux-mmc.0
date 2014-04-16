From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 1/4] [v6 fix] mfd/rtsx_usb: fix possible race condition
Date: Wed, 16 Apr 2014 11:39:30 +0100
Message-ID: <20140416103930.GN4754@lee--X1>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
 <1397199203-2235-2-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1397199203-2235-2-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: rogerable@realtek.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Andrew Morton <akpm@linux-foundation.org>, Oliver Neukum <oneukum@suse.de>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

PiBGcm9tOiBSb2dlciBUc2VuZyA8cm9nZXJhYmxlQHJlYWx0ZWsuY29tPgo+IAo+IEZpeCB0d28g
cG9zc2libGUgcmFjZSBjb25kaXRpb24gZ2VuZXJhdGVkIGJ5IG1pc3VzZSBvZiBkZWxfdGltZXIg
aW4KPiBydHN4X3VzYl9idWxrX3RyYW5zZmVyX3NnbGlzdCgpIGFuZCB1bmluaXRpYWxpemVkIHRp
bWVycyBiZWZvcmUgbWZkX2FkZF9kZXZpY2VzCj4gaW4gcnRzeF91c2JfcHJvYmUoKS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBSb2dlciBUc2VuZyA8cm9nZXJhYmxlQHJlYWx0ZWsuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL21mZC9ydHN4X3VzYi5jIHwgOCArKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKQXBwbGllZCwgdGhhbmtzLgoKLS0gCkxl
ZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJv
OiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnBy
b2plY3Qub3JnCmh0dHA6Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaXZlcmRldi1kZXZlbAo=
