Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E4265604;
	Tue, 11 Feb 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304752; cv=none; b=KSpL1GrOxs802uILj1VVLPyn0A9DR8nfsGyaQbZI7LroO0PcN3zyEM1Gt/rxSWgo/22/LpEz105DUkL5262q/HvZTihniPF+1fXBmSDCx90B1ebemO4FcUuIkYe5GvGcweQYQ09/Umpc3mZ5tCAqdw93lFo4AYtI1dAt+9tgrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304752; c=relaxed/simple;
	bh=v/Jok9KiEPoYdLkGoT5WJHe5oUzwY5NHLVXVVA+iJRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfMhjuEV2GVOJhTsw8kJ43C5F9kzLzrXBrtroxPojWBpv7CJxfukOLR66qX5H/imvKEdjN5lvOd4c5Gam7o6EEAnqFMzXPT24XW3UQSZyC1sEmUkjqWbLNC7RjZwlAqhV2LB2o+4ZhQmDPMuh2NAYHzyRYURc/6sh8Li5m2c3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgY9IZVp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgY9IZVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105B3C4CEDD;
	Tue, 11 Feb 2025 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739304752;
	bh=v/Jok9KiEPoYdLkGoT5WJHe5oUzwY5NHLVXVVA+iJRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgY9IZVp67cVbFI4jfVr7xHVisU4vQHZuG1uZWlCrEFpbmg/2dNn4b/SuQvmUd0eq
	 CVT/QkfAtdvp0+v1yC0NXDVvzmV4xeu1X1dDyeOxYM13irap3UlVed8o3FtqY43MUV
	 /yoASTYArEkmeTqV/2DOvzzVgE1ytQqwU8toQtqau5UpYjKg1ZsC7npOemFAo2CXP+
	 bHKrvp8r80hHPa+g8Hd6z41qLUigcsUjraZ6ZBD6qBRWZkSWrx3f8TyqEF2bQYdNSQ
	 ySnRzKmC3aBxnzOtNbZMA9AeGIj9pMbZR9kqDyfnwWWYfr+78qRfb/Vs7lfYelK/Y7
	 k1zOIv5I20AsQ==
Date: Tue, 11 Feb 2025 14:12:30 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma.B@microchip.com
Cc: neil.armstrong@linaro.org, ulf.hansson@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Message-ID: <20250211201230.GA600687-robh@kernel.org>
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
 <f6d7ffa0-6c08-45fb-9153-5e4aad1ca86a@linaro.org>
 <003ffa44-c88a-4234-a54a-50cd1140982a@microchip.com>
 <7180babd-302a-4f86-8770-bdd9f5c773cf@linaro.org>
 <7de20917-3176-4e80-8ccd-9c01c037cc9a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7de20917-3176-4e80-8ccd-9c01c037cc9a@microchip.com>

On Mon, Feb 10, 2025 at 05:28:27AM +0000, Dharma.B@microchip.com wrote:
> On 07/02/25 2:47 pm, neil.armstrong@linaro.org wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know 
> > the content is safe
> > 
> > On 07/02/2025 10:02, Dharma.B@microchip.com wrote:
> >> On 07/02/25 2:25 pm, Neil Armstrong wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >>> the content is safe
> >>>
> >>> On 05/02/2025 04:48, Dharma Balasubiramani wrote:
> >>>> Remove the compatible property from the list of required properties and
> >>>> mark it as optional.

The diff tells us that. Please say why 'compatible' being required is a 
problem and needs to not be required.

> >>>>
> >>>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Instead of moving the compatible string to the other binding, just
> >>>> make it
> >>>>     optional (remove from required list).
> >>>> - Link to v1: https://lore.kernel.org/r/20241219-mmc-slot-v1-1-
> >>>> dfc747a3d3fb@microchip.com
> >>>> ---
> >>>>    Documentation/devicetree/bindings/mmc/mmc-slot.yaml | 1 -
> >>>>    1 file changed, 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/
> >>>> Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> >>>> index 1f0667828063..ca3d0114bfc6 100644
> >>>> --- a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> >>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> >>>> @@ -29,7 +29,6 @@ properties:
> >>>>        maxItems: 1
> >>>>
> >>>>    required:
> >>>> -  - compatible
> >>>>      - reg
> >>>
> >>> If you remove it from here then it's still required in Documentation/
> >>> devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> >>> so please add it.
> >>
> >> If moving the compatible to its specific binding isn't appropriate (as
> >> per Conor),
> >> and if removing it from the required list here doesn’t seem reasonable
> >> to you,
> >> then adding an unnecessary compatible string in our DTS files doesn’t
> >> make sense to me.
> >>
> >> What could be the solution then?
> > 
> > The solution is right but you modify the meson-mx-sdio bindings, so
> > simply add compatible in a required list for the slot node.
> 
> Okay, we declare compatible as optional in the generic mmc-slot binding 
> but make it required in the meson-mx-sdio binding, which inherits from it.
> 
> So why not define the property directly in the meson-mx-sdio binding 
> instead?

Because mmc-slot.yaml is designed to be complete (hence 
"unevaluatedProperties: false"). There's at least 2 bindings which use 
it (with "mmc-slot" compatible). Leaving it at least prevents folks from 
coming up with their own random compatible strings for mmc-slot.

Rob
