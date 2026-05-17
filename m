Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90B2F7EE9
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779044779; cv=none; b=grlsrWL8R1MC5sMXh3e10m3o4aJcfyxIEIYP+iLtYSP/8Tgyx/z05Lb8PXDkFEWYJwZ+I0iboPH57LiXy6Y2GUYi0BVtvzCdNjhgkalOA0Rup5DFkFH96MVhCm3BOorzGtH4opHpVyQcn85bXASr/8Fn8W1nSAaS/0C1oGo3qmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779044779; c=relaxed/simple;
	bh=/x9LxNzmS5J8ypNDdwjQsG84LV/SknFWY/zG7E8fPZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odDGVyLS1sWQFnEuaEnwXVx/yq0jQlyUpyrwDYm/fU9x68B9rG7BUhODavQrIFXe64Bu0dyhkqZsE5WBaCO+Qul3ekSlGjTYGFobX49BImnbvbbm5cKY7Dmgv1rwC3dxvUyB3CSM5ESIqVCGyClQTzuFXsvWVagc4OyfyM9GihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACmHOvnp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R3mzC2R/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACmHOvnp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3mzC2R/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H9e9og1800255
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 19:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5CTp7WWFll3OVumVrIQDCRGiPwlHUxMe6Ct4Tld7Hi4=; b=ACmHOvnpQPi5Zhuq
	lHPwg6xZ3Q33aOjHXKqG/xofPsZZ8QovFsSbr//uC5cOusHZ6sr5oqFroOqLyWza
	iKBnfaK9D50elFGiFSk5cQiVYElWN3BgbHU60Uw5Zse2NmOI9KyGmGw9k6j+GR7g
	OSX/YWQHVcHniwHZZAe3ll+H3XxPw244PCzigUubsBI0lGEFRZJgkp/eaLXDfouj
	KSQ1/i/Iz9U6ZHh2i2tYjQCax+Vr6mxJSNB8JYAvTdD1JPR4sI+LPyt//hLXUgMy
	sWvFkoRX0EMPOzzghp35RCXkFof3OOy9vExE9bJ9qZRwGxsy6y+jdVoxU4tx7WD4
	osi7ig==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gwmbeht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 19:06:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso697294b3a.2
        for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779044776; x=1779649576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CTp7WWFll3OVumVrIQDCRGiPwlHUxMe6Ct4Tld7Hi4=;
        b=R3mzC2R/SCrcLQNns2mVOstqal+9xMmEkWLZT876DFAw0gXVo+K84jYb5+X7fTzO3w
         uCNDXM8t0E6UEeP+/QyDR91cv/RnEzg3KgnRtv4y81vJJNa9lygtZVPeTPsOFk/CKkJt
         FPYde4AsiECjbsKrBM/tXzXG11wJ4XlTLJPy+F99YteSAg+QI1IsY9+dkBSq9t+HG7Yh
         nO6qZW+kf2B6hquEjakVKVq+NUVyJCbBIoegz1s35+mfzAy1+5lybnESWYp+fnYWVbNd
         D+iGflPJIL4cK7w3H/qmXu71wOPgIBYu3lIny0cDUhIdbB17Y041wzzOzYHlSk7O0xr5
         vKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779044776; x=1779649576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CTp7WWFll3OVumVrIQDCRGiPwlHUxMe6Ct4Tld7Hi4=;
        b=YigEqnfsL7gGgk9V7c8zlnAaehmHKhJyv1TmhDIY/ue8+GenvasCNdjauC2Sr3+w7i
         FmmxWUiL1l4/aov0B1kBxMqb9hkZbNqkVHtqfx1DmnndagcS86eFThMLQuouO8TRx6Jj
         33tE010XBUVUg6T6rJHP8S4rINymehdysXzcIgdFX2ggxxM2cm4Flr/aTWNRJPWN2c2Q
         SZdlEEtCNxLV+wDWjY7x3Qs4QZ16wkq4xZX3tpNhxac2OmDkyqE+bkJodfXv3K9HGG2k
         eOoVG64Kng3VvFqhOtbLa8E2TkYVQPcg9zjBKojzjNRTtzNDPsmS9XFobKJEINOulrtp
         M03w==
