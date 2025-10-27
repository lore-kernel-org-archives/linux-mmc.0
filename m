Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C32566DD
	for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574325; cv=none; b=SbC0+Z1g3E3j0dRGZ+IGcJ0CnAhr+QmCwPEX09khN13T/9QUf3U8V9r6cweWxRZ2amMnXaxHUDLQaMcbBg6ZnRfNEuizGop4xkO3NhPJMKPArhfvJtu18mw0iR8eiI3pqtjwOi39pnda08DUOw76X6ZLpEc+1wIBKaYZwqllvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574325; c=relaxed/simple;
	bh=s5fi0aix74dhXeUfiX707igJJq83gWDg5mUZws693ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyEiTCLmWaEUOrh+dasNHYVNP1cU9wbe8XE6vX2fwfI+Sfo4QfeALObxYUykuXCGVTaQzV2/H7HcmkV8q+lXT/6bP1lr+J8Vka3uZRm77E62Jhq5CeaeBlUU8Vm2H+CwSC3xHyZXEJDvJtlCq6cpHVBXuFC6l6MbczN8K9L2m9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcQXI3Tf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcQXI3Tf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso3545133a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574323; x=1762179123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bIMvual/DCfbHFKLhMc6KNvRa8c9RJirQTWe6ek/vw=;
        b=CcQXI3Tfgt7ipYZ+0nPYI9mFjQl1CH1rbS7bGXPmFt5GFvQLR+oj7SSHdSJoDIo+we
         cTccAfFNZpEOvRJYloD4+2WHfssBJawdXio/5IdWpaRGmodqn12bOjfOoKiPoIjcno/J
         Rx2sl/Je5YVZoSySe1ZwAlDm3UiCV3r9lqbAYv6Dit5E8Gf8CZcch/GiMYf6pFv7ihsH
         XJZWbtXHSOXtE4XBmtIG+ZSOGziEVFQg7pfcImntTQPd2fH2FSrKYyGuZ10oJcxtWOtJ
         F4glpfx5ps155vyZ9VV3c3uHcl+MMGn9JfM12JQCQM2CctcMuUwj5LmV3rX4rgLAFMPW
         qcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574323; x=1762179123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bIMvual/DCfbHFKLhMc6KNvRa8c9RJirQTWe6ek/vw=;
        b=MZMuESi8wPGNuFPhaVmAjTdjJCiVZf3VUjU87tX8sM1VlQDWxlo74wqBanARMT4dJU
         GR3/1dL/giWHCd/NsKlKbjXOn+wVJDc11BT3Th+PQ/SAYULaLzZK9UhJum19g3k5x860
         h5t1ORlhGFIUnTop6sB4dPoAxR9wQZNcAzIWAARfLSVwGT9axMV09FIf5+5W1ntGjFW4
         t2FWRQ1uYz/Pszi8+wOU53V2a6x9K3OxN6VHcxqURFP18+C4fX13Suzq5vpJgM8eywC3
         7Bbrrs9nii3nHMq9CRF11iEpF4IScRlODoLd6ZoEvzf2x0OKRJLP3UkeQoDivOyh6Mrr
         D5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU4/lTzPRwtgkI7gvtx3e9FhfJqsiHcnIWusUtYrbv0/ZuCPXTirmG0dPIMjD+jRXPsetEMwDtcdLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsiktVuY4pOhrNZVsUmJfFHd5uUSwVcplOaTAvabpgRInIN/t
	TLGjq2MIxpOEJckRVN6FOCTdT/bWKr7oprab5nu6wuqsFWbIalYBiAJh
X-Gm-Gg: ASbGncu819tNzOq1vpzCoAQOa+X3VjK/pdrMcY4S8fa9gPr7ETVAd24jFNfvIanHzTh
	XBPMpT52Hi7S0Oo5mpjhsRtN2YF6TY0DAxay+XcE8DEKFg4cWerKNPnfdb/hSLHq0dfXjO9vxri
	Zl19lCo+Sf/5KUs0l9/b226FxgA/dAfy/VEIjj6oUwmQSYZjtE0iGkj8xG8AVHQO7AJjexKR7bk
	4QLBHiin7b2VMpep0ShwjXmL2J2LVSTv84EOZyKuxzJyfzKANUwXJhaC55G9xe4BIt58ItYYytk
	tqZtLLmOuA7PPP4v5WbtV6Rxw4fjL4mlJZxxdZ787iwrGRibz73rijgIoR8JMcV+2CuI+7lukzH
	wrvtzAnSqlfIt6VtK27BJphCScBp3q4osXMiMe0SjX77hFu9pdDSova2BkKBoWykIYcfvq9BGrr
	8Ko7u71rpqzAfRdRd/XU2rjlJUgntHScG5
