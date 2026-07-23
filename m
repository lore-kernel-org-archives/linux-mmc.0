Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332333CA4B9;
	Thu, 23 Jul 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833291; cv=none; b=H8OET9ByWH50U7KZW9AIl/txPXMG0YWBQiI0elDz8/ubRjBvUjPMZPd+1Wuc71iT5wudU7gwAVmfLLpHGURzuyiglIf4HEP2CgldW8oSNYANhpFFiCd63Bt1vpU5cCrwfi5jxiSGHclX58y0YEsnt8Z8wnbisVOqczAqfchxSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833291; c=relaxed/simple;
	bh=EZk2OxD+gEZHGoushqS4qlXklQu9SaQr4xg9e277/AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxTv2LY7615M9JKWR5MDnM+BDv+pMnLX54ks6jE+iLYE1iKBx9Qweb7KUvJoAHE/BbbOt1WKAW8GEwBoEn79qbLLXTuxy8jGOHQfOGAC6cmmNuvcXgdxQgKl4PEvN+nyika+F4SA2wysjqjc/DTdvk5wilreSNIhKqDdLzKFa2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4ibDkz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4ibDkz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6C81F000E9;
	Thu, 23 Jul 2026 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784833285;
	bh=/iOx7Kdb7RsiadRvbAxhLdFG7t3D5msEa1q1juGjNWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C4ibDkz9AkXQAVdjpp+M76TU/m9gT6JzHtD496S9GljsgnnrGkCnHqs5GB/Id/OOc
	 eBsMX4rgoeWi8lPJNLYbztDlHrjkTYlzkBHg9eLpbf6kz19YlGavfSc7vBswWowLcx
	 evoKL8z6p9vjoSky8liSKLTmYRj1omyHBts1UZUF2i2nkuxPNGcSwJ9+dgiwB90atW
	 MYlLTg1zUu67Fz2rCjx/K8RrJypbJGwNCx0QQdPCnKrzpUL8IqSZVNyo8wUdr6qhcH
	 vNoXLVeGK/8uu4oI2aCkjj8LXmm1wtr587HKJiGJlpcgLefidHY/R5B6A9P0z9j+Ij
	 l6nBn+yrWltPg==
Message-ID: <1a9d18ce-e6dc-40e0-aa2a-e27f694e1217@kernel.org>
Date: Thu, 23 Jul 2026 21:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Document no-mmc-poweroff-suspend
 property
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Avri Altman <avri.altman@sandisk.com>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Erick Shepherd <erick.shepherd@ni.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260722211417.3702709-1-kamal.dasu@broadcom.com>
 <20260722211417.3702709-2-kamal.dasu@broadcom.com>
 <20260723-venerable-infallible-oriole-434b75@quoll>
 <CAKekbevxiN=8q60sHkRLKzEwc75PYHO7nJtMEahLF+u39g-FBw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAKekbevxiN=8q60sHkRLKzEwc75PYHO7nJtMEahLF+u39g-FBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/07/2026 20:53, Kamal Dasu wrote:
> On Thu, Jul 23, 2026 at 3:51 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On Wed, Jul 22, 2026 at 05:14:16PM -0400, Kamal Dasu wrote:
>>> On some platforms, firmware accesses the (e)MMC card directly during
>>> system resume from Suspend-to-DRAM, before the kernel's own resume
>>> path has run, in order to load boot code using hard wired logic that
>>> is not field updatable. This requires the card to remain powered
>>> and responsive throughout suspend: it cannot be put to sleep, sent a
>>> power-off notification, or have its supply removed.
>>>
>>> Add a no-mmc-poweroff-suspend flag property so affected boards can
>>> tell the mmc core to keep the card powered across suspend instead of
>>> sleeping or powering it off.
>>>
>>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>>> ---
>>> Changes in v3:
>>>   - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.
>>>
>>> Changes in v2:
>>>   - New patch, replacing v1's card-level quirk, per Ulf.
>>>
>>>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> index 3d7195e9461c..5f7b3f8ef1dd 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> @@ -232,6 +232,16 @@ properties:
>>>      description:
>>>        All eMMC HS400 modes are not supported.
>>>
>>> +  no-mmc-poweroff-suspend:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description:
>>> +      On this platform, firmware accesses the attached (e)MMC card
>>> +      directly during system resume, before the kernel's own resume
>>> +      path runs. The card must therefore stay powered throughout
>>> +      suspend, and the controller must not send it a sleep or
>>> +      power-off notification. The kernel re-initializes the card
>>> +      after resume, since firmware may have already reset it.
>>
>> Isn't this exactly the same as keep-power-in-suspend?
>>
>>
> Not quite, though I see why it reads that way from the description
> alone.
> 
> keep-power-in-suspend only takes effect through host->pm_flags, which
> gets set at runtime via sdio_set_host_pm_flags() -- an SDIO function
> driver opts in from its own suspend() callback, per suspend cycle.
> The consuming logic lives entirely in mmc_sdio_suspend()/
> mmc_sdio_resume() (drivers/mmc/core/sdio.c); pm_flags is never read
> in mmc.c, which is what this series touches.
> 
> no-mmc-poweroff-suspend differs in two ways:
> 
>   - It's a fixed platform characteristic, not a per-driver runtime
>     request. There's no SDIO-style function driver to call an opt-in
>     API from for a plain (e)MMC storage card -- the requirement here
>     (firmware always touches the card at resume, on this board) is
>     always true, not something decided per suspend cycle.
>   - The resume-side behavior differs. keep-power-in-suspend without a
>     wake IRQ does nothing at resume: it assumes the card's state
>     survived untouched. This flag needs the opposite -- keep power,
>     but still fully re-initialize the card via mmc_init_card(), since
>     firmware may have reconfigured it while the kernel was suspended.

All this is just driver stuff which I did not ask about.

The property is described pretty the same - do not power off during
suspend/resume.



Best regards,
Krzysztof
