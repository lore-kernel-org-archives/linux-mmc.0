Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261221D3EA
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046710; cv=none; b=JZeVWhBOYlFkcg11uPx6hcInKufUZiLXDI7NnOGm/E9U881pYuZ1oYHoercwS+nKT50sKExkGGVElapx3FIl4w0g0RpBJAgWzZQOFAaGuIEBpvlYP+nwvegtZdV5LAf7Hj8NIoZPDPDuzjrLMq8EuHRPzLd6DH36CZUXtN9RVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046710; c=relaxed/simple;
	bh=Cn3rLXeC7/8U8GnfnBBPTCuzEGRSbZxO7swcK1Vm+b8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EXIXKeV/cL79hIwRya85XG32RbDp2EJQ/IWmccdltRs6F0HmJOSm56OshAAgxtKq+7/ALGieIzMMgRi82WF73X+9OCVJwXn3EZR6zmVN2WEOuRCgMR+OBG4QtkCna7ZH/mmKE94S4xjUcpZ7gKhgWltHO6tESXFHi9AJIwHdzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AerEwQez; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dc5Pfq8u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AerEwQez";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dc5Pfq8u"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2hBqj1821849
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 04:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2iBaFM03yaxA1ifzE5mpF6IUOLTnopVdD4Y+j5xacts=; b=AerEwQez3hKkA9cg
	Cf8MXszWQ9eYxi4XVklmuqVkajlgnH4/fQfw/f0/Yvz+JBKY/WkjUDYNW7FaP1p3
	rV6QZyxy0OClC95nZxInADIap+VTwN53jGWbWPBsgbH9BAj11FTLi3SYsZ5b3mnk
	q1b4SbVpS1eMibHTdv4sA8KAn6KTjXi9NNa32axFMh7jcTMg23z0N1E+OEtdD7k3
	xVIAPgQmaqFV9suDGSpJ6b32U2b+Mv1KgVPkFsKHDjuNA4t6625Y+2MVtYdDBA10
	bWUgV0yAkQC4nktccUOeeG0zTEQl4WWQqd+VwP4RJD3JyJWrNDOCT5Ghq5MbDcNg
	43ObGw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amp6h2rqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 04:58:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e66542afso178285895ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 20:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764046703; x=1764651503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iBaFM03yaxA1ifzE5mpF6IUOLTnopVdD4Y+j5xacts=;
        b=dc5Pfq8ujnws8J/es28gu6yjdG12goLfSSGZDrQa0i3bIZi9aiP8WywCRR+OfStDK6
         D6DWykVHei/ZzE9SRLLDRIVrG69KXOJjQR9lxCtWhGS9MyWaJXWexTV+cRWiowdKOkK2
         mamn2ZEaruAOBERfgAVuekC/o8AF/6VOmeBAmfBw1W2GOJnxvhm0n9I1X5hmcj6yKb/y
         F1P8OLRW7+owQ8fOxROQKjxptyojV9cHbc6/IsE9W4HIPrJZ3UWSvr0yi+cT9BUpd3EL
         8mdHbKTefhmg5+Z7ksCAG7xIX/whHZYtFC/oMKuQhxxne19Ku+O9atNcDAT92crKZdG0
         lMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764046703; x=1764651503;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iBaFM03yaxA1ifzE5mpF6IUOLTnopVdD4Y+j5xacts=;
        b=Rclt7T3CVdnonFFGBv7KKsXsch74ZdjJUoYYfmX32G8KnYHWp4EUtJx5K44/ZGVe1i
         ZibqYgeRwf2xpoMs+/Hgy1a+VDuves3o76+Se+ESRaEVHo2DxRO0fZVl2x5XSBLyTAm+
         uCEYUSyQx2LKOfB18Km0sDSIx7z6WFq3jBxBfWt3kydgF/sgyXqpAbydY8ngtyOkh6td
         ia1VfhT6RTznpDhX3O+/M4wLbpEnBgZn03n+ltrNPUpdTV+udV+8LwNhOzI3kvgR6rzX
         PRt63ZTSxbsDe8nLMd9+S5snb3iCqx1ZPzkRofwn6da/AfF+hJdOraHFJoZZssohhdHZ
         Mm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBRowJjcN7NRmFuG+esDqR2rU07aNrUXFa00p41mb9cPYQWBwElK0eBqYjx9tqCe+//aHNfP23Ty0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbor+7ceXEgbUNrv87gaOyP/14tJbqcFkMDBNzgj1GMooQC/oZ
	y7TsfYHYB+w7bw2C3G2izTviN6u3YYMZGhGauCKunLMny+JskL3R2t07cIqUGN/W4bBEH0X89mL
	7Gtacuu+yLkug8iw2Ra2+pdNNqTTzZFRdD4Svy1vtgFo7uV2vfQze17RGmj4C39Y=
