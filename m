Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894718EB0;
	Thu,  5 Mar 2026 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712735; cv=none; b=RAjsWLP1p0xjpf/MEsNj0qLoYhZ2XfL5t0kI0I4m+RqmSZvD2gp5YCmW6IZFN0XVVjnqSDZ5VIguIkZilP2u/gaO7jHpEKE5wGj//9Mz0NuAfpcFw5dlw5aH42hM683JPYiNhgCSxXkDQHWxyOhLTJWSxngY85ZlLdmv5LnzkcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712735; c=relaxed/simple;
	bh=MCIaZ62bOxHolmAR8XP3vkklc/zstKu8tjoJCXqNuGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaOFAURGL72DhXR5c4cJcB9Wb7mr3ZK1i7O/HQXqxzkmio+O84xjhJNWZrTjKKuHHifVZg8B/u7jaeA2Ik86WQWGJnoET7gTgboFHsPiLS5jK8ZLWTyB7TwZFw7/TSexMS+5r2Vd73EU3cSw4w0opAr2A69ZNMpnpoQze4fke6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krr8AXPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krr8AXPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33495C19423;
	Thu,  5 Mar 2026 12:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772712735;
	bh=MCIaZ62bOxHolmAR8XP3vkklc/zstKu8tjoJCXqNuGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=krr8AXPv9EVFxKVuYzzaj+gFjszMnyzzhthPzcNtExMy1IZ+aXOgvOcSip0XqWAU7
	 jliEKzjN5YcjuD4dq4puMktzuY/FrgtmH7JV16vmP4xaZ+MDPgiMP2dnJcXcUxy4Dt
	 x+L5lgqvzrLS/ZLns0umdwdOfi9vbHI02gQ/QuBWyhCjETc4G6obGTAab05neEIqVW
	 8EI9ss1pwBvUxq7qDV10jxaDkksWxYjNOCfY+QWH87Q4xgS/Q3W49vp6J92zoMumTc
	 ciH0ym82ZeqVEYYAeIsyGkJVZyF9dSpqowma16s1ve4fFIbJvkzZAZDToBO9hYDIw7
	 uNPoxiz953bIQ==
Message-ID: <6a481490-28dc-4b62-9782-95a32d0e2857@kernel.org>
Date: Thu, 5 Mar 2026 13:12:08 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: interrupt-controller: fsl,irqsteer:
 add S32N79 support
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Larisa Grigore <larisa.grigore@nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
 <20260225133858.8026-2-ciprianmarian.costea@oss.nxp.com>
 <20260226-ingenious-shiny-axolotl-e0e6d2@quoll>
 <e8e258fb-23c0-44d1-bf4d-e2fed92ad90d@oss.nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <e8e258fb-23c0-44d1-bf4d-e2fed92ad90d@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2026 13:02, Ciprian Marian Costea wrote:
> On 2/26/2026 9:31 AM, Krzysztof Kozlowski wrote:
>> On Wed, Feb 25, 2026 at 02:38:52PM +0100, Ciprian Costea wrote:
>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>
>>> Add compatible string for the interrupt steering controller used in NXP
>>> S32N79 SoC.
>>>
>>> The S32N79 SoC differs from the i.MX version by not implementing the
>>> CHANCTRL register, but otherwise maintains the same programming model and
>>> register layout.
>>>
>>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>> ---
>>>   .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>> index 5c768c1e159c..caf3e4a1f26f 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>> @@ -22,6 +22,7 @@ properties:
>>>                 - fsl,imx94-irqsteer
>>>                 - fsl,imx95-irqsteer
>>>             - const: fsl,imx-irqsteer
>>> +      - const: nxp,s32n79-irqsteer
>>
>> So that should be part of enum with the first entry.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hello Krzysztof,
> 
> Thanks for your review. Regarding this change, I was thinking since 
> S32N79 irqsteer does not implement the 'CHANCTRL' register, it should 
> not fallback to 'fsl,imx-irqsteer'. If the driver were to match on the 
> fallback compatible, it would attempt to write to the non-existent 
> CHANCTRL register.
> 
> Am I wrong?

No clue, I did not say anything about fallbacks.

Best regards,
Krzysztof
