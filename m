From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/4] qxl: read monitors config at boot
Date: Wed,  8 Mar 2017 10:19:06 +0100
Message-ID: <1488964751-22763-7-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-rpi-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Gerd Hoffmann <kraxel@redhat.com>, stefan.wahren@i2se.com, f.fainelli@gmail.com, lee@kernel.org, linux@armlinux.org.uk, bcm-kernel-feedback-list@broadcom.com, Dave Airlie <airlied@redhat.com>, devicetree@vger.kernel.org, rjui@broadcom.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

VHJ5IHRvIHJlYWQgdGhlIGNsaWVudCBtb25pdG9ycyBjb25maWcgYXQgZHJpdmVyIGxvYWQgdGlt
ZSwgZXZlbiB3aXRob3V0CmV4cGxpY2l0IG5vdGlmaWNhdGlvbi4gIFNvIGluIGNhc2UgdGhhdCBp
bmZvIHdhcyBmaWxsZWQgYmVmb3JlIHRoZSBkcml2ZXIKbG9hZGVkIGFuZCB3ZSd2ZSBtaXNzZWQg
dGhlIG5vdGlmaWNhdGlvbnMgYmVjYXVzZSBvZiB0aGF0IHRoZSBzZXR0aW5ncwp3aWxsIHN0aWxs
IGJlIHVzZWQuCgpXaXRoIHRoYXQgcGxhY2Ugd2Ugbm93IGhhdmUgdG8gdGFrZSBjYXJlIHRvIHBy
b3Blcmx5IGhhbmRsZSBhIGVtcHR5IGNsaWVudAptb25pdG9ycyBjb25maWcsIHNvIHdlIGRvbid0
IHRyaXAgb3ZlciBhbiB1bmluaXRpYWxpemVkIGNsaWVudCBtb25pdG9ycwpjb25maWcuCgpTaWdu
ZWQtb2ZmLWJ5OiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vcXhsL3F4bF9kaXNwbGF5LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZGlzcGxh
eS5jIGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZGlzcGxheS5jCmluZGV4IDJiOTk0OTYuLmNm
OTlhY2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2Rpc3BsYXkuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9kaXNwbGF5LmMKQEAgLTgxLDYgKzgxLDEwIEBAIHN0
YXRpYyBpbnQgcXhsX2Rpc3BsYXlfY29weV9yb21fY2xpZW50X21vbml0b3JzX2NvbmZpZyhzdHJ1
Y3QgcXhsX2RldmljZSAqcWRldikKIAkJCSAgIHFkZXYtPnJvbS0+Y2xpZW50X21vbml0b3JzX2Nv
bmZpZ19jcmMpOwogCQlyZXR1cm4gTU9OSVRPUlNfQ09ORklHX0JBRF9DUkM7CiAJfQorCWlmICgh
bnVtX21vbml0b3JzKSB7CisJCURSTV9ERUJVR19LTVMoIm5vIGNsaWVudCBtb25pdG9ycyBjb25m
aWd1cmVkXG4iKTsKKwkJcmV0dXJuIHN0YXR1czsKKwl9CiAJaWYgKG51bV9tb25pdG9ycyA+IHFk
ZXYtPm1vbml0b3JzX2NvbmZpZy0+bWF4X2FsbG93ZWQpIHsKIAkJRFJNX0RFQlVHX0tNUygiY2xp
ZW50IG1vbml0b3JzIGxpc3Qgd2lsbCBiZSB0cnVuY2F0ZWQ6ICVkIDwgJWRcbiIsCiAJCQkgICAg
ICBxZGV2LT5tb25pdG9yc19jb25maWctPm1heF9hbGxvd2VkLCBudW1fbW9uaXRvcnMpOwpAQCAt
MTE5Miw2ICsxMTk2LDcgQEAgaW50IHF4bF9tb2Rlc2V0X2luaXQoc3RydWN0IHF4bF9kZXZpY2Ug
KnFkZXYpCiAJCXFkZXZfb3V0cHV0X2luaXQoJnFkZXYtPmRkZXYsIGkpOwogCX0KIAorCXF4bF9k
aXNwbGF5X3JlYWRfY2xpZW50X21vbml0b3JzX2NvbmZpZyhxZGV2KTsKIAlxZGV2LT5tb2RlX2lu
Zm8ubW9kZV9jb25maWdfaW5pdGlhbGl6ZWQgPSB0cnVlOwogCiAJZHJtX21vZGVfY29uZmlnX3Jl
c2V0KCZxZGV2LT5kZGV2KTsKLS0gCjEuOC4zLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
