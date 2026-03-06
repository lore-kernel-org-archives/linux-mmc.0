Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28363264C7
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787618; cv=pass; b=QEa1i5Cb/+epkjfiq+vWHe8t/ZHDFSdcZXdHntcLvtKk7a8eaIPW2V99b9d+u1GszIXpyW6E6hIRo0fh8PJBb2+p8X0UPVqUZsEBp6lWaiHg6io7f3zV/IBCvMirOiuy60Tg0WCljh+zcf4GClHUYYc2p44pR3UAmWsKEJN6y5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787618; c=relaxed/simple;
	bh=0L16VWQr8QG1LSKiQzk1dxuu8pTEnzyJmWWHaNU5jqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4gmsrYIWTpmlEnLiQpL2HgD624i5SllMY/k2+VbZkUOkqPKRNnMp/sj2xJ85KoMYjs9lQmamwqMtoE7d68xUMKDKub37FGAbEQLrBlpDkabVgh9ge7GvDUYGc9/KcPdBiotPR6O1pNpzUNWIHJSHosYXbTsrijq1XWqcLBTrfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AQXAEIyP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=URben4Zv; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQXAEIyP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URben4Zv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264afBd526764
	for <linux-mmc@vger.kernel.org>; Fri, 6 Mar 2026 09:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0Q2OpTNsJNsKwES2aOblrfidPOydSd+/tsgWOvLO+k=; b=AQXAEIyPy0omLWNY
	xC5AkIZtvCyVzSjqALxnkJ5jaZOZbV5AmW9deGfMB7OCurlXwS6rhPDVV3np6dCT
	MMdSn3RHsUAs1YjrjEt/LjZYVwOvFH6y2n5m69T3BGCOiuNWwF497Yls9ayhkG4h
	LtuelBRmMz1QSQEp8CEq2nTuH6mOqTdcb5Ogo+JpJXVmVNe4Bnl8Ds2x976CwNof
	EJyRrTgo7DpmBffbcR9bt/64YS/xpNmoMo2NcTn/UP8X53T4UQR/eX1vtWbQEkcN
	LSOfF8PucvZTRYEwRqU+JYUBAmPArlJSlrd5vxmVg1MVEzCQBqqr8oq3DvKJwJPV
	hzPrlA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq85dm1nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 09:00:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso6498709eec.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 01:00:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772787615; cv=none;
        d=google.com; s=arc-20240605;
        b=SmnzJQrMoouqFDsJ71awPj6i4UgKBCrJimLjDqHakM+OhnOQjVNUch8kLsy/Ubgv+C
         WRDgUAshDaANyFSIZb8FFvEN2pvuAwyH2MTM2p/FXzLRsvlzdyu7vut+8fpYBamLETbg
         gH+V9HblrJtwnVnt/3uL6GNferMgWjlGbEvYK9ztMBA/+a/76OStz+zh/mkC8/30hIgW
         MHEKG4Uj+e+TogHlI8kQmWX34Y71UnNb2zlzaJmS8hl9zowWUToPgqm2ugdn0OW512u3
         a84S6WlflO/at2vJtGFapka9n+5Hjk0C25p8EC4GcnVGFYvc264EWRRd7VYqIp4RKUky
         J18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0Q2OpTNsJNsKwES2aOblrfidPOydSd+/tsgWOvLO+k=;
        fh=gm00Gl4XZu+MMmzWumuPy+yevCEoUK2hsOCPiSARNXI=;
        b=heVb344+uXOgWJQIpyKISnptR0pa6OpVoYz4tnfSZJUogudnsE58sx6VYyFSt6vMWY
         r9ZWuIDr3qqjeCt6N7mqdziq1Wc0LF3bQXV+OCIOiX+v4tjKB8U8wdyhT4k0UVygYair
         GX9YQmvNIfERx+jK+kn3rzxavylzCSutvUrmSm/EhWYLjr8aCHMA7B7d7N2mzZ41ub+L
         r6A+pGOKfceLq1wkSZpPGSi+JK5vNAKcqnUze6BhiWwZgVgK3x8IJ07KXlGiGI5LKn5k
         qJlSqPz+EuAdtzYhomffAesgVDc+c/SHIDpbaedZ4xk7ADojkjoTl5HX4o75hEMmynyC
         C7Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772787615; x=1773392415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Q2OpTNsJNsKwES2aOblrfidPOydSd+/tsgWOvLO+k=;
        b=URben4ZvgK/XK6SdXj/KFdReI25zCzLMo4LJf7lfGAhBEI/UpMgMcjs+Dh/E536SOm
         m5T+9EPoif2VEMLvnS85Wtg2mq40j3MhmYLC/6PNhqoKV7/j6RwwaNfmrYdrG2FxQEgL
         JTB4C8inHjayDZ5W1eU2d5O4cuah7udvupB1eQXKSr1x8/nDSlUsBmp8Du3Y2plwLisG
         8/+QjAbxRsU/Fm1pniopmKwhGi/Pxq1onmh05yAjUN+ZiHXFZXRCu0oqHRrNl5X+be/S
         mlSwoPz5aUNq79vTcQUHWAyjSOl/FHoKMY8XlpuWVSPf+XteWoOjKMzB87JisiDG52M6
         GdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772787615; x=1773392415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0Q2OpTNsJNsKwES2aOblrfidPOydSd+/tsgWOvLO+k=;
        b=ZL9W1p0Ie0pLsVDnp85osgJBUIBxAxKbOzHqetlrC/7Qbi9om3Rt47C85fUTclaQ8Z
         uaKZDDUUJUMPJP/prBsfkKIAXEYPz980/avTfRkiwSbUQ/wfMN5bWpyFQgW5dlY4ytpr
         euQhGDUmB+b7KBhDY0AM/5Dx7B7U2XTiOG5DFVtcdRH4N0Gk2IaIF7Wr8XuJ0HuR3bkJ
         EKIwYv6eoDP2ok+Ksht4nKIAwe+vWJzmCGzBXc74BIX87YyVb2yFyQIIoXScyHizjzw/
         sRqWwQkGTaI2lTSGtE8siuxnLju3uScdgU/LSumnf8weteOooPrayZiHkKTuyo5DpFWY
         G3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYRDXN9Gya/K5VfKGr+TaSX/2M/aePGNF6ODIsOKMTieK/hUj6Pf/bx7SMwSDKrj6adiS7yppDcDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFhgNZGqpubHvdezJ0v7Czz8CehW8RVHBQTlcXMGkeBA++Vxy
	9+1EL8dX7scjp/6B0UTEXwMtxeUvXpN1MebHI4WqoIY22Ht0WJ4BP9oAhTSEnKOrFTAZxkNZp8V
	cLvkJACC1iDNnmSb+cE0+SmBxFoXeXzCuU/1dCK/1kPIG9Xxsp2GJY7wcttU0p19w8AbAlsUG+P
	+XjeMN3sFHyJM4Mi4XYEYxXdJKo2MMlckqQD72eg==
