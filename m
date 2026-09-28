Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE24413799
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603871; cv=pass; b=TxUvId+0xBZwO2v9A6rHKEIw9F2L1RfVxH4yHwsC1pFGvw+WkAWvCK0GWNkhNyRZEsdETeMHwvaYVWG9M/lWy4fqBEwXgJLFoYd5RINjqDo1m9bdffXBej6BR+xSf58uKxD2k0SxxHbFUig7U1ZTw34RKv5Q51cHM2JZwtpIG5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603871; c=relaxed/simple;
	bh=N0apPBi5a5rdeR6XkE9u3uUSLlm4uI9nB9Kynheh+l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LegwDX715uxy7kG3styXTssGHZpG2I/ezztr5G0bawYNmDt2WsKwH7RU/atwsugl7aDAfBij3K7scPyuukFHWsC4RKKmygMTkMi49PTPG2yOkv0H6CYdFPxNRZ9l7Fxv1oNFKlUMfY3m0MtBqV1UQ+hbGYfa8C2/2snEj1QMt4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4tRZgHZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gZm+5Tke; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4tRZgHZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gZm+5Tke"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBANZU2294771
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=; b=Z4tRZgHZskb8ptT5
	TWLgXlXd5ZEfOMXoSIMOXv3xiSCfmZPrN/BXEN2Jx/EI7xgxsl/mhtg23qiOqhBr
	lotZeIr931hrlSEd5cQ/+wfndIUB7MMIEPhy0N4qQaoL3vx0QDP3gKzGCBMkjA4K
	qZEViEARpzKBw/bZJdJ6k6fM60UXmpX36/eFY3dIVjAN/AFSwPSLBAOzinZyFOZG
	8mAxM8Svcg16uWsn2JDQlVfu7pS1jD7EKG1O73xL6IcpK9DHPvN80Fj2n8ZkDcIH
	gzgCPX/52m/fh2UgSttxIDJ4qB8q8S1LQf9euuiVEAdLjZcrqYl5RVZOicTCxXKu
	X1l8WA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubhukc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 13:57:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86261e66700so2235433b3a.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603868; cv=none;
        d=google.com; s=arc-20260327;
        b=EV+OUqXQbO/tOQbp+CZtYrrA2dnlKGPJbR0cgZ2MKFf2xIlPqfUH4DqNmVQ6WBVp0K
         dhNxmfwBmDyNLImMSwXFBYmZfjoXSJdnm5sNq/WdXl/AJhdO0pkRL93oIKqFSNIV/Kts
         yYXAQjbZ7DBwoaF0ykmvBR5pNXsZvDxSmu+X/SvU0QSseM4mJI0mYItymLGZK5+wde2J
         HL/kFqW+T6ao5KdxpBDX9l8/qPPAUhzastRaLDK7GXFYs6IU0AEV5KJV8klbNRlI1ejV
         wbdxnsX41VHDEU16wRUvVetcoHpb9lveWRiu3pF+yl15uXCycCu2wP06rzLw9qdRycBF
         unsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        fh=OaKB25IAPJ2h0qAPA1pJoRrCGZnrjAUpZCiuLjubSfY=;
        b=T3IiYpFLP9q7MSBbYttx6nCt/1yF5c1gJDr1Q4U18sZQF+IPp+IQYeUaybM8FwoLP9
         gCG/M3jNpzXS2N71ENEUTVhRl3Ve8XQddWnUn5jsWMhC5j8Z4IeTnO+l37jKVd/rAfvH
         NkWrZm3+FHewe5pcNLijcWmk3W62g8xdG5auX+0ITUyolJjDufZewyyQ867YiExtuuvB
         E1I1mx02FXKEod5fD2TWVTN8WopXvQrRV6HWNK4JPY/wgKXNDVcXc44yr7wprhsTN2pe
         DKh37MqFDc2WlS2JkWmqc88Ml+L6H/rSiVkobqku2DcSl4mbr8BpI1b8l5pwC0nYQVJp
         3lQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790603868; x=1791208668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=gZm+5TkeNiuNCWoMFmByiGuXPWyeZfYVqr2uIkJNz73oKjT5kMP3a1/PLCH20oeLe0
         xcvk9SuiHU33LZ55Fbzpfxo1NFE/GBDg/vuoWelGhue22jmQ8AZDU0QRjzBVyuk62/HK
         pohM2L7obX8b66ghXXB9PSYRPQlEfxawvn88RDeEYywCxhFFV4rkCqwxuRdiC8P5I24e
         wA+SBuii5pGi4MhJHWIoXYSph59G0Q0iayJbv5z+vVNVBDBVkY21N9yu1IDSzYOFOi1j
         XrXt2aO9RGNzSTW5/ek7Wg9xq+o+xZaDAI6G3NrmZIDngCZvK9zlDMcXh3IiziXH73n2
         ybxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603868; x=1791208668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=gwtovLE3zubrRXT+OJ3zYqmLk25hwEzhlx1sDzrgcxSEp94629txaVs0dQydfqMB8w
         dXNwODIlpkMX+vcmGEGJAueBjXSmMLQbjb/GsnBDIbxqAMTWVZyNlgGLusngwDYThAI0
         NAObWW6Rwr6y2kwAENwz0iJViDOGCQw2nHdYgcFzYb1pu0zKG7KkOIx8hoRtet+kaw/L
         KnQ+DS0XBoSFICI6XtoYJEQpQZDav2lK2IPF5TB/KGLnyUSxw2idWQ69vdDLVmSS31Jp
         ssJM/3eT13cH4cytoqATtxvdIFhIVuUvJ9O1IOZd6iiuJLLyfzKC9/cChCrMUGYFMUjH
         Wj9A==
