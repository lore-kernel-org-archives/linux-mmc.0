Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CA3F9260
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470838; cv=none; b=KWC32+7wGPJ64kY6ma5gJLBorEt5aV9WcyNZYhqyaRITTITrmGYlL7lb/egWFRg2GBMrniiuj/tX0UqaIyCWhD1wIJIdoVcp/sC2yJjZ9w6C45AHPQe/tZQdsTAP36p1YM7iE9BsC9AwQ3NzLtxQm1O0JO6SFmG2l00tf1hitSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470838; c=relaxed/simple;
	bh=PCWXLFfrvNilpK8ZEoTfdntslW6sKXMO4gpjttz/CDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEKM3WcAHbR1WR7caGmCSHhhaVpI4e6mwRhE7xDYwvFRFVq3/ThxlBfFnBvf0fDiaY10FgKgzh1UOoad3qJbcvhLmCVfzZASxUkSDpvlEhHMy5GGhgO4tVLHQX4XF6VijU+8kMrtoHtlv+SR4XdiHndfuBY87fKNtB3lDrIxYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59eb501bcf0so1287586e0c.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2026 00:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470835; x=1781075635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVTm+HVXfWH2P4Im0jsyjBGPpAwX0VIXYMfcrROvkZ4=;
        b=GTyt60mNjVtbMXGrzgZPMJqEKZKuHZ8XgOGYSe+kn/NERu2YlMl3367JrWY6zI1mGz
         D5R8wkTEeaAJOm/XC/Rk8EjxxoHbO7V89us5r4EPxuqSXdgLmq53DAPYtOkRaRuYXpBO
         wNQTt8a8WgXdO1Dz5LUab5qMUvqceUidoIOG2TtFPoTVILY+E/sPcnyphHOQpslkirtQ
         EPpwXU/ncPoXlek2h736zMUgxvTdfr3cxd8rfwmmmKx058V8SHWGrRnWrNlZMTi8+0E2
         JDPoO6Go9RI1hM2x6tMlRliia7CATCuRVtc9Yqg+bFXNRf8VQWWCwf0X+CWti1zyuy5P
         e+zg==
X-Forwarded-Encrypted: i=1; AFNElJ8xqxyJeqiKO14vBH5BJJVKwiMd1XezeqV46rx8RPTAfUyz455CmAGlYVZ6AXSmIF7XSS2ktuDXLD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysBlUZBHLyk8wl4iJyqQCpa4gzFvT0OgYGaa1HQNTJWftwZZkY
	ZQQ+obmeom+jFlhxNUiAA1WJviuhZpjLrndlbkKxtuwZghJcjP+KT6+3rkpVh/YEOdc=
X-Gm-Gg: Acq92OH7R7lG+pQxwBUVDG2iEiMNa3VGSB+ZhLdlKbXB47Rn0qGxNljIyxqegcvGEEF
	euxiCVeR3YBuqKRI79pFoH9Pthf1zLqW2vWp8ofjWZxLEQFxGuvUJNsx77+kErjCxJ6/7bafpOC
	WvnXlG1Rr7vXB5GcdLeiAF3AfXvCQRkJHHarCbl3J5JxLFrVt86DFCah8i3Io6tTt+tmTzxH7Hz
	35bkbyrX1o6ZYnz2X0FLU2HnlbcB2A8EnKs9312u4FCfR8kZrJ9jw6vgPO0EMK6a94y4TBPaLR9
	jnVjONjynYBr6mAwlcOjGEFxyTuzQTr1LuZkZW3eEnwl21IaDTCubydlV1IyXEHEjTdeNQA10pQ
	/egv1+2MO901d29oggWT9ESMUaAK1CEOVXbNbcGZebgI2bTd4FHWM/ERjZEWjieQXQaJjyfWjaG
	B3sIIBoBVa46DAitAp+5AsE6catt+s/aC5PZ0n22hy/sptzejn/4iulYn1Ko2JPXkktZrfyp0=
X-Received: by 2002:a05:6122:d84:b0:56e:f071:d4ef with SMTP id 71dfb90a1353d-5a6e62bf36emr1029416e0c.8.1780470835496;
        Wed, 03 Jun 2026 00:13:55 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dcc34253sm1597535e0c.14.2026.06.03.00.13.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:13:55 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-961556c15ceso4441957241.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2026 00:13:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+HjJ8QgnJqLbo36odiZSyhzvlvocR1yYD/v2tql+cT/Sp7rAqCwnyFJSqzrB8Ntzeb7c4oYdyZL10=@vger.kernel.org
X-Received: by 2002:a67:e701:0:b0:635:1bc8:3568 with SMTP id
 ada2fe7eead31-6ec460bdfd7mr693156137.23.1780470834442; Wed, 03 Jun 2026
 00:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com> <TY3PR01MB11346485C16AFB6299B1711FD86132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346485C16AFB6299B1711FD86132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jun 2026 09:13:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFScg51Uj2_C9YmwAOfG1+pmGiHgEr1=s0UD=OwPb-uQ@mail.gmail.com>
X-Gm-Features: AVHnY4KTaTymKCx0LSLs6RhnIwDGw4kaIZ2uRjB878pxxG4jPILkeBa1s_xqOpY
Message-ID: <CAMuHMdVFScg51Uj2_C9YmwAOfG1+pmGiHgEr1=s0UD=OwPb-uQ@mail.gmail.com>
Subject: Re: [PATCH v17 00/17] Add Renesas RZ/G3L SD/eMMC support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"magnus.damm" <magnus.damm@gmail.com>, "wsa+renesas" <wsa+renesas@sang-engineering.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 3 Jun 2026 at 09:00, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Please ignore this series as by mistake instead of patch series 2
> I mentioned it as Patch series 17.
>
> I will fix the issue soon.

How? I am afraid the next revision must be v18, not to confuse b4?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
