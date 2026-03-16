Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7C32E12E
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651833; cv=none; b=E673f6XB6+MIOQV6YeAMXpUDSH8ANrBI3XsN9H1O3OI/w66OJIA5uqGbbjWtLlfZKKtMYtush808z6kEu2x0RbL6fH+u/i7ZT5owiyWbCmkm2QzvO0hsC27jC/vPbn2ADPU76CdZQ3xHPoNZNA/kdrcYT5TAujN34GjVwzZuKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651833; c=relaxed/simple;
	bh=NTcvsuGdFFCNDl1LmYf5IJqXK3/yowkel0MRzCFjEA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rit3vwBUwbpLgB7634sxMv7yo9tePLU8YhaAqYfWs7hXourIPHMufA42mahsC8ViKRqQqRCugkorZHXL3nslHdS+3YMpyDEPOWyw27G0yGQXvpe2xCib6Vvj060yRfy6OSN/l/hT0AcUSx4/NkwNA9fx7ycQ5UW1vlhBDI9vOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XzN5Wves; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWoeMhsa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XzN5Wves";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWoeMhsa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G658iT745781
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uxIt5bFyOn21UFobDspTNyIJUK1VFpOCpDcq0kigCmw=; b=XzN5WvesKeTofC7H
	71emGR6akr7BAIw18eRTDtKaDaPpG4SL6Ck8aNqNq7Y2ZflWiNhCemEsvK1w51iL
	Xa9Ku6lFxoPG/NnY5uwxJ9Md7InPysX4iR9VriRB3qy71IdwNN0GC9EDurBQJrVe
	lYNSmNpk0PpxQoaUoyqba0fkh98NeAAaN2Z+WqSFu1FpYHNldZTIZDBagaUSA/ez
	sP9OgmnPTocO8fAHA+fIz4AT4Ec/vvXzDtoFgcvwnLH5Wl015FYC6DNHBKNbKBl3
	DygEddJowzNJj6wGGGO7sYZI84rsvmX3PYMfDcMOZ2B1kOGInE59FU2eFCTqvI/s
	4hLFzw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00bd0yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:03:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c709551ec08so20839234a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773651830; x=1774256630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxIt5bFyOn21UFobDspTNyIJUK1VFpOCpDcq0kigCmw=;
        b=bWoeMhsa9riDiUmH8NWPJRvIEorscO8cwUAocO9VGmZJnwNT6t/tvt50HImUP0ov80
         IH7IoYvspWlHJOgqLEy6oYEsvy36NTyY0kKewzVawkNT2lRmsBNhRd96XTg68BfuATUG
         k/VNfRHaaDFF4HsAEJwCUF5geqkZr5oky32d03o4Oa5Ncg275XgfWKFVI9fYjtUaVR43
         dmVONu2zDl9GO/U4AGeOs86b99Npp2jF2TWKuYxm1NTKuBuLnfe+SzRODFniz6vSqxmG
         WoPc48nJ2efba7hwF4oeAvZpCQkNEtpPYmMqCto3bXLNW3DSUiw3MXmFMY7w59VMIPpN
         oDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651830; x=1774256630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxIt5bFyOn21UFobDspTNyIJUK1VFpOCpDcq0kigCmw=;
        b=E928/uWL3WrmQQ+IRBPqNPPQv1FkiVZmi9lRsdy69gR/GApAkGL/uAJaJ8yepl5i4C
         zWOeM8k9YNmsbYh6lFyiXUIu2N6OgcXSa9YnuNQyuU2I2OhhfF7zJNsYY5hkybCg5fpB
         UWdrIOPGwuYnFsxru9Uu50clRjoHZMf+lCNgaD58qsIFkAZCI2BUAbGWEtZlncFizCoi
         cUqkkR/YErI019ybhNMdn6WtZqm2Os06We6VA5cnLnTF4R3q+o94ce+pns8uH0WiOwa8
         CgOj3ZcqKMO/rVxPVT+rA5B20xzkVvwf5RQi9x4Ioib4rJEsIO1UP1oe1NXkKGClNwpa
         ABDA==