X-Gm-Gg: ATEYQzx+ftkkPjrN3Hf5DgRsKNbOJWvL7j38j+05UxtJ9hvkBEswpEylXCphYDR2l+8
	B/niz+wSV9AIeQgWIgbQypIfDZStnUfHHln1SSH4VIoGKt+0tzA3SnxlGToCmil8OKYEr5NKJfb
	0GFJn/tR0mUDs9p7ghfE/cMh6XD4No/GzCsscfmHAqNHupMjh1RNAYHlggDAPy52MHswr/uuftb
	91puaVF
X-Received: by 2002:a05:7301:1296:b0:2ba:7b63:3f4f with SMTP id 5a478bee46e88-2be4dfc5efemr474940eec.15.1772787614551;
        Fri, 06 Mar 2026 01:00:14 -0800 (PST)
X-Received: by 2002:a05:7301:1296:b0:2ba:7b63:3f4f with SMTP id
 5a478bee46e88-2be4dfc5efemr474918eec.15.1772787613896; Fri, 06 Mar 2026
 01:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-qcom-ice-fix-v4-0-0e65740a5dcc@oss.qualcomm.com>
 <20260302-qcom-ice-fix-v4-3-0e65740a5dcc@oss.qualcomm.com> <CAGptzHN=uiYoDC-LwmWcGc=bO6gYWmnr6DNiS+o0M_BS80QftQ@mail.gmail.com>
In-Reply-To: <CAGptzHN=uiYoDC-LwmWcGc=bO6gYWmnr6DNiS+o0M_BS80QftQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 14:30:02 +0530
X-Gm-Features: AaiRm506ir4AC8l0C0Le9ozBvSlNRLBgtgndnExCGvFEbKvlm59knOgNeJByd-c
Message-ID: <CAGptzHO+cXBib_cpD+GvM8riKVSKMF_1Y3DUJO6KL7HcM__mJg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] soc: qcom: ice: Return proper error codes from
 devm_of_qcom_ice_get() instead of NULL
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tDMqIKd6PgboU_t8u2HdYQcjET0H3Usm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4NSBTYWx0ZWRfX+pPcUs+pOqgk
 RsCUCcD3BNkmSErXLBi7lL4oIaqSAosEiuPXm++ltW6keimf5AOSL3vmuberi/VB+eI8sRxUa10
 LxC9/KT2/ZKDGnWBZyi7DILD7FMXsh5v6zKxARpTdsOlE8oQKW6Fi6w0xCxfPiyocexIM2UTtMp
 WVqWv7gQOKkhkaKr6QDv5vnfeo8tfgkvHQkQcDuoa/hXdr1CWeW8aZhqSGRosFg1j8+aBljwNNQ
 oNs0ky5BFTO9n5pjnWGYMS0XmE435KduwpJq0gPbpnPXDeP/afl6nPOFoXuSV3WbA4aFlwdob41
 RExVIxecOTvJNDqoOMaoxcpNBs/Bwl5NUZmsffxv23yeB5LOqJ6uW0oPOIz/O6f8+K21k2hIriu
 Q/gZAJzHkMQ6SPUCdoPYpNTNqFf6MZkoogQYip2cvSPb/NWE6zZ8L6RzKopiy1DWvyR3yj3Y+BV
 5PYXw+K4xkJlyEzWKUQ==
