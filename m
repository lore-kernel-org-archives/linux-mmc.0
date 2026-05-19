Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5053DDDBE
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177170; cv=pass; b=iXd9eDqg/yaZQir3MCbyA97RBt9oDLkbBt9XjkwzQOkoXSbPNKybcCJNW97SyM38vG689AUAUSRgs5XNOB3Y2ca0S3cDlTskQa5YtI/CyIb+84avUTML6iQFM093czQF+/9XzWU7/zRp1dakakLKvjqbTtGun+R1SZ/Porr6kW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177170; c=relaxed/simple;
	bh=4qsw1CL0gIfsq0n/YQnAXPwRiyWJyOXA5x3SXbkjk9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQhYSbapRb9xmOtqma/6tVAJ+MhIdMWO5+Ss5OEgGUTwX838+cYEthcnrgEgMDNFCixqbuD1t/Kemwzv7IpBmmKv8ASzNe7wEuvf3se9Fw+Q3nTzqrXwljzxZ2171R2aZAY4C+gIOx/o6Kgv97l+GTpoF2ebHJ3FgaOVtKt1pMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwohTdJn; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwohTdJn"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd21ffaca79so662065966b.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 00:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779177167; cv=none;
        d=google.com; s=arc-20240605;
        b=k3ICo4icsHOuqm5Ef1LfT346bB2zzDwH6IFWxb+5FLQfxUgeJ7c80ZfK8/D9nGFNyX
         mBlnh/iryagezvJEQM6OrIsyLFytN2naoNa8o/kUrVCyW7hz1g7dP2vdIEgR6yDTgsrg
         FHbEdBEIb4iJf/TDvasDOBp3u5rrjnUjkYtqD2Q6OoyEG6NNPXgef5kiaFtqEajMQab5
         71eNYTG2fvg/ihD1iTDIej+1ioUbn7Ss5omGZAP0Bhta5f97wA54gvIwOEC2XIpFgHzt
         tBh7EFwnp406lQbqMwL7RbpJHZYM1HB/bpDF4Vyy6GTBvQ2tVyKRpdmzLCGqxshyr7XY
         te6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HiU/yoCNaQF8t0jqyx8bIzdNkuvB2f4Rq5AvvK6VHaE=;
        fh=kytsJSQdfn+aqbOFpEGfwEsJbzbh1f9VCcKxfdxMrbc=;
        b=JhHGVW7pAaZ8iNwvj9nkyHZqef//G3P0rZRDWEZfRBqOdtF+IDKYcDdo6rp76kBDGe
         AprV8TLECBogmHA7liORvtboJAcJW/MKtcsxKWo4boJDEa6gSRS5Oc74rfsZnR4CKHKk
         EsdJmsrsdcp37uyMjmEE9/gZg1XJkqBAoHTCxAjItH4S9SAGXJhF9Je7VSNO98Ky6Ft8
         zJPn4qQP8ApTxCxEde95g6gaaQjGDXWeaZiigS1/rpx7p1kT94D5TwS6NWkQJccM47aW
         9GhTFSB0bn/LIhtoHfyg/nHXQu4LkRMugF4dtorY0ijjKab+qhRPNAYRMez5h7tIDHs/
         NoVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177167; x=1779781967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiU/yoCNaQF8t0jqyx8bIzdNkuvB2f4Rq5AvvK6VHaE=;
        b=iwohTdJnaBNjJqTrrNuSswYXTAqMPa1h77xIWeTFToD08eoS5dyGJe1D1yRaI/04oc
         qzfKlNh4TPFhidz7g7SqunYJq0xxa6rdfAroh9ZqfifTJz7iRU4IbhqhVIouBIUZ4y5D
         VvhI2pAd0FW4RFSnIX8IfL3rlpQ1CAHlpEys2GF9uphtEM+28Urb04kHuJ/0hT19uC3a
         ThNlRV0qk3LL3I1eundw8Xj+/5nf0Irv7pVFwHrPWXH7UXGWbBpLCgcI2hTRA52g+xsW
         levt2LPus93JwLi/6NjsYxFtsQyFtlcAxYvdxuwO/L62bPL8Q3nMM71C60qjVdQPmju8
         XMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177167; x=1779781967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HiU/yoCNaQF8t0jqyx8bIzdNkuvB2f4Rq5AvvK6VHaE=;
        b=ZyC3aJHKdDN9UIBIhNNgOIdSqRwISPG/SFngBhREeHArEk7u5vd+o6tnTbvYoZJ1yc
         Lc6nxJf58sw0osOeyZsrIl2jRwmUVYWK2ulvP0rpIZdm+4sObsMjgEzT0zrOH9TCUqBj
         7S2g/cAyjYRuPixwlujX7qH6y27y76vMvSE5kmpBEQc/GQFetgQ2K44Y5RDa0uY4VAPP
         LMsxP+NDFHHuDXVxflgVD5E9zzFMU0JiQkmX+sPpLlUtFmxhSWh+T0c97rWxunj8/yot
         bCwL7b1ac5cRPdh4F6hgLMOtbUZ2Rok9e/VPabp4KBFpBGFDoepV7Qd8XA37AcZveG9/
         orog==
