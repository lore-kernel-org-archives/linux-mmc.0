Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20B364E9E
	for <linux-mmc@vger.kernel.org>; Wed,  6 May 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063185; cv=none; b=dmq5A19jYcC1HVCnKysfjOA+XQCOR9CQqsGNm+bSwpNiaFH+mFjIhD4C5t4Vq9iuOiJsWj8AG8PnelFTUri3seFTAyI6bGfFOvVR7nllFWIX1mLMgrAc8hqFnuxQ9Om4t9Zq1hsLN0vJg5PSlxOFFOm9Q2U3uFXDHyQGRyXBXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063185; c=relaxed/simple;
	bh=B2Xa6VZztFm42sxYFXowro4G1pwYLrRZg7/codjLEJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHKSEbJZ7R4BoGLlnnN9T6iHoutKz+z1CH2uGSMU0bdD5I4VBqD6+DDMZqYpc0NiIZdxrj20xFlX0bsRD+JopoWxLiHCKPUbzQuwF1rq3I1eVofnXflz2j4R5qWNeDXx3UVR29HJ8ecJh8JaVlZzfEbAwY5GRWwXbk+yjiuJ0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-902deb2412fso250599685a.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 03:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778063183; x=1778667983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frOZWVrduNGKMu3VYaa4JiBvzYZTtFtYjox5RDxS4rA=;
        b=RhUzPtKldrWv5Klv/Wwvt7tGNj3snbHH0QUobnRP2lkBHJOffkKmvBbQZMJjKKNaW4
         9M7QiGRCZISp4mYf+icxuqSjINVji/zT+EdVxwnigUW6GVbo+u2Kh/YHx1OWYZbi9hvF
         CveLPbaEoWyKvBXKy8XU8BzWlyIyynvk+TLbBd5KJ/nom6oFZOW+PNY5/bl1lodUYf1m
         +nGLc/jcfbD6sWJ/1ZmtIaI5IURZW17TRYJ610uazRhKLP/ivnf3CUnv1+DUJYFRVDdu
         ap10lEiY3QMXZeC9tYBSmqifJHVlvakwsX9qfr0zk9JdlQFmGFyTTAyFNMvraRJe7F1i
         6Vrw==
X-Forwarded-Encrypted: i=1; AFNElJ/jdd+GTAcEoy6TTmq0OZqvlFuvvSPSNo5Je0BneEj6x/L3C8hztbBUDrHm15qxoIXkawPJragTgaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHSzN8iqqsng/PzOeD8AZpEwLMpx/C2PseFxXjWWvlipZT2Vqs
	LE9f8SPVbO5dc1j+nDDorzYrMslEzRmtGsVHHIC7bVq7r/oTYxiABuf89QfKwmVr
X-Gm-Gg: AeBDiesSwxGEDtNHkaeG270CSt+06nyIw2t6X+POHMtnM32jH1yROVr1w7FiK0HIvtq
	6YYl0B9IKIO1T+M0Yu89j09cmtHjxDZx59QxeTZ96lYWtu4qQ+jJRijHezsmBnEbTGusiCFHoLK
	rDBWz+cExMYbTzmWqTcl24y4Nld9rXVAI8uXVCGDl5yOhO6CqOraDcsX3pblUfGveQX58K3A7Gt
	nLE0RZLuc6MGH0FQtLvVrrsAkWMGHB+XGGoKIho1Qk+IBhuoYq4nx1azMeTcZ2jHI8e7fFXl3T7
	6OIjrmEf55CnwETL4/3MIEUNDRsnlvfrsBI+Z2rS+n0a79NEMVEUQyzYe9PVmDNNmGLHnzgHTSB
	RR3PrenMATa6xBZTnIlKP0jBq6mpjOmx0E11hOcRJJOC4QnRFkmMELaMo9fnFYPmLlWeQUwEzNR
	ypc2e4bBltyDyPdlnOAwHAK7o6gxXUBQtPAyZI54BiAHUJuJKmoJbeIO1rSbZXD9sUs95ls+g=
X-Received: by 2002:a05:620a:4688:b0:8cd:b317:a0b4 with SMTP id af79cd13be357-904d4e55f8fmr414782685a.27.1778063182919;
        Wed, 06 May 2026 03:26:22 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c2540ecsm1565879985a.26.2026.05.06.03.26.22
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 03:26:22 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so59032276d6.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 03:26:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9D1wrWWjHjFmph1MRQ+dBZ+vXs++eboyepPqdhvBkTSHAusshhU1QfWiiEaplSSTqcCfDVGtitxfw=@vger.kernel.org
X-Received: by 2002:a05:6122:3214:b0:56b:815c:961d with SMTP id
 71dfb90a1353d-5755963f49fmr1289109e0c.5.1778062762167; Wed, 06 May 2026
 03:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org> <20260504144534.43745-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-4-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 May 2026 12:19:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdqDpU+AZrwz5ccbZPjJfp5DspoVscYi=Q+w-nniuuCQ@mail.gmail.com>
X-Gm-Features: AVHnY4JCwkwAqaqLSNXuaf0ETjjPOv64a8QgXMobUA_baaUFwZots-RZr9ezKew
Message-ID: <CAMuHMdWdqDpU+AZrwz5ccbZPjJfp5DspoVscYi=Q+w-nniuuCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: clock: cs2000-cp: document CS2500
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 16:46, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Document backward compatibility support for CS2500 chip, which
> is a drop-in replacement for CS2000 chip.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