X-Gm-Gg: ASbGncuxBME9hRq+E4niUztt6T7yAdqr0fAbI2vFcmhHrrXCD3dPQ2NpV8dEbuTpuFx
	rCExmN1AA92jrS7U6SA/xXT9ecQeEbWAXkuNvtFb7SJxwnGec7zkrD1HKh/HtQ4UrJDqLdaH6+1
	oT1wBbx6w7EK7x2cv+wYcN/MvXOGski+p4tco3acz/6jw4TuG4OlmGJqQE8+2uQkapylOmMszXJ
	YAgRi2L/VOzRVV3vd8+lmaDx1lt6DMEAiyndPegdvPeM7MV0jr6qLMg+n8j7fdi78QJhUdehl9y
	5/jV65K/WebBK6ENfR0aDmuzR00syQDKHRqVcBKh/nqwlBVJifWAJgI+QFug2qNQIlrOzLNJB30
	6slPJ/4UhV0OpyRU8j8lH4rpa0JDhPxd6WGRJ18s=
X-Received: by 2002:a17:903:3c63:b0:298:8ec:9991 with SMTP id d9443c01a7336-29bab148b76mr17799335ad.37.1764046702456;
        Mon, 24 Nov 2025 20:58:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvy93KmotpTkKTfFW1AXkqPXluB8AGxeoeB72JpVqfYygb+4Us1GNvuh3O0ro9OydGAnC/eQ==
X-Received: by 2002:a17:903:3c63:b0:298:8ec:9991 with SMTP id d9443c01a7336-29bab148b76mr17798755ad.37.1764046701175;
        Mon, 24 Nov 2025 20:58:21 -0800 (PST)
Received: from [10.217.223.198] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107ee9sm150103535ad.1.2025.11.24.20.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 20:58:20 -0800 (PST)
Subject: Re: [PATCH 0/2] Enable Inline crypto engine for kodiak
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
        konradybcio@kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org
References: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
 <176399402112.138918.10418108466178515664.robh@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <a9f3f5b5-a3cf-ae24-9cd3-b3cd4c5c34c6@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 10:28:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <176399402112.138918.10418108466178515664.robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAzOCBTYWx0ZWRfX2L1o0JOXGOgV
 fvhMIfRxIgdIef3DY2suxdRX/Rp1Nk1PLq11yfqNJpJlycg/ygMTQICEITzRjL4ACoDhD/sr3Dc
 YGwGIiYO4Kl/07+EUvgUlWcE+eF5iS3SOLBMY19x4+BUCRKcWIc3GUESh5H6wAuOEj8XreKjipj
 vUp9gBL5fqfWZ78n5l/9cDFRoN1+5kOFhgC6ercLaJ5/HT+3Kw8EmuwJH/GRfDk2xHH7vIY6n6e
 1k3oaNoLKbELrOEXZIE1Ahx+APKuMycQdnFybtI4Iy9JiSLE3Z1HZRqEtii2jaZ4qjJ0EHSp6KF
 Cpk3/SzCsdXqqv13vtxIndaOiUTAIfll3MqA5v/PmQCHLkU9W/wcswNeMVnKFNkC+cdnduynuKk
 HmktmP49intPd5lOrVCvzZ49kUI32A==
X-Proofpoint-GUID: DmU_xdLn2BB5OJLCFGgdohdmd3iD0Wbq
X-Proofpoint-ORIG-GUID: DmU_xdLn2BB5OJLCFGgdohdmd3iD0Wbq
X-Authority-Analysis: v=2.4 cv=GoFPO01C c=1 sm=1 tr=0 ts=69253770 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=HJZWNtYfCYqp2gXpm1cA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250038

Hi,

