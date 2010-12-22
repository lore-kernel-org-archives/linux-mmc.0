From: Philip Rakity <prakity@marvell.com>
Subject: Fwd: [PATCH 7/23]  Alternative mmc structure to support pxa168,
	pxa910, mmp2 family SD
Date: Wed, 22 Dec 2010 15:06:51 -0800
Message-ID: <C514DA21-446D-4153-B5B9-E4AE4D0A06CA@marvell.com>
References: <C8F2F5E1-E72D-4679-AB8F-748CBE736262@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_005_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

--_005_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_
Content-Type: multipart/alternative;
	boundary="_000_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_"

--_000_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Resend adding correct name and e-mail for
Signed-off-by:

Begin forwarded message:

From: Philip Rakity <prakity@marvell.com<mailto:prakity@marvell.com>>
Date: December 21, 2010 11:08:35 PM PST
To: "linux-mmc@vger.kernel.org<mailto:linux-mmc@vger.kernel.org>" <linux-mm=
c@vger.kernel.org<mailto:linux-mmc@vger.kernel.org>>, "linux-arm-kernel@lis=
ts.infradead.org<mailto:linux-arm-kernel@lists.infradead.org>" <linux-arm-k=
ernel@lists.infradead.org<mailto:linux-arm-kernel@lists.infradead.org>>
Cc: Mark Brown <markb@marvell.com<mailto:markb@marvell.com>>
Subject: [PATCH 7/23] Alternative mmc structure to support pxa168, pxa910, =
mmp2 family SD

>From 499888df1a52491c201077c8a0f8310b70583290 Mon Sep 17 00:00:00 2001
From: philip <philip@philip-laptop.(none)>
Date: Sat, 11 Dec 2010 16:58:59 -0800
Subject: [PATCH] sdhci: Add pre and post reset processing for chip specific=
 reset

Marvell pxa controllers have private registers that need to be
touched before and after a reset is done.  Implement hooks
to allow this to happen.

Signed-off-by: Philip Rakity <prakity@marvell.com<mailto:prakity@marvell.co=
m>>
---
drivers/mmc/host/sdhci.c |    6 ++++++
drivers/mmc/host/sdhci.h |    2 ++
2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d5febe5..f439881 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -157,6 +157,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mas=
k)
if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
ier =3D sdhci_readl(host, SDHCI_INT_ENABLE);

+ if (host->ops->platform_reset_enter)
+ host->ops->platform_reset_enter(host, mask);
+
sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);

if (mask & SDHCI_RESET_ALL)
@@ -177,6 +180,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mas=
k)
mdelay(1);
}

+ if (host->ops->platform_reset_exit)
+ host->ops->platform_reset_exit(host, mask);
+
if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..9dd7bc1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -222,6 +222,8 @@ struct sdhci_ops {
void (*platform_send_init_74_clocks)(struct sdhci_host *host,
    u8 power_mode);
unsigned int    (*get_ro)(struct sdhci_host *host);
+ void (*platform_reset_enter)(struct sdhci_host *host, u8 mask);
+ void (*platform_reset_exit)(struct sdhci_host *host, u8 mask);
};

#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--
1.6.0.4


--_000_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode:=
 space; -webkit-line-break: after-white-space; "><div><br></div>Resend addi=
ng correct name and e-mail for&nbsp;<div>Signed-off-by:<br><div><br><div>Be=
gin forwarded message:</div><br class=3D"Apple-interchange-newline"><blockq=
uote type=3D"cite"><div style=3D"margin-top: 0px; margin-right: 0px; margin=
-bottom: 0px; margin-left: 0px;"><span style=3D"font-family:'Helvetica'; fo=
nt-size:medium; color:rgba(0, 0, 0, 1);"><b>From: </b></span><span style=3D=
"font-family:'Helvetica'; font-size:medium;">Philip Rakity &lt;<a href=3D"m=
ailto:prakity@marvell.com">prakity@marvell.com</a>&gt;<br></span></div><div=
 style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-le=
