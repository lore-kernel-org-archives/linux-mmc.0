Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B439AD51
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665899; cv=none; b=rjbL+HlMB3dawQ0ScvpCxsG9Rz4kwC82VdtWYVVg5iVafT6GRdy6h0zHO5nWPzakNNmzUF/7H2+GA4UmS1TlQJ+9UKymv8aV7g8tBIOP/PQtR3w7wi9iifl7V0vAQi/0ea2XiRILCLgJmmmwjF3EBj6yfwS4EoZ1KuBKhcbOskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665899; c=relaxed/simple;
	bh=oz5CN5RjjP95+hn3KIVzqIGYCeN2q+QJdx0EvADSitg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlIDehDqhFbcaxrpEeRpZa54be2VpITWX0uwJp1EgCqiMXqW2UWeTcbXuOktB1i8dswBGvoB8ELfIbbk5GEgz8x6zTdY1SRrDTfBRfshkbLqFfPJMn2NYWDqnkaXjs5gq4kPcwh6o2IxXmTkshDvxu+toQuQ2W3lM8HLcexZ2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pdxl5tYh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=daOMATY8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pdxl5tYh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="daOMATY8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47HQJ2774970
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 07:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DGbSxQ+ordORojocaH0U5BkUwxizVp+6KhwnNAplOmM=; b=Pdxl5tYhEsfAnRXT
	gev0v8DJT0KstEryTCVz3088i/nuuCAK1oRYjZilhwr4Age9XdTRoj8FMAqv1QbN
	mhjZXBZ9DXbDjS6qDfqHdzOSKjYvO++wHZ2odV6sWLLaa3M07Libo7ldgLBeq9U1
	/oIMNwFH5JZahpWHTA+uMzjXJVJ1SslEC719LpjkiHQdJDmec9XCWs0QmLDycbzc
	NReNLfiAt+tkCeIsmJ+9+aEUpRaQ6VD81Pdn0nUkcWzWeCZj2g+NpY3CDdu9ADq2
	R67FXj09Q1aG1SIdpDhH5VmnpXRH2rGpF/WWRmANT709B88sXCu5zkJpxeFLUw9g
	UiP3pg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw22r7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 07:11:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f3426a7cso890817185a.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790665895; x=1791270695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGbSxQ+ordORojocaH0U5BkUwxizVp+6KhwnNAplOmM=;
        b=daOMATY8OkyKLQzQ2Q0wFt+/ButrCKfGKvSHs4yWDwon+qkK20T7dTuqpUj5dHHzDz
         KeU6ssolw6w/q/htfLQkQAXxpUbE+Z61VW+LecdGeqi5f5Wac5n/5kZ0n87JoX/XmhlW
         RZPd5QbbEHjk/1DV+Z3raa9ZQ96Z2k+gutd15endBpyXr5Cb6Y/JnaTPXAxe+o8ADWUJ
         sJE7KzlsIhOl+dYh6leHpWqGyu5Wys74KSNez7rVQXVB2ZVMoXAo4FIyVFATj/C9P38v
         pjDtpQeCbOP32dAPYkN82LmUt8DuyuhF5CS2BBlXJYK8KTePrwoNIJirYP4zgc0Rd8vi
         s+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665895; x=1791270695;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGbSxQ+ordORojocaH0U5BkUwxizVp+6KhwnNAplOmM=;
        b=vXTr6PMCmMpLXR+mv9t1+z/e9k5ZxnsauwFjWxkQDMEjLfUO98OY0+7/JhAo6GfyX9
         j8sN02//Kd4XPZ2wnNkuwDCEJz0bHLmdANIP6NsiekQZ5egtL0PBS+koNvcpsMCOza+0
         3Wj2hfsIq+BuCp4mSBxM48kSjvO6MsJjSja6abSUUTylraout3CIw5m6MoP2hnCDBAuO
         m4aC1FCvGYAQUP6ZxeKgX1MS/GKML65+2wp4imTID2Xq2oEJB9NYmOEsEKtHSRLyfUsZ
         +6taN/upANxUuTmVdb75rnw2CeE4nOiEe9/mNVrkS26ZL18W/JuQvpM5/I3oK+WR4mBC
         t0Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwK4ISljgMF5yfj/M82FQS9AFshLXX4p6/nlO3vk22015c899y+zU9xIDJeJpCwymUqYgqu/P8p+2A=@vger.kernel.org
