Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3B36C0C0
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635415; cv=none; b=I2PZ5d1PyN+PUWuNoT8lgBgTlmP8VNLMO6dK4aITXwwKJsM2c8R5/UMKT2WlyxHGGsulG/ebhHIrO5u3JrosfFDjUucdlT45CeFuUl4+Evv5E+J2djRptMF8ZQBsLyvefCOwUVv0q8X8R6FcQesloAlyb0iEDHVYtWgHXhvrOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635415; c=relaxed/simple;
	bh=sC1KLy2SPQ43D9OQaLHsL9GAH/uPG9wpQURfezxkw+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J58chwhhvhlAw2Ev2NoicEC929EDPJmkGT1vKA6Yr6nZboL1Wca2eE/XbAiqpiViIhhpnVXyXb7SRhDGtx/qXFPe4a2jk/O2MJc1Gjxb+7e1iLoT9TnBLv68rtqEBjmiftzXXJCbtJrCK4KK8TrjQkKwqUWBwVOJqdbKmKPl5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-563610de035so3045457e0c.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 03:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770635413; x=1771240213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFhQGFBF0i+66a0TJna2Rm6FRsUIJ3sMEDyWqu3+t6g=;
        b=AEghHiFKe5nm4JQE/o9a5PV+9WSvDFh83LZnduI0C9q22xak/nMlmcAHA791nd8H49
         r1AxzFY+ifZeP6eGGBtk1rAqNxy+Kn3y1oUYtOOtBNhdJieQTWc44AeCvItKHbJzUxe9
         6QXZQ0bbsL9/wP9ECjtDb14fs9irexsPqmCiUxqnJ51NgSGq3SKKV1qjfcVJWH12DT52
         rvBP1c8xO/Q9DrASHhI4qcd2C/iZyzfdlKtLG3fmyf34CoJPsIAK/NvYeeF7aqUNZHXo
         jkxUDbiiMxH+XDIst374OGxy68fh4LS88X54vCuR12YQHtFFXT2jigu0eehvU2eIrdoC
         zbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnI9Ku/vLY+YXWLhEIlIr+kIwHy3IgFfzkC1/G9I04CYjuakHjlHa2FNE999gNV8f8N7w+OyTomRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdLyF5xf7kHVxd5piVpVdSWSuF/OVYT/9VLuw+5ZYbghoqo/X
	9XanWZzLGsVOKPVgp47OhRLqRWcBMCvDkVtsftPcTWrGzoki5U77vzz097KxGUrY
X-Gm-Gg: AZuq6aJfP4ZJ3t+PxCBGfQ5rwmU57nr7zs7o0ix9B/7H9/Y0k83aRBJ/Qu1KEpseM6l
	886dX4+KJBWjnkT19Wgo5R3xUiL6qVmTl0NaY95Mp+LH3A3jBtVfchGop7HOAc+TotMCH33MU8U
	Qyb7SjevWSgaJ8gEDNkGpPnKCUumicoQNUXIsHwPQoTGfFWRFucJDK6n4jN4VX1TvN59V/btcZW
	1apvqRok58IuzUt4w6q6UDFnh1C0kPpS6UZz3g9/AycQfl5DsPM3XTlr3+XiFdSONFVgzz2Zgrj
	x5VMvdkKlXbpLvo8N7NC428SvpR6HQD6BQCuavYqDrYCO0mhOTUX09ZmDjdBWjBDBTt4cujyC8L
	4tJp3cm3/NpZOA2SzSmBlOpgPQ55yMyw7nLC2LJEv+2OgNSp818BMWRZvgBxhvHj+E134vObz7P
	ZspTRPlkTnbDKqm16d0PEetqgaBCxre2hrwBRPS+9Sl8LJgGQ1PPvn