ft: 0px;"><span style=3D"font-family:'Helvetica'; font-size:medium; color:r=
gba(0, 0, 0, 1);"><b>Date: </b></span><span style=3D"font-family:'Helvetica=
'; font-size:medium;">December 21, 2010 11:08:35 PM PST<br></span></div><di=
v style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-l=
eft: 0px;"><span style=3D"font-family:'Helvetica'; font-size:medium; color:=
rgba(0, 0, 0, 1);"><b>To: </b></span><span style=3D"font-family:'Helvetica'=
; font-size:medium;">"<a href=3D"mailto:linux-mmc@vger.kernel.org">linux-mm=
c@vger.kernel.org</a>" &lt;<a href=3D"mailto:linux-mmc@vger.kernel.org">lin=
ux-mmc@vger.kernel.org</a>&gt;, "<a href=3D"mailto:linux-arm-kernel@lists.i=
nfradead.org">linux-arm-kernel@lists.infradead.org</a>" &lt;<a href=3D"mail=
to:linux-arm-kernel@lists.infradead.org">linux-arm-kernel@lists.infradead.o=
rg</a>&gt;<br></span></div><div style=3D"margin-top: 0px; margin-right: 0px=
; margin-bottom: 0px; margin-left: 0px;"><span style=3D"font-family:'Helvet=
ica'; font-size:medium; color:rgba(0, 0, 0, 1);"><b>Cc: </b></span><span st=
yle=3D"font-family:'Helvetica'; font-size:medium;">Mark Brown &lt;<a href=
=3D"mailto:markb@marvell.com">markb@marvell.com</a>&gt;<br></span></div><di=
v style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-l=
eft: 0px;"><span style=3D"font-family:'Helvetica'; font-size:medium; color:=
rgba(0, 0, 0, 1);"><b>Subject: </b></span><span style=3D"font-family:'Helve=
tica'; font-size:medium;"><b>[PATCH 7/23]  Alternative mmc structure to sup=
port pxa168, pxa910, mmp2 family SD </b><br></span></div><br><div>From 4998=
88df1a52491c201077c8a0f8310b70583290 Mon Sep 17 00:00:00 2001<br>From: phil=
ip &lt;philip@philip-laptop.(none)&gt;<br>Date: Sat, 11 Dec 2010 16:58:59 -=
0800<br>Subject: [PATCH] sdhci: Add pre and post reset processing for chip =
specific reset<br><br>Marvell pxa controllers have private registers that n=
eed to be<br>touched before and after a reset is done. &nbsp;Implement hook=
s<br>to allow this to happen.<br><br>Signed-off-by: Philip Rakity &lt;<a hr=
ef=3D"mailto:prakity@marvell.com">prakity@marvell.com</a>&gt;<br>---<br> dr=
ivers/mmc/host/sdhci.c | &nbsp;&nbsp;&nbsp;6 ++++++<br> drivers/mmc/host/sd=
hci.h | &nbsp;&nbsp;&nbsp;2 ++<br> 2 files changed, 8 insertions(+), 0 dele=
tions(-)<br><br>diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sd=
hci.c<br>index d5febe5..f439881 100644<br>--- a/drivers/mmc/host/sdhci.c<br=
>+++ b/drivers/mmc/host/sdhci.c<br>@@ -157,6 +157,9 @@ static void sdhci_re=
set(struct sdhci_host *host, u8 mask)<br> <span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>if (host-&gt;quirks &amp; SDHCI_QUIRK_RESTO=
RE_IRQS_AFTER_RESET)<br> <span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>ier =3D sdhci_readl(host, SDHCI_INT_ENABLE);<br><br>+<span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">	</span>if (host-&gt;ops-&gt;platfo=
rm_reset_enter)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=
host-&gt;ops-&gt;platform_reset_enter(host, mask);<br>+<br> <span class=3D"=
Apple-tab-span" style=3D"white-space:pre">	</span>sdhci_writeb(host, mask, =
SDHCI_SOFTWARE_RESET);<br><br> <span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>if (mask &amp; SDHCI_RESET_ALL)<br>@@ -177,6 +180,9 @@=
 static void sdhci_reset(struct sdhci_host *host, u8 mask)<br> <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>mdelay(1);<br> <span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>}<br><br>+<span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>if (host-&gt;ops-&gt;platf=
orm_reset_exit)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=
host-&gt;ops-&gt;platform_reset_exit(host, mask);<br>+<br> <span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>if (host-&gt;quirks &amp; =
SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)<br> <span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);<=
br> }<br>diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h<b=
r>index 6e0969e..9dd7bc1 100644<br>--- a/drivers/mmc/host/sdhci.h<br>+++ b/=
drivers/mmc/host/sdhci.h<br>@@ -222,6 +222,8 @@ struct sdhci_ops {<br> <spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>void (*platfor=
m_send_init_74_clocks)(struct sdhci_host *host,<br> <span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n> &nbsp;&nbsp;&nbsp;&nbsp;u8 power_mode);<br> <span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>unsigned int &nbsp;&nbsp;&nbsp;(*get_r=
o)(struct sdhci_host *host);<br>+<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>void<span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>(*platform_reset_enter)(struct sdhci_host *host, u8 mask);=
<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>void<=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>(*platform_=
reset_exit)(struct sdhci_host *host, u8 mask);<br> };<br><br> #ifdef CONFIG=
_MMC_SDHCI_IO_ACCESSORS<br>-- <br>1.6.0.4<br><br></div></blockquote></div><=
/div></body></html>=

--_000_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_--

--_005_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_
Content-Type: application/octet-stream;
	name="0007-sdhci-Add-pre-and-post-reset-processing-for-chip-sp.patch"
Content-Description: 0007-sdhci-Add-pre-and-post-reset-processing-for-chip-sp.patch
Content-Disposition: attachment;
	filename="0007-sdhci-Add-pre-and-post-reset-processing-for-chip-sp.patch";
	size=1910; creation-date="Wed, 22 Dec 2010 15:06:52 GMT";
	modification-date="Wed, 22 Dec 2010 15:06:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0OTk4ODhkZjFhNTI0OTFjMjAxMDc3YzhhMGY4MzEwYjcwNTgzMjkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBwaGlsaXAgPHBoaWxpcEBwaGlsaXAtbGFwdG9wLihub25lKT4K