X-Forwarded-Encrypted: i=1; AKwUvBwEH3U0fW5fmFJq2bzNaaxBi2mH2LUYOKFErem8WZpaDwOw5E7k9nPYVNL430+Nk5+50fLrq5o7Hus=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTZFkLk6wMA25fO5YP1hDWjqrbVti51Zr3aVKnwHWJq+C3G8lU
	mFj7gX5BFn3QswhYqo5Lxa2SSC6XJtrECMKaQZNnpY25f6entXkfoJvDq8vHFHPp2CLDk14XkwW
	wrqUqeagB2irkcgGlvCEuGqGJa3ZB+5mAnJ2Z4wkc/pTsZIOCYjUnJiO0YQjy/8UPPYz3M4Kk3s
	FiZ+czbUHgKpCLu8oMM7ytwc5I04iUq+hK9IzfYQ==
X-Gm-Gg: AYBFou2c/aTiE46DfdUzo0c6+aBY16MYiA233hPK5ewHCzjlmb//fbdVOPmub5GN71w
	k2lRH/kKUG0afTnUu1W5SreHofW+/vO1WEmOQGnd8JrWdssnrhiL41HEuTaTHuZQ4WDQ3apPxsV
	jmizVgeFauWViJcqCfNMrzkC5wcT1yqBxmwYsP9IufJ3WSqhDWY9eYJ79EQw==
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id d2e1a72fcca58-881c8819a45mr4006727b3a.23.1790603868138;
        Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id
 d2e1a72fcca58-881c8819a45mr4006707b3a.23.1790603867726; Mon, 28 Sep 2026
 06:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:57:35 +0200
X-Gm-Features: AclHuK-nE9h16BssbY-0V-0Lcqrz78yNjoqqCVRnCD5BWpC1wzqbo2Hd-T05VXY
Message-ID: <CAPx+jO9Vj=42dHEwLzTHe1b+nrvip+ibVv4iPquxwJKbFAkm=A@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
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
X-Proofpoint-GUID: C4kakTc9C_aW4bgM5a7zM8liN_o8k_Nw
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba725c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=xo1k5ONJVskqAlz3UKAA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: C4kakTc9C_aW4bgM5a7zM8liN_o8k_Nw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX39xB7o0ONB9F
 K8ZqpjfHNFfhysGyCCwX0pO08ekJT9G933MGXpQYd0qsPjSWWBJ6MrAJV+i7NPMd0BUw6nUAlJ4
 SMIPF40YyS+jsUCbbeTZin5hUcromjvzt+R5Jf9SnsgxhzB99AgBJ8vbjjSnw1kl/PJaOtURtnU
 AfNiK1xf7Hixupuygl4llMuKzPxvTvWj3bn+2t4hihrcqRoERJWvN90k4FS/rk41tKxhaMiOewr
 FnrKPjHNj0zU2m/kcjcRcJKJLmCtwatsi+789D0EPuEeh/4hxj4SZPYxixrxsXYRvaT16dZDslS
 mu5s+CGVG50QtbQDbhj1QHoiZoD0gVus3howkhlS6bi8HVDC1KFDWDqw61qgTQermTrdKRslIjF
 3ceMs9KksAe1H3DUyS3/8Lpo3eH6TbC7WtMOtnC5DgIGBDgB+5xLBpw62PYB4Q6OAQt4rr27Pjq
 3+c4ZSuO4GZzHWYgx7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX0KXSd+fN+ftV
 gA9AJrcAlTpb2I9V35bQeelzBGGprojD2VJDQPRI9wsMhLCXOpCZt2qI5mv5nXEBVERseHlNwMp
 VjosWuNE0KnqJ6zgxHBTUr77QjQBUi4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280055

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible for the rpmpd found on MSM8952.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index a70bfacbc5d1..8ee1c25a7c9d 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -76,6 +76,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,msm8937-rpmpd
> +              - qcom,msm8952-rpmpd
>            - const: qcom,msm8917-rpmpd
>        - items:
>            - enum:
>
> --
> 2.55.0
>
>
