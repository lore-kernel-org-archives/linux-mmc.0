Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48663AA505
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561446; cv=none; b=spw0Kx9lasKEqoA2H3z8d+RZZwEvnrA3TdbC4UB6JUc346xAawKYoG2vxlLb6a1fAu+v3JPj5MzkoL9ZoDBxkMN085vLA4DfCYyj4Hkrqe+g/Yw8NSoqonW4ARIWqdAcdkINgKDaWGw9Wrq+XHLIxlVzzZfrpfTqPHSF2NaBpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561446; c=relaxed/simple;
	bh=oUkh+IkvU0WloeDURJkNPgpaFOn0CnOUeYrz6WDf9Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9Tnh550kV0bV4hQaHPBpoVB12tiiRBnCavBBqKHlm27Iy//TK+FNmRJv/RkD+3LEbsJCscMd3B7GshJkpFl0St1iXKUGygrC7aa7awBQ1SyonarTLJoO+1AFlCrVxV/RxJ0cKLmcr3kgguagnbzEIMvbg2sGQTzSh46dRDNJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NcVdXS6F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dx23SQ65; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NcVdXS6F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dx23SQ65"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63763Wa92328036
	for <linux-mmc@vger.kernel.org>; Tue, 7 Apr 2026 11:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7fcm0e72F0fNBOECP4Q8mKvjufYSxuPXJ5ZSKjJwUJg=; b=NcVdXS6FexfcDVTH
	87YPJDzxi+sLWYSrbrEA+ynRopSu+2xXUac/Sx/B1doA5LqlbZMNbXbfoa8/NwSc
	uXrEx8QzEadAuGVTd4KiCwDDOXsdzwtMGDkJUA/J0tUENu+iulSn1Yn5sPpuw8ah
	sc7gDFcC0rrzUsrP+Z7afu1vF5FFJ7nqdqAOyVVxKml1oGs7fYmUFJoIyGgySaMu
	h4JeyQpnnQPWiGVr3PZYgLUgSiwAj9oM1fgpQHrN86usQQjhJdKU/UeFaUHuNHLg
	WFz5emw0GctHH9rjCzCZOD5mp8S7heVF3/Rce0GaUptHwZKY64pjKWj8k3plFsM1
	4BKMhQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcms4tfn3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 11:30:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5aa81907so30093751cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775561443; x=1776166243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7fcm0e72F0fNBOECP4Q8mKvjufYSxuPXJ5ZSKjJwUJg=;
        b=dx23SQ65XeiF5ZUgCJjMZAxQ3zWpEc05IqC5IFhX3BDlQ/xJ5XRIOLXNNuZ+i/e9hd
         FJrOQxROwcue0HtFbmO2lhgtip2ft3sMG4XPYdGnD5ljSAYw2thrNx6R5MC98r2N2qHI
         2I0mov1Bu+Y7q15qS0tB32R3M/QwytEB8tSYTQXlBoLPgRy9+vuIhjYI26s/b48b5uz1
         XgOPODZWRG3X/EvvIO2xpBukCHL2jpDaZxvVGxkTtwYfnWw+Bjziwnj88tBbi5w4k/oF
         yfwWlu8b850odODbe9A8v9ajIy4fzAS4Hx34y+/r0iGvRlMyodR7d509RcwMrfc3gy00
         cwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561443; x=1776166243;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fcm0e72F0fNBOECP4Q8mKvjufYSxuPXJ5ZSKjJwUJg=;
        b=p+UjRMYSiZkSBhwQ19/NCvH02wxAFoc4ir4EV2Eidcz+n6GvP7n7J7uWrqO0w+4Ph2
         3pp7GPCOVXJSYmYaScfDpuDee6seOQEs1DyWUvKTG2qCm1PqFgibSblozjxvz29nk6Gk
         tW+MFo8pRYghN30S2XWEe0egCKqECOpR+b8GRWWwaQ/CmTKmf7/78vlXteRJDAbMVsvC
         hrptN3IC4imFhax3URhY/9YdEpMxR+ba9pkR1YB+hZIpBJ+UDSWP+JRur6SVAZNP+2uB
         YTuj3LDZq2lbT8NP8fDAbK7VMlCJ9nTPGQqTCUoiAEUSoCoRnXVImBm/NiGfR2x5ACLH
         FXaQ==
X-Gm-Message-State: AOJu0YwPD0Qg/8aXzmeAKJICIn5/ImGx0ZgBGqdsQ5WCwfHs5YhUpai6
	MuZ/M5PLpOg8blFLFywbw9gLylMqxCbks+DJT5QsHnWLbBEdlATtJ9TUADCQtta8vCjcZEwv/n0
	1e1QcyVG1JMkgWd0oEaC9ta64crUi1Hq60X7m1MNpSvZuvXLc/t5mmlDKNV/4681FvyQq/A4=
