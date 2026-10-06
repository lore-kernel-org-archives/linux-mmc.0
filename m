Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF53BAD9F
	for <linux-mmc@vger.kernel.org>; Tue,  6 Oct 2026 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276802; cv=pass; b=PUD/GlxnOHR1qrpku6xWF/qf7puvxZuBZnEJLlk3Qi4tjoLJhPS8aEb8slK4IsVXw2Kve73b1T/tHettab4JindCWuM3CWdxRd7nqktbXYvPDHAIUTSjH7wv+xLbkO/Qj8rTWP4Ki/7STJy/LfvFDC3Y5/RODaI5tYMYXqVMXbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276802; c=relaxed/simple;
	bh=VLcjVIGQA/r1W3ldFK6WW8apuDX6mf7txYWwobfyjFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyL9vwIzbnFxtBRvGq1naEdsbN0OBZaOAETTLpZvT6nRSj61Zl5pegUPgKbpRjA0SCnsFekYr8x0aWP95V2TzMbr6PYehtn5EXU4WUehhkvuzK4XdnwwtakGpvmZxm5tqGCwN+PeT7xcS2v7ESYZXan3uWIuh0WOoXhBWtjuttc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N11QSB1z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qkr4eG01; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N11QSB1z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qkr4eG01"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6967T28Q3538898
	for <linux-mmc@vger.kernel.org>; Tue, 6 Oct 2026 08:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QQGtjGd8ssqWuv/V61Y20ONf
	ksGn+OprzCvB7AXUQWs=; b=N11QSB1zHyJJcjTIZFpax126Tk7PweRduHBLIQfr
	9WI/6tPVU6/1Sq7jSIhD7iJncx2dewrhweyDOeUxV7rS7YUMXPT4CrkLbzD5QgzM
	2q+RyDEN71+5KHHvSjS5clpUzoAVcBcq//y305l50RsWDd6KAR//l+rjuKWZCW2+
	wipkInHf7SGEizuN4h6jeybHNmEW2SJIBirz46aStIzpgr6hKBd8oLIihZDzjNR7
	sb8BuFtQnbettKsV3vvYdZC4V6ZTrDJylyo07DXmfIVN3D37HZ2g3ECCIl7F5JQn
	rUollOwbyfQoRHPqdxD6SfvQavDSjhPpLiyRB6m2GiM92g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4vmrr9dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2026 08:53:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d55d8cd938so39916575ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2026 01:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791276800; cv=none;
        d=google.com; s=arc-20260327;
        b=OO7uY7Ule3vt65FQJAQkZ8zTlwVa+E9BDTP37dZDYOH+51eUt//W47MoRLs4ODmq20
         VYDS9siiKcljkTwUskDkmuXE9dC4mNrki7pnWE/sBEr9BYUkK91pVR7HTtNiS23fBqAP
         HyyLCtXgCQY1Ht1JwQla+DplMDD+pG93ajbYqmH+USl//Rx1vX4SGJSa1KABEbKJ6TV/
         KqoDU/FBAICuSim3cmoU0juGDal4F/Zqs02iacDXY5x7JcJbU0FeYIZAQh2/9vboruAn
         FviDrvNiVyet7M51G7aPVZiNjtKXcuJXDasUVoU8wNkbAgfhL67eZ11cNb9eb3tAEZVO
         dMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        fh=lvskwhgQLG3C3YgtkpgBEBgQoOH4pDtzd9kkoPUAbvo=;
        b=pi7wxrQbJ5RTvGLlc/RkXHtYZfY4n4d4wCdhn91Ag0GyiB7VRxHtG/8zCx8885CH1/
         Ewwwg62f1/x8tyQcT0mezASKAMVtMsC1YbFa4bW0k5U0FNPANtlhQI8J1MtAKft/O+If
         l2SYalaqOSXmmQkmRPseSJBVZ5OrpAqAZICDRCV1oGZRzdG1Y+3t1g9irM7w04SaYlXt
         Fw+Ea2s9Ng9U7BaDZNWzAIRAg8FLZgf/ZuHyqz2Go2KbmlWYz7CLrhLPx123nXLLUkfm
         7jBGISBmwIoq+moLwI2sbOrNx8iVcIz8B8gOqU3OC4G9H6TzsRkFIiubZgR7FP+BJvtN
         QzjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791276800; x=1791881600; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        b=Qkr4eG01L0SgWYMfOLboetbicjTMNFGSU7JPC2tjjTaCTQMktFXJluk6fDheGWWXkF
         6d7cPrJtLG8mTpQnuLYzCxPGblvN/bkY9KTDYnZzUvxRxa6rkoT2L+M2QRgorfM1Fn9m
         VhvqpAfx6GhmBQQCXL0Mwo7WTzdU9CILnTAPSY3yJ3/Uuuzn0yNInynG8huoeQWGxFP2
         SZIZMZh675alBPyodQFoDSKuEbBKqkKMgyjvG8EwgP2dCzYd2bHvnMW+I6D5poG2v4v1
         IuShUpDIMjX/35RcLteyA8vlZYqS331kQ5XLwO+5kQwtjhAX0wyr5KrEAupSG+HMskif
         X2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791276800; x=1791881600;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        b=2oSjJNls1C/MAhUEjaVZn+7CYouUNWjARb7E0e2UVYEisJfhMRZwGTxmnfelC6YY7y
         uL8jMWWPXjoCEYJUKMX9flzwo/mtouhWjQkoeby/ySrQePEa5AoSrT+lf5+o/jknEzbS
         AuC/Honp9olE8eeeN40D2zGaAgq56Fl0VOCjwNrMvdkPA7qGOwWYBV2w+aTiRD876cBb
         J7p51qamUUNUI7ppp3hydEohkEwkHz0rPcp+FCxDHpSWE/5WNwztwjRITGLiG+YKkoUU
         nuosWvDZ62qlYzKhGMeevUnfBHneTqSokW2Zntgtcsu1q3d0EuqbaDGcwkoFhn2edncY
         uOhg==
