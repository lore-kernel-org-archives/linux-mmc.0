Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F53A4F4F
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762157; cv=pass; b=ewLMaIwyQbVkz09xIJD9ILj7SDLIIeiNryaoJmKMj4Ffup4UlR9jo8DnjgX78TXi4ho8nBwaZrPPMEFgZjZu+8wqa16LR3VPhW5hheUq8+e+iWLU8FbRyw9CVz7Czw+TCEE+C7lZR1ZVWGcD2ejKw6oR0oe/4psUVEPYYkjG8eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762157; c=relaxed/simple;
	bh=RIU9QShgP4nt11BO/nGdNguaaSaZzoHWc/VEX/ZXN6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKhDNyLB8MkLV5MsU08gy1JudpQAydP9kCmAdFYm+jKj7NeNuL2hL8brcCnd4SLBRUuFtRvNl2t1t4kmxH2VlTGgci8FpWLTdmwCM1DNBQDre7jpJYkMenkuyh1Ofcq6dL8JtZk+Ioq9Szi9smoNjVxhKpkxhwW9Vfuh+DHeIvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N09bgiLH; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N09bgiLH"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba7fd666666so210577866b.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 02:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776762154; cv=none;
        d=google.com; s=arc-20240605;
        b=dc/pRajoBTkcboS4goUmzzwVyYVTAq0I9wGkUFZGJ/hQIYTFrMAKXktYBkJXEW+X9h
         o0bQL+glgMsRhio932dMiYugOnn70LdLJc8p8uUG57xvVR3q8ov0GKObHrEs1fsGGnq0
         SUm0WN2QMwd1/uKT3XnymXG7OAIOrj4hXCklnCHV/0CymKdZmUmIZLyI+m30hkLSmlPa
         hB0s4bYllbMJQbPoDK2FTQk3WjG719/IMC4wN7o+W4QIw+FBNEtLw50pZPdfyHB6dGkb
         NFPUX2o7HlgrRO7qq8cUGp084cPViyd+OrdiqXugExLHBpRJfrUES/U0OCeFHWeXGd9K
         YFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8SkaqpIEbFtAVM5DlAwSjvX/jufqTUSlkSlX0ew/8Ws=;
        fh=4NzEFH5RDOiRIV4jX74ABsLCpEen+iuv4Yiphr9nK3M=;
        b=jAxzqZQlKZ9wMzLyUJ2VA4AGiOKGsgf6PVRpl4O4g0UprWP8ZF79cuqShq7TxDtVgr
         PhW/lcFFvs+7EAkLpi+v5x6CzrDOG7YRvsKOlWyBQ8CpEKSPQJw0iBO2YOlO81wYLDn3
         ETVpUFWr1Y4eoJzA8QRWx7rMUthQ5JomvS13ZkOmLBLFkJGMhXuM1D8ifXedAVx/UdgI
         gRMMZ2aApGVurIIe8PeHBLAffLdLcVgfgWXA9QM80YZqMO+TQko3RoC4QPS2vMap5Dp3
         xtkBcb6NhBHG0dHOpa+6Qc32A9DuINXAznHkC1IAvssN/4nzOYFXP/b5ou5uIlsPTY3C
         ZWJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776762154; x=1777366954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SkaqpIEbFtAVM5DlAwSjvX/jufqTUSlkSlX0ew/8Ws=;
        b=N09bgiLHGgmsZeFBGRqWJzpx6+Z+CmMa74VTWU7aG0nulDJBW0ibdn4zM/4/9m1lI3
         BJqLJ6BJZB1k2HmiytPNc5GBIUe4VHb/V/0DBVtI8ZgXwtQ589bQkWY9KLQgdkdmm2LY
         BEBNxhZA0shpHAy3hMjr+EvcWVu5+RUOJOThu2a6xkxirlBkUkSHPlfKlME457n5KkqK
         dh5NwVhFTi9rK7Skl/X1iRdGUY9SbyZedPU4XhUrh0aJkcl95PK1OfHovUcnHKzyji0I
         Cm7n2CamcDz2fC0oUfwkWOoBCGGcIjr6SzeGQCATv0SBxpqUfboJbSM1TJUfdto5jcUa
         I+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762154; x=1777366954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SkaqpIEbFtAVM5DlAwSjvX/jufqTUSlkSlX0ew/8Ws=;
        b=QiLFc1oSyIkW4uWV7KwRaNIaY0zSoWIwTYT1NkJ5tZd1rmcNR2AOuSCYcGl5E8XMeT
         sgKqfoRcjXg/eNev63JSEzdbPAbMRplxSKkgiJqgcbEV7UywAM7ZOLKeB+xzMjsSJjAS
         ZkMcBcW5NUSFiLfEfuwRb89B2fbY+SMWV8ZqF+3OpmnaJVBNhCVvd7qt7FLqlCwbSrES
         z7O1G6/qMVJJr1eTH4KMVR3hI4OTwb0xhB+OZLHS1yOGKN967IOEZV8ivSvkFpjw4slq
         gZ+V2f5Fp1In13H+3tCZ9B+uzYif4sMMXsfkEu5nEFGt4i9J+mONe0sge+9iXqD3guNv
         P9DA==