X-Authority-Analysis: v=2.4 cv=aOb9aL9m c=1 sm=1 tr=0 ts=69aa979f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=FoKZgoKw912WVnOwPkcA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: tDMqIKd6PgboU_t8u2HdYQcjET0H3Usm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603060085

On Fri, Mar 6, 2026 at 2:17=E2=80=AFPM Sumit Garg <sumit.garg@oss.qualcomm.=
com> wrote:
>
> Hey Mani,
>
> On Mon, Mar 2, 2026 at 6:30=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > devm_of_qcom_ice_get() currently returns NULL if ICE SCM is not availab=
le
> > or "qcom,ice" property is not found in DT. But this confuses the client=
s
> > since NULL doesn't convey the reason for failure. So return proper erro=
r
> > codes instead of NULL.
> >
> > Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcom=
m.com>
> > ---
> >  drivers/soc/qcom/ice.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> > index 833d23dc7b06..d1efc676b63c 100644
> > --- a/drivers/soc/qcom/ice.c
> > +++ b/drivers/soc/qcom/ice.c
> > @@ -561,7 +561,7 @@ static struct qcom_ice *qcom_ice_create(struct devi=
ce *dev,
> >
> >         if (!qcom_scm_ice_available()) {
> >                 dev_warn(dev, "ICE SCM interface not found\n");
> > -               return NULL;
> > +               return ERR_PTR(-EOPNOTSUPP);
> >         }
>
> With this patch-set on top of v7.0-rc2, I still see UFS probe failing
> when ICE isn't supported with OP-TEE as follows:
>
> [    5.401558] qcom-ice 1d88000.crypto: ICE SCM interface not found
> [    5.419482] qcom-ice 1d88000.crypto: probe with driver qcom-ice
> failed with error -95
> <snip>
> [   18.662977] ufshcd-qcom 1d84000.ufshc: freq-table-hz property not spec=
ified
> [   18.670193] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable
> to find vdd-hba-supply regulator, assuming enabled
> [   18.737665] platform 1d84000.ufshc: deferred probe pending:
> ufshcd-qcom: ufshcd_pltfrm_init() failed
> [   18.747141] platform 3370000.codec: deferred probe pending:
> platform: wait for supplier /soc@0/pinctrl@33c0000/dmic23-data-state
>
> Maybe it's the "qcom-ice" driver failure leading to this deferred
> probe problem again.
>

Following diff on top of your patchset allows the UFS driver to probe
successfully without ICE support. I suppose just setting the drvdata
should be sufficient.

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index d1efc676b63c..a86980647097 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -734,12 +734,6 @@ static int qcom_ice_probe(struct platform_device *pdev=
)
        }

        engine =3D qcom_ice_create(&pdev->dev, base);
-       if (IS_ERR(engine)) {
-               /* Store the error pointer for devm_of_qcom_ice_get() */
-               platform_set_drvdata(pdev, engine);
-               return PTR_ERR(engine);
-       }
-
        platform_set_drvdata(pdev, engine);

-Sumit

>
> >
> >         engine =3D devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
> > @@ -643,7 +643,7 @@ static struct qcom_ice *of_qcom_ice_get(struct devi=
ce *dev)
> >         struct device_node *node __free(device_node) =3D of_parse_phand=
le(dev->of_node,
> >                                                                        =
 "qcom,ice", 0);
> >         if (!node)
> > -               return NULL;
> > +               return ERR_PTR(-ENODEV);
> >
> >         pdev =3D of_find_device_by_node(node);
> >         if (!pdev) {
> > @@ -696,8 +696,7 @@ static void devm_of_qcom_ice_put(struct device *dev=
, void *res)
> >   * phandle via 'qcom,ice' property to an ICE DT, the ICE instance will=
 already
> >   * be created and so this function will return that instead.
> >   *
> > - * Return: ICE pointer on success, NULL if there is no ICE data provid=
ed by the
> > - * consumer or ERR_PTR() on error.
> > + * Return: ICE pointer on success, ERR_PTR() on error.
> >   */
> >  struct qcom_ice *devm_of_qcom_ice_get(struct device *dev)
> >  {
> > @@ -708,7 +707,7 @@ struct qcom_ice *devm_of_qcom_ice_get(struct device=
 *dev)
> >                 return ERR_PTR(-ENOMEM);
> >
> >         ice =3D of_qcom_ice_get(dev);
> > -       if (!IS_ERR_OR_NULL(ice)) {
> > +       if (!IS_ERR(ice)) {
> >                 *dr =3D ice;
> >                 devres_add(dev, dr);
> >         } else {
> >
> > --
> > 2.51.0
> >
> >
