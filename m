Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14394266A8
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065945; cv=pass; b=S7ixTq9Nol2Vx9Ei084CDxiepbwlA0OS5s1E7XEnSPOIh6tJhHCaPfeptQzFpgNxM4xs2x2vfTkvdp8TapsGWrBpOZuZksRpgix2iYyQubvSNwVYO6iaNdHWhnYC9RHYG7PHsswd1cXEwuVcI8TA+7xT8CI1IY10LRVLETNAcKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065945; c=relaxed/simple;
	bh=bg3LTAhtOBZMXXzmqiwYxZS4Dn8DXShYDUETK4a0IlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoBWmsLPCb2f9fJL0spA4K5aoIggZB43AD5V1FrQeLvMsiINC6nfJ3+GxDF9cAFHiimfc9QNLP9yJuVvnGgXma2WnmeTKITOytnvb8fonDIwZ9d8/cj09xynzJ9FcrJDXmYoe8Y/r3Lq/EB2nLTq5ho33AKhnanVauVtvlsCNA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMgI8EOZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XSgPew3q; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMgI8EOZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XSgPew3q"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDLFGh154847
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNT/STDufn46MsW8XTJOiNXVFj3l+MigpitoQ+h+900=; b=bMgI8EOZASGnpA1+
	l4qwiCOgzzguXaMkIl6KltUC/CPoJW+P3EQl/NadaMgfZMC4QeLQlRwodKvWqKap
	jmp49FgZ4EQ9FqJgkCq0lbThdc5k6D3aNCSauynFebXTjdtawDrZVQaOqd5EpfPh
	OeTjuIuVHb+mFfcYkjoYfRrqbs9Eib9wTyvP/iiEwCz9Xyn3gpzaU5OduU7FgbWX
	lLQiu8U2+ISADSCfaeSQ2oEHe7/QvEgk0CB7dbQHht0xL6DVSGXRtBcoAt6BxBaT
	l7fT7v5pPJzhcskrImBPDhcJI+jL15qo1jpXDgMXVVmIRcwODTjG7u+eJtB9fhK7
	wqaShw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eeuy5c8qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cc01da8fbeso118208316d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065942; cv=none;
        d=google.com; s=arc-20240605;
        b=jf/oxur9XS4nHEgeV94pj7kg0NeNin9OSXBIVNMuEqMvArfyMbxOxnn3Yii/exjkFi
         IUWcoPX30g0v84vAJ8ZBdMmwRYzSEoGOh65XNRQ4bugkekctLOMHtSEgDkQM216s3y9d
         Y1ppzdEjJTRtKv8YAvLjxHGnrmhnGwKPHXrKQgWnDqd9s4AujGYWMZGx8Hj3Nb5JGwP/
         fo6Gque6wsyY9f9A9tZYWNnZPPNa9nHKWXxhn46dAXi+zwq8NuCzTeKXWnqv/gRL6mSu
         LNwklIriFVf9ltpzHeTMmT88bdZn4z8oIro3/OQMb0173oM5UgU8TdWVmURsnA8MkdyH
         toUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZNT/STDufn46MsW8XTJOiNXVFj3l+MigpitoQ+h+900=;
        fh=IVhm44zgGF73dBNn1Xrc2BWlZhGqyectBP/9QI/VWR0=;
        b=dmly46BJ9aQ3A/APUFlPez64/+g++u6P5e8Tc6GSytwu1hV7t0YnslBTg55SAFv1AD
         zJ/np5+YSJdA4lMha8k8yRw2zzO5yjNbDxvhWKCP9UCnP/QFUE7P+fy0HFw2VONPbti9
         r4oi31Bm/NNQrKveOAKMxLzLQD9AyHvnVFGalhE/ChWAdVr3qT1XPEhhsTlYB5NIKdWI
         U2XcwibfP3TLoz+9s3F6omTRbzwhjsRgHwnYCJidA+J8BO1iF+GyinDgX/tX772zrvCX
         q4uEDbGyaoEIf1RPhXG7cuDgOUEqnEG9MkfNuhp04wXNypOuV8vwqrD5gMbUbZLCTLuw
         ie4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065942; x=1780670742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNT/STDufn46MsW8XTJOiNXVFj3l+MigpitoQ+h+900=;
        b=XSgPew3qn9d+tH7MargyQ7ZXTjwnlfKWc4F65rjGfLUiidV4t3yWlcX3dnWgvDA2TC
         FGoIXYlj0Xt1VkGqTRspJm6HEnKXtYjVaJ4z8mPoyNNU11cG2mBixE6u0mv+iFO9+KHF
         JslKNMyL1bZGsef0TSJpBcuZ6Qqu+NSdzLATt37UBf+oSuSLxLfm0hhCvDd+gJ972Huk
         8zCK+eDqw/eqvl7JWrjk77mLVkQVs/NFfiZ58foDpSXXhh4P38uqdCjXEqj3FNX/rK3+
         8/Ft5phHBrff1P5J3Sp4Odqag6dst3CoBy3//PoqomVFjC3vRGroBSrZHAdjizVE2zHG
         Jiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065942; x=1780670742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZNT/STDufn46MsW8XTJOiNXVFj3l+MigpitoQ+h+900=;
        b=b2Icormg38uK2AGOyHkSwed+CadCFW7LwfCMTfxYLCaQJjQkIXD5IAc/JZhSQ8X2M4
         5QMySXoQI9KWfQI/9qyuTBzwPKa/au/ZVFLSIIm1xAJPE+x2m++r1B3x+1pwDEknmvPG
         11+KBBWol8PeQBmTBLnW+j+82wU54djh/0V+gafuPykr487EZuSs0pSFIi/ps6KHus0l
         m/xgUX5RnoUIn/IDoeZhADUaE61Y5abS414Yrqe71dEtLMJNIB+V2NHnUZSrJHVc1dJg
         N8opew6clpIOpTGIUJ9505GKPcH2GpDcWDJ79Hb+5UAA6vopHGwkgifakpfsXY9ypKmJ
         x7ug==
