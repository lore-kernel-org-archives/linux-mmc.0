Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0B2989B0
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954755; cv=pass; b=ptQppA1NYHSBRc4gOvYz9fg4xHUctA6cXTeYT0yf5BTPRusvlaorn4wBa221VKxX06rYdetW06VC5x54Pzd+jiYpI9RsrJv1pB4sFmC3tULRoMJlsC6a3JC2pVNeXEgKE6BVkw2i2P0lki2txWv5Z8VOlPaoE8e4p0sSKx6vm7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954755; c=relaxed/simple;
	bh=2VUtW0YpXM+NjDn8hDo/IqLapZK8BOphv1C4iFqDS7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kk23fzt309wD7YLEeP2tdQGGuXY1Jj64KIkh6FMN1azz/OOPONGzaN6mGtnuMqn/SXQO75dKkudLTfi6Vx1AJTeZVT2TKjml1dmWSeuyfVuyOlMZLLaRTGCjCizCqx1y12MwW/glKGi0ajQKo09Xr1aXxpjruzbFZ4YtFWTK1H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mh1kEMZg; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mh1kEMZg"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2a75393e2so4078477e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 03:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774954751; cv=none;
        d=google.com; s=arc-20240605;
        b=BmI5jC+dCmIszikJXgzageLrdaxWL01Rcj8LiaFnDjiyUPAHa6c1qbDP/XqVnyl9u6
         dyoBFIQeMaBwekv3nK+Tt49TsEXj/B8KP8cU9pVAtXwObBXmjilqcwYkOOk42xZBjVXP
         u3Z7PXoH346syNmDmqwmPR+ENlbPT8RrYO26GDMFaTJvbvyTTPkYAqgIfvsuG6WVSBdH
         hYx3d1ww0rGz2a57Hb+s0rC+44jHSsRk2TQ3JNmhERlKi/Xi0QNrqy1J/IC10Cg2SYyR
         6cCp/8BC0SixXeb0D1xjj29F1fnp/Ii2RhdFOsM/2hSCyUgTzMpULuDWfvoOWro/jEfP
         f7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fL8mGMhRS7HqUOu1W0Z30JuQwLChCz1UuGa8bh9Su6c=;
        fh=wUk1/APn/RNWggevKdUsUuzilkXH79NlA9bV+XT7qBY=;
        b=VBh7BvenrwWdLKTVWhvvDjVRiRefv1t3eXp6zibKsdWKgXQudA5zeHHtapeHTRVVaZ
         gZXChW0oHewMuP8Y6+WixTKINWD4pu5i5CiVdiTAys9SXzqECQXbOJNrXRuU1oiY3kmB
         gjdBpJ/bpErO63yBYIuQUSe3JM89Hd/5Wgwxi+iIGYTKha/KQXL2IIZz8koteyYnTdPI
         2h90aLvcJEfW+t67NCuiWWi3EIm8WXykxawbZ2dxK0xRIww9Z+NwSlXTw5bxPMwYG5Pt
         NBHG6/7DRFtwyIi/jW+NSKC4V/uQ/uAF0/LnJ9IijybX3NhxdhaPKTM4nGX975zxJIwt
         4WvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774954751; x=1775559551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fL8mGMhRS7HqUOu1W0Z30JuQwLChCz1UuGa8bh9Su6c=;
        b=Mh1kEMZgKEF4pk+ujME5vMjdsXwCDFmo7Me2lq2lUiRxMd641FPSg40y18Xi3nGAva
         zS6jlPu8Ke24OjKGnE7mumdMLw0xttB7GikIkW3dGFSg7/qY+Z22baHUUxTA2W6qwYUj
         jandTH4NL1u6PIzf0GjOUHu1/Oct/Q4yBv3l92C7TcmjFjvYMF6RgoFq5i5v8OkXz+dc
         VqbAwkNQG22P76CVL2jssoCDM/uPc4uRX3Cce/CCa1xBhY6IaqAWggE6yp2Mpx6kajSg
         sDP8CPa+1Xbuiw+7nupHYIEMYkxsC7gHefv2u1Fg7fCz6V7GILodECrQXlRpNzVWkBUn
         PsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774954751; x=1775559551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL8mGMhRS7HqUOu1W0Z30JuQwLChCz1UuGa8bh9Su6c=;
        b=oZV8skNVz9P9pv/tToHA5w+S5KQg/YdGZH3J3dO3GS1ZRlFdtfIyJkbnwM/SEbuJ9j
         KRF3xohkK0AvCT5Dk5DKuroOsV8K3yXakwgQDWbu2BgoSn+DkA7Tet0bb99BNbdvPGmZ
         KbLDmqx1p3qIWSXytQt6rLilDD9WOACszlGCh3PoRLgjMjrvp780ZDqbLfRMte0P5d9o
         sGk3PjdX8P6sZDfUR9TopcISFRZxH8h5r2UIrI0DEsFoSqm/9O08WWf4GMX/sfeONFW7
         X0NKYseDFVoPUKZg2+V1QXNQdnxwHxopFscC3VoYuXvD5HMnCzjRRf+hZ5nVZW6KX1N2
         l/9w==