X-Forwarded-Encrypted: i=1; AFNElJ+zzcomSrUI0yN91tGuDg3vu32UpRWnxsA8c+O5a1rVvj4dGYEQktk+IMdF+CzbTxiDCp/i1imXgJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySzUqEJkz1xF4ZVhbcxn2eMMwuWj0QGznUClLlRbwJDiqSFq4V
	Im6hw27ywKbwjQCKQmYzfAUc66mmoQg+w1tcUe6w9g+ghaJndlc+O3ZJZW0Or6MxJnRkyvEDxzk
	BeMA9HAjmLER6TSnUEhhtehXFHwA+BXI=
X-Gm-Gg: AeBDievjUVvU26dmry+mUUCFZCgrgKzKw6TuX2FnBOaG69UmnYOkphDMqtaQTgILRmS
	hmtYUZwkBU44PicnVBWv5BlwqDnAiJDI7UmjbQDnDSLgQtaLfZN9E/eIRpGwu8ctin9FP1IUIM1
	/p/KO0YjVAPI/ev96ZS0gXdzAHK1tLP9XHGPfvZBt58xoY+oiI1Bq6Co0NEorgnZxKKre8fesiR
	6IU6lFPiXaIwhZXNsjoySDyQXJymqmFj6a1B64bWk1/WRF02lC7iot5fvfKX0hDKBne4WYLJThQ
	T5+m7Jlg19rgwJit0AcHgVIWYzatV1VevF+2vAI8OlxP+bfZI3IfXEqrDYnxzYwONKEoqpmg3+D
	pputZc6C+DGIZ5oN+fXbnJFlA0wpg+w==
X-Received: by 2002:a17:907:a4b:b0:b8f:e46f:8079 with SMTP id
 a640c23a62f3a-ba41955770cmr840251166b.22.1776762153647; Tue, 21 Apr 2026
 02:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421025052.755471-1-inochiama@gmail.com>
In-Reply-To: <20260421025052.755471-1-inochiama@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 21 Apr 2026 12:01:57 +0300
X-Gm-Features: AQROBzAxV3Llp1jDqyc-LTiw_nLwhgf4Wa9hpjC4yT2_F5V0_dWmZvHeBtekByg
Message-ID: <CAHp75Vf8DN-FY=DKrcid5rPk-tM6o4mxyPLuYGEsNUqrksEdPw@mail.gmail.com>
Subject: Re: [PATCH] mmc: litex_mmc: Set mandatory idle clocks before CMD0
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>, 
	Maciej Dudek <mdudek@internships.antmicro.com>, Kamil Rakoczy <krakoczy@antmicro.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:51=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> The litex_mmc driver assumes the card is already probed in the BIOS
> and skip the phy initialization. This will cause the command fail
> like the following when the old card is unplugged and then insert
> a new card:
>
> [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
> [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
> [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
> [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
>
> Add required clock settings and initialization for the CMD 0, so it can
> probe the new card.

...

> static int litex_mmc_send_cmd(struct litex_mmc_host *host,

>         int ret;
>         u8 evt;
>
> +       if (cmd =3D=3D MMC_GO_IDLE_STATE) {
> +               litex_mmc_setclk(host, SD_INIT_CLK_HZ);
> +               litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);

> +               udelay(SD_INIT_DELAY_US);

Why is it atomic? I see no evidence this function requires an atomic
context. Please, use fsleep().

> +       }


--=20
With Best Regards,
Andy Shevchenko