X-Gm-Message-State: AFuF++nQMx5WfpTtevWv705oJ8uRRHAmYSffKqn98sIibe3hxMXN97e3
	yUfvajQS0tqjM+Lr6o/CF2ugho4hN06Bjox7QF2BlzxAlD8a3vIdDCvrF7l6D+ZiyRfVCLTssPg
	AYR4mq7GzbGRUAbRFkqtY1OMv3s25rlAUUdsd03IqnSICpPyJo/wLJttWsbSjAYQ=
X-Gm-Gg: AYBFou0i1Xs9w2pEEccQX7Uufwav9WzmFmyPKSEMnJsacHuXe1pE5qKa4FtXe/kgbkI
	evCNk4Ibgst7+cpoMsA6MxC2XS9Od9vZqSy+QaQyOwLOa82SqOpW+NF4sdGu5w0Ga5dNotrNnFn
	VNwZHn5q51ZXxOa8HuSKVs2x2qITJBode/C4zbkyB+f7EFnahoGD6a5soKcQ/MbTM765L4tFRpT
	khLuExFUlVMX6eNpogKVdDnHMpIfrppdvlQaZin7edc1d8onezwrM2z0p42D7Dg4ECak9lbN6qv
	q4AqTe3TN8LnwKBhlL+dvWAktHpp0SRwOET60kYJnf81ndLObgD3tO5P/OdgPvKF2oahfr5QU6H
	4wvSV2qqBnc1xW4CueKuImc8zO80Q1dzAASxtMC1Vm18vEqx2HRB0sO+UUGN1DA==
X-Received: by 2002:a05:620a:c41:b0:939:4b31:4669 with SMTP id af79cd13be357-93c43c1ea79mr2442107585a.29.1790665894712;
        Tue, 29 Sep 2026 00:11:34 -0700 (PDT)
X-Received: by 2002:a05:620a:c41:b0:939:4b31:4669 with SMTP id af79cd13be357-93c43c1ea79mr2442101785a.29.1790665894123;
        Tue, 29 Sep 2026 00:11:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af506fdc1sm1730213f8f.21.2026.09.29.00.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:11:33 -0700 (PDT)
Message-ID: <4de27200-3598-47b7-b0af-8f7acd037618@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 09:11:28 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/19] thermal: qcom: tsens: Add support for MSM8952
 tsens
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
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
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb64a8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=uWCFXIfD3x_FUo0uTIQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: H8Q8sdtsBKZjNyoyJU2zynK1C84GWG2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfXxhznFDlDF3+8
 /c5rSmwWyo7h5MWmVi7lHeah7OkcsRLqI81jfvsjsPn/SwnA/KcUkhUh8Q13Q8rsr+hYaWV6k1W
 1HG+rxRvRMKENOpDAQ4+AfFGpmVWPUZ5+s/77n7cfEgzn7U87pGsV1n0oZNwPXZ2GUT8u+laBo3
 3EX1O2qwgmFZDpYsSe8C/I3Mz4Vc+ZhzhrAJY8cKssshhSeh67qCjYX4MG8QpIeKzcJfiiKcYMV
 C+eEEfryIao1EO9vYKqiJfur0zdItirndt/IgHsheUQqmxUesQOorRBp0z9lSjsyGbxF1jZLTlc
 dGrHVHJu7M047I9gVW2j/fQt1DvK7uymSuQkNWVYYWIJoakR8+yd/0Tyv8Q79vwiVT/lBNCt8NO
 cmMcA0ckq3T2pKAAtuZP0qEW1tjWqGPomBGZ9kh89r7J4yN4IWrWTj4P0TFECdh/jIhWedIQlaA
 FRH+aq5V+VQaUwhGCdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX4HuiKB+jTT9F
 y/4ziOKrHqFQ229YGTiWklyFnjW8GUEKYE0Xiv+nTiorxibk6wJtIWapbii2TYTaL/r7BHB2PAo
 s+YUdfa463EgkxONrOrEFVFPezCkqUI=
