Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA037A4BA
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238655; cv=none; b=nQ95D3r/cMKwJzYCKDSuhKnb6aa7QVhyKCQNM1s4euroTODgbq9ukVlQJt95TRJSYIU5oPEgDo3fO3BbMtDhJTcSbYqPzCa47bhDJrRTq2gFHgS3WT3s6aDZMQ8vCtsu6IwT5WBxyrs81+jBIPubOWIpqDWeOSfHb+1Ry6qqlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238655; c=relaxed/simple;
	bh=JEUShUcBn6WVVCyv1/izNcZLY2tqPOkmYnvqIuBZXKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc2+TFUnuc5wmN0r3ZW9zyx48aMmnIhq6T9bNfuY7sSizIzsFBS8R+XMGcqcNspanbkBp9aaTeW36joy6CsnSMCb5n8RzqB4RMyqUY/fmVhk8WNXEBmQ8FE3J/d2ewnsxUNYjt7YFJkfSNDSN3hKzKxkKitMz5yvvfZgcFZfMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dUOBF+Hv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUOBF+Hv"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-382fe06aa94so46739791fa.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768238651; x=1768843451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paTthnqDXOZr7d/25HaUzXH+xhp3M/b/nGQdFVCn7j0=;
        b=dUOBF+HvOegu6DOujijSGEGpvnFDvUQPMe4Md06S5QPz43OE5cVc56tgwss7E8vc/b
         8L8T2hAem95D93RVdByzNHlJlSZixzOEXfXUngpxE1pVglXxb5j3IcttWZTyfH8sV/FP
         5qawQOCkT4HFN/Bopz4gGkiipg2KCT4ZxAuobqajnFW6WBDsEyDI3Bxim3648D6zNJpV
         UQfG+vvF9oqwiPCaT+7hOJZw4i+lGwybb6j+JV88lKzmEfMN20u/83ClJ8zoE2ev44tV
         zW8JQ2SRkTG+yK+mkPSYkUg5R/nVNKAbzmZHT+iBuRBuIQy2u9d/b0LbtPI43b5Qubh0
         fshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238651; x=1768843451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=paTthnqDXOZr7d/25HaUzXH+xhp3M/b/nGQdFVCn7j0=;
        b=aJuEXu5UWcvchdQzDCzCOIaSWrRf/yUss1zrHmN9OYxcmdXmDcdK/3vCNjhMUV26zP
         sfR67WBypmLWuxj25+m/tIUa8+W35ZhC7AkjwkowbUwNOm5JofkS0SWOhIAWWdty2ttE
         BPaoTXl5zCfiKrBiurcUn8OYr5PpjYD3Vt++GH2JR0SYu9DhzKg8gAEvP1lw0yZt4xe4
         +I8d4Hf5OMelX1fT0rExObiA8Uh0l1nD1OPdtCRGi/p+ZFfYbRM0/jECSdGgXWlNYK1G
         GHUvhOH1df+QL7NvD1u2xEx41pPuMtSzsrj3ibETudS60WB34++jcc5yulmnSKblt35t
         YR2A==
X-Forwarded-Encrypted: i=1; AJvYcCWpZDPe60rMYY3286oRTI4/g2zVIxKszpfh+tmwAqnKcrub3Wkppd3uR0EHpiYpfdZBW/BszJGsKK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPVvWUzu/+4FoeN/tKeoWtBAN3z7P+rzB1DTZ2OkCZ0C7RgNp
	IvWJAYoves4+JfDy3qmGSdcqOmGTrVDypCkrwncbUrKsMIChz8AZIrTOrXePXaumrrTPwlQt4ky
	yOHDFs7M+2MsFY1krOiN8SQzGkE+GZG6Eo9CZqhCC1g==
X-Gm-Gg: AY/fxX5VVmEatONMMJ8BIiPnhpNpmTaCWKj0YI6GdGxhAkOhp71n9LzgoQng2TDTGQV
	du85VKuT1XISQDNoXF396OjHWqIApg4TPicLbR2bM2uKNlQnmssxqxVyyziZx4zDVwaMMIR0k6R
	AK3IrLD2QV7cbIZ0DxzvvJ1Xc7xE2V9ENhti5RPMwi3uENT8LY22vobNKuWGacsLwtKll1YiW+D
	kvKtezaXg0W8oReh4lFYUfF9gyBj8GkvE97UGj8HiuGuGHcJgaWMsyBxGz3khKYgqeVn7G4
