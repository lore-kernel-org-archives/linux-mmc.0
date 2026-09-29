Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035A52BE3E
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688871; cv=pass; b=syKkCNPR+BT+SnfuJ88XjVsTV5ltI8dZh/3g0M2RBGKjnC08CgVMeGkO0Q7HG37J9r9Jn/OyLjbs+80jdyKzURhwof4+dBJwY0mEfrMc5Fl8DNInFf5e9Jh6wQOuP/g5c5d7hE8ER4Qm45m6qaZUJMcqeS7PxuK8NtnX376xvY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688871; c=relaxed/simple;
	bh=aatIQCpb5b6E18tOT607YiK+lREgF4JTQbKPFrO+iVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBQB6ubOErzCiNPnC+yXzxVCFmZA6/lf0BGsVMITOY5hoKfv3Xc35rhvTlKSfNuwTG70HguQ0gbin/NvJSLf90m2ffS3aLPFFREbMsTBaOW5hjN24cMMXPoOajwS2A+V9LCbrXnGWAvWaZSiNsN02e7n2MMSmjmUYwT4jWmptwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hk6mvLlV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MnW5UteW; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hk6mvLlV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MnW5UteW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqoAk3936949
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=; b=hk6mvLlVWv66MepN
	iXjqUBQgGPOer5qnBJte12x4wjPvxOCEYL7J06CYjn0EHwKp/mQIZhzGf/7PTCrr
	JPVMRa5P31yNjd0syZbjgMb1SqSQl0EhM88wLqYun1EFTHMdFhjcUQaYctLQJvLB
	m8rrLNP8N82Uo9R+rz0dot2NO2Ag+BRrRZy3QHNaATzsOSBlDlmyQoF67xxVYAwr
	6AvhbgJpiztMCqAaEVjfmc1yrAp8Qnex8FnEzTZH2Oi00Q9D6r5JmaAxiFebRClG
	r3l0ApPic+NoNoV0+qGAVh5h3Rn6Nx3BILxnO83SaAFd/J++STdI9TWC1odBWbQy
	41skTw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1grd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d9336581a2so62301025ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688867; cv=none;
        d=google.com; s=arc-20260327;
        b=BWJIldVk1PGclopZpK2q5WqPGUasYPNy6esXo1q8ApAi8Y6AQlrfzBIEA1rTPp9WB9
         kDQP/a6crxpL21AvXb5N5IUmQXxCXXP347zSoxavoZbLKNprafQYOMezLvbgditqpNKi
         ru+oo08tqQfYP9L/aK29Jy0ZXHkNWs2M6EGNtFRUqyqx9DFe/OlibRZblSNcMZg/TfmT
         P8JfePFPxv+0jE2PHIe3GuAdHKv+/O5zDiMPYilil7V7OkIs+EP8uGtxFW594UJzeu2L
         2GCvzYEIVlVNZpe9+L2UwCGstxf5hJWiQu1s5Af6Xt4UP4lNyM6X29cQ9gQZXbECzspg
         Lt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        fh=z6aRTIXLzhRl+y66wwMuObhSXOiXIp6EAZnc206CdK0=;
        b=RJoFm7UFpmw7WxWYiQjzvv46uHsgfCNOA1zYQeKKt7vRWzW2VqXJ6XDDvdswBDCEhZ
         zNoKXx6oobIIyJ8+OUDUJDSci5fi3z1mNXbPz2Exd/p2cLsTsOTDUq+grfEm8Mys0e1G
         hNkvA3TZsRFjxtm34txWJaJNpzIZJErVm0ovDv/i2Y9/Srx5k3rYBS6BD6qZNvoUqe6y
         tBGoeFcobT2qcz4QF3w1Bfc8lCCDA6RyRlwcu7h+b8UCSm4vTOsmKq+oEXdMuIHMdQwt
         aiyyvcnP1kTY4DBjk/3jBr1ywgpgd51WpvMavkd6kQxQHM23p1CNjBcbFHn5rDeFpVlZ
         fyew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688867; x=1791293667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=MnW5UteW5tCkE0domqFe0WMEddVoAo24BrHbfCGicKqHJ7zswfoA07vSpvD8NfqOnE
         fF8ELmym2xBwXyl8/OfGKwGsoqqQxQokZj3gd+Dq32ZPO3DRhsUh73z2LfN2tdHpGy/H
         EPBeds6ekZJPCl8GDtF9YdK/apasEgcCZd5m+U8eKxUnzX94w6I8HytVWl5AvvjGs3zR
         DpK+qksSdODDf/RHW+WZU/BkBWAdIHCAI/QR4tzPiMQzi530jEw/yRRLhlCn3CDzzxlv
         lqWsAjIxiU5+U2yWw0xsJgp1V2E0KCF+z32vgJSxHnU3S1tTCcTS6PAXS2gHKiJQLrhb
         2M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688867; x=1791293667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=bxjWgsnqd8bcdjD9wT7khXcXAnUZFQvzLWHkMwxH808jaYOhSxztAm3GfONML0AMWb
         Tlz8uydxBO8D15D6B+NVWr1eejX2HTCAGog1dECrYZhWzlENt3/FpVc9GKPtr54QGcnh
         IVA6LtJDZnjacxeGFyeTCnXvGad12pemdvGn6S3hDU9pif+c6ymbU8/gS/ryBZ+HKh/C
         wt93LCenosr7xlMDjJOeyL+zmvuWQU9IWS/4UrdYkpjSIeqGXR84EcAkY5QBzUV1tdJV
         O7IeoORd7ql7jTV1dW0QBo7hIrZ2vM++tL7CG2LkEEsMergrNb7WQ1CXp4mGMypdLJzB
         /JQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcjlkurrC06shvl4wKOds6ewDgD1DdNQTcwEzjOE1CfKWeQHIZJynEn3cwVpWENO96vd//oSp3NLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdweYQ7qMm/s6HJb4o1+SIli678mEmlq/sE5cbfBnyTqcZLHt1
	wpxqGGHVRIsjjn69u1aDIdoyNgCJCF40YfdBamaU2I8rPBUeMeGgRStHfmXWxNt4pBLXAYnhrQ/
	Qxb4vbShLBVi3GewgcL0Q7xTLHE4ML4wqQE+twIGQp1vyUKpyZSMFqzNk6whomnuKmEHlcDRClj
	SO3xN3JJNAMhXIsO0qgo+tMWr7rhz/Uf8YBnMRKA==
