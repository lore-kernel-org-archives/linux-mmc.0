Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46B266B72
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786875; cv=pass; b=V/ixyBJktQYWea1JZQUJn/whtB4oO+9QAmdPbS+21jUXElay+a4kezOwhrfz1hZNjDfN/KnGYcYU7L77MU1lK0JiVg2EThBlFyRFHEQsYJrBJfybLLiRyCVkE5Qh+uFnPy5JXdlf+d3GBNrRxAVCLQrLxXQ4QJ4j5JOriNeryrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786875; c=relaxed/simple;
	bh=ZaBQ5tkLSmw9g7b8fhNlWVbbux3qphLUl1rPCiwF2zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJKROrgcynstt8q7y79pyv5xwRZqm8zkcZbJ6VDle3bWtyTTQWNt1fkbIYQv5gmC4WlmNg66V03by6a7kKUU/FZ1H1yHfCU2xGiSHQwG/pXO/bBbNM5MdYz5wqcvcY8zF86FoMC7t+ytoIl8GiG6NLYQRrdeqzd5oQUboki5URY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NnXx+cbb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AM17GEDn; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NnXx+cbb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AM17GEDn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62654PQt4193476
	for <linux-mmc@vger.kernel.org>; Fri, 6 Mar 2026 08:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X2ApZDaJcSIzT6mlxuYP1CqmneNlNHGPXDzmji4RH34=; b=NnXx+cbbq/HsKF8R
	LEVMtBHS5WQZGAhSPbl3kITrHa8CHRR/Zh9CxkCjtAp/7KLlutfy5mJKEOzpA+1t
	XmzVegaMVmw0qQmKsOXdOwjJlkCruDm4t0+c57nP1UzOzfZGDMnH2LrcWZkpyaL3
	5b1zKViUky0JLxsIMi0Jp57YiomiFtlGxXsu/G78dEpKlXItttOl9mTt+r0oE60O
	Ig9WBY2hbaNeOg+2eNiclZ+sEiiQCKG1Sfdua9RnfM+hOP6M7tsM/m8oPv2gcL3M
	t+2+GD0Pm+hl4QDXRMWhLxbMJCASiUpXgBbhD+Cew0eUYT6iPpa4IDckfFF2wYLs
	7FaiRg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrf5rq04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 08:47:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2be232ef3d3so59488718eec.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 00:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772786871; cv=none;
        d=google.com; s=arc-20240605;
        b=RQTxjOzkeYzBnqkiv7CbklXKPUc6BM36j3QaXgXS2eb+xOorVBqB7xLyqV3f9kLUOF
         rPdzpny2Oq0rNaZTpvBNaQMMVEow1n5DTZoNlo7yFOSzOuK6MCkLFuK7w64q+iWF5XxP
         vrMQt0LduSdxzya+DYjEed8mV3wn5MEFZ3YZUH8pleA46IGrqLNM9/koTBN+4dqCbZvO
         Y0qg+hHnKunaX8GeB1JzhCDINwVidalDKkyj/qBTMMeXh/FF0AYaBJj7Wldq1YZIu1/o
         4ttq3pbooSPfI9E+F76hBhPrGj6OeEx5M1nxQJOtmosWTIy6QHhl4QDc5Ru/YQVVE0LP
         ueLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2ApZDaJcSIzT6mlxuYP1CqmneNlNHGPXDzmji4RH34=;
        fh=KpRk7F05NTIA8MvgmUJdALTHEUJXL0Mdx07ZiPxYxWc=;
        b=VpU+swoGfDyWgH+Drz5B70F8rwubiVGhuMzIcS0rVIodGlLp/N5QKztLi8nKkyqZKh
         Gn9ZI3rJ3jUT434/Y+r9USBvAbmt6eHxvohEvqwtn0V5P66o9GF7FciBbqZcBNY5ypyx
         yCV9KIj1vVDNlj8YdZgkHLJy/n82OUvfAxSHrA08CfTxnEaM5O1zJlj8vyagFbS/HSWp
         6dwmvfpEtgGffb+KbprtlgcBr6xoXbF5YHGrGFdqnNP4JkjWiM2dN2aDBHYBdFsahT9t
         CTWxjADsHrTjKLlSSyfzzGc8Vf6Y8VPkeM+PrqjeVXkaLV9+wtFustAE+PIIqUR7TPb9
         hY8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772786871; x=1773391671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2ApZDaJcSIzT6mlxuYP1CqmneNlNHGPXDzmji4RH34=;
        b=AM17GEDnjgW9AQdNrxY79zzhyxZdNDS6MjMAF4YEBt6iWLja55bEJPBdL9Ah0etxks
         F7V1BQX4Vp1zS9dCwVzQqHZBEOmkSn22W4pnDnNIQo901GjA59AmMziZDvmBgZK7jLZ/
         u0cXsGYSM+5QwPaMEjUGrzl0PcUPZZVOHskddyJ1acKdOKj1XIFL9xoz4GiY0NFiCwKX
         U0aS1Fs5fMEptn6eLo92XESn9gKS92Sj39XSwUvAbqqFG1dKp2MY5mO4HYE/cV8zVqSZ
         6E9UzsSXFlvPKu7l3NJJFsdAHudUq+A1Bw+5BB+cvK3KnmAi9vdy/7GCglYB4kMmSD01
         oVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772786871; x=1773391671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X2ApZDaJcSIzT6mlxuYP1CqmneNlNHGPXDzmji4RH34=;
        b=YKR6vI/ZR8pkeU9C94s1EHTB34THy1Z+ujwE0J9wYV5bt86AURnjqMmN+CLUQveXHI
         vRd7hWbdAPT3bcwpgI5HARFV5RirGdm7VHIC3+Dm9ADYxd3w4rLQ5v/zOdGW5gSSypQp
         oCynWntHJ0bFNO35txvHaGMGirRG0Og3ChKvK8p2xO7GYKNmtiKv4uG2u5kgi/MmnIRp
         1FJwYlooy1F2iodWI6a4j1w/ZhU8mi+z/fve/RrQpcmmkz2KxgQilfdHIg2Plm6bOLRv
         C+q2oOo5f8FZ0zAAkhV4fXgKRHRpORa3P0x7cb2ljJLeGr2Wc4qc/ITQsfA2S5J/xO7r
         VicQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR1MUppuKEfXaFT+lg2vocDU9RdBXl2HT3V8EtpEwb2hBuEBEipx0T3BDws5WBIkk21Xy8iuBuWEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzApcin4E3iC+Jx2/NVVdZS2Lf6IIlCLvJQmCIyAT4MKNuBtFDs
	EKWGrVxBpNLTqzw9aBNZRSdSevQL0mi8aaqR55S//AHO8R31HiGs3eIgoNNI4DQ6MUNgXqodeGa
	e7kYfHrpbv2xrvj+FGtKHjOjp5F7lKoqIWWwlaELILCxfaM/mO3Oz59Rjxb8kyhfag8zWpOvEK+
	OUnmT2La8D3bnSp50PB7MsRuvodb1mLWx+0Gdb6g==