X-Forwarded-Encrypted: i=1; AFNElJ+QbP4EI+YIiFG0ZBmpuhhWJ9Ug2lP6mGv+w1IW+76i57EYlsELKdv3zfj8CwfnffsPfptC6z8DgSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpytIvHHZKYKjMPcuCF3vy9eiY+++JbZFbXAKTHFymU2VrTUa
	3dD1xQJzmMneNA+rgCqLAfmOucCoI3VSfk/t40S1GOZf9m2RXNb/buxJXQ138crAbBkiEZJpkiZ
	Twxg1kvGe88VV7rO/l11RLB6jdhdcMI1AwKjsNsmIYXx2nAWH2LzdGWh4rjNy4Mo=
X-Gm-Gg: Acq92OFLmPUfNoBn7eVLW6+Ymg5mB0Va40vcEKJefHGIPTG43yV+TpkST5UHcqjN+jw
	DJzKbkjbRGD5zuSb3o7qwsNdMu3KLua4tKIaH+QMU5zg9ImIDvSzciAyE1MLQ0nBM1jWEymL6NL
	h2hfb68w7+QxEIFspj7DKP494Ja2LaT9RkL+ycX3qXRAv7cEqv3WqPNnCY0+u7UIhgcOMUgbM6g
	uVqoL1oB+AljJjzMEzw0zYGIbgwDBO5l04NKVdLZS/5qwVfTRBlhx9el3rxDBNY3O7sMFlbqRby
	10hpgPTXi98AcWleAlt+ZoNoNCUI/YT82OEOVYUxA1fpIYSXX9Ditd8eoRZYysvq15jA7TsNjZO
	9irEqQPp91kTovomd69ZnfDVjMbaSfyfiKsD8dUcAQbUySbqifY4=
X-Received: by 2002:a05:6a00:4fc8:b0:82f:84c6:6510 with SMTP id d2e1a72fcca58-83f33c961c7mr12510764b3a.11.1779044776089;
        Sun, 17 May 2026 12:06:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc8:b0:82f:84c6:6510 with SMTP id d2e1a72fcca58-83f33c961c7mr12510718b3a.11.1779044775544;
        Sun, 17 May 2026 12:06:15 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.235.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f8b8b3sm11579843b3a.59.2026.05.17.12.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 12:06:15 -0700 (PDT)
Message-ID: <6df56ddd-3cc2-414b-882d-641277ce1a66@oss.qualcomm.com>
Date: Mon, 18 May 2026 00:36:04 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add Shikra CQM and CQS EVK boards
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
References: <20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com>
 <20260512-shikra-dt-v1-4-716438330dd0@oss.qualcomm.com>
 <mw2ipu5z26ubmrg6qe2v36cp6ktkqtbpfe3hmr434qdgm66nz4@pu6yy7hw4n3t>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <mw2ipu5z26ubmrg6qe2v36cp6ktkqtbpfe3hmr434qdgm66nz4@pu6yy7hw4n3t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qvgxKepxFXZ6TQ5BrPviBl1QSkb5CqD5
X-Proofpoint-GUID: qvgxKepxFXZ6TQ5BrPviBl1QSkb5CqD5
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a0a11a9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=g4/7f0GlZvY0MGcqtTB0Sw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=4NbkJTruBT-5dyiUZdQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIwNCBTYWx0ZWRfX00gCaTj2GCz4
 yEJYflPhC0IPrYRUsX2NsNr4nK7fpNulxknGoO4g/nVzCvx0vFB10atNhKlNU9OO3syQcT8DrXi
 sXQBBl24ynIP8WyGxUR5S27XfKvuuHiMjkloikpAZ5C2c93zc3p9JTH5aJ2YnuAec/+/p8UgqJ3
 4eTa272MYJjzRheMTo3ipKyT/tV2Ca57paLkOukvfKepHibNZQ4ufniMBkY98gKIGN2wSJ6QilF
 11YkP0MIaGqebDUHwizioJ0d0TRCmexq7Qd/pvrbPE+0BJEzrjZ1bxkIiZ0vGFiD6LBfKUx12Hy
 SOBZvkxZjjGghhABLFCvNpCInSAu83GtRn4RUx08+w3TAI5MlIHgqlJNd2zgsSlFVfx+14/oyc4
 ozcjG5O85gmkeBHlVct+vdhnTB12WEHDo5MK6sta+UM5T/pAG8FWQ/Xep6wkbZyEr12+KZVBdyZ
 XidurLMhqxAeUq2VKJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170204