X-Forwarded-Encrypted: i=1; AFNElJ+BObjGewgRbxg3TAJOtyXUWzWrqwchvNrfsTo/Frhg+y3JMqEmZUG4pW8uRyXn2cr2YU5sbMM8frA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NStwJhUPkPTdOFNDXuUZK4Dt78Bua7yesPjKrvqIsqJrkYxZ
	akfvz4GfFa7UDdhaZVfJ/lROPu0pqi0EHsrzkuO6dhijhzHRNp9KdS6WDhxHCldKA4VLlliWRqd
	fFlopsyUZyv3ieDTbSWTVoiHsomyku4k=
X-Gm-Gg: Acq92OGfOnbNvSKsHxyktDZjA8+qCOKMYpn518VJKw31BrdDQey291gEZvBb4b01drf
	ThlbFhxoI/OQeo6WCX52pdlrv3fj/8bB0Khy6bShPPZKEokCDPyMkAonpW63BuXA0sW2aZCQl+M
	Fh0IEw1Hb3+4gzbPiglcLt/eE/jBSAy7vpNDUtWGbh4jZZn9QC9RW1LVP2F+s/sB3SyMo3FstBE
	ZgrksF2S0/toGAZtbSLyXrySlBRSevsi8gfGQD6oz+f2vhneAcSWAMn8i0jF21T0BAQYtwAl2+q
	DvcH9wpH3CDC7DjM+Cju5qwFENXRwqR3ClZaTaov/TZx30DN0K22ZKiapIf3JEk+FV2DPXXFK+v
	T5MPOXa4=
X-Received: by 2002:a17:907:1c0a:b0:bc1:d3d2:9348 with SMTP id
 a640c23a62f3a-bd4f346164amr961289266b.20.1779177166905; Tue, 19 May 2026
 00:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517015323.264179-1-inochiama@gmail.com> <aguQwccX_ujIoARX@errol.ini.cmu.edu>
 <aguRU9Ces7ruBbRY@inochi.infowork> <aguWhuNsV1KKxMeQ@errol.ini.cmu.edu> <agvN86UYsdU7Ixun@inochi.infowork>
In-Reply-To: <agvN86UYsdU7Ixun@inochi.infowork>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 May 2026 10:52:10 +0300
X-Gm-Features: AVHnY4LwgEEwJr23iq8a4v_FXFrxJSXH4zwyTh_41jYllOgAR7qJJSrd8H1IMIM
Message-ID: <CAHp75VfruMEp++65kFtMt=Em-bF2d1jMUywT-6ropx6cTHFygw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
To: Inochi Amaoto <inochiama@gmail.com>
Cc: "Gabriel L. Somlo" <gsomlo@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, 
	Joel Stanley <joel@jms.id.au>, Kamil Rakoczy <krakoczy@antmicro.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 5:51=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
> On Mon, May 18, 2026 at 06:45:26PM -0400, Gabriel L. Somlo wrote:

...

>         /* Update sd_clk */
> -       if (ios->clock !=3D host->sd_clk)
> +       if (ios->clock !=3D host->sd_clk) {
>                 litex_mmc_setclk(host, ios->clock);
> +       }

FWIW, it's a stray change.

--=20
With Best Regards,
Andy Shevchenko
