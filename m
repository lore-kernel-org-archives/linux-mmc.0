Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66198481DD
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041453; cv=pass; b=gzteCVxtONQcPatln/khtg0FEYpYuHEz1WkLNC1p6OMeoBun8CwGatWt8AZBSsJ8yxFK49AAsB1sJ9mDp9bXy6i803wjICSBJi1rqo1L9EyZlcMbX2nS8Hup1mJzOWSL7UzFBpPuR8ufgK39QN6QGYvCKSjSlmCRJ4iMI5U01s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041453; c=relaxed/simple;
	bh=Kd8qJEQ1MJLL0QfvPt72Ua3hnI5RJ/rb/CwYYMsza9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2E500nSKocMGM2gLk6Y7RPAp+1b+XK+00uBrlo1GQT5rLjMvi98Ir3KcVpQEOmZyFobQsjdlb2qsC+9KEfzG5HJ5uUAcWu1+YfNnJkJvq7IDNQ2BzkWaPTtQzGRxardoZPE2vY4Vq6OZEszfOTYVvPDVviO2Doueut8y1wplKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RSFBYzch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q6/1Gvy7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RSFBYzch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6/1Gvy7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6294f9bk1587840
	for <linux-mmc@vger.kernel.org>; Mon, 9 Mar 2026 07:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=; b=RSFBYzchkx1FJOkU
	MSQihrtqCbBriUU/UThW3/sACa3gwCpnDJS1F1MHLzbZtwHgEVzzg9YU/BB9FeyM
	FqqlvLcdZiu2627KnFin5jCxRKRPi60KfPfyOYUODjjIhxfgAUDzvSYp7U0ZTVEp
	W/8/cN+vX1RMI/0S9mBb3aak1m5bJPygWcUvtjLLFq665QEJYOPBW792BvxO9k68
	RLO6O6k2OjGks3/8L7wu+G7J/p1DwGktcmm9Y8mkqHAzp8HTzYtflJAmDQpWt1P9
	jkAJdC6fDxbnRmNQYywgjl88sdUCYq/D9ficpnRqvVlYp0uXhdaHZWvVUqNrLgTe
	kRCbWw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csqcy8fs2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 07:30:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso12583457eec.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 00:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041444; cv=none;
        d=google.com; s=arc-20240605;
        b=XlRCIK5EaiXnGhDxd7Q8K4h0rl09TxmGN8J4jofpdM+CdZC/avT7q64mIxhHmZ0l60
         JV9H+a0juK9ScxebQQGJyieQ4iABPvSjR6oeHA28JEvonIqBy3DR0pYEMaHyWJq7MhAI
         Mpt9f/Mk/OCXB2sUfP784KmmWVx/tC5yA36ZaBo9/eVN63p+nzrORB9pS99Dc6e+/fWA
         Yw+J0HKoz6bKzt+PjUaoqPQr4AbziF5gmHOoA+2bvn4Ir+BYFmle9Z0bHQrmw/O+4mHU
         DkhGINyuDt8xtlf+Hjzmq876fhLIU2Z6DBX//N2hBZDmhOhYP3eLN7qRi2SdfQ5jSrQ1
         ziUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=;
        fh=uom13i3so/HK0Qx5o67PBbDVQFfT2vaUHJreeEELkec=;
        b=OC+E0PeFYrukJjci2nVDANE8Ym9ZUEVv8OcEmto6MFAW0n8e8q2amZ+rFb/jtq+XBT
         F77xjLj3O2xgu1LwP8rMHyTBOkdi1OFgn2gwZXzx5CGvrZzJDgP+n36MeP2dqOHNmdla
         Mfnm7jyxttnSDFUx6lWX3Xa7ar8O9BVk6igJ6OZnZZ6aQC8SpGNDD/p2CINjOumDb63P
         1rq3nTqk5EXoyGi89RbmtaxQ2Qcqrik0Xfqz31maG7KRSkZo4S9ZSf/X1rauYnd/21us
         VX/NAnckdcAkJn8Xyk2K1UmIrtKtipUF8j0SUm/Yo9n7RwWhS6pztKcc+WHdTxyJkNl3
         7m3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773041444; x=1773646244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=;
        b=Q6/1Gvy7mh+NwQGngFQ8eA3klw/zVldQh2efbXiJz0NGl7rhU4RtbdlS3hkvYwnlDj
         F4xikf9sTyhzsU88WtU5Ai0mw5IrGcRQeM8qQ2kuUgs0ItwctiMNUzxg4ZO0G/vPex58
         IRXHTWjqrrSEbSNvFAv0cnv0e2j5gNz0Fb8X3ieyTaxYCcUkXePxDmfEsBKysnMzfEE4
         /fFC855a+oXXKQeXIcnpTr6g7Q3UrLr/FjFzfR+tOwtclyZtQY8zBe6WJizw0RKCXZxr
         f+uuqBhhzI/fsvWqjPvJZJRYOD2o1YLQpE//1ocacq9kqr4R4CidnSOmpcw7wKPeOuvL
         EfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041444; x=1773646244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=;
        b=YQvXTFGgMBO4q4HuZvvae+vSXZXWIST11wk6rpJjjSWlunt3/uhtwmA3+yKllHenYw
         pIEzDGr4TGysgKYPGviIe05kA6pj7cM5QNLWpslHqpyr1c/KJ3dLyQgnu7jCDcdvuCPr
         EmDuj7HXN/fjx840i04cURdKQpb2SSHH1xJqZ5VD9TEUqmwIODciBYYlql5M2Py19bFn
         729ysUbH/f4geCY7BgBQ55bCgRnkCKPrguetCuD7NrWRws0ViLrlNH+uyY4MOhjgABc/
         lap1pI327KB5Dmq8yebAwhbJdwYSe5piAogCqsv/s2gNrbqGtZ6TkNB220TsmFBcv9bE
         h7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJw6xWM3PTc/2e2Fp534tRO7NB8cF8Es0gknbipvp1QQC1WclglASO+Am8iunfmi7ZJV4Nxb0yX/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtB7IWZAZ22i+mcWE6aLSDfuE4I8XfDfoQa3L0GRZWW0Jweag
	pgasPQY3HPT419XsyUOqrxV0jx3flGZ1G63ppkoQ3z+yYDGEoXTE4h7Esr5PtvqcRCJybCUDdMD
	9ollloWpwXSXFB/p91zRHPkY5pHqsTlxmM/vLK1Mfu1xuWcoHR4qvfn+0D97vXfbgD5Wfje7JCf
	roxUJDV2ZzHojxFisNcNhH4WsvKxflF+xA9YusNQ==