X-Gm-Gg: ATEYQzxfnoHYQvSPlClmdknuPSnD5bBBxiEJZ1k4mdS0cJKhuZzKhAZKQtRoxbAF6In
	Bl/2Hoby/fcPA0/ip4MUq/mEDFUeFcI+OLTNXXA79V2un7zu9uju999Szv9/PpdqQnFnIImgKOH
	ibp1sttGNQ+2JkawxSLyClgO2uzbBcCG/sCA9bSNd7SajlWfiuj7KltPt4N4oapo1EY0ukpn973
	tkSucQF
X-Received: by 2002:a05:7301:2f95:b0:2be:1946:8579 with SMTP id 5a478bee46e88-2be4e05bca0mr561975eec.29.1772786870559;
        Fri, 06 Mar 2026 00:47:50 -0800 (PST)
X-Received: by 2002:a05:7301:2f95:b0:2be:1946:8579 with SMTP id
 5a478bee46e88-2be4e05bca0mr561960eec.29.1772786870005; Fri, 06 Mar 2026
 00:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-qcom-ice-fix-v4-0-0e65740a5dcc@oss.qualcomm.com> <20260302-qcom-ice-fix-v4-3-0e65740a5dcc@oss.qualcomm.com>
In-Reply-To: <20260302-qcom-ice-fix-v4-3-0e65740a5dcc@oss.qualcomm.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 14:17:38 +0530
X-Gm-Features: AaiRm53gfCr5M3RUQ0TNbe5SUyiCFNlNVgIigtSQ2TjqBnHklxctDwimKFYR3Hc
Message-ID: <CAGptzHN=uiYoDC-LwmWcGc=bO6gYWmnr6DNiS+o0M_BS80QftQ@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: SNDFfSVCyhOFF3BRAFfC9S_ZzG2-nwUH
X-Proofpoint-GUID: SNDFfSVCyhOFF3BRAFfC9S_ZzG2-nwUH
X-Authority-Analysis: v=2.4 cv=L+oQguT8 c=1 sm=1 tr=0 ts=69aa94b7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=9oxdx14C3Cyt1g6qQDsA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MiBTYWx0ZWRfX50OFKFT/j3yn
 oBLYAoXkT5Z45riFpmALnF7JYiKg48/83x4RJVzcCz5iZISlqKcz17wMX3Vp0X2IqfJoIDR0q6p
 aIxob7hoI533JCx2s4JT+JBTnxUFdjAegnU09r7UlrngInEmFAszu1VmzoklVzANyO3jimZDI23
 EpriBXpYCv2IAVP7cWiM1NhQ2M3iVGCb+QANtqtP/mQMA5E2ySi2UwNL45gGLL06CuW0VgIWLtm
 MfAsit1LaBu9uLl8IjNZBvb3LM+EVh1nLO0vMAYYtRW/cuqXYWeBLvfeaRe3TiUBO6VQv3VZA7+
 l/GdroJoSbC50i9r8Sh5g30ChiKt8Nyut/LcVDGuHkGuSFJ0OTJIeKrB5VNmz6X4565XTPiKj0S
 i7wIibPDmAKiSRtQtdTbR7+hUmYCXJni3bSsqCecCeCPf5RwsmhTs3d8ufSrD0v1j3LSrA6mCkK
 fSpFRnxsZDfZmiDIx9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060082