On 5/13/2026 5:34 PM, Dmitry Baryshkov wrote:
> On Tue, May 12, 2026 at 09:38:07AM +0530, Komal Bajaj wrote:
>> Add device trees for the Shikra EVK platform, which combines the CQM
>> SoM variant with a common carrier board.
>>
>> Two EVK boards are introduced:
>>    - shikra-cqm-evk.dts: pairs with CQM SoM (retail, with modem)
>>    - shikra-cqs-evk.dts: pairs with CQM SoM (retail, board has no modem
> CQS

ACK

>
>>      support)
>>
>> Also add shikra-evk.dtsi common across both EVK boards.
> What is the split between shikra-cq[ms]-evk.dts and shikra-evk.dtsi?

shikra-evk.dtsi represents the common carrier‑board and daughter‑card 
configuration shared across all Shikra EVK variants, including CQM, CQS, 
and the upcoming IQS board. It currently enables the debug UART, eMMC, 
and USB along with the required PMIC regulator supplies.
In follow‑up series, this file will be extended to cover the remaining 
common daughter‑card peripherals, such as MIC, display, camera, sensor, 
and NFC daughter cards.

Thanks
Komal

>
>> Each board DTS enables USB (peripheral mode) with the appropriate PMIC
>> regulator supplies for the QUSB2 and QMP PHYs, and eMMC with the
>> correct vmmc/vqmmc supplies for the CQM SoM's PMIC.
>>
>> Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>> Co-developed-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Co-developed-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
>> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
>> Co-developed-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> Co-developed-by: Xueyao An <xueyao.an@oss.qualcomm.com>
>> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile           |  2 +
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 61 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 61 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 13 ++++++
>>   4 files changed, 137 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index cc42829f92eb..6de783bcd133 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -328,6 +328,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-huawei-matebook-e-2019.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> new file mode 100644
>> index 000000000000..12eeca84832c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "shikra-cqm-som.dtsi"
>> +#include "shikra-evk.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. Shikra CQM EVK";
>> +	compatible = "qcom,shikra-cqm-evk", "qcom,shikra-cqm-som", "qcom,shikra";
>> +	chassis-type = "embedded";
>> +
>> +	aliases {
>> +		mmc0 = &sdhc_1;
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&sdhc_1 {
>> +	vmmc-supply = <&pm4125_l20>;
>> +	vqmmc-supply = <&pm4125_l14>;
>> +
>> +	pinctrl-0 = <&sdc1_state_on>;
>> +	pinctrl-1 = <&sdc1_state_off>;
>> +	pinctrl-names = "default", "sleep";
>> +
>> +	non-removable;
>> +	supports-cqe;
>> +	no-sdio;
>> +	no-sd;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +	dr_mode = "peripheral";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_hsphy {
>> +	vdd-supply = <&pm4125_l12>;
>> +	vdda-pll-supply = <&pm4125_l13>;
>> +	vdda-phy-dpdm-supply = <&pm4125_l21>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_qmpphy {
>> +	vdda-phy-supply = <&pm4125_l8>;
>> +	vdda-pll-supply = <&pm4125_l13>;
>> +
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> new file mode 100644
>> index 000000000000..bc93282f64cf
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "shikra-cqm-som.dtsi"
>> +#include "shikra-evk.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. Shikra CQS EVK";
>> +	compatible = "qcom,shikra-cqs-evk", "qcom,shikra-cqm-som", "qcom,shikra";
>> +	chassis-type = "embedded";
>> +
>> +	aliases {
>> +		mmc0 = &sdhc_1;
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&sdhc_1 {
>> +	vmmc-supply = <&pm4125_l20>;
>> +	vqmmc-supply = <&pm4125_l14>;
>> +
>> +	pinctrl-0 = <&sdc1_state_on>;
>> +	pinctrl-1 = <&sdc1_state_off>;
>> +	pinctrl-names = "default", "sleep";
>> +
>> +	non-removable;
>> +	supports-cqe;
>> +	no-sdio;
>> +	no-sd;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +	dr_mode = "peripheral";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_hsphy {
>> +	vdd-supply = <&pm4125_l12>;
>> +	vdda-pll-supply = <&pm4125_l13>;
>> +	vdda-phy-dpdm-supply = <&pm4125_l21>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_qmpphy {
>> +	vdda-phy-supply = <&pm4125_l8>;
>> +	vdda-pll-supply = <&pm4125_l13>;
>> +
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> new file mode 100644
>> index 000000000000..fae8c75b68b3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +&qupv3_0 {
>> +	firmware-name = "qcom/shikra/qupv3fw.elf";
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>>
>> -- 
>> 2.34.1
>>

