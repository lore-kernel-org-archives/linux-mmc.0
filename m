Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4979351C1E
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704815; cv=none; b=iRJY4IzUG93wzJqzQquWu+MaFXQMGWGPkKg9IefbeXrtnlHe26oFWKbkwP4woGUYX0335gG9j7RHr+3SmRngLNHlyZB5QYFI8OUnwzFdszyYly0dZqUZYqsOM3KMXm60ubZJ11AFMVtXhT6NOQF0gnl9CEZHrhEMgy9ISp7YRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704815; c=relaxed/simple;
	bh=p0HvZ3sT7POUm4/0PI1XUJ7a2BU4q/k/Mg+JR9ylYyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMEybsd/eTyQQ21uTHjCH7F+l31heJisBSfXb52CxAnqqQsWOA4dvHoei8C5MK3yGAY24mbfoon9fwahumOctsdH+lqmxwrwE6JGGfA34SQq+RybKjaI61oVIpg8CZcSsur26N4fYLGyMjukwHM10uV5BVwD7sm4wH8Vwuv4HAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba4a1a0325so63279925ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 03:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704813; x=1780309613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N8nwhp2ksCBATTBgDUrbzFAvExrUr7ic1VBwQK9ofc=;
        b=Gu3zf6BC+HP+55hceWSR/UdIwEkDoiGdn/urPeAz4OJpnu977i1982O962ZXFHmVFk
         NhrKRSkm7DgrTmpnllk1In+BOF45WUyPxobRJFQTeqjOJihSoo/P5X5Ny7/eTYwBvV5p
         4Jj+1k6b6m2pZ3KvGFMx4bxPKzs4iz2rapiRP0lyB+OIIu9XdHFtJtbOSr64ZoQnorch
         WjRpFQeNTdq8JT30nM3RVslCd0Ld7nSfXKgpl9x0ZUogsvCjzKngkj4VZWnRbNIY2bgC
         krs7b9iK1Oz5n3hBllTAWrc08PTfcN1WpVfjvseltLBkHDKJeAnbqCqPgB4DrVZW7Ws8
         +FsA==
X-Forwarded-Encrypted: i=1; AFNElJ89UpLj71IiWba77vkAB8TQTtPIByjrtFbVyBiufa+hkg5jDTME7OY9F36Ko2t5m1ebpH029m9HA5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LiSKgKg+Gbtr5oZKITAxCwq3fqTARaCcH+rvV6v21+mDuezT
	W0Ifw1QeiurmLyucMsGDiN7i99KML/DW8dBTC9mbAfHs44C7VbDwsHUPGudOqbQL
X-Gm-Gg: Acq92OER75SVhT6eRLUWIMoE+a1N6FG6zPGAyiHnTrwcwnvQpuJqvtjqWumgLKTlMh1
	EwYHJ3j0F357EhBd99WY1N+lKA8PQPJWHN76bslA/gRwydFSCMnbHMFbhZ04/ViDRnKBCBrYHRs
	QlVTVWS53Za4bf6Kxac3NOwd5qEnliJOQdXNBTYrZ2KqLOtwcqiMYWX4XjKmw59dCrzOiW7AqsF
	OQShxT8yZU9rqeSa2/yYB/gjpr6gg0jklH4v2eMrR7U1KMTXuu02a52j/I0wXeeMW5BoEgOZiGt
	8HLkR0jjjAYfcehKvRsX9C+84BP1KZBPc/X10b0TOL8xmHSYDFYlwkK0pEIWh6az6JpB4+4x2R6
	v3yiim3Rp9vSDriYu4eNOBUkq9Rb33pRIGVZitxg+nHEkc3gfQ+0Et+fGIOQ1Lllf6sBnX694k2
	oS1fJH33QzYpoNHjSWOOvFUN8uScU2vqX29pF+cAMtzCuw4s+txJqmj5JwDHbMvmnr
X-Received: by 2002:a17:903:2f4e:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2beb06fcbc6mr153697385ad.20.1779704812913;
        Mon, 25 May 2026 03:26:52 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58e4fcfsm94765935ad.71.2026.05.25.03.26.52
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 03:26:52 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c822652f82aso7906093a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 03:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9VTDfwaCNsTTh5cX2ABO917Lx1MOhqN1MqwXs7R7lIjt4gX/+TdFz7SnKoOE2HMKLAL0NYEbkTJQI=@vger.kernel.org
X-Received: by 2002:a05:6122:2215:b0:56c:ce8a:b07a with SMTP id
 71dfb90a1353d-58660d810c9mr6371489e0c.7.1779704495972; Mon, 25 May 2026
 03:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdWwantdbvPSFoYm=+_OoQQkKwz+K=qwWgy-7tSp1BNJBw@mail.gmail.com>
 <20260522172000.15096-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260522172000.15096-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 May 2026 12:21:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrdPrtE-8ytaBA5oYsFa_1EyVgQTWM_9qFszwEf_u6FQ@mail.gmail.com>
X-Gm-Features: AVHnY4JxX69tsdj1KyIPYumyrvTwDTMHhV4blwWLghLppzdyXfjGAG938kQSX7s
Message-ID: <CAMuHMdXrdPrtE-8ytaBA5oYsFa_1EyVgQTWM_9qFszwEf_u6FQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: renesas: r8a779md: Add support for R-Car
 M3Le R8A779MD Geist
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 19:20, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> From: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
>
> Add support for the Geist board based on the Renesas R-Car R8A779MD (M3Le)
> SoC, a register-compatible variant of the R8A77965 (M3-N) with reduced set
> of peripherals.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> V3: - Drop pwm2 and pwm2_pins
>     - Follow KSZ9031RNX tSR for reset assert time,
>       FIGURE 7-5 Note 2 for reset post-deassert time
>     - Add RB from Geert

Thanks, will queue in renesas-devel for v7.2...

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a779md-geist.dts
> @@ -0,0 +1,720 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the Geist board with R-Car M3Le
> + *
> + * Copyright (C) 2025-2026 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "r8a779md.dtsi"
> +
> +/ {
> +       model = "Renesas Geist board based on r8a779md";
> +       compatible = "renesas,geist", "renesas,r8a779md", "renesas,r8a77965";
> +
> +       aliases {
> +               serial0 = &scif2;
> +               serial1 = &hscif1;
> +               ethernet0 = &avb;
> +               mmc0 = &sdhi2;
> +               mmc1 = &sdhi0;
> +       };
> +
> +       chosen {
> +               bootargs = "ignore_loglevel rw root=/dev/nfs ip=on";
> +               stdout-path = "serial0:115200n8";
> +       };

... with the chosen node moved to its final alphabetical sorting position.

> +
> +       audio_clkout: audio-clkout {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
