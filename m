Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532339DBFD
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263842; cv=none; b=cPxWXkFb7OIXj31GgOk1HWDECjTOiXCTlH8lWKrjvWLpP8L+Rdyj6FVsloZ6vSu3ve8KaZfwsnRGuGtYIjc5IUBiLkMTwfj2sNW8Eh5xK/9WBNDOqk4gSArTe9grquUHM6abkSFH98DLe6vtz4ceDTWC2KyV0RRc3IOUPMh2BSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263842; c=relaxed/simple;
	bh=vttU9sqwDyiNjeIypWh2+4bpJ0lWzS7An9QPEHok0rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoWomEd75wjxs03rwCkodtrzHJ+ES+2iSsyecU1xQnYL6R1J7vkrgF5rRT4sF3JR/ri273iaRTLlRrOaF07U1k+Vgi87H2kTc7Mtut3eqM1Llc54ZzI7TYi3NbLK9ztZYKS66cZwvtArRofnmdeKmFCaloDKStydiiLJmbbFJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5751b7d147aso1617622e0c.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263834; x=1779868634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP4IvGyOQMv8jR6AqNClc2139GxxUkZLqrvZUOhN+08=;
        b=IyJITzwunY4jxByCstLTePBW0dqwU/d3hBFc3wz8RkGa4n0eRQGqPMydm4yfn4hcnJ
         I/mh4Jyb/Az7B03xypfgS3YaZ1OoK0e6OGDvU0Nj56Gt/uPXZR1x0mmbliuBXw8HaS57
         Rg1Do70CqeHZ4Xj85cVCnDc6VL8slRUpM9v9rEpmXVFjqIyMDuESwbrIgQIwrFDrYDaU
         FZokLzWXz04ohHAACglBUSNScvtKjQ4BWrr2URRbAp6fvrSIAcKa1jk4RdfB9KlSTzx7
         gP8UIOef5RsY3l8cw9kNM9cEqHfUki/Xsi62BjxciOGv981WQuQlvDiGgyHRsOV1XSfp
         jZeg==
X-Forwarded-Encrypted: i=1; AFNElJ9Ww027LP6+FbD885r2feSDbXuCfn8OcgPryHq8DH71F7qcTA9F2d6ui9eYxC/K4XDKYEn8w9H07dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPX/wgdTJEo8ZsYnmAUf06VZR7tZFi3yPQzt9ZwJL4iPc1kzuf
	zDxu5C+ZPSYkc9EpmkjxPd8KtAGUxqbTxa5GgGzmkps1TLHLfJ5tjgmLM+PH5qTR5uw=
X-Gm-Gg: Acq92OHA5A2d6ZCPKOLpfjKWd1W1iYb3GsFmQMgM2LWtGCt9DSM2Qm5TasVU5pAGt2R
	8WR8ukWRRL1qwE0/cxmhElN7gznJbTd3amLvFNAAXWsHqHYiBEdazB+7K3XhrN40mzvv/oJP2qg
	Iv+g/ILwOnkmiEZWs0T9kJ99SZ9DBac37vxDs9Rm1USwLkKcLTYmqZN/y+x25ikUjlcuAeMp8Ak
	RpnykFpigw+Z0KkGFZZAo1IFGMlgu1B5WsGBXS3UyK65wZWkukfD4qoX5PPxLx1+n0edyaYIcA1
	E4/xX6ikf9DMgUtHd2H3bEw1ajXRMUigR8gkXfJPJGmyueuDQXgSfGPycvVlgzy+PUjm7ybUCl2
	d0haZ0XnRx/Uh1tEEGm1a5d9cAgbGC5hlfiLqDXltjKOOIE+/9MpMMrhRsyRMA+eKP6WJTSwHwQ
	rkB798lbh61+aj124lTbHw6JorLQ7Jrw1WhFkfFKxOA4RW6ElR42ZVQv3gzw8B
X-Received: by 2002:a05:6122:2205:b0:575:1711:a9c4 with SMTP id 71dfb90a1353d-5760c054182mr12365271e0c.9.1779263834070;
        Wed, 20 May 2026 00:57:14 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2cc387esm7990007241.4.2026.05.20.00.57.12
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:57:12 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-63124a80693so1632683137.3
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:57:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8AiVvnJqcEpVpODZiAt8IYlUvuSWgQ6GZ1F+xd4c1HnVi5MzTgBS8AI03v4Ez16yu4wAP0jxiXdbo=@vger.kernel.org
X-Received: by 2002:a05:6102:5489:b0:631:ea6b:23dc with SMTP id
 ada2fe7eead31-63a3cc0dccamr11327097137.2.1779263831882; Wed, 20 May 2026
 00:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 09:57:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAbew81+-aOgRPPzFx=9bAYsPDVDRj7Z_VBcZt1guR=Q@mail.gmail.com>
X-Gm-Features: AVHnY4JQ9wdKc003sx3iEEgNQvICTkkCLSI-l3x3iSx-VDEvIu9SAakZxqdneuk
Message-ID: <CAMuHMdUAbew81+-aOgRPPzFx=9bAYsPDVDRj7Z_VBcZt1guR=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 15:53, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2E (R8A774C0) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2E is identical with the R-Car E3 (R8A77990), it
> requires the specific quirks and configuration defined in
> `of_r8a77990_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774c0" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Dropped adding entry in the quirk list instead added entry
>   in the OF match table to map the SoCs to the existing quirks.
> - Updated commit messages to reflect the above change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
