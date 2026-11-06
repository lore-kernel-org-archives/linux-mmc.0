Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961407;
	b=hynYNPiI35b89qstYa1b3ADD6iAB8gSe9/Y7oizVM1gUWleG9qBsZP30VIsjBcuDDzBn
	 vThTR+3z6JyTB0dPYAFdJMqJZgzlkPeAbksPX4dRWeJYJCV24M1Emc4jhG4eZvvHD7MiU
	 AH/YkTQYv7KdnFjTO/MsQLMqgLOhux+IasAFaqnul7DLP44zAQF+ftHLDuE7Ig7A8yOXI
	 dZdnxz2Lt+WvX4dXOpJdVh5MqDvY1tKWR2TklWut+i3ewV53JNXo76sKf5PwgxSLu78vC
	 FT2PgzzQbMDDo2a0dl8Edd+efW/y4UzUyQBmczcDqTp0vZnBqi2pPl7Pl1bZoF6iENg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961407;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OZxu+tbVDDy7xSEFH0lL5b+ofAM+EN3/G8wai787Xb0=;
	b=rsYvCNB9Hn7j77oAH7z75YQZvRDhiBBvhmS/exktMLgmoMJf/XrF7T5gTVJq9B9dzv16
	 +PXYl3zcB+DnJlRc0dkYyCBOwBYcGxA9rny7SKn7syIYh/g7fbNE/FLuQq+3yFbwHiA50
	 37CMDxrkz9lZElp7rcHgzguGg/3VkqA9yRZSYdCmFM9A6QJj0m0k8g89Sc7o+Cg9f7az2
	 baysKGP4NBKu+13Wybl18YgQ3UP0qK6nE6uCrhQjMH7ORHNpcpMpp3ZKgo1+fghZq4udq
	 VJ2erSMwvIOqcW5rB0yIZSEl1UY9O0HEPJDo/SjVLB334LmLjuay94c7QuGOKUr6g9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c9OVlT2c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EDpPcUah;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55874606A32D
	for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2026 10:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55874606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c9OVlT2c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EDpPcUah
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AP8DC091085
	for <linux-mmc@vger.kernel.org>; Fri, 6 Nov 2026 10:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OZxu+tbVDDy7xSEFH0lL5b+ofAM+EN3/G8wai787Xb0=; b=c9OVlT2cojNESEDS
	7dgR4tpP8A1pHJdPy4VqU9/FRLrrTPUmE4cccbo4wWLPouzpmNA01u/vrILyoa1j
	HfenqI8h3LZrkrDLW4SGnb9sJsidlk/n6s9NpFXi2F9nZGR8hWEAv1XVe2Mpt13q
	uQM6+WYfEsg83lIvvG6tSLyQaYZsa4wIQZuDOGa1b0ER3oiwdkLu7WG8F0lC5QwP
	bQWeLetbYrYWjs+T9cYLDoerCe1Af6n+SGBGhJdK9ZLFlPeNuL4+COssbxpSwxG8
	br0pt8iaDCXqA/m9xoqG2awHNYSrxPgLOn37NLOw/t+Pgl5JZJIneSwt18hckR/n
	AoqxnQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb2d2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2026 10:36:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso427951a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2026 02:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793961405; x=1794566205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZxu+tbVDDy7xSEFH0lL5b+ofAM+EN3/G8wai787Xb0=;
        b=EDpPcUahnJsI3pgdxkd2tYEtkSGFQ6Qe4naxryX4npp/2pG8rR+MJ1oXK9fL/kiwa6
         JoZ5QmBY6bWFLSuDWv1oMn7PrtUytmb7PGZjCgqkkCKAsdXGV217UVtgsDIsPQ1dfO4q
         fgFMNI5H01e6159jI8W9GO/bUcsZBFeDigmMzLDJy/bcd8kV36htz6HouHc/yKZpzbHD
         lPc6Uk+rYQn86mLXpLKdq6ceHWD19bzb1KelP3rebKIk2nh8y/5ok6G0yCmEexdKCfgx
         eWL/as6JM/2Yqx6ifzL4AdUca87V50JR5GwJCPVhBECHWLEck/Chm8v7Bkz2N4loiLCs
         1baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961405; x=1794566205;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZxu+tbVDDy7xSEFH0lL5b+ofAM+EN3/G8wai787Xb0=;
        b=LPPorHtIQOyMpWnrkGbgzJmWBStZwE8NaYBTkNgSJ+hzoMfA+JP621gEh9AihZioF7
         XQ7l5wg64L8lJ0srcaKIK9AWIJHYn4+CmXY2N5lNwMpiVtktFvdrN6bcj07ezyRhJ9VV
         RQeZ1Yxy+eQPX74B0ntNTn6UdoiNIdd417877VrsAODiW836axVG5a/+j3a05aF64cRL
         ToCULbrwA/w+oVyGpbOfIwssDWWIXbLdYONYDQqCWHgKTFQz7zM98dpChSmfnfCeqonh
         K/evwbdQc1vgQSK5w5w+EY0UMNw6XLI/6pNTB5CIfxYkVFVN0cXS6qgQRrKPseztra6o
         BViQ==
