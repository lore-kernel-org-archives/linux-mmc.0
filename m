From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 27/27] devres: kill devm_ioremap_nocache
Date: Sat, 23 Dec 2017 14:45:32 +0100
Message-ID: <20171223134532.GA10103@kroah.com>
References: <1514026979-33838-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1514026979-33838-1-git-send-email-xieyisheng1@huawei.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-mips@linux-mips.org, ulf.hansson@linaro.org, jakub.kicinski@netronome.com, lgirdwood@gmail.com, airlied@linux.ie, linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, daniel.vetter@intel.com, tglx@linutronix.de, linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, boris.brezillon@free-electrons.com, andriy.shevchenko@linux.intel.com, vinod.koul@intel.com, richard@nod.at, alexandre.belloni@free-electrons.com, marek.vasut@gmail.com, industrypack-devel@lists.sourceforge.net, jslaby@suse.com, dvhart@infradead.org, linux@roeck-us.net, linux-media@vger.kernel.org, devel@driverdev.osuosl.org, jason@lakedaemon.net, arnd@arndb.de, b.zolnierkie@samsung.com, marc.zyngier@arm.com, linux-mmc@vger.kernel.org, linux-can@vger.kernel.org, linux-gp
List-Id: linux-mmc@vger.kernel.org

T24gU2F0LCBEZWMgMjMsIDIwMTcgYXQgMDc6MDI6NTlQTSArMDgwMCwgWWlzaGVuZyBYaWUgd3Jv
dGU6Cj4gLS0tIGEvbGliL2RldnJlcy5jCj4gKysrIGIvbGliL2RldnJlcy5jCj4gQEAgLTQ0LDM1
ICs0NCw2IEBAIHZvaWQgX19pb21lbSAqZGV2bV9pb3JlbWFwKHN0cnVjdCBkZXZpY2UgKmRldiwg
cmVzb3VyY2Vfc2l6ZV90IG9mZnNldCwKPiAgRVhQT1JUX1NZTUJPTChkZXZtX2lvcmVtYXApOwo+
ICAKPiAgLyoqCj4gLSAqIGRldm1faW9yZW1hcF9ub2NhY2hlIC0gTWFuYWdlZCBpb3JlbWFwX25v
Y2FjaGUoKQo+IC0gKiBAZGV2OiBHZW5lcmljIGRldmljZSB0byByZW1hcCBJTyBhZGRyZXNzIGZv
cgo+IC0gKiBAb2Zmc2V0OiBSZXNvdXJjZSBhZGRyZXNzIHRvIG1hcAo+IC0gKiBAc2l6ZTogU2l6
ZSBvZiBtYXAKPiAtICoKPiAtICogTWFuYWdlZCBpb3JlbWFwX25vY2FjaGUoKS4gIE1hcCBpcyBh
dXRvbWF0aWNhbGx5IHVubWFwcGVkIG9uIGRyaXZlcgo+IC0gKiBkZXRhY2guCj4gLSAqLwo+IC12
b2lkIF9faW9tZW0gKmRldm1faW9yZW1hcF9ub2NhY2hlKHN0cnVjdCBkZXZpY2UgKmRldiwgcmVz
b3VyY2Vfc2l6ZV90IG9mZnNldCwKPiAtCQkJCSAgIHJlc291cmNlX3NpemVfdCBzaXplKQo+IC17
Cj4gLQl2b2lkIF9faW9tZW0gKipwdHIsICphZGRyOwo+IC0KPiAtCXB0ciA9IGRldnJlc19hbGxv
YyhkZXZtX2lvcmVtYXBfcmVsZWFzZSwgc2l6ZW9mKCpwdHIpLCBHRlBfS0VSTkVMKTsKPiAtCWlm
ICghcHRyKQo+IC0JCXJldHVybiBOVUxMOwo+IC0KPiAtCWFkZHIgPSBpb3JlbWFwX25vY2FjaGUo
b2Zmc2V0LCBzaXplKTsKCldhaXQsIGRldm1faW9yZW1hcCgpIGNhbGxzIGlvcmVtYXAoKSwgbm90
IGlvcmVtYXBfbm9jYWNoZSgpLCBhcmUgeW91Cl9TVVJFXyB0aGF0IHRoZXNlIGFyZSBhbGwgaWRl
bnRpY2FsPyAgRm9yIGFsbCBhcmNoZXM/ICBJZiBzbywgdGhlbgppb3JlbWFwX25vY2FjaGUoKSBj
YW4gYWxzbyBiZSByZW1vdmVkLCByaWdodD8KCkluIG15IHF1aWNrIGdsYW5jZSwgSSBkb24ndCB0
aGluayB5b3UgY2FuIGRvIHRoaXMgc2VyaWVzIGF0IGFsbCA6KAoKZ3JlZyBrLWgKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