RGF0ZTogU2F0LCAxMSBEZWMgMjAxMCAxNjo1ODo1OSAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHNk
aGNpOiBBZGQgcHJlIGFuZCBwb3N0IHJlc2V0IHByb2Nlc3NpbmcgZm9yIGNoaXAgc3BlY2lmaWMg
cmVzZXQKCk1hcnZlbGwgcHhhIGNvbnRyb2xsZXJzIGhhdmUgcHJpdmF0ZSByZWdpc3RlcnMgdGhh
dCBuZWVkIHRvIGJlCnRvdWNoZWQgYmVmb3JlIGFuZCBhZnRlciBhIHJlc2V0IGlzIGRvbmUuICBJ
bXBsZW1lbnQgaG9va3MKdG8gYWxsb3cgdGhpcyB0byBoYXBwZW4uCgpTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2hvc3Qv
c2RoY2kuYyB8ICAgIDYgKysrKysrCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggfCAgICAyICsr
CiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LmMKaW5kZXggZDVmZWJlNS4uZjQzOTg4MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtMTU3LDYgKzE1Nyw5IEBA
IHN0YXRpYyB2b2lkIHNkaGNpX3Jlc2V0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1OCBtYXNr
KQogCWlmIChob3N0LT5xdWlya3MgJiBTREhDSV9RVUlSS19SRVNUT1JFX0lSUVNfQUZURVJfUkVT
RVQpCiAJCWllciA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX0lOVF9FTkFCTEUpOwogCisJaWYg
KGhvc3QtPm9wcy0+cGxhdGZvcm1fcmVzZXRfZW50ZXIpCisJCWhvc3QtPm9wcy0+cGxhdGZvcm1f
cmVzZXRfZW50ZXIoaG9zdCwgbWFzayk7CisKIAlzZGhjaV93cml0ZWIoaG9zdCwgbWFzaywgU0RI
Q0lfU09GVFdBUkVfUkVTRVQpOwogCiAJaWYgKG1hc2sgJiBTREhDSV9SRVNFVF9BTEwpCkBAIC0x
NzcsNiArMTgwLDkgQEAgc3RhdGljIHZvaWQgc2RoY2lfcmVzZXQoc3RydWN0IHNkaGNpX2hvc3Qg
Kmhvc3QsIHU4IG1hc2spCiAJCW1kZWxheSgxKTsKIAl9CiAKKwlpZiAoaG9zdC0+b3BzLT5wbGF0
Zm9ybV9yZXNldF9leGl0KQorCQlob3N0LT5vcHMtPnBsYXRmb3JtX3Jlc2V0X2V4aXQoaG9zdCwg
bWFzayk7CisKIAlpZiAoaG9zdC0+cXVpcmtzICYgU0RIQ0lfUVVJUktfUkVTVE9SRV9JUlFTX0FG
VEVSX1JFU0VUKQogCQlzZGhjaV9jbGVhcl9zZXRfaXJxcyhob3N0LCBTREhDSV9JTlRfQUxMX01B
U0ssIGllcik7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLmgKaW5kZXggNmUwOTY5ZS4uOWRkN2JjMSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApA
QCAtMjIyLDYgKzIyMiw4IEBAIHN0cnVjdCBzZGhjaV9vcHMgewogCXZvaWQgKCpwbGF0Zm9ybV9z
ZW5kX2luaXRfNzRfY2xvY2tzKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwKIAkJCQkJICAgICB1
OCBwb3dlcl9tb2RlKTsKIAl1bnNpZ25lZCBpbnQgICAgKCpnZXRfcm8pKHN0cnVjdCBzZGhjaV9o
b3N0ICpob3N0KTsKKwl2b2lkCSgqcGxhdGZvcm1fcmVzZXRfZW50ZXIpKHN0cnVjdCBzZGhjaV9o
b3N0ICpob3N0LCB1OCBtYXNrKTsKKwl2b2lkCSgqcGxhdGZvcm1fcmVzZXRfZXhpdCkoc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QsIHU4IG1hc2spOwogfTsKIAogI2lmZGVmIENPTkZJR19NTUNfU0RI
Q0lfSU9fQUNDRVNTT1JTCi0tIAoxLjYuMC40Cgo=

--_005_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_
Content-Type: text/html; name="ATT00001..htm"
Content-Description: ATT00001..htm
Content-Disposition: attachment; filename="ATT00001..htm"; size=147;
	creation-date="Wed, 22 Dec 2010 15:06:52 GMT";
	modification-date="Wed, 22 Dec 2010 15:06:52 GMT"
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PC9oZWFkPjxib2R5IHN0eWxlPSJ3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7IC13
ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgLXdlYmtpdC1saW5lLWJyZWFrOiBhZnRlci13aGl0ZS1z
cGFjZTsgIj48ZGl2PjwvZGl2PjwvYm9keT48L2h0bWw+

--_005_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--_005_C514DA21446D4153B5B9E4AE4D0A06CAmarvellcom_--