X-Forwarded-Encrypted: i=1; AKwUvByEANGlO2MkglvlafO4RBlv8hvJsdGQQb9/HjYAny9KFBEjJ9w8bDg+zUFT9LNAD4Xl+Y2hTNrH/Xo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9b1IS+iNCTkfcWQydgFqHHAPh6KDmvIXyQSaqBTP5idtoOUFV
	qgULfMAwicw3iGL3mbtNVyKrYwu6yCJpQ71BbG/OtEDpB1IL+W6B9qd+4OIoqqb4Pj/0KbSiLOV
	T0i2oDNwSdX2CIDTG74zFYdHM80MWSNQrPCUU8Dp3q3QQpv+lpq1NtfOMlAAvnpwR0fb/E7nJkG
	WmJ+SoLASc8nBSUIKyI0jYTmnugX1x5LJw5vlE4EvFjV2PeclI
X-Gm-Gg: AYBFou27Crx1y3rd7DbgYjxUhyiwF/pwi1rzXe2Djviq/TrcnB2aIX6O5fLM+FR7aDR
	JAiT1prvnmN23pt90HNBlEwNIZN+mo2dS4Qmv5pdi9UcOluArEYunTVJTDgDIA57v8gHXUiZRBt
	ak5zsQiLwPpnZpgfXmEsIvH5oi6nEriwx21StLVnYSTFZ5hfvBRRKpVsjfbQ8lEln7f/WtoXiUd
	JpKtRPncaP3rGM=
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id d9443c01a7336-2e5dcde4da4mr6597375ad.55.1791276799663;
        Tue, 06 Oct 2026 01:53:19 -0700 (PDT)
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id
 d9443c01a7336-2e5dcde4da4mr6596685ad.55.1791276799127; Tue, 06 Oct 2026
 01:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <179098834078.3641559.798772743228949994.b4-ty@b4> <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
In-Reply-To: <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 10:53:07 +0200
X-Gm-Features: AclHuK-hxeLXCCkrwwvQbFIYUVeIjRX4eEFvyGsggP4ez254hGL6BWI-C4KAx08
Message-ID: <CAO9ioeVAf2GgS+wu9GiQ3kM-_1KnrdMfhcpVotxhiFegEiZP2A@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=XZ4cX455 c=1 sm=1 tr=0 ts=6ac4b700 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8 a=OuZLqq7tAAAA:8
 a=wG-LvS21qxlCLh7KYX8A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: -4iESM-IuYZHHTGq2RcDdM9fS3XNTrBj
