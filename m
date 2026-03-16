Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1B34BA21
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645546; cv=none; b=h/+92yqfGUZ9zcYpgkSNS3fWvZmT/UBfZy6yrXNaWzJ2wxzcIOk1Ne8FZuMhoP5zFvxWWuDk3YO6fB+ETRuoGwgWi8lhpP1281dJ2INnUMmnsv160O8Czz+SwEO2qYCToexx+8poMpHu0e0LDnQmkU7HcNtiCefhtxB58RUHVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645546; c=relaxed/simple;
	bh=j8v8ld7zJoZ9UjhL+Y57qItIiIfZVj2JTddzfGquieI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDz/n+tvXVnvgYG0QQJ27ZNCHeIGNX4rsU459dNdYcgA2YqT/eyuN1Yjgq7bHM1rN0+iHzJ65i6fv3Ju/K/47pk/vWKR0Cq9s2ChAMIhP1nTkfCdhUjCd5RpHowtTMrtnys71exMYLP0Xajx2/1osHgGuCeyZUYhfGRdQjKXD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pLedPCbI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hScF2Ru6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pLedPCbI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hScF2Ru6"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64nFL1724882
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9XNQwagjQvS1eX8YPd1QfF/D3gxhUMNjfLGG0HuA04A=; b=pLedPCbIxWA7k0aE
	j/AH2ZN0Xz4dlUErhfkoEASMaztd60FdpVtZKk4rRP6nGM5o4U8a5u4TpJP5tHoe
	CGaPRdPf00qvgRg+fQpIJlJg2xyFVkXEAODPA1Vck4F5ZN0qvY3YXKCwQxnqSYd+
	8GuM36SO4VVpLxNqB2D3hgBvbGvNi5i2pfF2lMdo8UObuoZ7uBertxReEk7dhTu7
	wZOhAhCCw6wNv4H6ct9J7475v6kZZ07wsiNBTLyViMdDjBb1om3NU6MVrevpdJxY
	HY0IT98gSrTEYM/wG7ojVnAuuGCiD3vBl3TnEZpdUedjKuGF14W3DWZBhxc6gFHE
	60ScgA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0udmexs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:19:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82a2bd628d4so9105445b3a.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773645544; x=1774250344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XNQwagjQvS1eX8YPd1QfF/D3gxhUMNjfLGG0HuA04A=;
        b=hScF2Ru6z5B9/Lvgs75NImvnG8fAwrPYa0oNfVKLbgNqP0q+NSIKk6ngCfKQ6X+0OV
         RiDAGneBi7RtZNGLWZ8oabqMkSU2o+TnPsxm07XZ4JyqmsNmuLzp5nMhJmT42qSD1sSz
         k6xiwR6g9WJClhB7obqHLODhRc2kdIzm3gJXgYn1zwcQpJ70Sd12qsj7MQFuL7S6mo/A
         FKS/uCSDh8lASSKW45TwSTkQaGV0sikzrYLZxmPAnalTJCtyBIl/Bo/zJ8Qe7AvyH17W
         sm8nPI6AE0XzGBFmQEhtq7swECGZlqHzr1QEmmRZ9IYKres5k7G/zf3ojtqUbXAsKxmu
         6cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773645544; x=1774250344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XNQwagjQvS1eX8YPd1QfF/D3gxhUMNjfLGG0HuA04A=;
        b=fbDDHgEMIKq90oXJTwztp0A6oHeb7xFy0UZhL9yao2N9+SIufTYh8y+bCycLuwH9CP
         thioo1p3A8yWEmqAvHhPVvyU3AwBB1iiEwF2MBdUBN3ShF0+j27iLhVd9kPpkyVZZzBC
         zC8DsP6k7WoEUs67JpWpQtuVpSdIT+KFYJ2nwntmf0T0Zvy589FYyWXST5PG5xpVZNhD
         flByeA1NGcD7TuV4fI1a9Ag3GY8MnexeUT7OrqtTQgBgCI4+klgL9xjyPTTlWdEoUA/u
         BEYI4thrpfqfirpwsoNPMZvAqQQCmXGLmQ6zpNecnHdiM+og0CsgDqAcQWmAE7r4cUyY
         q9oA==
X-Forwarded-Encrypted: i=1; AJvYcCWKcZCcyeL9vnLBNIOOfUP7kJJXIPSYUtLfnmcJD+NvswnlQ1R8sXizV2nNxD7R9X3XJ0IimKCD+6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPB/2du3pO2uBCB5vm0O5w0ITt170YmHIbTh61ew1WTjXor7XT
	gfEqQBX78lMYOZrC/F9/TEch1+5N2I4cTGuF/QLdJyip054IH4X+B8mM/KxPRr2lGQ6yJH4kimL
	jyRH4iDh1np8R28PneMgt3rPSCPJio7KUYWsMY6gQdIXWXHSb70QGUeLyO2Pr4MM=