X-Proofpoint-GUID: H8Q8sdtsBKZjNyoyJU2zynK1C84GWG2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290028

On 9/21/26 20:19, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add MSM8952 support for tsens.
> 
> Downstream does a lot of advanced things with calculations.
> But seems like using tsens-v1 directly works too.

Can you elaborate a bit the changelog please ?

Thanks


> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>   drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/tsens.c    |  3 +++
>   drivers/thermal/qcom/tsens.h    |  2 +-
>   3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index faa5d00788ca..f4201748ea29 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>   };
>   
> +static int __init init_8952(struct tsens_priv *priv)
> +{
> +	for (int i = 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope = 3200;
> +
> +	priv->sensor[0].p1_calib_offset = 2;
> +	priv->sensor[0].p2_calib_offset = -1;
> +	priv->sensor[1].p1_calib_offset = -4;
> +	priv->sensor[1].p2_calib_offset = -4;
> +	priv->sensor[2].p1_calib_offset = 4;
> +	priv->sensor[2].p2_calib_offset = 5;
> +	priv->sensor[3].p1_calib_offset = 1;
> +	priv->sensor[3].p2_calib_offset = 1;
> +	priv->sensor[4].p1_calib_offset = 2;
> +	priv->sensor[4].p2_calib_offset = 3;
> +	priv->sensor[5].p1_calib_offset = -1;
> +	priv->sensor[5].p2_calib_offset = -1;
> +	priv->sensor[6].p1_calib_offset = 0;
> +	priv->sensor[6].p2_calib_offset = -1;
> +	priv->sensor[7].p1_calib_offset = 3;
> +	priv->sensor[7].p2_calib_offset = 4;
> +	priv->sensor[8].p1_calib_offset = 2;
> +	priv->sensor[8].p2_calib_offset = 4;
> +	priv->sensor[9].p1_calib_offset = 0;
> +	priv->sensor[9].p2_calib_offset = 0;
> +	priv->sensor[10].p1_calib_offset = -3;
> +	priv->sensor[10].p2_calib_offset = -2;
> +
> +	return init_common(priv);
> +}
> +
>   static int __init init_8956(struct tsens_priv *priv) {
>   	priv->sensor[0].slope = 3313;
>   	priv->sensor[1].slope = 3275;
> @@ -223,6 +254,19 @@ struct tsens_plat_data data_8937 = {
>   	.fields		= tsens_v1_regfields,
>   };
>   
> +static const struct tsens_ops ops_8952 = {
> +	.init		= init_8952,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_8952 = {
> +	.num_sensors	= 11,
> +	.ops		= &ops_8952,
> +	.feat		= &tsens_v1_feat,
> +	.fields		= tsens_v1_regfields,
> +};
> +
>   static const struct tsens_ops ops_8956 = {
>   	.init		= init_8956,
>   	.calibrate	= tsens_calibrate_common,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b5ec70201e2f..4d7013fc79d6 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1191,6 +1191,9 @@ static const struct of_device_id tsens_table[] = {
>   	}, {
>   		.compatible = "qcom,msm8939-tsens",
>   		.data = &data_8939,
> +	}, {
> +		.compatible = "qcom,msm8952-tsens",
> +		.data = &data_8952,
>   	}, {
>   		.compatible = "qcom,msm8956-tsens",
>   		.data = &data_8956,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index e8376accdff3..a35b15312961 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -669,7 +669,7 @@ extern struct tsens_plat_data data_8960;
>   extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
>   
>   /* TSENS v1 targets */
> -extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
> +extern struct tsens_plat_data data_tsens_v1, data_8937, data_8952, data_8976, data_8956;
>   
>   /* TSENS v1 with no RPM targets */
>   extern const struct tsens_plat_data data_ipq5018;
> 

