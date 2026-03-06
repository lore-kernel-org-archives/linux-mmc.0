Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B657266B72;
	Fri,  6 Mar 2026 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786713; cv=none; b=GbMOVjHD1tcbw/GSa3Ne2fxNYH8jwz060j1d6b5qLFjfTr+F/Manjr/AM98ESXhxGIB7YvBTiBk0ktX+Q1kZ7Aeg+6nSiGY5BVTraPTAkPdf2CBAH8MgNsxKUDqFfiYMVjy2SCuSIACvigNBDIf4CJM7MQbewm5uMpM9ZHeHN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786713; c=relaxed/simple;
	bh=xDpS7E9mTWjhtIwUYMgTXCTt+wHEc1BFGf+VVsdD1lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLdwdAmHa6TzTWdxAP2ihru6E+CkKeqDPVYhJezk8oAvxM2JV/wuW0b2wDRT0o98g2mv2M7as9L0/d6uRdjitjRPD6DhlSHHIZBtdl39b28AmV2kNoVd1Xu/Nt9lCEnN6arfWMnNpy6tCNr8j/KyWyMxc26KT8vPgOx3YbhN5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJdame2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJdame2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A931C4CEF7;
	Fri,  6 Mar 2026 08:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772786713;
	bh=xDpS7E9mTWjhtIwUYMgTXCTt+wHEc1BFGf+VVsdD1lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJdame2/emJrCIivulXkdE3s+/btMsDNwil+GEaLS2cmx+2r7OiBel0Gj90oU5cB+
	 6xDw/2eQLN23jsHPK7fAlz+f0y57K7a/D5jXI/NC7z+T6XXcocILfT1Ts3tBD+ZJko
	 ijowZzmOH0J/KTi0mhp7R0IoYVJuRYKfHYQagnMrtnAmEEDuqlnZLwNjNSzee1+ngo
	 3Fe0V0dBMskdTJH3QrCC7h0u7/410SAfpfGGb8gc05r0NfCEVl6P3zZEUZGCFQ1Knl
	 RsL2PpPGpPUq0obgrUca5a/OiQiYS+E2Erxr0FwJSP/wxAtobVS3KafB+H7IrEKVXr
	 w2woqcojCaFTw==
Date: Fri, 6 Mar 2026 09:45:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Lee Yongjun <jun85566@gmail.com>, ulf.hansson@linaro.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: allow dma-coherent
 property
Message-ID: <20260306-tactful-asparagus-cat-b77853@quoll>
References: <20260305234703.38490-1-jun85566@gmail.com>
 <CAJ8Y1dTJ5yNPP8BN46BfDdLAvuWxW+OrZ+P538Bp9+3_6XankA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJ8Y1dTJ5yNPP8BN46BfDdLAvuWxW+OrZ+P538Bp9+3_6XankA@mail.gmail.com>

On Thu, Mar 05, 2026 at 04:03:48PM -0800, Ray Jui wrote:
> On Thu, Mar 5, 2026 at 3:47=E2=80=AFPM Lee Yongjun <jun85566@gmail.com> w=
rote:
>=20
> > The Broadcom iProc SDHCI controller supports DMA, but its binding
> > schema does not allow the 'dma-coherent' property.
> >
> > As a result, dtbs_check reports the following validation errors
> > on the Northstar2 SoC:
> >
> >   mmc@66420000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
> >   are not allowed ('dma-coherent' was unexpected)
> >   mmc@66430000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
> >   are not allowed ('dma-coherent' was unexpected)
> >
> > Allow the 'dma-coherent' property in the schema to fix the validation
> > errors and accurately reflect the hardware capability.
> >
> > Signed-off-by: Lee Yongjun <jun85566@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > index 2f63f2cdeb71..579e44843404 100644
> > --- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > @@ -38,6 +38,8 @@ properties:
> >      type: boolean
> >      description: Specifies that controller should use auto CMD12
> >
> > +  dma-coherent: true
> > +
> >
>=20
> Yeah for Broadcom iProc SDHCI on ARM64 platforms (including NS2), cache
> coherent DMA is supported (as opposed to other 32-bit based ARM platforms=
).
>=20
> Change looks good to me. Thanks!

Just open the file before giving blanket reviews or how are you exactly
reviewing without knowing what is there? This was already fixed and
this patch is obviously wrong.

Best regards,
Krzysztof

