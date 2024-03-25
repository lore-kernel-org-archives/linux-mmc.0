Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52D13CAAB
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372797; cv=none; b=QF9Jiz0JUOgtCDtIwceXl3d8iVBEIP7Rb8lXtYeSo7MOoDkOO2AlY9PFFCc9HF/8JYo/f2c67MhSNwhmo7S7G7NWnnZhTGNS9sSnW4aQVaJigYHjTlz1vQ/q5C8kFNs13ZUHTqhqc4CFCajaf9RIjCC0ho3T0v+6X8nQT4x3Cdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372797; c=relaxed/simple;
	bh=T0UhGD46y7GnmjcpACpO9YkO2PsWjjjy6i5a75FohHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZdwLiZa7HpcRmQoEK84tc7Ck7ppXLn3W7tuEhwtW4K978MuxB6USeULHuBADZuc/HQlnwJstl5o47tPbo4473kLSqKE2lVG8et0kLLkZZmYFepGpEye0Lj5kxGSOiqEWQJqO4J/pZKRYAGKtVw2RK0rqewMSkRBOH5v+bGYDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBswOZdo; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBswOZdo"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc236729a2bso4128270276.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372794; x=1711977594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yxBqMV2tXP1EFJC3ffAea+Nlp68o2kbIX/WBGOrDI24=;
        b=EBswOZdoXYXiAgsTBQJ0rKDwO4neaTATSCscl4tXH23JK6Y1rcM97BjBO/vIcyz/yD
         BjrwdtUpfzVepNKG/N4n+R2Tmn22Nw6G783FFvEzHzxJCFYyvTTnFFe9QDsJAulDqCKu
         1bmwuk3s5Bl87G1K9QeSYouBhGUBp7XmXsuQlg1y9PuIACdYsoIjaU7a4Xn2e2s7WTga
         5/zsGXO/8lWlovqTNT7xGFuS+vxBcoV5RZor5f63yz4J29mk1R1BDVN7EDV91V5/4NFw
         SeLogAkHyA9fhfa+TO96j6aljBhcJeZraJmJEpExV8Yr+2dr3rrGxJFLlPJ5AttsfgD9
         GbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372794; x=1711977594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxBqMV2tXP1EFJC3ffAea+Nlp68o2kbIX/WBGOrDI24=;
        b=wopMfItLzfjVGLggOWeEoRzMi3r6B7LbeGjeesMS54EzgtmiERgH9co2jXBkum5yzb
         512nms+u74JmY9LfroEz258fD97AttWvFPDSY4ZbB8HbK7lb2qBC41AJTNV7q2S+7yOi
         sGRhZyFUm8kgJQLRIB5fI/pjwfd/sDYF5HtnJU0zUrJZJyMsWKeb9blaSy54/38LI5RW
         wmZBcrQQZU8Ey9zxUJVfWo5WC117Gt+SCwto2XlpjDBOHNMjLChCKYQoSQ1tgqAeh/Uk
         nlr+OREztpYXO6zDp9b46goZJ3McgD3yT+D4CYSRBL93aY9rHTMKVCU0+NTlvJDAGItU
         SzCA==
X-Forwarded-Encrypted: i=1; AJvYcCVbYwamE5P9cS+DYoWzU0c8FtDVB+XrMrbYuFavMT1Pq9zur5BMwFq4+G5XgpgVGYLbCYwyeys2NY6EIoduM5UL0nUMSmCH3k6I
X-Gm-Message-State: AOJu0Yw2c7iTxvvOjg9cPkjcxPp1tU0eUn7f+7/F19OMB1lNt/SuUQd1
	GbpTVffx6eKs8IYc8arQ3in8W+47Bjo4yTS6HphthJxSOHSJHUmt5ldWooqn5sTARs06Bh/fcb+
	/WXH1d6khWJrPZ5tTHP6xHbbvNSOPYOM1uAac5A==
X-Google-Smtp-Source: AGHT+IGHYRk03A+ebdrgDqCegMS+TQhHjy1L3Fp6OrAoZ21JkL2vjd7xmwf3RER4jqhhXfsQH0CLxSd+Wsa60dSp6/U=
X-Received: by 2002:a05:6902:3ce:b0:dce:53c9:4d9f with SMTP id
 g14-20020a05690203ce00b00dce53c94d9fmr5372283ybs.58.1711372794518; Mon, 25
 Mar 2024 06:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324214329.29988-1-wafgo01@gmail.com> <20240324214329.29988-4-wafgo01@gmail.com>
In-Reply-To: <20240324214329.29988-4-wafgo01@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:18 +0100
Message-ID: <CAPDyKFoSB3+jqw+cmc7x6NMSV9tegK=c-nUjC2pXiYFUzjEM4w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, Marek Vasut <marex@denx.de>, 
	Marco Felsch <m.felsch@pengutronix.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 22:44, Wadim Mueller <wafgo01@gmail.com> wrote:
>
> Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
> we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
> driver works also on S32G3 platforms.
>
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 82eb7a24c857..466e7157308a 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -90,6 +90,9 @@ properties:
>            - enum:
>                - fsl,imxrt1170-usdhc
>            - const: fsl,imxrt1050-usdhc
> +      - items:
> +          - const: nxp,s32g3-usdhc
> +          - const: nxp,s32g2-usdhc
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
>