X-Proofpoint-ORIG-GUID: -4iESM-IuYZHHTGq2RcDdM9fS3XNTrBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfX83g7YyRaSlrK
 bNXrBymG3m6E4nCDPLXV1LXT/F4XGet008BxYZ/4pSkULxLMva+QhbMtEpoBa9SctBb9unn/Chc
 RRXWRo9PONuAsOB2a++vHJjdfIp/9Mglw4ARRik6dSq4pMC5KjLT0ZoiRDqewJdratU9UFH3g+O
 YJPgcEG37AJl2cxq0T0x0BojQkYxRrxAuVsaw4OZr4fM391eUiTgyEaGmpctEZVs6a/9NtxXXe1
 aQPm60uTa/BNqEsr93hrIAp2jj3QKFPYGeHh0jlQEEJm1nk1LequSdgGv0pUWM9i7jvGfGX8e+S
 x8uqDN89lmQmTWIkFF/BPsBqRjaCQSmgECEF7BEbMOhXyoZjxJYJym9vF23wj/gBbYj9mV94Ssk
 TF5/H2qjPcuVZGOpLID8PKprNW4fGdfCF2YeroHZCbEZP00wDQBtaGz4soiNt8166d27Rjb3hSW
 5bip/KrAAZwxyHyS+mA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfX1K5QSvdhY87E
 yVosaah4Cei3WsfzC9V+voWvF+Zn+enRK0sltCBsH0pHRrK4k+S1uHMH4ekQgaQGiNqTME+T1Kr
 F8DdvPej25sBx7O77Fna5dhR8l6qN0k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060035

On Mon, 5 Oct 2026 at 16:00, Muzaffer Kadir
<muzafferkadir@mainlining.org> wrote:
>
> On Sat,  3 Oct 2026 03:46:52 +0300, Dmitry Baryshkov wrote:
> > On Mon, 21 Sep 2026 21:18:51 +0300, Muzaffer Kadir wrote:
> >> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> >>
> >> Ported without uart connection. ramoops and usb
> >> mainly used to debug.
> >> USB is not enabled in this series because it
> >> depends on the not yet upstreamed (and not developed by me)
> >> pmi8950_smbcharger.
> >>
> >> [...]
> >
> > Applied to ttt, thanks!
> >
> > [01/19] dt-bindings: clock: qcom: Add MSM8952 global clock controller
> >         (no commit info)
> > [02/19] clk: qcom: Add global clock controller driver for MSM8952
> >         (no commit info)
> > [03/19] dt-bindings: nvmem: Add compatible for MSM8952
> >         (no commit info)
> > [04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
> >         (no commit info)
> > [05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
> >         (no commit info)
> > [06/19] dt-bindings: vendor-prefixes: Add General Mobile
> >         (no commit info)
> > [07/19] dt-bindings: arm: qcom: Document MSM8952 SoC binding
> >         (no commit info)
> > [08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
> >         (no commit info)
> > [09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
> >         (no commit info)
> > [10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/df6ce9e6447e
> > [11/19] dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
> >         (no commit info)
> > [12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
> >         (no commit info)
> > [13/19] drm: msm: mdp5: Add MDP5 configuration for MSM8952
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/7af226f9aa59
> > [14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
> >         (no commit info)
> > [15/19] dt-bindings: thermal: tsens: Add MSM8952
> >         (no commit info)
> > [16/19] thermal: qcom: tsens: Add support for MSM8952 tsens
> >         (no commit info)
> > [17/19] arm64: dts: qcom: Add initial support for MSM8952
> >         (no commit info)
> > [18/19] dt-bindings: input: touchscreen: goodix: Add binding for GT970
> >         (no commit info)
> > [19/19] arm64: dts: qcom: generalmobile-shamrock: new device
> >         (no commit info)
>
> Hi Dmitry,
>
> Thanks for accepting MDP5 patches.
>
> The message lists all 19 patches, but only 10 and 13 have commit
> links, the rest say "(no commit info)". Does this mean the whole
> series was applied, or only the MDP5 ones?

Only MDP5 ones.

>
> Best regards,
> Muzaffer Kadir
>


-- 
With best wishes
Dmitry