X-Google-Smtp-Source: AGHT+IEviiqE2SlQm6eemgttI8MVkNfaOt6WGDe20ZhviMpdVwklyiWV5N+bno3nacD2dlPGOaJ0qmPzOJFZ2N7sXEI=
X-Received: by 2002:a2e:a812:0:b0:383:19ea:6a33 with SMTP id
 38308e7fff4ca-38319ea6fecmr36543881fa.15.1768238651260; Mon, 12 Jan 2026
 09:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it> <CACRMN=d8YX1LG4NSPnNXGnU2u-Ej7wsTom_DpVrD4T_byRE2CQ@mail.gmail.com>
In-Reply-To: <CACRMN=d8YX1LG4NSPnNXGnU2u-Ej7wsTom_DpVrD4T_byRE2CQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 12 Jan 2026 18:23:35 +0100
X-Gm-Features: AZwV_QilpAjI0AMTTaytJBNTqzjACUviJaFVXH3fFF6FekA5ZD2r02SbeNMcupw
Message-ID: <CAPDyKFqZsSi54FtYQR+vmjjUVmFPftipPdpUpDhCmEkTPiRH2w@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Add support for "mmc-pwrseq"
To: Sarav K <sarav.devel@gmail.com>, Francesco Valla <francesco@valla.it>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan 2026 at 03:19, Sarav K <sarav.devel@gmail.com> wrote:
>
> On Sat, Jan 10, 2026 at 7:28=E2=80=AFAM Francesco Valla <francesco@valla.=
it> wrote:
> >
> > Add support for parsing MMC power sequencing (pwrseq) binding so that
> > fw_devlink can enforce the dependency.
> >
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> > Resending this patch as it slipped through the cracks (of my attention,
> > at least).
> >
> > Original submission is at [0]; there it appears as a v2 because it was
> > the first time I used b4. It was also part of [1], which wasn't really
> > a patchset but a follow-up to the boot time SIG meeting.
> >
> > I added Ulf and CC'd the mmc list, hoping they can (more
> > authoritatively than me) reply to Saravan's question:
> >
> > """
> > I took a quick look at the documentation. It's not clear to me that
> > mmc-pwrseq always points to a supplier. Can someone with more
> > experience on this confirm that is what it's supposed to point at?

Yes, the mmc-pwrseq property provides a phandle to the supplier.

> >
> > Meaning if A lists B as pwrseq, is it always the case that B needs to
> > be powered on? The binding documentation doesn't say anything about B
> > needs to be powered on first. It's just saying A and B have an
> > ordering requirement.

I assume with "powered on" you mean "probed". In that case, yes, A
(consumer) can't probe unless B (provider) has probed first.

Up until now, we have relied on deferred probing to manage this.

> >
> > If the meaning of the binding is _ALWAYS_ B needs to be powered on
> > first, then yes, this patch is correct and I can give a reviewed-by.
> > """
>
> Ulf, in case you missed it, this email is directed at you or other MMC fo=
lks.
>
> Francesco, can you see who added support for that property and direct
> your question specifically to them (in case it's not Ulf)?
>
> Is this fixing a specific issue for you that's pressing? If so, we can
> land  this and then see if anyone complains.

Thanks for pinging me about this. Please let me know if there is
anything unclear.

>
> Thanks,
> Saravana
>
> >
> > [0] https://lore.kernel.org/all/20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@v=
alla.it/
> > [1] https://lore.kernel.org/linux-embedded/20251126-beagleplay-probes-v=
1-0-c833defd4c9b@valla.it/T/
> >
> > Thank you!
> >
> > Regards,
> > Francesco
> > ---
> >  drivers/of/property.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 4e3524227720a596b0f12976f83357851e9b94f3..05ae33a58b5aec0a8f4d3b7=
237ce88066d86dc9d 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1410,6 +1410,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-ini=
t-providers", NULL)
> >  DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-=
controller-cells")
> >  DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
> >  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
> > +DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
> >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> >
> > @@ -1557,6 +1558,7 @@ static const struct supplier_bindings of_supplier=
_bindings[] =3D {
> >         { .parse_prop =3D parse_msi_parent, },
> >         { .parse_prop =3D parse_pses, },
> >         { .parse_prop =3D parse_power_supplies, },
> > +       { .parse_prop =3D parse_mmc_pwrseq, },
> >         { .parse_prop =3D parse_gpio_compat, },
> >         { .parse_prop =3D parse_interrupts, },
> >         { .parse_prop =3D parse_interrupt_map, },
> >
> > ---
> > base-commit: b6151c4e60e5f695fac8b5c3e011cfcfd6e27cba
> > change-id: 20260110-mmc-pwrseq-e885e677ca2b
> >
> > Best regards,
> > --
> > Francesco Valla <francesco@valla.it>
> >

Kind regards
Uffe
