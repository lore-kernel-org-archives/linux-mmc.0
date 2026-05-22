Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B2421886
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463765; cv=none; b=trL3kCKaMp9rI1ZI3xa58oo0sQi4GQJh27j3z9AX0a3x62s8OJdIC+RVllPxp7nRl22IelQBNUQzPOPLS4y/ejam/ZsWG5y/6iiOzoKTLxLXlr++MfBDctnIuMU3BHPt6tICCaJa78Cf4VxuQwiSx+pXSDf4Bo/6npP2JJpXqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463765; c=relaxed/simple;
	bh=EB5tKPXi7NNM86vQZ4/x9OqKlx4YTJ1xqabX+NGrs1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtrcoOJF3n/nDvNMQSrHWdWEapwmuC4vqTybPMYkRgQAA62BijcVQ3mhNH8remizEWvMAMmTMbveqaC6wcU77ll9R1vyzwxd8l0B58Gj6EybRqfbkyh+D+SioYPVsS4OkMARZBTDOAdKT5wVsqH1OXQIRwirdJK3JM0VBF3Wt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56f6afbd205so4491938e0c.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463763; x=1780068563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdOpo31kserPmrGp3GvpU58TPDoGY+y8EflyrkRt+J4=;
        b=sUNdtTezlhFIVeGxgbAsQDQPpBqeZrD/nBRjPsQ8W50zutyA8A7g6MIB+wSh8PqCBp
         TQXYdkxVjsb0gAsh3eXJTmoUzG8ptCLFAgYaoOEo5e9Al5kyEy2LtFin1hmVS8A/hfh5
         U8FxCkq7raBbsY/Zo1LSAFgLPcDREJZZikEAXQ6We4Nx/Fh0NJymKZ0zWcahak67BIXO
         vlnYFu3h/bOPjvR+X5c4I8WtzBlsAizdkyx6FuKL6SaBWbmt7ylq/GaWOvfqKCzslXAi
         nMX2Hqs57Mro6CI33Ztuem00iZbBEO8i4aRE8sfC9z1N1N43EDeZpFRx6f8Syszu9wtN
         x7PA==
X-Forwarded-Encrypted: i=1; AFNElJ80SBenB1gLqzCyKrdFy3e8jRvfzqvtYf/MlyRcbh5sBar3zGceYLK6zxul65NLp/msUAa3+5W3WIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsHJhE5JQ9fozPjOCehtXfhsYsWlCenPnK8OwE8RjhsPfU7lu
	7gdaSfZzOXIO2w551dOTY6HRIVbhLnKtqNKfrZdyGUhGTQeOMC8ISbJDRNr6UJNHaI4=
X-Gm-Gg: Acq92OGhk3LB2od6XCpECYlM2DwkAEm6wVTTF3nWgvD50Y8JJyvA0vx4q8VmTDFR+74
	rzmSa/jPCUX86fKqFQwp0dJudPrI+qtAEbgiGZRvEz9y/Nm+SrowE61ZBpVw888ztjfzNmky0AL
	5yPya19pMBZHrQ8kvRp7aXxrA1sXqc9lqp2DqJavneptamitYSqt9blZ6zIEjfNAlQulcysp4vd
	RjSL1/Pmg4I3Rx7W95Egko5A7UIfJ8YXjNTnVG6n0QxO9Xh4HK+c+twOyS4CNOMPzcw3wOvHT4M
	3t5nE+PEfrAEAH2mA8s8luo4oOR2mCp+OcHePVsXR9fe18/Z+ImnKNZxqh55glbP7z1qyTFpp8u
	5y01qVIN9PI7JvdZAHnTqbvS3KZbwzyA21gJaz/Zd96QcjGHKflM9XmqTK8IJAZcKpM/ucgj1pq
	uppNsQU0COO6o7nz9pXtw/WX33ut55C7drkwZAOEetW3/JttgNDzmZs3fwIifE
X-Received: by 2002:a05:6122:54b:b0:56b:8ba0:fd58 with SMTP id 71dfb90a1353d-5868efd797bmr1661225e0c.6.1779463762969;
        Fri, 22 May 2026 08:29:22 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586ec46c8ddsm2709921e0c.0.2026.05.22.08.29.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 08:29:20 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-95ce7b777ccso4486768241.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:29:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+iSv0jGxfRQZwopLbU7igtFHyiZGZ6UEFaJ1d2cP+O0XalKgE5dF61/Ki11yt2s9k5aiojy/GJQQ8=@vger.kernel.org
X-Received: by 2002:a05:6102:c4f:b0:634:10bd:95c6 with SMTP id
 ada2fe7eead31-673d1c38b59mr4123345137.22.1779463759525; Fri, 22 May 2026
 08:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org> <20260504144534.43745-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-6-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 17:29:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNLshTRi8yqOBezHpWc1b=f7VdSyN_+cC=r0dKAi8R7w@mail.gmail.com>
X-Gm-Features: AVHnY4LJMj7MpfiKYvQ9U6raZAqssKkW2xRRdr52QyR92yVonmyMfE85fwhFPPk
Message-ID: <CAMuHMdUNLshTRi8yqOBezHpWc1b=f7VdSyN_+cC=r0dKAi8R7w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] soc: renesas: Identify Renesas R-Car R8A779MD M3Le SoC
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 16:46, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add support for identifying the R-Car M3Le (R8A779MD) SoC.
>
> The Renesas R-Car R8A779MD M3Le SoC is a variant of the
> already supported R-Car M3-N SoC with reduced peripherals.
> Enable support for the M3Le SoC through already existing
> ARCH_R8A77965 configuration symbol. PRR reads 0x67c05501 .
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks, will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