X-Forwarded-Encrypted: i=1; AJvYcCVrScUjo9hYOPaIp+YlnTNm/4WzeazPI1m4Jq1SxBudX4Oq5INzECrInz0MOnN6dolaakRrr4NIsI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAD0KKm39qy2F2KqQPKJ734KvGQfOPnrIQbnj/orNJn4l03Iq
	zoel+rY3bMHTzQ7+SbxYW6B8Cmymf1T+3pPstVNvHnvh3olFN/wKWPg16Dlm0fh3Ebmiyk3sgyL
	5esqf5IKHH68skOxPjW/T82juNR26jEvTWJeeSjYdFvksp8mS0GyJhUSQ8vdiUACsc0U78gc=
X-Gm-Gg: ATEYQzzxSvUF908R2ThgXWch0JWJ1+OQ0LiDtPZWQ5Eth3takOz+o5LXVhN0/WhbWHJ
	3t9aR1A+H4HRp7Xmu8/AJ7NSfMGP77cg7cP9mwEb90siCW0E3ElG9yPDpMQFLv/qRLm1KKX2SVY
	uMlJ9OWwmqcKFY37mTy2oYnWYl9GdGfMc1MYEwQ7um7tYNqohyU20UOJY2Q3WGw38xj1XKkgVd9
	W6f/r9jqGj7AoQ17eu5LyJVulBdetU5RH/HVSAxeV3cyNkZNZ0aKUe6ZwKEQtIPfKGTGqy/iBSQ
	SogddWYXjHFnVDyWuCrKOSP5nXnxiN/hkiscjtaOQhosIpZBNAn3QN50Mqs0onrjJkoGypPR5Jv
	1bBaPvmmr9C5VYir2IZsiS2XNTnV9xCbQBp7YF2Zw+GJXwuGJYPPki0mD5ATY5QjU4A==
X-Received: by 2002:a05:6a00:761b:b0:829:8e63:fca1 with SMTP id d2e1a72fcca58-82a198d4ccamr8653987b3a.33.1773651829984;
        Mon, 16 Mar 2026 02:03:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:761b:b0:829:8e63:fca1 with SMTP id d2e1a72fcca58-82a198d4ccamr8653948b3a.33.1773651829361;
        Mon, 16 Mar 2026 02:03:49 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07244071sm13207421b3a.6.2026.03.16.02.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:03:48 -0700 (PDT)
Message-ID: <84f1407d-62c6-4ec2-8976-eabe66c74728@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 14:33:41 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: add IPQ5210 SoC and rdp504 board
 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-8-fe857d68d698@oss.qualcomm.com>
 <6e33daf1-bb90-47d8-955c-12ccdd30ebce@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <6e33daf1-bb90-47d8-955c-12ccdd30ebce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IsATsb/g c=1 sm=1 tr=0 ts=69b7c777 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dbLGCUDwb5mCwCoKLG4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA2OCBTYWx0ZWRfX/A97RMGJKkIM
 oAPHwRasklJ1GKQ46VNIMzg8skS1nlnv4GcJ9ozC/HpGP4QfJL737Q79KTWFetFzhoczf42alof
 2HnDHaIEGA4lDqlZn1ptmxevRTwHXlmSeo6C/D3QIJg3h8cK2iUBa8ehRMwIQPxpE3v5TOzOt7Z
 c9BbTXeI9u75epFjhapqKj7ygerMDGZteeVdIrnATcEb3MfAf0wIgO8e4yLV230NCtIv6bvdsiO
 2Jqzl5icqwF/05BwXd0Iss/T6wcrqCAogCWAUnvBfaOjiDfYYYfD9XOuuP80xyZILE8X0T4jE0U
 s1MqDhccGxrJqIMV8CdoWRn/sTvH7s2DFLH0jtpk0D7Q3Ao8b6gta0wNxq0ZWdmBrvNQpCo1HIG
 /RW/gwFhGwA/n/Hq+XUgDF5SkKn/9MUIz79HcaFIODRSDuPHtoBup1YLAR0GkNyaB4TliaoiNHt
 y5/seAu41cCeM83PQtQ==