Hey Mani,

On Mon, Mar 2, 2026 at 6:30=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> devm_of_qcom_ice_get() currently returns NULL if ICE SCM is not available
> or "qcom,ice" property is not found in DT. But this confuses the clients
> since NULL doesn't convey the reason for failure. So return proper error
> codes instead of NULL.
>
> Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/soc/qcom/ice.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index 833d23dc7b06..d1efc676b63c 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -561,7 +561,7 @@ static struct qcom_ice *qcom_ice_create(struct device=
 *dev,
>
>         if (!qcom_scm_ice_available()) {
>                 dev_warn(dev, "ICE SCM interface not found\n");
> -               return NULL;
> +               return ERR_PTR(-EOPNOTSUPP);
>         }

With this patch-set on top of v7.0-rc2, I still see UFS probe failing
when ICE isn't supported with OP-TEE as follows:

[    5.401558] qcom-ice 1d88000.crypto: ICE SCM interface not found
[    5.419482] qcom-ice 1d88000.crypto: probe with driver qcom-ice
failed with error -95
<snip>
[   18.662977] ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specif=
ied
[   18.670193] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable
to find vdd-hba-supply regulator, assuming enabled
[   18.737665] platform 1d84000.ufshc: deferred probe pending:
ufshcd-qcom: ufshcd_pltfrm_init() failed
[   18.747141] platform 3370000.codec: deferred probe pending:
platform: wait for supplier /soc@0/pinctrl@33c0000/dmic23-data-state

Maybe it's the "qcom-ice" driver failure leading to this deferred
probe problem again.

-Sumit

>
>         engine =3D devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
> @@ -643,7 +643,7 @@ static struct qcom_ice *of_qcom_ice_get(struct device=
 *dev)
>         struct device_node *node __free(device_node) =3D of_parse_phandle=
(dev->of_node,
>                                                                         "=
qcom,ice", 0);
>         if (!node)
> -               return NULL;
> +               return ERR_PTR(-ENODEV);
>
>         pdev =3D of_find_device_by_node(node);
>         if (!pdev) {
> @@ -696,8 +696,7 @@ static void devm_of_qcom_ice_put(struct device *dev, =
void *res)
>   * phandle via 'qcom,ice' property to an ICE DT, the ICE instance will a=
lready
>   * be created and so this function will return that instead.
>   *
> - * Return: ICE pointer on success, NULL if there is no ICE data provided=
 by the
> - * consumer or ERR_PTR() on error.
> + * Return: ICE pointer on success, ERR_PTR() on error.
>   */
>  struct qcom_ice *devm_of_qcom_ice_get(struct device *dev)
>  {
> @@ -708,7 +707,7 @@ struct qcom_ice *devm_of_qcom_ice_get(struct device *=
dev)
>                 return ERR_PTR(-ENOMEM);
>
>         ice =3D of_qcom_ice_get(dev);
> -       if (!IS_ERR_OR_NULL(ice)) {
> +       if (!IS_ERR(ice)) {
>                 *dr =3D ice;
>                 devres_add(dev, dr);
>         } else {
>
> --
> 2.51.0
>
>