X-Gm-Gg: ATEYQzyiz74+XMlhBzJOsSwj900DyYLIcrUL41kzZsjmU3b7Yc8gCU3/w9SHYEuzTRN
	7ZWKlvKjk2pDBU2I1RTnkNwV+vdW/4cHriqPvCZUH62hyvOP+o7Gl6GorOL8vrUZpiFdm38DNSw
	V8Q8med+wlMTfclk1lF+oUcOQ2S1+ECPRD35X+QZs1QtuO8QmEW6sAO0IiZqnuzcUZRKASOA1gX
	UPjSF+nv895VYziYEK0TzxJMuSByZ89u1uY5EcPx9B2Zot1Aj4zEK7bL5yTHOi/1GW+wNMLONz1
	8fRNz60lU1Jj1XhB2vlbs3QmboS/UziUjxmYSObxuK2+MNIQKFKE1IDyblxthqWrQFXBtkllyrT
	rdJ2YDJRRMQxHq5rSDWusqT14JXgLtNWIffSZAr/pTJZPhi337E113cOGVvjMbN5RNw==
X-Received: by 2002:a05:6a00:2989:b0:82a:ea3:c174 with SMTP id d2e1a72fcca58-82a1993b643mr10389515b3a.56.1773645544028;
        Mon, 16 Mar 2026 00:19:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:2989:b0:82a:ea3:c174 with SMTP id d2e1a72fcca58-82a1993b643mr10389496b3a.56.1773645543599;
        Mon, 16 Mar 2026 00:19:03 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727e581sm11875787b3a.27.2026.03.16.00.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 00:19:03 -0700 (PDT)
Message-ID: <309abcd9-3baa-4fa5-830e-c9d36b6890c3@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:48:56 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: pinctrl: qcom: add IPQ5210 pinctrl
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-3-fe857d68d698@oss.qualcomm.com>
 <20260313-primitive-talented-boobook-d7a7e7@quoll>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260313-primitive-talented-boobook-d7a7e7@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BJ2+bVQG c=1 sm=1 tr=0 ts=69b7aee8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=4YdXfc-GfyRXmrUFxqYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: rRM1KPHD2a6SXao3Ug7K5O3xdB4qKDuR
X-Proofpoint-ORIG-GUID: rRM1KPHD2a6SXao3Ug7K5O3xdB4qKDuR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA1NCBTYWx0ZWRfXxwA2msfvLBNX
 lwpRx3ElKi7L4/0KGDg8sPAQ6Kyyl2AeSJMU3UXQiYIi+VqBhp7VFpIsw5QBV101JvcPLFh6Ub1
 uFXpFjW9Wn6YhtsXNOxs//uB0mNBkZfYnLnvTLpSAYCZdrUxgvccF1p/l7DUDIV2AAJzSPoqKeg
 IyqDjvkYO7jQnFd8f33b8ygDcTHx69QqN/CDJKF2f6y1/G5IWuTTT/wkpsCUbQg76e1s7hOm85U
 TVwepVrnly/29iHg+m+PJgo+ehx35VDnwfIFSUP0c/WEnLl7JaV9p+g2HFfTTXOjEX9g6/v91uS
 f63CwWqByp3ySghBsNOSfgYsgTaCjOM2WjK6xnOngmwA7W2JWo0fsck7ZEqjWBM2RzRV7jLGrP6
 qO5bmEll5cELIAWRlbzAP2iF/QpJzUElqhOuhRSpQcFS43t47302D6Y3pCmJFDkDcKTOSFGZQCS
 frCXypxTzb1oagFU3QA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160054


On 3/13/2026 6:54 PM, Krzysztof Kozlowski wrote:
> On Wed, Mar 11, 2026 at 03:15:45PM +0530, Kathiravan Thirumoorthy wrote:
>> Add device tree bindings for IPQ5210 TLMM block.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   .../bindings/pinctrl/qcom,ipq5210-tlmm.yaml        | 141 +++++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5210-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5210-tlmm.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..3e5a46638385cf7925963c7e4b615c67e642152c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5210-tlmm.yaml
>> @@ -0,0 +1,141 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5210-tlmm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm IPQ5210 TLMM pin controller
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> +
>> +description: |
> Drop |

Ack.

>
> Please do not combine completely independent series, targetting
> different subsystems, into one patchset. It does not bring benefits but
> only make everything trickier for maintainers which need to figure out
> dependencies and cherry pick instead of applying entire series.
>
> We raised this multiple times and it IS documented in your guideline, so
> READ the internal docs.

Ack.

>
>> +  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5210 SoC.
>> +
>> +allOf:
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>> +
> ...
>
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    tlmm: pinctrl@1000000 {
>> +        compatible = "qcom,ipq5210-tlmm";
>> +        reg = <0x01000000 0x300000>;
>> +        gpio-controller;
>> +        #gpio-cells = <0x2>;
>> +        gpio-ranges = <&tlmm 0 0 54>;
>> +        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <0x2>;
>> +
>> +        qup-uart1-default-state {
>> +            tx-pins {
>> +                pins = "gpio39";
>> +                function = "qup_se1_l2";
>> +                drive-strength = <6>;
>> +                bias-pull-down;
>> +            };
>> +
>> +            rx-pins {
>> +                pins = "gpio38";
>> +                function = "qup_se1_l3";
>> +                drive-strength = <6>;
>> +                bias-pull-down;
>> +            };
>> +        };
>> +
> Drop blank line
Ack.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks!

>
> Best regards,
> Krzysztof
>