X-Forwarded-Encrypted: i=1; AJvYcCWc27Zjq6pMJVvwRBY+iW4O+iic5USEts4tFsfvdt7HjE970Z0DkcNmu8uBtR/E0ZET+EH/kHVcuRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDdAplQjxlhcHVN53OPkP/K2i7HZe7Ow7s3xL2u+LkjUCrNs7
	1nEhv9GjlRZNOjDiwsC6MV5NXgrxIn9kEYLI9aXW3C3z89HzaUpcVDPN7q+M/+8XgtL7UQzzK6F
	Nr44CWDmoQgV+cSzVDVFVZMYFjWD7sLZhr9+MMvjnxw==
X-Gm-Gg: ATEYQzwSjdZ1SKQroZhPWcAoc0MbZ0p0/GGuNnZ4MkzQzJqF7nTJrkSIFWRwHIaUlLt
	/f6aJiRRYQ6o8ZvjtvMQHtRgxwpqh9HLT/F+19QWTzvV1WnjomZsfu53xlWHHH6ybjjoMjHVQ6q
	sjihzw1d+qd8APzB3QVVhjAx0TDjlI6sFxTfv9YMBXyoiNmtGwUuJ/vgAlViOfTaRQSuoqkDpwr
	TCYMfEjOKO+R0gn2b3uudoP1HAyfyMgLa/irh2Nc+wZ0nyPfYpz/FWFlp94/nu5Hvk4DGpFqk3o
	F1AgFQNR
X-Received: by 2002:a05:6512:3482:b0:5a2:b01e:5b5a with SMTP id
 2adb3069b0e04-5a2b01e5c9amr2976958e87.33.1774954750886; Tue, 31 Mar 2026
 03:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
 <20260330-orangepi-sd-card-uhs-v5-1-bd853604322d@gmail.com> <20260331-eager-kind-civet-62f60a@quoll>
In-Reply-To: <20260331-eager-kind-civet-62f60a@quoll>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 12:58:33 +0200
X-Gm-Features: AQROBzB11zXXvkr31NXEyNIIlW6o7ZaxcYR8a2pmCHpw6-PFnrMqVgTaVeOSgY4
Message-ID: <CAPDyKFrafqhNbetL5kOzAFO526yUrJWa6mS_FPX-cw9bj2Mg4Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: mmc: spacemit,sdhci: add pinctrl
 support for voltage switching
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 08:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Mar 30, 2026 at 10:38:02AM +0200, Iker Pedrosa wrote:
> > Document pinctrl properties to support voltage-dependent pin
> > configuration switching for UHS-I SD card modes.
> >
> > Add optional pinctrl-names property with two states:
> > - "default": For 3.3V operation with standard drive strength
> > - "state_uhs": For 1.8V operation with optimized drive strength
> >
> > These pinctrl states allow the SDHCI driver to coordinate voltage
> > switching with pin configuration changes, ensuring proper signal
> > integrity during UHS-I mode transitions.
> >
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  .../devicetree/bindings/mmc/spacemit,sdhci.yaml         | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > index 9a055d963a7f0cdba4741c1e3e7269688dcd5f45..201ab97f0e88376a4680dcca7917e8b3172bd84a 100644
> > --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > @@ -44,6 +44,20 @@ properties:
> >        - const: axi
> >        - const: sdh
> >
> > +  pinctrl-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      enum:
>
> No, that's not enum but list. Look here:
>
> > +        - default
> > +        - state_uhs
>
> Instead: uhs

While I agree that "uhs" would be better, we have tried to stick with
"state_uhs" for legacy and consistency reasons with other mmc
controllers.

No strong opinion though, what do you think?

[...]

Kind regards
Uffe
