Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86037B40E
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890251; cv=none; b=mYCFpAf9a5vpR7hKRDftSL1AUxaLS2kY1Y5ecQv3nTNFFRbIS773tCgrYNQIDja5VlzVliKTsdbOXi+bJtNGXWZvDqfwE2gJHEQbslKB63TUQ/TQvx0zxZFBc3lW9+IAtKQrFdY6wGdI+d2EJYaQFhK2VJDPakgTIElHpMySwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890251; c=relaxed/simple;
	bh=KQvTe851Bvsh8j+PgLjhAYuShFSOrpuVnlKmfK6Ke38=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i3/fxKK04DesM0YhY8gH3VcTCAOGdI7k2klEUWEY1Ny19ODwNgnLzSyuAOV5WNVTnLiYsDzSAYG4s8m9jDK8cqiJfq0UZxPjL5RztdWlKS8zbRu8MMLXmOmHmek1RwMN3e5MX8XFuzTJn0WTb13RPbFP9buVSDdiTiP2s1KOzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWPq7p5/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=caEEgNFD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWPq7p5/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="caEEgNFD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K6IAbZ1904964
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 06:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dqnUnHSglS08Ezs/9IFZQZo2vw1kZKcPcP5C+SqXBDc=; b=SWPq7p5/mpy3ncPK
	dpVzkW82+ZaSyhmIATF4mHMBuToZR+U03nPCxrtoCZiz6AlO7qXY37dRUI+Ojip3
	6NXIBTIX+HSxAFgq/qXni6B5fZeXxA8CS4fUWpdLMMrvHRy/gKEkZf89JpyzWig8
	SMaxjp4/hNDdDecNa11ZYPPzcGR9P4S7SHJWNjR3By4+4zANhrsNVJf8GHf09/xL
	Q8DvkSu8dw9lwBcY/KkVE1cGjKm5uuKyBqPYQY3hUbhtO6kFf/RZME4wgEuGRv6N
	JpOvs8Hk1ZgFbT+tBOdZEIaxbUSqoE/rVNzwAaPL9sxAFTrSsniEpirYsAoo5mnK
	xf3r9Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmub967-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 06:24:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0e952f153so111227395ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 22:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768890247; x=1769495047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqnUnHSglS08Ezs/9IFZQZo2vw1kZKcPcP5C+SqXBDc=;
        b=caEEgNFDKVvs27oMBxCLi8MFS1XesEsHLGNmIxPx6qeaFvSwDrEfFBI/Bcs0nVIIo5
         uUT7i3VjvwLOlLiVzOAxm7eVbxiPCCJaJ78c/ez+ZbaJ08fmD+zLjjUtYZEKDPnzlzaX
         Vv4pZ7euEk+gobOEvYolAinesQQGtCPorN4YBXfPF8bFwU8QhqPuta7zJoU1yEXhj+nG
         ELAFX0zAMXQgjtMSACK974uOMsjGXTd8RNLKGiQmMJGJr1jDd2ffT6M5yuHYuDxRN/2l
         vZ+FCC2O98YZaVhf+tNyKEWNUvxpWGcq2A+kI5mij2I0xGtajDjqqBrBkP2hJFAsRJqB
         TgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890247; x=1769495047;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqnUnHSglS08Ezs/9IFZQZo2vw1kZKcPcP5C+SqXBDc=;
        b=akXFWKWF6DNcCLlty+m1/3Q9ADU+myioeNZ6AEZ/1VRKZhLWj4ZZqA/YG0MpB/xVW1
         c91RVDtBfgyxEOTMpcnSWJmnODb1AcwD7AcVLeuypQ1RNanbhX1T9cuf6PgIB97vgAlw
         4nbGXqV/YOroDY8kx9tRV+Vsr40DGwFcRO7zYGPV7tVi7pPXUwL3SgFVcVN+SbFXSZxC
         eQXgZkwnlldwafvl6CksZMmSJ3/sbV0vSPMiaDhWDL5MHj/IvFzmKAFe79c+WNya6SO3
         KYbkujHfV1ALgV8IJSVQq1zQ5TUuo4QFikNBw1q4RD+YzzGVdAeMrTbjvdq+DQGG+EFO
         iiMA==
