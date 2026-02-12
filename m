Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D41D61A3
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915204; cv=none; b=ItqfMyc2cV40kjfMcZMmCxUAFe5csyk26Ue/8I2lnb2C7n0YuBz8jfhk0dX9BFLaPV8hBaWoB3N5OUSgbrx3NoFtMuqy+z1+Y1WxP0L8vvjUCVTmUYNLFCKjTvG6CQVziJL6ibfW3uRMbKgsBEDEy43E9MJNHCg2oVDMRQQXDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915204; c=relaxed/simple;
	bh=FavnLYuCSZbZEB88+6M4JKOu7/zHNtiz8QGLBab5uI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUncaF5q/SKEA8frqWWwiNpi9SKZGnRfttlbUVZDoYLemAfa8wqMdOeS+z5GQgQm+dTc4TiZE/p640YA+Xu+LwHYb2DTW1FtP8KVts+KdBu/kC4wP8StFCu/LbgnCMdSzOCIQb4z2qrFjGvIqzJXj8N4nsNv8zKYGdwDRfa8+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56637565faaso61653e0c.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 08:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770915202; x=1771520002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om3cuNbQzAgOvOQckRciuNr9O8eg7IAaHrWKXJVxB8U=;
        b=VU5lEmlkO9uMvb7WEi4Vq9bDzejY/La9oHLqjRzc0GpmEETfT82TI1ffK/Lsjx/HVO
         e9A+n70ZCRcHM5xLAgDyweJ4kgIcxONNSgvhgC7TYa6/avn6kOnY6JzeQcGh4wg32Rra
         61xTLqDL/F/gcSZGibDuJ04N+R7GfLgikDvgpJnVSvV6aH9gqSKpD0XG8YrsvpdDXbW6
         1yRCI9zH1awq00zshUYJ536V/pBsZ9G+XAKfn7JyySrJT8Z1hccHJdRxI+SuSwpw/b+J
         2DQdG3ozi4biIGn5lLpfhGIP8H8jS6buBB9OiPzvW5wjatxvaoMztvTj3TMkmL/39eG9
         yWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVwLc956OtyIGt/mQKUnRGUFTLk16x8aK3+vG9I8nGOlwBlELE/Mg8BHCQ1CKBuAM34zO6AGunvbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysF+51HL3EYaDjxwbBl8oTW2nlB18cxS5mzhZx0HZ9w1U6d6Gn
	BXy5jzHScbkFGXvSXWlH6vlArtAS+5IOHztO8Xp+kFnnM0ddR41XkWh0uhoL4QjR
X-Gm-Gg: AZuq6aK1ADYkmQgNFrZC4pjo3MRO3KP2LHvZGbzt6uuoRexS5vykGfztOhb8gXryfTJ
	m/vrP2p0Oq5M6CUpwrvQ+BMch3Vf4s/JxyvBxuS2leeTG6l8X0sjDQI9NN4363EdpuRSbPMud2e
	tWf/vHJ86Pu6mfmsq2t9AQCl0jHpAY0h1u/9JL9naFm8IVSj7YtTPAqrmk92Yfy1LyDvhxsMT1g
	XdUnXjHIl/xyurU1TYnrsXcejmnmST51MEZQ0+xFyPwi5xK2B+167kexmKaNK09IxOPGk7KyvYI
	YLBa20eS0efL0nbTHFG962IpWQ/vUuugtB92lY0LLrP4aHYRMNFKG5no4KEIuPtldmFjn6xSp1L
	JjGbsEmsQqMWLoVc70suWg1iNZiGzExTtA9/sLTLGseomXml0rcZSiSGdOBlp444t4FmuOGOGHt
	UEmUN1htL1uE9vy0s3mYjScRDiB8CKTNXgWfpy5kv5B6r813E8PUzkkk1WeaT5
X-Received: by 2002:a05:6122:2a0e:b0:563:8335:9ab7 with SMTP id 71dfb90a1353d-5675b7e678emr939626e0c.19.1770915201295;
        Thu, 12 Feb 2026 08:53:21 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674bc76b6asm2069404e0c.0.2026.02.12.08.53.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 08:53:20 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-948d0d5d4d0so21683241.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 08:53:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCNMNHjwcRs+LKUybhtPOgj9WjfLfxaYY4t9Tq3djmlJ123OAOzoDDuLX73Jm8m6giRhxRWUImsV4=@vger.kernel.org
X-Received: by 2002:a05:6102:3051:b0:5fd:f8d6:e5d7 with SMTP id
 ada2fe7eead31-5fe003fb1fcmr1021759137.11.1770915199593; Thu, 12 Feb 2026
 08:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
In-Reply-To: <20260212164823.mbeycqwzsy2dfq6e@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Feb 2026 17:53:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
X-Gm-Features: AZwV_Qjd18dp3H6_yOLJUoqzfa3vu8ojTLTUkfH0N1bdOdZMnHdC-jkEvP2Togs
Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Thu, 12 Feb 2026 at 17:48, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Sun, Feb 08, 2026 at 05:38:56PM +0200, Josua Mayer wrote:
> > Rename the temporary devm_mux_state_get_optional function to avoid
> > conflict with upcoming implementation in multiplexer subsystem.
> >
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
>
> In the future, when you have a series with cross-tree dependencies,
> please try to think of it as individual mini-series for each tree's
> 'next' branch, and specify clearly that you need stable tags (to be
> pulled into other trees). Telling maintainers what is your expected
> merge strategy helps avoid making mistakes.
>
> For example, if you did that in this set, you wouldn't have missed the
> fact that in linux-phy/next, phy-can-transceiver is _not_ the only
> occurrence of devm_mux_state_get_optional(). There's another one in
> drivers/phy/renesas/phy-rcar-gen3-usb2.c, and that should be also
> handled in order for trees to not enter inconsistent states.

To his defense, the one in drivers/phy/renesas/phy-rcar-gen3-usb2.c
is a recent addition.

So this is yet another case of "convert all current users" (i.e. those
present in the typical subsystem base, typically *-rc1), with new
users popping up in -next in parallel, which happens all the time...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
