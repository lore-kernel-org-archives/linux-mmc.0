Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D42877D7
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020523; cv=none; b=GpNfv9iM24Cj04QExHg1hPJMD6pVJUMR4fPd+2kaaMD/vKnQJBRJ1n4An957TquYNDZcF3aMsOHRoRzQJeZEckpgFVse7wGDlckvH1W/g47mXusTssUtK1VgNNWAxBZdkICP1KbVuGOqN9NV+uMLE5s0NWJ79csGI6yeE58lEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020523; c=relaxed/simple;
	bh=JecI4baRKbxg9mlRZPX14WKgBFLLGnH9ACj7lbwRX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjCkaUrkGO7WKjXkfdK82TsCFQTzom3Lf0TRv9twK14FP9Mk3+Pr0e7vJk3288wSEpYST2Dn21ZFkW0oPmYtuM6gYeh/7CRX5nDO8i+VqcZbf2U7v5M1wWEGowYQyHWPPaWbrrb7KrnasZX2ZPTFtADMJQGN1D+UzkxYE3bmAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mZ6riIwC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZ6riIwC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9evI3007324
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OWBe468scwOzFXQ4FxY74VVg
	9u9BX5oCReSyR7Jc2vg=; b=mZ6riIwCeVoyP9biCabTnNSPvQyOeOZmDSXFkNgu
	c9HT8QqkzJYfxPZiSKYzkQEG+ALrKKM1nwYKwXlyRZi9cJtIQ7pvWFhS9MqC6WRh
	4YG7jHroAaC6ZMkUlcwInkZ3CNTllvyQLbvJrjMtD/Vg9GAfMc81ddILUn+FjERc
	4M+Yyxp7Hzg2Hl+th7HmfrShx/7DaUh3h02xfMf7LN/HNtlpRT/xiMc41fRfnSA2
	Bys3yD6jE0iplgnAfucmVWEw5pIk65V+b+revqmyYX8n684cgD8/lEUM2COjifd4
	6d/xEsT/Oh2dBvrCMEjm2ZQcCO5NN513W2mGCwMqnKx8Xg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n49dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:02:01 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-545f436ad2dso6444957e0c.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 04:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020520; x=1758625320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWBe468scwOzFXQ4FxY74VVg9u9BX5oCReSyR7Jc2vg=;
        b=IW1DN5jhWlNOtSVRZIyLxYrLgeSFLgmRsR1exJYa1Vof2cb8d1C/1d6BGZVYBhnrVG
         XWjqINGf9eMbKU+A3lHueVSi1fYwrSS6kGLDpYWdoQAS2q4vldp3TpUSjAfrhgbnKWJ0
         TyFXJQxVh0y2vO6pZfHcz609sTOndbYQPwJCjcn8ORTUOJuMdR6HT+I0+/u5/Z262CMR
         H93IbDQFuiNaUEPtQfpYm53JJTscrMM5Rnp17GmYK61AOYr+h3Ne+A5RoA9Tw2fQrbil
         ct8Zpu4bhY6ANl2/Wz73vMuNaeT0pDypDfc7gG2rb4oiRy2ydqD9FSP/y0Q17HK50SzQ
         T4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZWd6UAKsxRDtHV/dpKsxdxw8ZWMQWLJkpDPhIIkp5fgLw6/j0/aQSHt1QFSMBuOiw/y/cHRaLTuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/2aszC+NPvcRaMAmdNspPoD69eL0b62NOHBnzZLIojNDSyha
	mf28jiLTMuTn/6/9xfwwX3XZ76vbRRiKdXY+Ae5Nt/+ZWKtxPLxgRtgQ9f1sOMtnEOf5qlmXtUR
	6rwuNeGQtS3Oq4TZc4GrEWNLWlkkpPe8udwn/h88K9/4IIQIJjuUPofVsTwEpWHA=
