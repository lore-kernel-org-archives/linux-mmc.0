Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32FE223707
	for <linux-mmc@vger.kernel.org>; Sat,  2 Aug 2025 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754136273; cv=none; b=cZT1ay5gKzdEAzLYhncp1tLNMRG7Xr2h4SygIebyT2sB44Cvw9GJ/a7ydRadyuMgQKBwLP633sF4KrEAIvdVU7tuTpjbsSXT2sOigaKE+a55mpoXaXlms/rOLFMS8wDbsqtdCGA5fAtgCdubxbqG6BKpE+O8UEpVrDIqAB8j7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754136273; c=relaxed/simple;
	bh=1uzB9r6w4x1mX3RQ6Geex7yxzg322VObRaZu0yQ2zp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch5iBDk9jHeS8AKINA/xym4FJR6/cDS3iPFRb0XRwbT7bciXLOuPW40Km0duhJNylV/3C67T3quEWwH8vChWbI3nx2iAzCIR7neQp8suBy6t9Bg3qCnCfyP/mJ4Hflj4Iqp/yqZ4i4iOMkz5yB423LJzxVJHdIu2fWKZE1VPgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UWM3ocOQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UWM3ocOQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5725fVi7010447
	for <linux-mmc@vger.kernel.org>; Sat, 2 Aug 2025 12:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vCSAiNPoWEksGD85Y1vvHR/fUZ2hueivl1eXMSvDOnU=; b=UWM3ocOQ+HzZFmFm
	EKT7uAZPdG3p6+e087FTZgXEGhjyrCSdKk7LDW4Pv42XZmfEHQxCZMMlSK3XbcXF
	YVpuA6dgKz/WpXdNItfqKFZmlKBBQoaIpTUOf9s4Stt+xm2RMfeH35+U0IindvQu
	CWhMJHMadNrtObCKFOOxWHaJg/2Wi24kiqARnlFXIFUaO7mS6inwdsF7H6wUFCMx
	qrlgFHC5Sfys/6s4Sb3FHp5A+d7j2mDomWaDCqkJW71gHT0UQFG5ggv73vSWX635
	OagCwra1zd8P9lWqXZSNqHIcnW6Oy169cI6QRXPwIC8HoM3HQCrk6PIlnCX2bfSU
	iDCZmQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc0mex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 02 Aug 2025 12:04:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7092a001573so4376946d6.2
        for <linux-mmc@vger.kernel.org>; Sat, 02 Aug 2025 05:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754136268; x=1754741068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCSAiNPoWEksGD85Y1vvHR/fUZ2hueivl1eXMSvDOnU=;
        b=STebeGxSxmuRvzBep0VJLTAss9fo88I4ReaPtaLJPkFfZjWjTSgcQ0VAjw1cEstzYw
         6xcUp13YasA1GR/IjkUg2AVq2BzHpFgfgo9dOGRlTyEOIzR876Lel1q+hN/P38kfyFU7
         1IrPB7ppspG+LU11DRvpgikYtghadP07FVgfLViFgfT/SE/tBgBMALHB3k7fGgQLyRox
         3iUBKottMHJCKiu47JCBqYby/Vu1H8ycsAABR7kiJiGxZtCfDxSreKSeaXyGkgCQs90c
         zmvi495SK1EUgS+OHZ8zKifBK0skK5C5hyGchI+/hKx2JhqIAP1YjruufZHsILFnNIaP
         9lSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrEBQD3IpztIqnlweOBzb9YQkZZbyzuu6+ws1Op0yBHveUBiwPDdN7W6zn4ZI5H8OuSWUJ6F2Y88I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5Tj8afJXLZaY74gWGuA/QKmRkx08qSU36JtvuQszSJi242M9
	gzjF/WghLWOznWs6a7+Tpg+oHrS9GraGbebJBiwr78p2eEoj3RFyfPmwvVPfDLKmUwG4of8WQYM
	MgMZIshIC6O5r/uiUcUVxkmjqGITAwJt/o7AdXjc4vaKNFBmUFNd6omtEhF6qNPU=
X-Gm-Gg: ASbGncsyVyVw7OONboOSJXgmlBhATkSJrRRFxwUQqSJ2dlUmL1Io9Pw5Kz7L1lYc+We
	wze+2b3TJcx2SaGesvY1dCCGd/pIwU6lpLc4oOdt/VX8enDCyPfoSenXWUiTHxBamTiYYq7gVc/
	9EaJ+UQVjFIll3XEWzfZYP9eN6HXLNqmvxDS6z1Nbfu4QmmZmCS53iSTdJY+QCdI7r1O4kchzc/
	tbwDrjUyspBHEEP3BqLpjtv60XCm2V4cXcJ1ueMRE3eLRnsrE96KXbBKF0trXVvNPvfOdAWjRIf
	pIqCpNA2nJpV3a1B+fvMykP+yTbWP/GwZAgR+EeKdBGjGTtdo0UCFf2ruO+C5RSn5tJVr00y4LH
	sNDTEqIhZI2CswjS16g==
