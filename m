Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78850096B
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826947; cv=none; b=gfQCNVqtbeXFnKzx9GliS6iacHYFoYOn0kqTUFqWmheIlBkzYnzSc7K7BLxiaEYU2BxZzeG3hbeHZC25oqePx+j6UhLv8xEZQxph0ARb1Vqs3FHp54NnuCQv+XXreggS3Cceah4Dm+GoafRPomuEQbwlXNDBp4qYePZ0C+3WoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826947; c=relaxed/simple;
	bh=vD8cbVHkNYwHVGwV3rwR0Uo/5RfBWglP0e/ow6yLRi0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PZfV1tGFEcjRpX83Q6Iat+80mlCkHG2p7IjhholuJhid1WdNZgmL3WybD3NcP1YabhtdIwnXShYGkCbBfRALoyvivSyfa3ZW/ZuGKgOyYnqN8X8mA9M9P4Ht7FFMnw2vBC/9iqVRAxamYkFmWlIdMQ1kHvQ9tP9a1mYjaPWnQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cm2Coeaw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G7gyXKCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cm2Coeaw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G7gyXKCJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JAJxJS1531420
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 12:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TU2vtCAfzwAJaCXmNSsQOt4NE2nzscGeqZYEijVdEEs=; b=cm2CoeawHAQLETPM
	MG1BvPW16Jizl4ho75co5R0zjdZGGt8x/QpllTIiwD9n5uHTzgvFdBVMLtGjDQCb
	FaF0tMoJis8XJHRwqSEJxNJKsVY5hXaFywQvAlHC4kgqI/sMPex9ncq74pGTpPtA
	PDYH2yaj1KnFgS6lc4YK3de7upJUEsM+euyQA4Nx3gTBUnj77LqwJhz8gH3cFh9F
	9up2X2fPm9uhYr2mvR6K3+TXqJRf5/GiwymKiIF5bhfgjO/KXvLWcchFMKYBP9JE
	NmK6VQHLOa0UVx842Vq7j4S/zrL/s7/32ipYUTuJjjQCkzMxkUauj3U6dNf1glaL
	f9OGTQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjrxrd7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 12:49:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81fdfafe6e9so59448b3a.2
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 04:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768826945; x=1769431745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU2vtCAfzwAJaCXmNSsQOt4NE2nzscGeqZYEijVdEEs=;
        b=G7gyXKCJ9k+913LXqJiYjhZl5LNSzJbIFLG986Rmm4HfMfly0KlAmwV0Hi7gjf/g3M
         PwtVMNo669Q/zyYFbMWbl0HWsFvI/Sv2gNJlQyspkGPLseRMBXS3sUcgufOa9LUapAjw
         Ab5uYV9B5rxuE2MaSSYbpWxa+dLKHS0kPbY/FCF80tZ4JFSMlNEoMZImpp9YGYLAlMz/
         eYZjOdBfm9ensKz4mfUeD/pd+TUFyNdJVOIW88uaeZLhMZSEyzeVl8+0zyhX3cBjud/j
         a32LOgcsw7Q1hsnNHx0IT08iCZgpXdkCaMJ4jkTcVr8Xi00kZ0WDOvauKt1SRnN6IF5M
         hftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768826945; x=1769431745;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU2vtCAfzwAJaCXmNSsQOt4NE2nzscGeqZYEijVdEEs=;
        b=BxIjGRSr/7F4m6JNGPUq7j2HBD+npjaxEPEXIpdB4geYV84Q7o7lLe4fPY6e90wpYD
         QTwugP6pWO3q7Gc24oKSYJhLqos6jrGXfmBjlmXD8dMtHTL+uW2SrgSj0jQFWgdto0Ln
         mVfkllbXnlXnXNxg6hN1Bv2LZF3n15s0rch2aCMEVzOarNEMq3lQTOOR3Zv2mPkkVU/7
         v6UtT3NXbtRsm+kSJ/1/fBqCy880G+QBXUZ5sK+RD2SAARnyS+YunDEPNjRSZ/TbRI5R
         M/icY9mManMoA9RJI9z4jQqJabPuwgI2S7VC1xkZghnNKbz4McFZPn8v0470h66L9hvL
         hPMw==
X-Gm-Message-State: AOJu0YyPaylp6UNXfBb6MCIxRsOyYznfhfWrkVY2XzKvFIQyGvN4yFgN
	l1oASg+IvHtnKjuYlewvbRVy/oMWhBQM55enShukDKF7HEv+hiHYVRFbPXJscntFU3uXT3LM0Wo
	EXPtCB9cQtQ6LQw2OEB6DOw1wfdZh71ASgUrjJURLz5zz4w+w9a5346IVUCDIGf4=
X-Gm-Gg: AY/fxX7jW4we5N6pmw+FnckwaZtjna7Wee78DMdRUaIMzXgn5SM9h/cQsDYEdJfPOBx
	w5cSHnSkpw3f2KrFPMtgGtUsQYKfu+o+wL9BXJE5lzq/KHw+xOPAa1u3S9pak3JMZbLR/RT66xj
	fQcJvtsJ3q8q7iuXe5cnqdNbbig++587mQSHulc86iZlJ+KKyq5KRb5ntdPsIC1Q7xjsbg740WY
	LKehOwDUeTPVLUNIeFpB3DvLv3w48l/MBKpFrNaN9D1pvW9p98CGyT/GZowdZ7+ok5lw34PzBIw
	Smickl3UfMxMA5isd1XTQlXSQLV4iKGR/JC8rjxBUSIVvg56YFeXTdMPYmU69L6GBJXRK6OHgws
	7gB93F/ls694TidIBDasK8TkSP4LeIkRT2/rTskY=