X-Gm-Gg: ATEYQzzhV73g2AYErukc8yiPtQ+t85qi6nLADpIXjnNfT/jFzD2/UUTt+l5qbd/NBH2
	0ORvbu0l1D1wGJqNjNXyN0k1oLt3BPT2IEjZTG0FHLIeaDZzWxEXyTcBsOn1I7Yq44MeyUh09hl
	eRLSkGivmJQOD3BL+Ertwr82KZxOeFoMzxcd/TIbi+fnzMj8b0BbO8IyYWlbgz+DqnNqZK3gAtE
	dmUgxg=
X-Received: by 2002:a05:7300:80cb:b0:2bd:cbc7:16e2 with SMTP id 5a478bee46e88-2be4deaee17mr4001098eec.13.1773041444360;
        Mon, 09 Mar 2026 00:30:44 -0700 (PDT)
X-Received: by 2002:a05:7300:80cb:b0:2bd:cbc7:16e2 with SMTP id
 5a478bee46e88-2be4deaee17mr4001080eec.13.1773041443825; Mon, 09 Mar 2026
 00:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-qcom-ice-fix-v6-0-4dd3347df530@oss.qualcomm.com>
In-Reply-To: <20260309-qcom-ice-fix-v6-0-4dd3347df530@oss.qualcomm.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 13:00:31 +0530
X-Gm-Features: AaiRm52VPpypDsuJ5PtJbOzCheET4KyzNoAC9-1s0jjopDFrH_S9Z9ZnkapMfGE
Message-ID: <CAGptzHP7g3frxtF2UKfUj=TJaJQobX3FrTb+eqRE6p8JPDZjEA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] soc: qcom: ice: Fix race between qcom_ice_probe()
 and of_qcom_ice_get()
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
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2OCBTYWx0ZWRfX5Cj9m3O6kQgT
 SRsKktsFDOHaEjQJM9O7MSi9cbX7gH5rgwUq3EQ0kARJedO5YVxU/s8zo4ko8BpFXGuihayNIkE
 ldwJgDI01zoBVuvu3aluhU2Qjw1snGUog5z8G2bMjVp0YESlpqJ8Gys20Dcmj+egeBX2Coicvm2
 cCTwK0dL5nad3ooGUt7TjGxo56MpKjPBk3tPY7vGPzDruyU3dReOSJHtM+ob3EsB0Cy9ogt8lr0
 FVZDqY0ulv1/1exeAQD3xQLvXUqttEPnK9i7ntRHzIYNWa/DKR3mWhdVOy9hpn7Vnv1wJBXMoQZ
 S3LertHxko095GCJbDKR6NLVzDAnWA+vpQ6jR93DSs6uED2R1DP3zIOwLBCNAPbQLOoY9UvhZE3
 Tneu8HuZxw00/XBa0PGOBDvNcHUu5pLlXhxmgHW1UbwQm51/aUQ6067dcumx8GzxX4GgX7mP5zA
 BArqQRPULN5uz/4puQQ==
