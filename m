From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
 sdhci-pltfm driver
Date: Mon, 27 Sep 2010 15:24:02 +0200
Message-ID: <4CA09AF2.2030809@st.com>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <20100927103722.GC2664@pengutronix.de> <4CA094D7.7070101@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_002_4CA09AF22030809stcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:34622 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756013Ab0I0NY6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 09:24:58 -0400
In-Reply-To: <4CA094D7.7070101@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

--_002_4CA09AF22030809stcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 09/27/2010 02:57 PM, Peppe CAVALLARO wrote:
> On 09/27/2010 12:37 PM, Wolfram Sang wrote:
>  > On Thu, Sep 23, 2010 at 11:14:24AM +0200, Giuseppe CAVALLARO wrote:
>  >> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>  >
>  > I'd prefer it the way sdhci-mv.c is doing it (just one #if-block and
>  > returning the code from the sdhci_*-functions). Then it should be fine=
.
>=20
> Okay! I can rework it without any problems.

Hi Wolfram
attached the new patch:
Let me know if it's ok.

Best Regards,
Peppe


>=20
> Peppe
>=20
>  >
>  >> ---
>  >> drivers/mmc/host/sdhci-pltfm.c | 22 ++++++++++++++++++++++
>  >> 1 files changed, 22 insertions(+), 0 deletions(-)
>  >>
>  >> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
>  >> index e045e3c..89ea64b 100644
>  >> --- a/drivers/mmc/host/sdhci-pltfm.c
>  >> +++ b/drivers/mmc/host/sdhci-pltfm.c
>  >> @@ -165,6 +165,24 @@ static const struct platform_device_id=20
> sdhci_pltfm_ids[] =3D {
>  >> };
>  >> MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
>  >>
>  >> +#ifdef CONFIG_PM
>  >> +static int sdhci_pltfm_suspend(struct platform_device *dev, pm_messa=
ge_t pm)
>  >> +{
>  >> + struct sdhci_host *host =3D platform_get_drvdata(dev);
>  >> +
>  >> + sdhci_suspend_host(host, pm);
>  >> + return 0;
>  >> +}
>  >> +
>  >> +static int sdhci_pltfm_resume(struct platform_device *dev)
>  >> +{
>  >> + struct sdhci_host *host =3D platform_get_drvdata(dev);
>  >> +
>  >> + sdhci_resume_host(host);
>  >> + return 0;
>  >> +}
>  >> +#endif
>  >> +
>  >> static struct platform_driver sdhci_pltfm_driver =3D {
>  >> .driver =3D {
>  >> .name =3D "sdhci",
>  >> @@ -173,6 +191,10 @@ static struct platform_driver sdhci_pltfm_driver=
 =3D {
>  >> .probe =3D sdhci_pltfm_probe,
>  >> .remove =3D __devexit_p(sdhci_pltfm_remove),
>  >> .id_table =3D sdhci_pltfm_ids,
>  >> +#ifdef CONFIG_PM
>  >> + .suspend =3D sdhci_pltfm_suspend,
>  >> + .resume =3D sdhci_pltfm_resume,
>  >> +#endif
>  >> };
>  >>
>  >> /********************************************************************=
*********\
>  >> --
>  >> 1.5.5.6
>  >>
>  >> --
>  >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
>  >> the body of a message to majordomo@vger.kernel.org
>  >> More majordomo info at http://vger.kernel.org/majordomo-info.html
>  >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20


--_002_4CA09AF22030809stcom_
Content-Type: text/x-patch;
	name="0001-mmc-add-suspend-resume-in-the-sdhci-pltfm-driver-V.patch"
Content-Description: 0001-mmc-add-suspend-resume-in-the-sdhci-pltfm-driver-V.patch
Content-Disposition: attachment;
	filename="0001-mmc-add-suspend-resume-in-the-sdhci-pltfm-driver-V.patch";
	size=1680; creation-date="Mon, 27 Sep 2010 15:24:07 GMT";
	modification-date="Mon, 27 Sep 2010 15:24:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NDdmNjM1ZDA4MjRjODhmNjU3NWQ4NmY1ZTlmNTAyODM4ODNjZDYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogR2l1c2VwcGUgQ2F2YWxsYXJvIDxwZXBwZS5jYXZhbGxhcm9A
c3QuY29tPg0KRGF0ZTogVGh1LCAyMyBTZXAgMjAxMCAxMDoxMzowMCArMDIwMA0KU3ViamVjdDog
W1BBVENIIChtbWMtbmV4dCldIG1tYzogYWRkIHN1c3BlbmQvcmVzdW1lIGluIHRoZSBzZGhjaS1w
bHRmbSBkcml2ZXIgKFYyKQ0KDQpTaWduZWQtb2ZmLWJ5OiBHaXVzZXBwZSBDYXZhbGxhcm8gPHBl
cHBlLmNhdmFsbGFyb0BzdC5jb20+DQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZt
LmMgfCAgIDIzICsrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlcyBjaGFuZ2VkLCAyMyBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1wbHRmbS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5jDQppbmRl
eCBlMDQ1ZTNjLi5jNDNmOTU0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1w
bHRmbS5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBsdGZtLmMNCkBAIC0xNjUsNiAr
MTY1LDI3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHNkaGNpX3Bs
dGZtX2lkc1tdID0gew0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShwbGF0Zm9ybSwgc2RoY2lf
cGx0Zm1faWRzKTsNCiANCisjaWZkZWYgQ09ORklHX1BNDQorc3RhdGljIGludCBzZGhjaV9wbHRm
bV9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldiwgcG1fbWVzc2FnZV90IHBtKQ0K
K3sNCisJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYp
Ow0KKw0KKwlzZGhjaV9zdXNwZW5kX2hvc3QoaG9zdCwgcG0pOw0KKwlyZXR1cm4gMDsNCit9DQor
DQorc3RhdGljIGludCBzZGhjaV9wbHRmbV9yZXN1bWUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
ZGV2KQ0KK3sNCisJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShkZXYpOw0KKw0KKwlzZGhjaV9yZXN1bWVfaG9zdChob3N0KTsNCisJcmV0dXJuIDA7DQorfQ0K
KyNlbHNlDQorI2RlZmluZSBzZGhjaV9wbHRmbV9zdXNwZW5kCU5VTEwNCisjZGVmaW5lIHNkaGNp
X3BsdGZtX3Jlc3VtZQlOVUxMDQorI2VuZGlmDQorDQogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9k
cml2ZXIgc2RoY2lfcGx0Zm1fZHJpdmVyID0gew0KIAkuZHJpdmVyID0gew0KIAkJLm5hbWUJPSAi
c2RoY2kiLA0KQEAgLTE3Myw2ICsxOTQsOCBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZl
ciBzZGhjaV9wbHRmbV9kcml2ZXIgPSB7DQogCS5wcm9iZQkJPSBzZGhjaV9wbHRmbV9wcm9iZSwN
CiAJLnJlbW92ZQkJPSBfX2RldmV4aXRfcChzZGhjaV9wbHRmbV9yZW1vdmUpLA0KIAkuaWRfdGFi
bGUJPSBzZGhjaV9wbHRmbV9pZHMsDQorCS5zdXNwZW5kCT0gc2RoY2lfcGx0Zm1fc3VzcGVuZCwN
CisJLnJlc3VtZQkJPSBzZGhjaV9wbHRmbV9yZXN1bWUsDQogfTsNCiANCiAvKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKipcDQotLSANCjEuNS41LjYNCg0K

--_002_4CA09AF22030809stcom_--