X-Gm-Message-State: AOJu0Yzj1ywZsJ8CjQ6Ijba8aqfdmQi2j+4eTIlKL9ppbsYPOJDEKwpB
	6v2xauhET36jZKHSOiOqJkt64M7z2ZKRwgG3fg+911Idvc0b/HA/kmekJGac1VRoiky62QuNR//
	Yc58YJ64bBOCxUtGmT8jVjN7DHSTc8JcHRAeCjli5U/4ZVyB3zUDLSTGFMNconzY=
X-Gm-Gg: AY/fxX7MvI+vIHUzbytZ4j+FYvmNNAda1eHOClu4r6l4h222NXjSuSAzbF+6jUpF2iG
	k5n7vFczJ39Elpo3iOWS0FQOPxk1+FVNJT53aP5Fkh4lInPX4MqY18oGJu23u00Cwukf5FAh8T5
	566Pnmkr6TEAmJmO4rv63N0iRQFq3FWXFSc3VtQO1CcAGxCYqQ25GDTlcCanoPdpNCX1pErYytj
	4Obraa9QJyMOvNpg3G6S+k+Z0UG5qTxRzO7xlhHX+U1QnkhWWsFveL+IXQngmKKE16P1oRDSd8U
	afSEOLBCE9iMUwKcWCWVAmrFDAKg7rVSgfJXmasXuBW/MWMofW+TWJkZ+muI7w9qbcFbkdNIRPF
	nRvVJ4CS3NP52gZCbSsiC2gGL2ZKmw70GeRF3LmI=
X-Received: by 2002:a05:6a21:a92:b0:34f:28f7:ed75 with SMTP id adf61e73a8af0-38e45d08641mr914493637.8.1768890247098;
        Mon, 19 Jan 2026 22:24:07 -0800 (PST)
X-Received: by 2002:a05:6a21:a92:b0:34f:28f7:ed75 with SMTP id adf61e73a8af0-38e45d08641mr914469637.8.1768890246585;
        Mon, 19 Jan 2026 22:24:06 -0800 (PST)
Received: from [10.217.223.153] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291ca2sm10975787b3a.54.2026.01.19.22.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 22:24:06 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Enable Inline crypto engine for kodiak
To: Rob Herring <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, conor+dt@kernel.org
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <176840729246.2734238.959231359705262987.robh@kernel.org>
 <9c21bc87-326a-aa0b-ba81-31b10e119acb@oss.qualcomm.com>
 <CAL_JsqLVOLwC5fdQUoU-0QXcyjH0tK7cTE_7B6kVa6kFE8zF3g@mail.gmail.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <96ca9dd8-2d92-262f-8bb7-0f0c30cabd74@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 11:54:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLVOLwC5fdQUoU-0QXcyjH0tK7cTE_7B6kVa6kFE8zF3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA1MSBTYWx0ZWRfX4lMYa1lSJgzi
 +tvjSNXaaIj7fdSoiGJEC2YJ0+KP5l7dVgUAj/Sh96JstBrVEBMbvVR/7ojtJ4ptFc9rkHmwI8M
 /rV77ZpVDsXX3Ffe1ypf2CTCTeeCd9jSasMx1+yWvHLOLNKw4DIqzXP0aNFDE+GvFV/SWg3fYCe
 VzzUEeEIfrCLMiDjWu164aFysmx0dZsTR/xPklN5bzn5e0t8NfVUu/Lhjzv5/+QvbogjWvoPgDq
 FAdA/WyL0JtQ6JJl1VglkmmrPfaw9dlxWxg0hfAyDi49QiFduXKz3EpSgKFNHYMpK4PKmrlppa7
 eqMfyP2Qx9xYHF7XBGu1dUQrFgZSJMa8EpbLD2EP49upCYTdt0L4ldtOtxi9BnsCcNwYS1qlFr7
 JpONBqdx8OhOWhj5oMoqfalccZNIk9PG33sH/ssMkJygwLIvgJXPrdmjw3ea2l59XjwQoKKgF3E
 uf4OwDA0RWuGZlVW1bQ==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696f1f88 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=oVZI_Enn05QVDH3hfaoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: ahr0wGxeYiCBuqY9-j3aRPh1gEjfIoV5
