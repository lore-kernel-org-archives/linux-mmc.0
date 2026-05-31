Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD333A9D6
	for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217044; cv=none; b=l+7KKBGgy+26mJbIH8VbfPbolLCErejWF75lArM5XDTaSgTOwC4W76ftqHEXE5dFkc3g1G4e4PRcXpjOFlLd76/lktRbWRkYok/HgxqBoZDKhTEeBBbaeCQfpdATeAz0t00STCEcD8t83V38fAlTHicvW2HX7AGkJUCFXDpTmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217044; c=relaxed/simple;
	bh=VRoCK7u4CxDAaDhSmUkIbsYdQb82r8KYQ5s/yqVlez0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FP3aCGzu4A8AZuiVuxFTnMpYI6F83dJZVa+vZtc2mjJcyz9kCuwiQIqsWmuLpdv9g7dY6jMZMdnn+7YfhBYO2Fo3ImBPcAm7XCnPKRPWw5qf1cz+AYxOqe1K+qqnR1732dfcAqqi3+MoZseP+wXw8AG5gXYMPYrmGySST/RXKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d0db9372so81789691cf.2
        for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 01:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780217042; x=1780821842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBvM2ORohpXQB4d5IQuHmDJKKy3F6iaCOKJvYc8ytZg=;
        b=n5wyLs9JBhMCzYWrUxBoDrZkJ4Fm644G+elU2yhMktLdqzLFExu7Q2/O/PvNY4RyOe
         ZLSFWQsdMC32g1fQ2QI8XnoXqE/MIZG7Oj919YgJMUVanAdwyIeBHEvC9KmVX4DkxgIV
         GxJqieTtNAERWSYQHAkR80T3rS2PVp8tkjCYvQQGUbLujEIvpyzy1SCnJ7+G3/Onv6EA
         eDc6jxQkubKOJCHAvEdRMWnGKxVADfarYq/6zu0i8XzPZ30rBvZpQMRr5evp0ryT/QsN
         AJU4JFy6HjVtYAFmDZyO79J0oJgVnBwSbQE45tBDcxi6nD/BcC87q5n0vwVPP08Q23os
         opFg==
X-Forwarded-Encrypted: i=1; AFNElJ9ch5Z18FADmNfXPb1xmQTgMxytFPbH9VMbckkQd4uvhX+T/TKlBU1C7gR1H57cBHZe/k6N43fnUqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8SbIBbSLqKAVffdYMGEnJ3LJmObfomflgRniLEMwM941hS2t
	WpoZdzbVdLhv0kW/4jgkJlIa/eW7AEvEeBaOEiEu5we/vmRjZVeI+z4ApBhTzTKL
X-Gm-Gg: Acq92OF2M3bmpxFnjIv/+XhYLafHemc9IJqK+HQmx5SO7OFHrBZnXSMxz5M4eUfO34H
	kV0AM5YUDm8kM+Exd2Pm/Frihr+dLtKUmivll2ocDauW3MSxRmmnLIxTQWcvGMWx7i3opQJQdFK
	wi68trdg/3nQ6J7JngB1lgNmM8Ww5OCJ8qsL3CroPUrKz+Tl2suzPmieYua9XcFyeRHv1dhfock
	9IFjj63sq4fkvU1erApl2txU5axnZbB9dHmwW1YUifs+dS9+8ME4iYD+rjLcyJm/qaehtXBAS/j
	d+mrrQ3ZdY4dK3Qce+MUoAFi71PXqMnFYdSV9CC3H3rnCcw/mCsxU1+tg9Mmjd8PuOC3Bpi4MeU
	Rcl4+4Sed/qqHVZwc/7+e8ckXADuKVLYg0tdZvg86A93bSaavUZPDtp0aG7hC9w3UjvxqnjTXUj
	9+HZXqCA0G3WM0xGBSKnE09Ah0YznA0oElGXj5aCa6xrIrMOPoO42E3JODWpQrHIEKWgc5RMWlh
	5g=
X-Received: by 2002:a05:622a:60f:b0:50f:be4f:465b with SMTP id d75a77b69052e-5173a7ef056mr92362351cf.33.1780217042183;
        Sun, 31 May 2026 01:44:02 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea227f2csm63139076d6.40.2026.05.31.01.44.00
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 01:44:00 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5174a0b39a2so4421261cf.1
        for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 01:44:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/tvrh6mirFSmtqZWzXH7Es9Juca5aXC/Hmj9GGs9ADMlhVY+qeYDJ1vADyLjnpRZDGfYLal9EyDsg=@vger.kernel.org
X-Received: by 2002:a05:6102:5344:b0:631:4cda:3ebb with SMTP id
 ada2fe7eead31-6c693a257bfmr2158834137.24.1780216616348; Sun, 31 May 2026
 01:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org>
 <20260504144534.43745-4-marek.vasut+renesas@mailbox.org> <CAMuHMdWdqDpU+AZrwz5ccbZPjJfp5DspoVscYi=Q+w-nniuuCQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWdqDpU+AZrwz5ccbZPjJfp5DspoVscYi=Q+w-nniuuCQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 31 May 2026 10:36:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcmFz0vr+YadbKOy111PgDFYCm6kgRMWjKxyNj4mxbWg@mail.gmail.com>
X-Gm-Features: AVHnY4JIRr68RiPmOxbgFI01Y083MJgBCtNRl2Ceai1FVE5g6dLCk5lLsnDcPaA
Message-ID: <CAMuHMdVcmFz0vr+YadbKOy111PgDFYCm6kgRMWjKxyNj4mxbWg@mail.gmail.com>
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

On Wed, 6 May 2026 at 12:19, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 4 May 2026 at 16:46, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> > Document backward compatibility support for CS2500 chip, which
> > is a drop-in replacement for CS2000 chip.
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