X-Forwarded-Encrypted: i=1; AL+hErEPqhjcSzkkg9gYiM16rgHRdrvNpFiK0rGZhixXAvwHyTyiUcOvPSCFow4gmEZDxy+RsAhJ1WI0jMg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CDVXXPQ80QsMGemZdKF+md9WmfwqvAYk/Efif9d+Qf3THoDnM
	3gOVc4OSodNAj4bABQO+dh9quYvfnz2rKt720D8xKtXobyqAnSpqSiiQbvmpzPR4sVRXY+GVrcd
	Wt3uFxhuYfOGxbVYB3uSHHYrNAqjrz7YiT/IAkTsTcJxSGlQ77BYvayZSoZM1Vaw=
X-Gm-Gg: AYBFou32a5dSSHUyoXvWRqAHk8UTn5QEUfGSiIUKjZNwuI8/DVrZdeUCr9ZYFDa29N6
	vEFX8lUA8XqGxYXrYwWFvm6vCPNhiyjMf9ImeWP6d4r/j6RRa8ApF76KNwRO97wAqgnBlKLb06c
	EMSarB8lul405qN9nCFEANm6Htt7IuK1dyOcMXDKrJQNdhcc3mzQDtRaAz7GGi+AwQXqmuP+23M
	lvk7TH3xIq8r1WIdlwZWZ7FTJIzE2njicUXFTmgSUo5u8K3qRA/VVhe3gRid2c6aqII1m3XA6GL
	UpDGEXiMd16ICmQnpPiKRe3Dm6jyCanfZnS9SG/bfnw/mP6h7K4I3LWOhO24StLV7fwpy1A4GD4
	YbIu3A3wWNvrHoLyLUrXh/xijeSBnGwKR8l9UpgmDfyTmd1dHtQuNrjWZ8aUcjh6Wira2M8WXli
	M=
X-Received: by 2002:a17:90b:39ac:b0:3ac:a139:1b13 with SMTP id 98e67ed59e1d1-3b0db6f156emr1991652a91.29.1793961404875;
        Fri, 06 Nov 2026 02:36:44 -0800 (PST)
X-Received: by 2002:a17:90b:39ac:b0:3ac:a139:1b13 with SMTP id 98e67ed59e1d1-3b0db6f156emr1991632a91.29.1793961404355;
        Fri, 06 Nov 2026 02:36:44 -0800 (PST)
Received: from [10.217.219.8] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c66fe1sm2885209a91.7.2026.11.06.02.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:36:43 -0800 (PST)
Message-ID: <90ad258b-00f3-45b2-bf7d-5865a9d66258@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 16:06:38 +0530
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document bindings for
 Nord SDCC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Ram Gupta <ram.gupta@oss.qualcomm.com>
References: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
 <20261102-sdcc_scmi-v1-1-244dbd893051@oss.qualcomm.com>
 <20261104-sticky-perch-from-sirius-d3ebb3@quoll>