X-Received: by 2002:a05:622a:1a27:b0:4ae:f8d8:b0fb with SMTP id d75a77b69052e-4af10978640mr22590151cf.5.1754136267964;
        Sat, 02 Aug 2025 05:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHRqglWcLnh7BFuPTAQfd/4FrslPHxTGZAg9UU256erRSiEGc77z4U8yY2TghDqr4GcFIe7A==
X-Received: by 2002:a05:622a:1a27:b0:4ae:f8d8:b0fb with SMTP id d75a77b69052e-4af10978640mr22589701cf.5.1754136267429;
        Sat, 02 Aug 2025 05:04:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c099sm421786166b.108.2025.08.02.05.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 05:04:26 -0700 (PDT)
Message-ID: <55420d89-fcd4-4cb5-a918-d8bbe2a03d19@oss.qualcomm.com>
Date: Sat, 2 Aug 2025 14:04:20 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
 <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
 <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WqnNya7YPMiHHIbDP6-fghyRLd2rxdER
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=688dfecd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6H0WHjuAAAAA:8 a=GauJToF0qxMHlBv3vicA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: WqnNya7YPMiHHIbDP6-fghyRLd2rxdER
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDEwMiBTYWx0ZWRfX9cv5H8GpVhVQ
 E8E/vtq/DO83Gv/CQwG+ZOwqBT3bfTVhI6GkaYsNfQgCITUUo7FMXS84PBv7og+aiwsCHxBHina
 kl3/x9OrHW68Tk+EVcisSeZNPp2XkJyHVWF0ARfBTSAJsWsOBARkgvR/kS3prwgBaspbcd3xSpm
 Ypa/6lidbd+xpm+k0XgGKtWF3/NtyD2xGHEcgv2QbvnFlIbUjL4G9Rau0nx5PlNYIA338kvWXbq
 EgV+0RKW8IcyFrXsZMOO4/4Se/6UUtAw8P4ircmJK/IFJ3dgYf9wL5E6JtgScg9jgzsqqXGz6Ww
 GZare19NQ3ayeMbdw7F16urhnjN3+HA8FXH1whVpAYbwgVP5GrazOq7GkoulWSO0SNVGHa/+6ru
 TmPpU1c6rpkcN+yrdRTnBbiGEeOsx4hmTrb6eyxz1Wc7n4OLrfM2dj6RbIIfAVlvfAFOF+1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020102

On 7/29/25 8:49 AM, Luca Weiss wrote:
> Hi Konrad,
> 
> On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
>> Hi Konrad,
>>
>> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>>>> Add a devicetree description for the Milos SoC, which is for example
>>>>> Snapdragon 7s Gen 3 (SM7635).
>>>>>
>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>> ---
>>>>
>>>> [...]
>>>>> +
>>>>> +		spmi_bus: spmi@c400000 {
>>>>> +			compatible = "qcom,spmi-pmic-arb";
>>>>
>>>> There's two bus instances on this platform, check out the x1e binding
>>>
>>> Will do
>>
>> One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can't
>> reuse the existing PMIC dtsi files since they all reference &spmi_bus.
>>
>> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
>> connected to anything so just adding the label spmi_bus on spmi_bus0
>> would be fine.
>>
>> Can I add this to the device dts? Not going to be pretty though...
>>
>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> index d12eaa585b31..69605c9ed344 100644
>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> @@ -11,6 +11,9 @@
>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include "milos.dtsi"
>> +
>> +spmi_bus: &spmi_bus0 {};
>> +
>>  #include "pm7550.dtsi"
>>  #include "pm8550vs.dtsi"
>>  #include "pmiv0104.dtsi" /* PMIV0108 */
>>
>> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
>> other designs than SM7635 recommend using spmi_bus1 for some stuff.
>>
>> But I guess longer term we'd need to figure out a solution to this, how
>> to place a PMIC on a given SPMI bus, if reference designs start to
>> recommend putting different PMIC on the separate busses.
> 
> Any feedback on this regarding the spmi_bus label?

I had an offline chat with Bjorn and we only came up with janky
solutions :)

What you propose works well if the PMICs are all on bus0, which is
not the case for the newest platforms. If some instances are on bus0
and others are on bus1, things get ugly really quick and we're going
to drown in #ifdefs.


An alternative that I've seen downstream is to define PMIC nodes in
the root of a dtsi file (not in the root of DT, i.e. NOT under / { })
and do the following:

&spmi_busN {
	#include "pmABCDX.dtsi"
};

Which is "okay", but has the visible downside of having to define the
temp alarm thermal zone in each board's DT separately (and doing
mid-file includes which is.. fine I guess, but also something we avoided
upstream for the longest time)


Both are less than ideal when it comes to altering the SID under
"interrupts", fixing that would help immensely. We were hoping to
leverage something like Johan's work on drivers/mfd/qcom-pm8008.c,
but that seems like a longer term project.

Please voice your opinions

Konrad