X-Proofpoint-GUID: dfTTPXA-XNvVOXQBGOZUNI0PVn-fgl4V
X-Proofpoint-ORIG-GUID: dfTTPXA-XNvVOXQBGOZUNI0PVn-fgl4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160068


On 3/13/2026 6:18 PM, Konrad Dybcio wrote:
> On 3/11/26 10:45 AM, Kathiravan Thirumoorthy wrote:
>> Add initial device tree support for the Qualcomm IPQ5210 SoC and
>> rdp504 board.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>   arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts |  93 +++++++++
>>   arch/arm64/boot/dts/qcom/ipq5210.dtsi       | 304 ++++++++++++++++++++++++++++
>>   3 files changed, 398 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 02921a495b2cbabcbacc74fbbb99eafe1f6478ac..e7748af640cccffa5c83ec82c37aa441444c2b13 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -22,6 +22,7 @@ hamoa-iot-evk-el2-dtbs	:= hamoa-iot-evk.dtb x1-el2.dtbo
>>   dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk-el2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5210-rdp504.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..3d95939785bc5bd4f510e2f992f0a1e80848c8de
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
>> @@ -0,0 +1,93 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq5210.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ5210 RDP504";
>> +	compatible = "qcom,ipq5210-rdp504", "qcom,ipq5210";
>> +
>> +	aliases {
>> +		serial0 = &uart1;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0";
>> +	};
>> +
>> +	soc@0 {
>> +		qupv3: geniqup@1ac0000 {
>> +			status = "okay";
>> +
>> +			uart1: serial@1a84000 {
> Please define this in the SoC DTSI and enable it via a &uart1 {} reference
> from the board DT

Ack.

>
> [...]
>
>> +		xo: xo {
> "xo_board" is the convention in other DTs

Ack.

>
> [...]
>
>> +		L2_0: l2-cache {
> labels must apparently be lowercase nowadays

Ack.

>
>> +			compatible = "cache";
>> +			cache-level = <0x2>;
> = <2>

Ack.

>
>
>> +			cache-unified;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		optee {
>> +			compatible = "linaro,optee-tz";
>> +			method = "smc";
>> +		};
>> +
>> +		scm {
>> +			compatible = "qcom,scm-ipq5210", "qcom,scm";
>> +		};
> OP-TEE *and* SCM? What does the former do?

For OP-TEE, we have use cases like getting the random numbers, 
remoteproc PAS and few others.

For SCM, setting the download mode is one typical example where OP-TEE 
doesn't come into picture.

Please let me know if this helps.

>
> [...]
>
>> +	soc@0 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0 0 0 0 0x10 0>;
> should dma-ranges also be 36-bit?

Ack.

>
> [...]
>
>> +		qupv3: geniqup@1ac0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0x0 0x01ac0000 0x0 0x2000>;
>> +			clocks = <&gcc GCC_QUPV3_AHB_MST_CLK>,
>> +				 <&gcc GCC_QUPV3_AHB_SLV_CLK>;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			ranges;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +
>> +			status = "disabled";
> I see there's only a single QUP wrapper - therefore I'm going to assume
> there will never be a SoC where this needs to be disabled

Ack.

>
> [...]
>
>> +
>> +			uart1: serial@1a84000 {
>> +				compatible = "qcom,geni-debug-uart";
>> +				reg = <0x0 0x01a84000 0x0 0x4000>;
>> +				clocks = <&gcc GCC_QUPV3_WRAP_SE1_CLK>;
>> +				clock-names = "se";
>> +				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
> Please uniformly keep a \n before status, file-wide

Ack.

>
> Konrad