X-Google-Smtp-Source: AGHT+IH5yXGx+LupzIOPczjiiLlR5YgFAp1+QvWwv8ZLoofxPfnSc2zQ+LY35y3vpNkMMUH1Hauifg==
X-Received: by 2002:a17:90b:1dc3:b0:338:2c90:1540 with SMTP id 98e67ed59e1d1-33fd66b4230mr14770603a91.20.1761574321988;
        Mon, 27 Oct 2025 07:12:01 -0700 (PDT)
Received: from [192.168.1.5] ([27.7.191.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f604dsm8788404a91.15.2025.10.27.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:12:01 -0700 (PDT)
Message-ID: <b6486799-9e46-4b6b-bf95-001e11e958e4@gmail.com>
Date: Mon, 27 Oct 2025 19:41:56 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com>
 <20251027135752.GA316916-robh@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20251027135752.GA316916-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27-10-2025 19:27, Rob Herring wrote:
> On Thu, Oct 23, 2025 at 05:37:36PM +0000, Charan Pedumuru wrote:
>> Convert SOCIONEXT Milbeaut SDHCI controller binding to YAML format.
>> Add a new property "voltage-ranges" to resolve dt_check errors.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 ---------
>>  .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 78 ++++++++++++++++++++++
>>  2 files changed, 78 insertions(+), 30 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>> deleted file mode 100644
>> index 627ee89c125b..000000000000
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -* SOCIONEXT Milbeaut SDHCI controller
>> -
>> -This file documents differences between the core properties in mmc.txt
>> -and the properties used by the sdhci_milbeaut driver.
>> -
>> -Required properties:
>> -- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
>> -- clocks: Must contain an entry for each entry in clock-names. It is a
>> -  list of phandles and clock-specifier pairs.
>> -  See ../clocks/clock-bindings.txt for details.
>> -- clock-names: Should contain the following two entries:
>> -	"iface" - clock used for sdhci interface
>> -	"core"  - core clock for sdhci controller
>> -
>> -Optional properties:
>> -- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
>> -  requires the CMD_DAT_DELAY control to be enabled.
>> -
>> -Example:
>> -	sdhci3: mmc@1b010000 {
>> -		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
>> -		reg = <0x1b010000 0x10000>;
>> -		interrupts = <0 265 0x4>;
>> -		voltage-ranges = <3300 3300>;
>> -		bus-width = <4>;
>> -		clocks = <&clk 7>, <&ahb_clk>;
>> -		clock-names = "core", "iface";
>> -		cap-sdio-irq;
>> -		fujitsu,cmd-dat-delay-select;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
>> new file mode 100644
>> index 000000000000..6b67bef30347
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SOCIONEXT Milbeaut SDHCI controller
>> +
>> +maintainers:
>> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
>> +  - Takao Orito <orito.takao@socionext.com>
>> +
>> +description:
>> +  The SOCIONEXT Milbeaut SDHCI controller is a specialized SD Host
>> +  Controller found in some of Socionext's Milbeaut image processing SoCs.
>> +  It features a dedicated "bridge controller." This bridge controller
>> +  implements special functions like reset control, clock management for
>> +  various SDR modes (SDR12, SDR25, SDR50) and physical pin property settings.
>> +
>> +allOf:
>> +  - $ref: sdhci-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: socionext,milbeaut-m10v-sdhci-3.0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: iface
>> +
>> +  fujitsu,cmd-dat-delay-select:
>> +    description:
>> +      Its presence indicates that the controller requires a specific command
>> +      and data line delay selection mechanism for proper operation, particularly
>> +      when dealing with high-speed SD/eMMC modes.
>> +    type: boolean
>> +
>> +  voltage-ranges:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> 
> Sounds more like a uint32-array.

Okay, I will change that.

> 
>> +    description:
>> +      Two cells are required, first cell specifies minimum slot voltage (mV),
>> +      second cell specifies maximum slot voltage (mV).
>> +    maxItems: 1
> 
> You can better describe it like this:
> 
> items:
>   - description: minimum slot voltage (mV)
>   - description: maximum slot voltage (mV)

Sure.

-- 
Best Regards,
Charan.

