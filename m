Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030AD37C0F3
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048990; cv=none; b=qRkgT59kdAW5HAeX9EeT9nGYaL4aQlvwhpBK7feLb0zHn4xz3sXgT+RYr1Ljft8s0rXx0HXwn2PvKFCw6vxk0t/jG1Lhyyvc1Z9SUHPLv+lA+F60ze42R3FrNoZ3laSc2qCWzqwIqns2O3GLWdSYtrAhDmALY1SaTxnsbpivS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048990; c=relaxed/simple;
	bh=MLEjwEkCyE8tSQkNhVK9VSgVCJg/jYUFTlBSNNFJ0Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZaJYCCjge7397qTUGcfWeeA7S07RBvObrBHLWclenSxuoRlzq2eOVtiS8nL4DUeAoKZgwYc0CKqJhuvWySISrHbJvvw0ayaFF3KhC+H7Rke/WOgMwrRO8dDg/WP6bDkvc0JDSBzel38zAss6fVGj2kaGcX+t5YfymE96jieEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTPlSE/s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTPlSE/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747A2C4AF09
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773048989;
	bh=MLEjwEkCyE8tSQkNhVK9VSgVCJg/jYUFTlBSNNFJ0Nc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tTPlSE/s0XKnCPujPaDcMk97XcMjeJU3rCuL7hp0sCzp1dS46slFOrVGK75Nu6bxB
	 HHG99Gz0THlhQ8bGr+Uh96iW21v9zbHE6tU7zQYfv6Amjt2yNwoQQ6HmJoT1OHSYcu
	 rH6jmChdS+GsOHUqjR0ZsLp6wPEhBT22PrEONZmwr9VkM+wuVxhiPdPBJvULlXMAWF
	 VHhsaVzl6B7HZVRS0slz97C/zdkWpnPDK4edAl2vOxti8mwO5LV+8MJAgvZe46pUVH
	 AF5fKURkAHelgHsL5NiQ63dSttS8nb5PMyW5TQ3IHx1Y9Sxp2eSVe6BGNSLxE8VQQo
	 bnfgb4orbugvg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13323ba85so4838794e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 02:36:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU53wB47dYQNJfvlJ29LyHbxbkZ7/wG7Cz1+hYuDNsUROBfYh3A9vB6Q2BOgZ28aEHB8SsbS5PsCUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXI/563dOgw4/1xbnU2NS8K2oMwbtkU02szBHvAmh9HSLomuk
	380/xSpQ+QkqiK1atbU8vq3RLbkUZgWNDDXqMDjjETqd8I6Uvzpe7FRK0mtPOgPiwzySixjSjny
	Og5KkdsSF4sjUTqKsyFngCsK+1r+ptozrEoL35ksEwA==
X-Received: by 2002:a05:6512:3409:b0:5a1:23fe:b04c with SMTP id
 2adb3069b0e04-5a13ccb9aa1mr3231141e87.18.1773048988118; Mon, 09 Mar 2026
 02:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220194725.1341281-1-sergey.suloev@gmail.com>
 <CAMRc=McNXzDE48zX=eH_bfg+KBN=2-yeW6bjL1L=hCmHu6xv8w@mail.gmail.com>
 <923d35430a633af4064d671f1cac1d47780cd14f.camel@pengutronix.de>
 <CAMRc=MdAp9fgp2zoU0AXow2avejqB=ZjiKanVgFVxokcmFAvuQ@mail.gmail.com> <8d991c0f-3244-4c0a-af4a-8d7aeb8ca35b@kernel.org>
In-Reply-To: <8d991c0f-3244-4c0a-af4a-8d7aeb8ca35b@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 9 Mar 2026 10:36:16 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf+9iATXoeGVzQHbYFo3vDz6jQc5Mj_XK8=c12JsPs7eA@mail.gmail.com>
X-Gm-Features: AaiRm50zz6lWKnVGQPbWBEmMzHV9G7-KzS0-lBuSl8iC5zH04uY153QQqA30zm4
Message-ID: <CAMRc=Mf+9iATXoeGVzQHbYFo3vDz6jQc5Mj_XK8=c12JsPs7eA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: fix probe failure when
 CONFIG_RESET_GPIO is enabled
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Sergey Suloev <sergey.suloev@gmail.com>, 
	ulf.hansson@linaro.org, catalin.popescu@leica-geosystems.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:46=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 05/03/2026 11:04, Bartosz Golaszewski wrote:
> >
> >>> Philipp, Krzysztof: what do you think?
> >>
> >> I think this is a missing feature in reset-gpio.
> >> This driver could fall back to to devm_gpiod_get_array() also if
> >> devm_reset_control_get_optional_shared() returns -ENOENT instead of
> >> erroring out (maybe -ENOTSUPP would be a better return code for [1]?).
> >>
> >
> > I did not write the initial version but Krzysztof: is there any reason =
we only
> > support a single, two-cell GPIO? Would it be problematic to support any=
 kind of
> > reset GPIO setup?
>
> It was only due to limitation of my initial solution - see even a TODO
> note in reset/core.c. I think the problem I had is that GPIO specifier
> without flags (so cells=3D1) would mess with GPIO_LOOKUP(). And if we hav=
e
> cells=3D3, where do the flags are? If you assume flags are last argument,
> that's an implied ABI encoded in the reset core.
>
> Well, heh, implied ABI that 2nd argument are flags is already there, so
> the code is partially hacky, I agree.
>
> So honestly I believe that GPIO core should handle all this mapping of
> original reset-gpios property into platform data to reset-gpio driver.
> That's the answer for your question "would it be problematic".
>
>
> For reference, original patch:
> https://lore.kernel.org/all/20240129115216.96479-5-krzysztof.kozlowski@li=
naro.org/

Philipp just picked up the reset core rework, once it's in linux-next,
I'll try to extend the support to accept multiple entries in
reset-gpios.

Bart