X-Gm-Gg: ASbGncsM029DfJRm0WhN1g3wZjjvFISh20d15BNzYQ766BO9SJwsyagfejcw4QRdZxw
	XiC16Bf5rW6cjY7ujtFBWFwBl0VgUcZLZFnPYE03sywLMaRoTBGYmc8zsS9GysIqRkBbqcTvruj
	8IULkDuFOkIw9dgyenqN0Pjc33Dlu0nvsSHrHgieHlTIYIitbT3p30vDOa0BfiWcpZ9JEQQ3oM3
	nkxR+guBW16xHlI/u2FauTOmad1Ya2z+K3x91IVcm4F8siX6LI4gF1DlqzF3LM+Y7E1aKP00wd4
	wYG1q3kU8TTJfYoyxcweMWykhTKbdA3v7ACbB20IO9Rhr48c2QWwIN82tBIAP5mgv0Iek0C8brx
	UqULh/1KgXiWrW2RlHf1jfRgWrmWziAJvdMJfi+fcexKO+H6zwmWd
X-Received: by 2002:a05:6122:250b:b0:537:3e5b:9f66 with SMTP id 71dfb90a1353d-54a16cb4b3emr5739174e0c.12.1758020519582;
        Tue, 16 Sep 2025 04:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIhQ74kakQxgpRzO0ONsKwulv83qkPHfKj7TAFJZhqWDBg4A4PoFyYmOJehH1fow8stkNEhQ==
X-Received: by 2002:a05:6122:250b:b0:537:3e5b:9f66 with SMTP id 71dfb90a1353d-54a16cb4b3emr5739122e0c.12.1758020519115;
        Tue, 16 Sep 2025 04:01:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-353725e1bc6sm26001481fa.27.2025.09.16.04.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:01:58 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:01:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Message-ID: <nz2dsvc6qyz47dxfbj4deo5xttnegv2qmueo4k5mhrvnkqh3oo@ddakv5hphfw3>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-8-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-8-53d7d206669d@oss.qualcomm.com>
X-Proofpoint-GUID: 3UunwO_w2k-PCQUepJVnLPFbHMwVLCvU
X-Proofpoint-ORIG-GUID: 3UunwO_w2k-PCQUepJVnLPFbHMwVLCvU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX8fxToFcxTrAh
 +rOVlO6KvZ17z8xkyw3A4CeaxiU8oFnzBZifB4KiuPSyD6TRpp0iQrre4VtDUzsEL/RvPVM4utj
 Z2VXWjepNY+lS7KqdQKaxJLJSvrxPyjXqTYUlyzQp6oZnjkEDalt8e5e45Afd9EAR/Wyda/4wbj
 oRzsDIsfLqa7/dI0SDfgJhI4NQgDCyFuprcddNf7R88P9ojunM7vAsGeH3d8uNQ3pXn/LdZYl95
 e6miBlRFhvzb0IBead3h3IqDoAVgKyBIRTlfiz+SCTt4hVLwvVZblBQ9PU/18jkQ2oo9rCX1cHz
 83FfBpk/97R7O6N+uNc4ygbw5hsnLRCr50e1vAdNQGJd6eYLc8yIvH7Sv+IvaWOZ5ysG7viQRZF
 Ld21CDbQ
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c943a9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B3P4ua6ZyXwAq7e7NPAA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On Tue, Sep 16, 2025 at 04:16:56PM +0530, Wasim Nazir wrote:
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> Enable the first USB controller in device mode on the Lemans EVK
> board and configure the associated LDO regulators to power
> the PHYs accordingly.
> 
> The USB port is a Type-C port controlled by HD3SS3320 port controller.
> The role switch notifications would need to be routed to glue driver by
> adding an appropriate usb-c-connector node in DT. However in the design,
> the vbus supply that is to be provided to connected peripherals when
> port is configured as an DFP, is controlled by a GPIO.
> 
> There is also one ID line going from Port controller chip to GPIO-50 of
> the SoC. As per the datasheet of HD3SS3320:
> 
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
> pin low. This is done to enforce Type-C requirement that VBUS must be
> at VSafe0V before re-enabling VBUS."
> 
> The current HD3SS3220 driver doesn't have this functionality present. So,
> putting the first USB controller in device mode for now. Once the vbus
> control based on ID pin is implemented in hd3ss3220.c, the
> usb-c-connector will be implemented and dr mode would be made OTG.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