X-Authority-Analysis: v=2.4 cv=QJtlhwLL c=1 sm=1 tr=0 ts=69ae7725 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=D8yADozZ_YwZBmLQuGgA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: P7hDpK4WPVQ4o5pPtf9QbnfCT2cXRPnz
X-Proofpoint-GUID: P7hDpK4WPVQ4o5pPtf9QbnfCT2cXRPnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090068

On Mon, Mar 9, 2026 at 12:28=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series fixes the race betwen qcom_ice_probe() and of_qcom_ice_get()
> but synchronizing the two APIs and properly propagating the error codes t=
o
> clients.
>
> Merge Strategy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Due to dependency, all patches should go through Qcom SoC tree.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
> Changes in v6:
> - Fixed sparse warnings
> - Link to v5: https://lore.kernel.org/r/20260308-qcom-ice-fix-v5-0-e47e8a=
44b6c4@oss.qualcomm.com
>
> Changes in v5:
> - Used Xarray instead of platform drvdata for passing the pointer since d=
river
>   core frees drvdata on probe failure.
> - Link to v4: https://lore.kernel.org/r/20260302-qcom-ice-fix-v4-0-0e6574=
0a5dcc@oss.qualcomm.com

Thanks Mani for taking care of my inputs, this patch-set works for me. FWIW=
:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com> # OP-TEE as TZ

-Sumit

>
> Changes in v4:
> - For supporting multi-ice instances in a SoC, stored the err ptr in plat=
form
>   drvdata instead of in a global pointer.
> - Link to v3: https://lore.kernel.org/r/20260223-qcom-ice-fix-v3-0-6ca584=
6329f7@oss.qualcomm.com
>
> Changes in v3:
> - Dropped the platform driver removal patch and used the ice_handle to pa=
ss
>   error codes. This was done as I learned that we need to have the platfo=
rm
>   driver design going forward and also removing it introduces other issue=
s.
> - Link to v2: https://lore.kernel.org/r/20260210-qcom-ice-fix-v2-0-9c1ab5=
d6502c@oss.qualcomm.com
>
> Changes in v2:
>
> - Added MODULE_* macros back
> - Removed spurious platform_device_put()
> - Added patches to remove NULL return
>
> ---
> Manivannan Sadhasivam (5):
>       soc: qcom: ice: Fix race between qcom_ice_probe() and of_qcom_ice_g=
et()
>       soc: qcom: ice: Return -ENODEV if the ICE platform device is not fo=
und
>       soc: qcom: ice: Return proper error codes from devm_of_qcom_ice_get=
() instead of NULL
>       mmc: sdhci-msm: Remove NULL check from devm_of_qcom_ice_get()
>       scsi: ufs: ufs-qcom: Remove NULL check from devm_of_qcom_ice_get()
>
>  drivers/mmc/host/sdhci-msm.c | 10 ++++-----
>  drivers/soc/qcom/ice.c       | 49 ++++++++++++++++++++++++++++++++------=
------
>  drivers/ufs/host/ufs-qcom.c  | 10 ++++-----
>  3 files changed, 46 insertions(+), 23 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260210-qcom-ice-fix-d2a3a045b32d
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>