X-Gm-Gg: AYBFou34ou4pFiitA5QDQ7FmuH7DSW3UWfR/PUvso4xpx3DkB3ianHyYiYBOf2QZjLo
	9U5OGR4LFeQz1Whc8GEvRgGvYa5i4O68FD3TENEtpHHjnv9YWgd8pKD/u2Tu299RBhPhX52fvxP
	UFDB8QFtdxTsbSwnO0geMFzTV+uaNet2eaEn/VhgI2vLrcjTpbq9LpCPp0Kg==
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0bb60e74cmr11071532a91.39.1790688867350;
        Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a0bb60e74cmr11071507a91.39.1790688866886; Tue, 29 Sep 2026
 06:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:16 +0200
X-Gm-Features: AclHuK_IsoMVZ8jA--KFIskLK5LDOvw3Q0lyiLyhAEn2l6B1awM5w3Hl8Ax8gbg
Message-ID: <CAPx+jO9qPRgae_VqWrGQ8bhDOHBf+zDzw3A-BxCMa25XfPaa7Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
To: muzafferkadir@mainlining.org
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
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX86hP7HVV7tPA
 9ChfsC7c9mQ0np8i5VoZGic1O549AxOxHVkRDiEjoWiHMX6ShbfT+kIn6hcExc+4D0ouKplZS3L
 hmZMTL5HtP+c6aawa2ERU3FLsVU8avI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfXyVt8K9+nSMfW
 TNheOnrpMsN92V3CoKYnRJXhR2pkDrClRqhuyalG7FgqQi0RPxzB57cIIlOTBJUcOQSrtRzisp5
 galawgLzq+o8HYvcJz+GpG0NGIBJLmqyh1c8bbtgJxARy4r4dBRuRjFGMNlOd98n7FnLdLCaxzE
 K9T5rmEDZUj1IGdDX3QNd/cj9PUvzAOSWOkBIjkSoOAG2FDi1it4Wu+v8eFLdesbLQZoYEIac7L
 yeOhHf6/GTg3kTWZ69qMolAmuSvZuEVT+MROAtgTFhu7IyQtm38s71U4cwYib1Q1hjk1NHLX8Ar
 KxSnj77h9AYExvhjIL3ArXPlg6SoP+ORkgrZXb7deYlnvw/AepP+vpCCnVVf5/HhHadQh/9tlEI
 7etoJcpp7MmPr0qwsTN3TGUDZorkPwAjDKi4sX86WU0zm5YsO9Z6+C5ZMJ57ZK5DxV5vUr7wz2q
 MkdPTV9sbnZvjrKnmSg==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abbbe64 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=wO7LUizMVtHDz2nkp9wA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: caitW1tpMYT4ziK2HlIOnwHUDg-LVjBp
X-Proofpoint-GUID: caitW1tpMYT4ziK2HlIOnwHUDg-LVjBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible string for the SDHCI controller on the
> MSM8952 platform.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/=
Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index 69bd44e65ad7..9d4409c958fa 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,ipq4019-sdhci
>                - qcom,ipq8074-sdhci
>                - qcom,msm8226-sdhci
> +              - qcom,msm8952-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
>                - qcom,msm8976-sdhci
>
> --
> 2.55.0
>
>