On 11/24/2025 7:58 PM, Rob Herring wrote:
> 
> On Mon, 24 Nov 2025 16:49:12 +0530, Neeraj Soni wrote:
>> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
>> node to enable it for kodiak.
>>
>> Neeraj Soni (2):
>>   dt-bindings: mmc: sdhci-msm: Add ICE phandle
>>   arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
>>
>>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 38 +++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/kodiak.dtsi          |  9 +++++
>>  2 files changed, 47 insertions(+)
>>
>> --
>> 2.34.1
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
yes i had tested this patch by running these:
pip install dtschema
make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
make dtbs_check
but did not see the below errors. I will upgrade and re-run the commands to check these. 
> 
> 
> This patch series was applied (using b4) to base:
>  Base: attempting to guess base-commit...
>  Base: tags/next-20251120 (exact match)
>  Base: tags/next-20251120 (use --merge-base to override)
> 
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com:
> 
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sm7325-nothing-spacewar.dtb] Error 2
> arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb: mmc@8804000 (qcom,sc8280xp-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-crd-pro.dtb] Error 2
> arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/qcs6490-rb3gen2.dtb] Error 2
> arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg: [[0, 74989568, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb: mmc@4744000 (qcom,qcm2290-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb: mmc@4744000 (qcom,qcm2290-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb: mmc@4784000 (qcom,qcm2290-sdhci): reg: [[0, 74989568, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb: mmc@4784000 (qcom,qcm2290-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg: [[201867264, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-zombie.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg: [[201867264, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8550-qrd.dtb: mmc@8804000 (qcom,sm8550-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dtb: mmc@8804000 (qcom,sm8550-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dtb: mmc@8804000 (qcom,sc8280xp-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg: [[201867264, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: mmc@7804000 (qcom,ipq6018-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/qcm6490-idp.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/qcm6490-idp.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/qcm6490-idp.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dtb: mmc@8804000 (qcom,sm8350-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8550-mtp.dtb: mmc@8804000 (qcom,sm8550-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-samsung-x1q.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/qcm6490-particle-tachyon.dtb] Error 2
> arch/arm64/boot/dts/qcom/sm8250-mtp.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-crd.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-crd.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb: mmc@8804000 (qcom,sm8550-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb: mmc@7804000 (qcom,qcs404-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-crd.dtb] Error 2
> arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb: mmc@7c4000 (qcom,sdm670-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb: mmc@7c4000 (qcom,sdm670-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq5424-rdp466.dtb: mmc@7804000 (qcom,ipq5424-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs9100-ride.dtb: mmc@87c4000 (qcom,sa8775p-sdhci): reg: [[0, 142360576, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e001de-devkit.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e001de-devkit.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dtb: mmc@4744000 (qcom,sm6125-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dtb: mmc@4784000 (qcom,sm6125-sdhci): reg: [[74989568, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dtb: mmc@4784000 (qcom,sm6125-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb: mmc@8804000 (qcom,sm8150-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-idp.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-idp.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-idp.dtb] Error 2
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-evoker-lte.dtb] Error 2
> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: mmc@87c4000 (qcom,sa8775p-sdhci): reg: [[0, 142360576, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-idp2.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-idp2.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-idp2.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8150-mtp.dtb: mmc@8804000 (qcom,sm8150-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-samsung-r8q.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg: [[201867264, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dtb: mmc@7804000 (qcom,ipq5018-sdhci): reg: [[125845504, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dtb: mmc@7804000 (qcom,ipq5018-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-evoker.dtb] Error 2
> arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: mmc@7804000 (qcom,ipq5018-sdhci): reg: [[125845504, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: mmc@7804000 (qcom,ipq5018-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb4210-rb2.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb4210-rb2.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb4210-rb2.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg: [[0, 74989568, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qrb4210-rb2.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdx75-idp.dtb: mmc@8804000 (qcom,sdx75-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dtb: mmc@8804000 (qcom,sm8350-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dtb: mmc@4784000 (qcom,sm6375-sdhci): reg: [[0, 74989568, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-mtp.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dtb: mmc@87c4000 (qcom,sa8775p-sdhci): reg: [[0, 142360576, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-zombie-lte.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sar2130p-qar2130p.dtb: mmc@7c4000 (qcom,sar2130p-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-herobrine-r1.dtb] Error 2
> arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: mmc@8804000 (qcom,sm8650-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/monaco-evk.dtb: mmc@87c4000 (qcom,qcs8300-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg: [[201867264, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: mmc@8804000 (qcom,sm8350-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb: mmc@7c4000 (qcom,sm6350-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb: mmc@7c4000 (qcom,sm6350-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb: mmc@8804000 (qcom,sm6350-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: mmc@8804000 (qcom,sm8450-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sa8155p-adp.dtb: mmc@8804000 (qcom,sm8150-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-zombie-nvme-lte.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8450-qrd.dtb: mmc@8804000 (qcom,sm8450-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dtb: mmc@8804000 (qcom,sm8150-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8150-hdk.dtb: mmc@8804000 (qcom,sm8150-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-idp.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-zombie-nvme.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-idp.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qru1000-idp.dtb: mmc@8804000 (qcom,qdu1000-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-hp-elitebook-ultra-g1q.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-hp-elitebook-ultra-g1q.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus15.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus15.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-crd-r3.dtb] Error 2
> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: mmc@7c4000 (qcom,qcs615-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: mmc@7c4000 (qcom,qcs615-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: mmc@8804000 (qcom,qcs615-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: mmc@8804000 (qcom,qcs615-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-villager-r1.dtb] Error 2
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/qcm6490-shift-otter.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dtb: mmc@87c4000 (qcom,sa8775p-sdhci): reg: [[0, 142360576, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/hamoa-iot-evk.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/hamoa-iot-evk.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: mmc@87c4000 (qcom,qcs8300-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dtb: mmc@8804000 (qcom,sm8450-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dtb: mmc@4744000 (qcom,sm6125-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dtb: mmc@4784000 (qcom,sm6125-sdhci): reg: [[74989568, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dtb: mmc@4784000 (qcom,sm6125-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/lemans-evk.dtb: mmc@87c4000 (qcom,sa8775p-sdhci): reg: [[0, 142360576, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sa8295p-adp.dtb: mmc@8804000 (qcom,sc8280xp-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/qcm6490-fairphone-fp5.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8650-mtp.dtb: mmc@8804000 (qcom,sm8650-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8550-hdk.dtb: mmc@8804000 (qcom,sm8550-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dtb: mmc@8804000 (qcom,sc8280xp-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dtb: mmc@7c4000 (qcom,sm6350-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dtb: mmc@7c4000 (qcom,sm6350-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dtb: mmc@8804000 (qcom,sm6350-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg: [[201867264, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14-lcd.dtb: mmc@8804000 (qcom,x1e80100-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14-lcd.dtb: mmc@8844000 (qcom,x1e80100-sdhci): reg: [[0, 142884864, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dtb: mmc@8804000 (qcom,sm8150-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dtb: mmc@8804000 (qcom,sc8280xp-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8250-hdk.dtb: mmc@8804000 (qcom,sm8250-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: mmc@8804000 (qcom,sm8650-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb: mmc@8804000 (qcom,sc8280xp-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-villager-r1-lte.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/qcs6490-radxa-dragon-q6a.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg: [[0, 74989568, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dtb: mmc@8804000 (qcom,sm8350-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: mmc@8804000 (qcom,qdu1000-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-db845c.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: mmc@8804000 (qcom,sc8280xp-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8350-mtp.dtb: mmc@8804000 (qcom,sm8350-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: mmc@8804000 (qcom,sm8550-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> Error: arch/arm64/boot/dts/qcom/kodiak.dtsi:1073.4-27 Properties must precede subnodes
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.dtbs:141: arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1509: qcom/sc7280-herobrine-villager-r0.dtb] Error 2
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: mmc@4744000 (qcom,sm6115-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg: [[0, 74989568, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: mmc@4784000 (qcom,sm6115-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb: mmc@7804000 (qcom,qcs404-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg: [[201867264, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb: mmc@c084000 (qcom,sdm630-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb: mmc@c0c4000 (qcom,sdm630-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: mmc@7804000 (qcom,ipq9574-sdhci): reg-names:2: 'cqhci' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: mmc@4744000 (qcom,sm6125-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: mmc@4784000 (qcom,sm6125-sdhci): reg: [[74989568, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: mmc@4784000 (qcom,sm6125-sdhci): reg-names: ['hc'] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb: mmc@8804000 (qcom,sdm845-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb: mmc@7c4000 (qcom,sc7180-sdhci): reg-names:1: 'core' was expected
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dtb: mmc@8804000 (qcom,sm8450-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb: mmc@8804000 (qcom,sm8450-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb: mmc@8804000 (qcom,sc7180-sdhci): reg: [[0, 142622720, 0, 4096]] is too short
> 	from schema $id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml
> make: *** [Makefile:248: __sub-make] Error 2
> make: Target 'qcom/apq8096-ifc6640.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-j3ltetw.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-fxtec-pro1.dtb' not remade because of errors.
> make: Target 'qcom/sm7325-nothing-spacewar.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-asus-zenbook-a14.dtb' not remade because of errors.
> make: Target 'qcom/sm7125-xiaomi-curtana.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-dell-xps13-9345.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-mtp.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-a5u-eur.dtb' not remade because of errors.
> make: Target 'qcom/sc8280xp-lenovo-thinkpad-x13s.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r3-lte.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-crd-pro.dtb' not remade because of errors.
> make: Target 'qcom/sm6115p-lenovo-j606f.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-sony-xperia-yoshino-maple.dtb' not remade because of errors.
> make: Target 'qcom/ipq9574-rdp454.dtb' not remade because of errors.
> make: Target 'qcom/qcs6490-rb3gen2.dtb' not remade because of errors.
> make: Target 'qcom/msm8992-xiaomi-libra.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r4.dtb' not remade because of errors.
> make: Target 'qcom/sdm450-motorola-ali.dtb' not remade because of errors.
> make: Target 'qcom/x1e78100-lenovo-thinkpad-t14s-oled.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-quackingstick-r0.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pazquel360-wifi.dtb' not remade because of errors.
> make: Target 'qcom/sdm630-sony-xperia-ganges-kirin.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-coachz-r1-lte.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-dell-latitude-7455.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-lg-judyp.dtb' not remade because of errors.
> make: Target 'qcom/msm8939-wingtech-wt82918.dtb' not remade because of errors.
> make: Target 'qcom/qrb2210-rb1.dtb' not remade because of errors.
> make: Target 'qcom/msm8996-mtp.dtb' not remade because of errors.
> make: Target 'qcom/sm8750-mtp.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-zombie.dtb' not remade because of errors.
> make: Target 'qcom/msm8992-lg-bullhead-rev-10.dtb' not remade because of errors.
> make: Target 'qcom/qrb5165-rb5.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-lenovo-yoga-slim7x.dtb' not remade because of errors.
> make: Target 'qcom/sm8550-qrd.dtb' not remade because of errors.
> make: Target 'qcom/sdm630-sony-xperia-nile-discovery.dtb' not remade because of errors.
> make: Target 'qcom/sm8550-sony-xperia-yodo-pdx234.dtb' not remade because of errors.
> make: Target 'qcom/msm8939-huawei-kiwi.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb' not remade because of errors.
> make: Target 'qcom/sc8280xp-microsoft-arcata.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-oneplus-fajita.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb' not remade because of errors.
> make: Target 'qcom/sdm660-xiaomi-lavender.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-coachz-r1.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r10.dtb' not remade because of errors.
> make: Target 'qcom/msm8939-wingtech-wt82918hd.dtb' not remade because of errors.
> make: Target 'qcom/ipq6018-cp01-c1.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-samsung-x1q.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-motorola-surnia.dtb' not remade because of errors.
> make: Target 'qcom/sm8350-microsoft-surface-duo2.dtb' not remade because of errors.
> make: Target 'qcom/qcm6490-idp.dtb' not remade because of errors.
> make: Target 'qcom/sm8550-mtp.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-a3u-eur.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-sony-xperia-tama-akari.dtb' not remade because of errors.
> make: Target 'qcom/x1p42100-crd.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-mtp.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-xiaomi-elish-csot.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-wingtech-wt88047.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-thwc-ufi001c.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-xiaomi-sagit.dtb' not remade because of errors.
> make: Target 'qcom/qcm6490-particle-tachyon.dtb' not remade because of errors.
> make: Target 'qcom/qcs8550-aim300-aiot.dtb' not remade because of errors.
> make: Target 'qcom/sdm450-lenovo-tbx605f.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-xiaomi-elish-boe.dtb' not remade because of errors.
> make: Target 'qcom/qcs404-evb-4000.dtb' not remade because of errors.
> make: Target 'qcom/qcs9100-ride.dtb' not remade because of errors.
> make: Target 'qcom/msm8996-sony-xperia-tone-kagura.dtb' not remade because of errors.
> make: Target 'qcom/sm8150-sony-xperia-kumano-griffin.dtb' not remade because of errors.
> make: Target 'qcom/sdm670-google-sargo.dtb' not remade because of errors.
> make: Target 'qcom/x1e001de-devkit.dtb' not remade because of errors.
> make: Target 'qcom/sa8775p-ride.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-crd.dtb' not remade because of errors.
> make: Target 'qcom/ipq5424-rdp466.dtb' not remade because of errors.
> make: Target 'qcom/sc8180x-lenovo-flex-5g.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-lg-judyln.dtb' not remade because of errors.
> make: Target 'qcom/msm8953-flipkart-rimob.dtb' not remade because of errors.
> make: Target 'qcom/sm6125-xiaomi-ginkgo.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r3-kb.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-motorola-osprey.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-xiaomi-pipa.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-oneplus-enchilada.dtb' not remade because of errors.
> make: Target 'qcom/msm8956-sony-xperia-loire-suzu.dtb' not remade because of errors.
> make: Target 'qcom/msm8937-xiaomi-land.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-idp.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-evoker-lte.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-homestar-r4.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-rossa.dtb' not remade because of errors.
> make: Target 'qcom/apq8039-t2.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-motorola-harpia.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-e5.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-idp2.dtb' not remade because of errors.
> make: Target 'qcom/msm8939-sony-xperia-kanuti-tulip.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-samsung-r8q.dtb' not remade because of errors.
> make: Target 'qcom/ipq8074-hk01.dtb' not remade because of errors.
> make: Target 'qcom/sm8150-mtp.dtb' not remade because of errors.
> make: Target 'qcom/ipq9574-rdp433.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-sony-xperia-tama-apollo.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-lenovo-miix-630.dtb' not remade because of errors.
> make: Target 'qcom/msm8994-sony-xperia-kitakami-karin.dtb' not remade because of errors.
> make: Target 'qcom/sdm630-sony-xperia-nile-pioneer.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-grandmax.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-alcatel-idol347.dtb' not remade because of errors.
> make: Target 'qcom/ipq9574-rdp453.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-acer-aspire1.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-r1.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-e7.dtb' not remade because of errors.
> make: Target 'qcom/ipq5018-rdp432-c2.dtb' not remade because of errors.
> make: Target 'qcom/apq8016-schneider-hmibsc.dtb' not remade because of errors.
> make: Target 'qcom/qrb4210-rb2.dtb' not remade because of errors.
> make: Target 'qcom/x1p42100-hp-omnibook-x14.dtb' not remade because of errors.
> make: Target 'qcom/ipq5018-tplink-archer-ax55-v1.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-evoker.dtb' not remade because of errors.
> make: Target 'qcom/sdm850-huawei-matebook-e-2019.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-kingoftown.dtb' not remade because of errors.
> make: Target 'qcom/sm4450-qrd.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-j5.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-asus-novago-tp370ql.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pompom-r2-lte.dtb' not remade because of errors.
> make: Target 'qcom/msm8992-lg-h815.dtb' not remade because of errors.
> make: Target 'qcom/sdx75-idp.dtb' not remade because of errors.
> make: Target 'qcom/sm8350-sony-xperia-sagami-pdx215.dtb' not remade because of errors.
> make: Target 'qcom/apq8096-db820c.dtb' not remade because of errors.
> make: Target 'qcom/msm8996-sony-xperia-tone-keyaki.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-longcheer-l8150.dtb' not remade because of errors.
> make: Target 'qcom/msm8994-sony-xperia-kitakami-suzuran.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-mtp.dtb' not remade because of errors.
> make: Target 'qcom/sm6375-sony-xperia-murray-pdx225.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-yiming-uz801v3.dtb' not remade because of errors.
> make: Target 'qcom/qcs9100-ride-r3.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-hp-omnibook-x14.dtb' not remade because of errors.
> make: Target 'qcom/msm8953-xiaomi-vince.dtb' not remade because of errors.
> make: Target 'qcom/ipq5332-rdp441.dtb' not remade because of errors.
> make: Target 'qcom/msm8992-lg-bullhead-rev-101.dtb' not remade because of errors.
> make: Target 'qcom/msm8917-xiaomi-riva.dtb' not remade because of errors.
> make: Target 'qcom/msm8996-xiaomi-gemini.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r9.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-sony-xperia-yoshino-lilac.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-gprimeltecan.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pazquel360-lte.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-shift-axolotl.dtb' not remade because of errors.
> make: Target 'qcom/msm8996-oneplus3t.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-zombie-lte.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r3.dtb' not remade because of errors.
> make: Target 'qcom/monaco-evk.dtb' not remade because of errors.
> make: Target 'qcom/sar2130p-qar2130p.dtb' not remade because of errors.
> make: Target 'qcom/sm8650-hdk.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-herobrine-r1.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-longcheer-l8910.dtb' not remade because of errors.
> make: Target 'qcom/sdm630-sony-xperia-nile-voyager.dtb' not remade because of errors.
> make: Target 'qcom/sm8450-hdk.dtb' not remade because of errors.
> make: Target 'qcom/msm8929-wingtech-wt82918hd.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-sony-xperia-edo-pdx203.dtb' not remade because of errors.
> make: Target 'qcom/sm8350-hdk.dtb' not remade because of errors.
> make: Target 'qcom/ipq8074-hk10-c1.dtb' not remade because of errors.
> make: Target 'qcom/sm8450-qrd.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-lg-c50.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-sony-xperia-edo-pdx206.dtb' not remade because of errors.
> make: Target 'qcom/sm7225-fairphone-fp4.dtb' not remade because of errors.
> make: Target 'qcom/sa8155p-adp.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-qcp.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r1-kb.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-grandprimelte.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-zombie-nvme-lte.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-homestar-r3.dtb' not remade because of errors.
> make: Target 'qcom/ipq5332-rdp474.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-asus-vivobook-s15.dtb' not remade because of errors.
> make: Target 'qcom/sm8150-microsoft-surface-duo.dtb' not remade because of errors.
> make: Target 'qcom/msm8996pro-xiaomi-scorpio.dtb' not remade because of errors.
> make: Target 'qcom/x1e78100-lenovo-thinkpad-t14s.dtb' not remade because of errors.
> make: Target 'qcom/sm8150-hdk.dtb' not remade because of errors.
> make: Target 'qcom/sc8180x-primus.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r10-lte.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-j5x.dtb' not remade because of errors.
> make: Target 'qcom/x1p42100-asus-zenbook-a14.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-idp.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-mtp.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-hp-elitebook-ultra-g1q.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r10.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-zombie-nvme.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-microsoft-romulus15.dtb' not remade because of errors.
> make: Target 'qcom/qru1000-idp.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-hp-envy-x2.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pazquel-parade.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r9-kb.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb' not remade because of errors.
> make: Target 'qcom/qcs615-ride.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-coachz-r3-lte.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-crd-r3.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-gt58.dtb' not remade because of errors.
> make: Target 'qcom/sa8775p-ride-r3.dtb' not remade because of errors.
> make: Target 'qcom/sm8450-samsung-r0q.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-villager-r1.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pazquel-ti.dtb' not remade because of errors.
> make: Target 'qcom/qcm6490-shift-otter.dtb' not remade because of errors.
> make: Target 'qcom/hamoa-iot-evk.dtb' not remade because of errors.
> make: Target 'qcom/qcs8300-ride.dtb' not remade because of errors.
> make: Target 'qcom/apq8016-sbc.dtb' not remade because of errors.
> make: Target 'qcom/msm8996pro-xiaomi-natrium.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-samsung-starqltechn.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pompom-r1-lte.dtb' not remade because of errors.
> make: Target 'qcom/msm8953-xiaomi-tissot.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-dell-inspiron-14-plus-7441.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r9.dtb' not remade because of errors.
> make: Target 'qcom/sm6125-xiaomi-laurel-sprout.dtb' not remade because of errors.
> make: Target 'qcom/msm8994-sony-xperia-kitakami-sumire.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-serranove.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-coachz-r3.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-sony-xperia-tama-akatsuki.dtb' not remade because of errors.
> make: Target 'qcom/ipq9574-rdp449.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-r1-lte.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-lg-m216.dtb' not remade because of errors.
> make: Target 'qcom/msm8939-asus-z00t.dtb' not remade because of errors.
> make: Target 'qcom/lemans-evk.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-crd.dtb' not remade because of errors.
> make: Target 'qcom/x1p42100-lenovo-thinkbook-16.dtb' not remade because of errors.
> make: Target 'qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r9-lte.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pazquel-lte-ti.dtb' not remade because of errors.
> make: Target 'qcom/msm8996-sony-xperia-tone-dora.dtb' not remade because of errors.
> make: Target 'qcom/sa8295p-adp.dtb' not remade because of errors.
> make: Target 'qcom/msm8994-sony-xperia-kitakami-ivy.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-xiaomi-beryllium-ebbg.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pompom-r3.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-oneplus-dumpling.dtb' not remade because of errors.
> make: Target 'qcom/sm8650-mtp.dtb' not remade because of errors.
> make: Target 'qcom/msm8996-oneplus3.dtb' not remade because of errors.
> make: Target 'qcom/sm8550-hdk.dtb' not remade because of errors.
> make: Target 'qcom/x1e80100-microsoft-romulus13.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r1-lte.dtb' not remade because of errors.
> make: Target 'qcom/msm8939-samsung-a7.dtb' not remade because of errors.
> make: Target 'qcom/qcm6490-fairphone-fp5.dtb' not remade because of errors.
> make: Target 'qcom/sc8280xp-huawei-gaokun3.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb' not remade because of errors.
> make: Target 'qcom/msm8953-xiaomi-mido.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-asus-z00l.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pompom-r2.dtb' not remade because of errors.
> make: Target 'qcom/sm6350-sony-xperia-lena-pdx213.dtb' not remade because of errors.
> make: Target 'qcom/sdm632-fairphone-fp3.dtb' not remade because of errors.
> make: Target 'qcom/x1p42100-asus-zenbook-a14-lcd.dtb' not remade because of errors.
> make: Target 'qcom/msm8953-motorola-potter.dtb' not remade because of errors.
> make: Target 'qcom/sda660-inforce-ifc6560.dtb' not remade because of errors.
> make: Target 'qcom/sm8150-sony-xperia-kumano-bahamut.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pazquel-lte-parade.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-homestar-r2.dtb' not remade because of errors.
> make: Target 'qcom/sm8250-hdk.dtb' not remade because of errors.
> make: Target 'qcom/sm8650-qrd.dtb' not remade because of errors.
> make: Target 'qcom/sc8280xp-microsoft-blackrock.dtb' not remade because of errors.
> make: Target 'qcom/ipq8074-hk10-c2.dtb' not remade because of errors.
> make: Target 'qcom/msm8953-xiaomi-daisy.dtb' not remade because of errors.
> make: Target 'qcom/sc8280xp-crd.dtb' not remade because of errors.
> make: Target 'qcom/sdm850-samsung-w737.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-samsung-gt510.dtb' not remade because of errors.
> make: Target 'qcom/sdm850-lenovo-yoga-c630.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-thwc-uf896.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r10-kb.dtb' not remade because of errors.
> make: Target 'qcom/msm8994-sony-xperia-kitakami-satsuki.dtb' not remade because of errors.
> make: Target 'qcom/sdm632-motorola-ocean.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-villager-r1-lte.dtb' not remade because of errors.
> make: Target 'qcom/sm6115-fxtec-pro1x.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pompom-r3-lte.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-sony-xperia-yoshino-poplar.dtb' not remade because of errors.
> make: Target 'qcom/qcs6490-radxa-dragon-q6a.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-huawei-g7.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-wingtech-wt86518.dtb' not remade because of errors.
> make: Target 'qcom/sm8350-sony-xperia-sagami-pdx214.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-wingtech-wt86528.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-db845c.dtb' not remade because of errors.
> make: Target 'qcom/sa8540p-ride.dtb' not remade because of errors.
> make: Target 'qcom/msm8939-longcheer-l9100.dtb' not remade because of errors.
> make: Target 'qcom/qdu1000-idp.dtb' not remade because of errors.
> make: Target 'qcom/sm8550-samsung-q5q.dtb' not remade because of errors.
> make: Target 'qcom/msm8992-msft-lumia-octagon-talkman.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-gplus-fl8005a.dtb' not remade because of errors.
> make: Target 'qcom/sm8350-mtp.dtb' not remade because of errors.
> make: Target 'qcom/msm8956-sony-xperia-loire-kugo.dtb' not remade because of errors.
> make: Target 'qcom/msm8976-longcheer-l9360.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-r1.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-pompom-r1.dtb' not remade because of errors.
> make: Target 'qcom/msm8998-oneplus-cheeseburger.dtb' not remade because of errors.
> make: Target 'qcom/sc7280-herobrine-villager-r0.dtb' not remade because of errors.
> make: Target 'qcom/sm8750-qrd.dtb' not remade because of errors.
> make: Target 'qcom/sm4250-oneplus-billie2.dtb' not remade because of errors.
> make: Target 'qcom/sdm636-sony-xperia-ganges-mermaid.dtb' not remade because of errors.
> make: Target 'qcom/qcs404-evb-1000.dtb' not remade because of errors.
> make: Target 'qcom/ipq5332-rdp442.dtb' not remade because of errors.
> make: Target 'qcom/msm8994-msft-lumia-octagon-cityman.dtb' not remade because of errors.
> make: Target 'qcom/msm8916-acer-a1-724.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-xiaomi-beryllium-tianma.dtb' not remade because of errors.
> make: Target 'qcom/sm6125-sony-xperia-seine-pdx201.dtb' not remade because of errors.
> make: Target 'qcom/sdm845-xiaomi-polaris.dtb' not remade because of errors.
> make: Target 'qcom/ipq9574-rdp418.dtb' not remade because of errors.
> make: Target 'qcom/msm8216-samsung-fortuna3g.dtb' not remade because of errors.
> make: Target 'qcom/sm8450-sony-xperia-nagara-pdx223.dtb' not remade because of errors.
> make: Target 'qcom/sm8450-sony-xperia-nagara-pdx224.dtb' not remade because of errors.
> make: Target 'qcom/sm7125-xiaomi-joyeuse.dtb' not remade because of errors.
> make: Target 'qcom/msm8994-huawei-angler-rev-101.dtb' not remade because of errors.
> make: Target 'qcom/ipq5332-rdp468.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dtb' not remade because of errors.
> make: Target 'qcom/sc7180-trogdor-quackingstick-r0-lte.dtb' not remade because of errors.
> 
Regards,
Neeraj
> 
> 
> 
> 