X-Gm-Gg: AeBDiet8IgufZ9n1NOwBR9JpuG7e3CtfGby+HoabnPnoW5cOneihbqABUUa6p97I0NX
	BGSWhe3hZPZitjd7Kyr8SLRBk81VTGH4bYt0BaSTURRD8q5sBYJCreei88pCJDU4/dshD2excun
	fxPQZv/xoo7qNY+oNWBJPddzKCxt7HOdFzZOfZn6mtaTOGtXIIHBtShdnjR7tlRWZ+VOsNdbvSa
	nNGwhY94YaUCsFzzrEimD2EzIor6Z0TP3QtCnUA3M4Ik0GdUWUz6Iu0RVH0wtfq50we5tTzK7F3
	KDVFzsZs5e3QLewppSprghZV1lt6GeFKQ/JUcA+qbiidJdb/S67nqOibF3Ir85IdkZLdD01tugx
	kChSm5VYBqHJIvp62wR7pGhCHrxVn8nZ0nEhoptExJJXyuFyP
X-Received: by 2002:a05:622a:412:b0:50d:8b5a:1317 with SMTP id d75a77b69052e-50d8b5a1860mr121380281cf.13.1775561442628;
        Tue, 07 Apr 2026 04:30:42 -0700 (PDT)
X-Received: by 2002:a05:622a:412:b0:50d:8b5a:1317 with SMTP id d75a77b69052e-50d8b5a1860mr121379271cf.13.1775561441938;
        Tue, 07 Apr 2026 04:30:41 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488940e075esm433790835e9.9.2026.04.07.04.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:30:40 -0700 (PDT)
Message-ID: <f0234c44-401e-4c43-a753-e4efffd22fc5@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:30:38 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: cqe: Add CQE DT support for cadence controller
To: rohan1sj@cadence.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Milind Parab <mparab@cadence.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Manikandan Pillai <mpillai@cadence.com>
References: <20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com>
 <20260407-cdns_sdhci_cqe-support-v1-1-13efc0810631@cadence.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260407-cdns_sdhci_cqe-support-v1-1-13efc0810631@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwOCBTYWx0ZWRfX/yz1bCgipH0T
 Mejd5LZ1S181CR1WwzABnyqdedkTMRUKDr2QNKhZ8cHdoiByVsI/P0QXwuQT0CPv2EnJTDKqvxD
 +J00Dcw6c1MAJGfC3D9YmYawh+d0Mo/UiCxdTc1YvQ0u9QrmeC1Is4OicRagxuuHH14yBmbeeSt
 zMlb8pvftBCYqKUqs54nm4eDBPOfJ1HDJDzdKE++8W13tGK3zK3CfnV5oTFLdD7NGD2ndYVq6U9
 8r/Wp2cyVfSDe+aLuxE+O9Vrb164bOK4U2hhV15LKkgRUTZM9COFktqdCXcVRT0ndMN14YQnG5t
 H+TDjrGoux/ZlC3M7QLSlZlmY+Z3YF2YMrUUblpXv3V2dJtL67XdUzt81mEIx5FuCPJ/S8H4Csu
 a8pjP6gr7GQ3wfgYG8GGWdwaZAHoF2qnSOtuDfurmQAe0QSpogyBB2sc4sRQnQP1ihX7bob09QW
 o/cshfy5F3+t771BaMA==
X-Proofpoint-ORIG-GUID: oy84u36rTBlH5WVihs-hJK3j26pSBWmj
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=69d4eae4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=ezp-VJT6kXTpWd2-OGcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: oy84u36rTBlH5WVihs-hJK3j26pSBWmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070108

On 07/04/2026 13:18, rohan1sj via B4 Relay wrote:
> From: rohan1sj <rohan1sj@cadence.com>
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


> Add DT config required to support CQE as present in
> cadence eMMC host controller

What is DT config?

Which devices? Say something useful here.

> 
> Signed-off-by: rohan1sj <rohan1sj@cadence.com>

Please use known identity.

> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 32 +++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index ac75d694611a..c0d8aefe20c2 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -24,6 +24,10 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2

List would have to be here.

> +
>    interrupts:
>      maxItems: 1
>  
> @@ -139,7 +143,19 @@ allOf:
>      else:
>        properties:
>          reg:
> -          maxItems: 1
> +          oneOf:
> +            - items:
> +                - description: Host controller registers
> +            - items:
> +                - description: Host controller registers
> +                - description: CQE (Command Queue Engine) registers

So just one list with minItems

> +        reg-names:
> +          oneOf:
> +            - items:
> +                - const: sdhci
> +            - items:
> +                - const: sdhci

core

> +                - const: cqhci

cqe

Anyway, reg-names here are pointless. They should be in top-level.

You also need to disallow the reg-names for Pensando, because it has
completely different.

>  
>  unevaluatedProperties: false
>  
> @@ -156,3 +172,17 @@ examples:
>          mmc-hs400-1_8v;
>          cdns,phy-dll-delay-sdclk = <0>;
>      };
> +
> +  - |
> +    emmc_cqe: mmc@5b000000 {
> +        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> +        reg = <0x5b000000 0x400>, <0x5b000400 0x060>;

No need for new example. Just correct existing one.

Best regards,
Krzysztof