X-Proofpoint-GUID: ahr0wGxeYiCBuqY9-j3aRPh1gEjfIoV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200051


On 1/20/2026 6:55 AM, Rob Herring wrote:
> On Mon, Jan 19, 2026 at 6:49 AM Neeraj Soni
> <neeraj.soni@oss.qualcomm.com> wrote:
>>
>> Hi,
>>
>> On 1/14/2026 9:48 PM, Rob Herring wrote:
>>>
>>> On Wed, 14 Jan 2026 15:18:46 +0530, Neeraj Soni wrote:
>>>> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
>>>> node to enable it for kodiak.
>>>>
>>>> How this patch was tested:
>>>> - export ARCH=arm64
>>>> - export CROSS_COMPILE=aarch64-linux-gnu-
>>>> - make menuconfig
>>>> - make defconifg
>>>> - make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
>>>> - make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs
>>>>
>>>> ---
>>>> Changes in v2:
>>>> - Removed the "if: required:" description for "qcom,ice" dt-binding
>>>>   as the ICE node is optional.
>>>> - Corrected the ICE dt node entry according to the dt-binding description.
>>>> - Added test details.
>>>>
>>>> Changes in v1:
>>>> - Updated the dt-binding for ICE node.
>>>> - Added the dt node for ICE for kodiak.
>>>>
>>>> Neeraj Soni (2):
>>>>   dt-bindings: mmc: sdhci-msm: Add ICE phandle
>>>>   arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
>>>>
>>>>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
>>>>  arch/arm64/boot/dts/qcom/kodiak.dtsi                 | 9 +++++++++
>>>>  2 files changed, 13 insertions(+)
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>>
>>>
>>>
>>> My bot found new DTB warnings on the .dts files added or changed in this
>>> series.
>>>
>>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>>> are fixed by another series. Ultimately, it is up to the platform
>>> maintainer whether these warnings are acceptable or not. No need to reply
>>> unless the platform maintainer has comments.
>>>
>>> If you already ran DT checks and didn't see these error(s), then
>>> make sure dt-schema is up to date:
>>>
>>>   pip3 install dtschema --upgrade
>>>
>>>
>>> This patch series was applied (using b4) to base:
>>>  Base: attempting to guess base-commit...
>>>  Base: tags/v6.19-rc1-102-g3af51501e2b8 (exact match)
>>>  Base: tags/v6.19-rc1-102-g3af51501e2b8 (use --merge-base to override)
>>>
>>> If this is not the correct base, please add 'base-commit' tag
>>> (or use b4 which does this automatically)
>>>
>>> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com:
>>>
>>> arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pmic@2 (qcom,pm8350c): pwm:nvmem: [[386, 387]] is too short
>>>       from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pwm (qcom,pm8350c-pwm): nvmem: [[386, 387]] is too short
>>>       from schema $id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcm6490-idp.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-idp.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-idp2.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
>>>       from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>>>
>> The crypto node i added is not a "bus" node but a leaf node for Inline Crypto Engine (ICE). There are no props like "compatible = "simple-bus"" or "#address-cells" and "#size-cells"
>> added in the ICE dt which indicates it is bus device so why the tool expects "ranges" prop? Adding "ranges" as a property in ICE node will be wrong since it is not a "bus" device.
> 
> The issue is your unit-address is upper case hex.
> 
Thanks and i will fix upper case in next patch but the logs are bit confusing to indicate upper case issue as "ranges" prop missing.

> Rob
> 
Regards
Neeraj