X-Forwarded-Encrypted: i=1; AFNElJ/68+kjVvF9tXrk13EKpilk5Jmxo2xhwcYw14zBacBb6y747YZkyAuJCRVwbTcHHX8BrgxQCTqrD54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx36PtBz3UoV7y7r7otwUL304Pw0cgCXwhuuuU6qVA3bVQJ+gBp
	nNG6DnH2G6IHmwj1j4tRBAOWdGvJIP8vredTOj4vebqzlsFqlIGa7T6qQmmmLSF8dVfMgWhjmZn
	8dZjTsT/UKwI60IcttZiblxOFrxwpfnpOcII+5+jewS5LUpr8g957TyE+GVprpr8K3Gbjo8pU5M
	eQ0vXBnN/TNVf8mbBEI663x8rHXQ9CvGQr5PXQCQ52r3G+FA==
X-Gm-Gg: Acq92OGIGCwZpZnXY65vjI6VOKwlAoBjlbyWOsg8bmh9ZUyec3gpu51eMiRc3xwvAQc
	d0i63dOH8+O71k5Ohe5fXPRnKAgEedZArpJrj5ol/arAOan7Zmi3CaVZMlCbP4xszr6STHLYuRH
	owq1+PYyj5bkBul6GKZcUuCz+egaAZ7E/u4VolyWNM4smIIPwEG/u8yRc3FV7Obaph9PywgksWc
	uVN3pTlw+nt7ym5DA==
X-Received: by 2002:a05:6214:2f13:b0:8a0:d08c:a720 with SMTP id 6a1803df08f44-8cce8009ba3mr46872306d6.17.1780065941618;
        Fri, 29 May 2026 07:45:41 -0700 (PDT)
X-Received: by 2002:a05:6214:2f13:b0:8a0:d08c:a720 with SMTP id
 6a1803df08f44-8cce8009ba3mr46871746d6.17.1780065941236; Fri, 29 May 2026
 07:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520075445.2146152-1-mukesh.ojha@oss.qualcomm.com>
In-Reply-To: <20260520075445.2146152-1-mukesh.ojha@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:29 +0200
X-Gm-Features: AVHnY4ILxN1D3bGPLo_Xd90zYcPQxgHpc9Zzsf0SP2F8swcrwL2vE9YowRwFUaU
Message-ID: <CAPx+jO8aEOdgGGFZnmwxfGK0DWXmCT1MW56RTwj_T=x4n-RA+A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: qcom: Add Hawi compatible
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SPtykuvH c=1 sm=1 tr=0 ts=6a19a696 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=P8YsWRJYj8jjKQ0leZkA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: NubyhkmFo1i-7LnbHzsMuSOPMd_xrmf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfXxOKaj18sUfy9
 YJZfrCsnv/YlVtn1lpZeBd3nLLlyVmM9WR4OMd4fZJ4D1NNIJp/4H7D5v+peBKHxFvYOwEVuq0f
 eh2i/cNYaX+5mwl+V1SCBf+QkOlwbjlpR0l9VDuOZmZfII6NpjUOYVDc3wzf0EdgugxARe+EHGT
 74mkTRbKEUXwdhJewrskzjdSE94lbKcxuDQ/VFJRA6wr4p5voNojYzrxsl0ZDKcfxs1H60vuWiQ
 e44cyJu4u9TRECR7LfoqR/xFNPNF1jteWeRohJISGh/QnudoAa22p8OfmnZLJeuZTI1Wg03sYDB
 5iWC7cawRdwe4l/IzSYtXBKvlx4NlghULglU3tVMZalMUYyMnsFm8aRHXv5Q9kYHy8nAH6Pcm0h
 Ah9ezm3jjG3kzKvm7o7DN0G3eix883p94B6N7kQtG8jQhxnpuB/Pufo+yUnSWFewvpPi2BEoLwo
 XQFMvH8NF30GuzyzqPw==
X-Proofpoint-ORIG-GUID: NubyhkmFo1i-7LnbHzsMuSOPMd_xrmf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290147

On Wed, May 20, 2026 at 9:54=E2=80=AFAM Mukesh Ojha
<mukesh.ojha@oss.qualcomm.com> wrote:
>
> From: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
>
> Document the compatible string for the SDHCI controller on the
> Qualcomm Hawi platform.
>
> Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 695a95e8f35d..acbbbeb2be45 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -37,6 +37,7 @@ properties:
>            - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
>        - items:
>            - enum:
> +              - qcom,hawi-sdhci
>                - qcom,ipq5018-sdhci
>                - qcom,ipq5210-sdhci
>                - qcom,ipq5332-sdhci
> --
> 2.53.0