X-Received: by 2002:a05:6a00:ac4:b0:81f:7db2:89db with SMTP id d2e1a72fcca58-81fa188208fmr9565269b3a.68.1768826944590;
        Mon, 19 Jan 2026 04:49:04 -0800 (PST)
X-Received: by 2002:a05:6a00:ac4:b0:81f:7db2:89db with SMTP id d2e1a72fcca58-81fa188208fmr9565248b3a.68.1768826944085;
        Mon, 19 Jan 2026 04:49:04 -0800 (PST)
Received: from [10.217.223.153] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278061sm9319886b3a.44.2026.01.19.04.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 04:49:03 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Enable Inline crypto engine for kodiak
To: Rob Herring <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, conor+dt@kernel.org
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <176840729246.2734238.959231359705262987.robh@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <9c21bc87-326a-aa0b-ba81-31b10e119acb@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 18:18:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <176840729246.2734238.959231359705262987.robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEwNSBTYWx0ZWRfX+nxhT9twLLhn
 dTa53R+mBReCn6eqcKJ4CmoAm3ikMvhK7pYkx/ZydxyRpHW4djhnSpZn5KUMTVCcvC3alQ+L/th
 Bef91hpJefgkkXrD8sENgHHo7JCykI0Df2VlFhNb04eHTvDMmdoVHXrZ7FIC+u87XpZvgbqgHvW
 ElNlv90B5Eg53J5Tz4O0R/3O/QFzPS58YawrXd+oOZ1Tm5JMeAlpNYh44kJIOpEv6dG2VrTVbSo
 Za3JoLylWj/aU/xJ8fOzFP1DtSEn0UR52UA0M5lLi29bbthjPKWpkJ8JhxZVRslxOiYK20hO3pK
 zDLINP4Y4FiEJ+cQ/nB0guI91lnU0bGTGobVkmhaaTLLQ2gv9jf9TczPbYoOc9Rc9xsO7SVv3TR
 ck0D807zCkph49BBPsTtJsFzjtFuE9sSK78l20VjyS8+UIChpmwJIkKSZZ2cft5dGi8VduumcWZ
 Qy45ePl9IMPWxZS3RmA==
X-Proofpoint-GUID: EgsMYkDH8aYB9gwe7J-56MndVL37tED4
X-Authority-Analysis: v=2.4 cv=PPUCOPqC c=1 sm=1 tr=0 ts=696e2841 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=tbLNEdYNDDqBs7JTpEAA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: EgsMYkDH8aYB9gwe7J-56MndVL37tED4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190105

Hi,

On 1/14/2026 9:48 PM, Rob Herring wrote:
> 
> On Wed, 14 Jan 2026 15:18:46 +0530, Neeraj Soni wrote:
>> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
>> node to enable it for kodiak.
>>
>> How this patch was tested:
>> - export ARCH=arm64
>> - export CROSS_COMPILE=aarch64-linux-gnu-
>> - make menuconfig
>> - make defconifg
>> - make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
>> - make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs
>>
>> ---
>> Changes in v2:
>> - Removed the "if: required:" description for "qcom,ice" dt-binding
>>   as the ICE node is optional.
>> - Corrected the ICE dt node entry according to the dt-binding description.
>> - Added test details.
>>
>> Changes in v1:
>> - Updated the dt-binding for ICE node.
>> - Added the dt node for ICE for kodiak.
>>
>> Neeraj Soni (2):
>>   dt-bindings: mmc: sdhci-msm: Add ICE phandle
>>   arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC
>>
>>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
>>  arch/arm64/boot/dts/qcom/kodiak.dtsi                 | 9 +++++++++
>>  2 files changed, 13 insertions(+)
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
> 
> 
> This patch series was applied (using b4) to base:
>  Base: attempting to guess base-commit...
>  Base: tags/v6.19-rc1-102-g3af51501e2b8 (exact match)
>  Base: tags/v6.19-rc1-102-g3af51501e2b8 (use --merge-base to override)
> 
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com:
> 
> arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pmic@2 (qcom,pm8350c): pwm:nvmem: [[386, 387]] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pwm (qcom,pm8350c-pwm): nvmem: [[386, 387]] is too short
> 	from schema $id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcm6490-idp.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-idp.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-idp2.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb: soc@0 (simple-bus): crypto@7C8000: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
> 
The crypto node i added is not a "bus" node but a leaf node for Inline Crypto Engine (ICE). There are no props like "compatible = "simple-bus"" or "#address-cells" and "#size-cells" 
added in the ICE dt which indicates it is bus device so why the tool expects "ranges" prop? Adding "ranges" as a property in ICE node will be wrong since it is not a "bus" device.
> 
> 
> 
> 
Regards
Neeraj