X-Received: by 2002:a05:6102:3747:b0:5f7:2430:cba with SMTP id ada2fe7eead31-5fae8a60f02mr3408262137.12.1770635413472;
        Mon, 09 Feb 2026 03:10:13 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9490155748fsm3202385241.7.2026.02.09.03.10.13
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 03:10:13 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56637565faaso3895875e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 03:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3ek4TKpFnRl4/sJp5FYZefGPRNUGaTT6zovxepkgJMt+RSWNddLAJTkRrVtpcMpmhyzBGL8DexDw=@vger.kernel.org
X-Received: by 2002:a05:6102:f10:b0:5ef:ac78:3c77 with SMTP id
 ada2fe7eead31-5fae8aafb2dmr2699695137.18.1770635026255; Mon, 09 Feb 2026
 03:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
 <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com> <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
 <1a4288f2-ee5c-494f-9fbe-ea3a90a16014@solid-run.com>
In-Reply-To: <1a4288f2-ee5c-494f-9fbe-ea3a90a16014@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 12:03:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWa6o19+oX=-Hkpx+tEsnJ39vyi91FwbU+YHJqv=QsPkA@mail.gmail.com>
X-Gm-Features: AZwV_QiXoAPXWcsFJ5cXmi5LxanLCRJoL8Hmi_xM0cWtiaFZbVoUaSfpkEx2uEE
Message-ID: <CAMuHMdWa6o19+oX=-Hkpx+tEsnJ39vyi91FwbU+YHJqv=QsPkA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Mon, 9 Feb 2026 at 11:47, Josua Mayer <josua@solid-run.com> wrote:
> On 09/02/2026 12:17, Geert Uytterhoeven wrote:
> > On Mon, 9 Feb 2026 at 11:12, Josua Mayer <josua@solid-run.com> wrote:
> >> On 09/02/2026 10:06, Geert Uytterhoeven wrote:
> >>> On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> >>>> On 03/02/2026 15:01, Josua Mayer wrote:
> >>>>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling t=
his
> >>>>> option thorugh the kernel configuration without explicit "select" d=
river
> >>>>> dependencies.
> >>>>>
> >>>>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>>>
> >>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>>>> ---
> >>>>>     drivers/mux/Kconfig | 8 +++++++-
> >>>>>     1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>>>> index c68132e38138..e31c46820bdf 100644
> >>>>> --- a/drivers/mux/Kconfig
> >>>>> +++ b/drivers/mux/Kconfig
> >>>>> @@ -4,7 +4,13 @@
> >>>>>     #
> >>>>>
> >>>>>     config MULTIPLEXER
> >>>>> -     tristate
> >>>>> +     tristate "Generic Multiplexer Support" if COMPILE_TEST
> >>>> This didn't do what I thought it would.
> >>>> It was my intention to allow enabling this through menuconfig / .con=
fig.
> >>>>
> >>>> With the syntax above menuconfig shows:
> >>>>
> >>>> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> >>>> =E2=94=82 Type  : tristate
> >>>> =E2=94=82 Defined at drivers/mux/Kconfig:6
> >>>> =E2=94=82   Prompt: Generic Multiplexer Support
> >>>> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
> >>>>
> >>>> This means it cannot be selected.
> >>> Looks like you haven't enabled COMPILE_TEST first?
> >> Correct.
> >> But CONFIG_MULTIPLEXER should be visible always,
> >> not just when COMPILE_TEST is set.
> > Why should it always be visible? All users select it?
>
> This is not relevant for v7 now and can be handled later.
>
> It was discussed previously that drivers supporting optional muxes
> do not need to "select" MULTIPLEXER through Kconfig,
> E.g. the renesas sdhi driver.
>
> However other drivers are already selecting it even though the mux
> is optional, see e.g. phy-can-transceiver.
>
> In order to support muxes in renesas sdhi driver e.g., users must choose =
to
> enable both the renesas driver, and multiplexer subsystem via the
> configuration.
>
> The mux core standalone also supports a limited use-case without other
> driver
> interactions, setting idle-state e.g.:
>
> mux-controller {
>      compatible =3D "gpio-mux";
>      #mux-control-cells =3D <0>;
>      mux-gpios =3D <&tca6416_u20 0 GPIO_ACTIVE_HIGH>;
>      idle-state =3D <0>;
> };
>
> So it can be generally useful for a user to enable CONFIG_MULTIPLEXER.

Then please say so in the patch description.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