Content-Language: en-US
From: Anjana Hari <anjana.hari@oss.qualcomm.com>
In-Reply-To: <20261104-sticky-perch-from-sirius-d3ebb3@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BtRdALyCMWjBpA8gztfGnskCRYlOzKPo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX78ivhJ86yd1J
 eIxuB3KpRpTk2BbPXnSuxxX15x6SlC45amfHuhExWcoEOWGqPQFxD1MhAtoU4A0CH7eq3+xz5gh
 OTuMj7GFlMJqRun6e0TtFk2uxCTZvHk=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aedadbe cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=f_B6lkSkO6dyqIEesxIA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: BtRdALyCMWjBpA8gztfGnskCRYlOzKPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX7KcWjAqc1Bvd
 5glDCWLT1O9K0dC1MAWhiN7oRtTsd1TohHauN6xFwAexh3xgVt4ah+xFLPiG4lgT2hEdWY+mHIq
 r5l3MTODuL5P4/xVFweTuQIQNzdUxrrtQwMH3+7DCDmMkU85zKwvvBhRUbtYrYB9yw2EFvKtJSQ
 4W354hPS+gRhA+Nbk6UWMVLtyT5PwNRuzmJP7PDflTYWIgM/zP7y2jpZv/vUFcjgKTgYMOxRC/Z
 p1CVL4DXdYXS5rYc3oFY0wSgW1FmjECvWvEx96bphs6v9VtOGu3pvzXVsLZZ5n/oSS7DCfSYAwZ
 HsJecuI1WolpeCm/pEFFkWok1aJdoQZXuzVyG663jeg6mdEe8uk65uhmTnc6lmK61E/J7IKxM7v
 w/8xz/wgdxCUJjMtAnN3SvbQZaO9EGekpMwaZx8BoZoRUF8vQQgk3nX1tCfUxcMtDSBeN+pkysm
 UiPX3a4EpfrI6BnDzYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060042



On 11/4/2026 7:28 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 02, 2026 at 07:33:41PM +0530, Anjana Hari wrote:
>> Add Device Tree binding for the Nord SDHCI variant of the Qualcomm
>> sdhci-msm controller, where platform resources are managed by firmware
>> through the SCMI power protocol rather than being directly accessible
>> to Linux.
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> 
Acked, will address in the upcoming v2 patch.>>
>> Unlike existing sdhci-msm variants, this binding does not require
>> clock, interconnect, reset, or regulator properties. Instead, platform
>> resource control is abstracted behind two logical power domains:
>>
>>    - "power": controls the SDCC rail power state. The kernel requests
>>      power-on and power-off transitions via the runtime PM framework;
>>      these are forwarded to firmware as SCMI power-state messages.
>>
>>    - "perf": exposes the supported clock frequencies as OPPs populated
>>      dynamically by the SCMI perf domain driver at probe time via the
>>      SCMI performance protocol. The driver selects operating points via
>>      dev_pm_opp_find_freq_floor() and dev_pm_opp_set_opp().
>>
>> Both domains must be listed under power-domains with their names
>> declared in power-domain-names.
>>
>> The compatible string "qcom,nord-sdhci" selects this variant at probe
>> time and causes the driver to attach the two power domains via
>> dev_pm_domain_attach_list() with PD_FLAG_DEV_LINK_ON, ensuring correct
>> suspend/resume ordering between the SDCC controller and the firmware
>> power domain devices.
> 
> Do not describe driver. How is it exactly relevant here for the hardware
> description?
> 
Agreed, will be addressed.>>
>> Signed-off-by: Anjana Hari <anjana.hari@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/mmc/qcom,nord-sdhci.yaml   | 89 ++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml b/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml
>> new file mode 100644
>> index 000000000000..c512628617b0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml
>> @@ -0,0 +1,89 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/qcom,nord-sdhci.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Nord SDHCI Controller
>> +
>> +maintainers:
>> +  - Anjana Hari <anjana.hari@oss.qualcomm.com>
>> +
>> +description:
>> +  SDHCI (SD Host Controller Interface) present on Qualcomm Nord SoC.
>> +  Clock and power resources are managed by firmware through an SCMI
>> +  server, so no clock entries are required in the device tree node.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,nord-sdhci
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reg-names:
>> +    items:
>> +      - const: hc
> 
> Where is CQHCI?
> 
>> +
>> +  interrupts:
>> +    maxItems: 2
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: hc_irq
>> +      - const: pwr_irq
>> +
>> +  iommus:
>> +    maxItems: 1
>> +    description: phandle to the apps SMMU node with SID mask.
> 
> Drop description
> 
>> +
>> +  dma-coherent: true
>> +
>> +  power-domains:
>> +    maxItems: 2
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: power
>> +      - const: perf
> 
> Best regards,
> Krzysztof

