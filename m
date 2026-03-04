Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAF1EE7B7
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642472; cv=none; b=cd1jycpMRwiO7HFiBhu3QirrAEfF/cFeUgMccsgecopwF565kFweB983dvJnUO46q8EKW9yajqOhDWjMOUWGOwX4GJjqYEnoYBkxE01jTPW9v6AEuvpinyyVPONtn0gyL4rQnw1fxBg0bdfL3kjDea7tenzVhsziy5UzEobLX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642472; c=relaxed/simple;
	bh=SM/Q4LQ/H8j6XmOswwrFxXe2Uog5f2j4sOGjUkxwQCM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIk2dENsfzQLkFZPN6baFMmC5IAUSq/Cp3amPe3tMBkGrVQyv9C2LXqtZ3vDErWPlDwxOeXX+m6N8Ib0uM5ZaCcu4yNtyKkoom03amuI9t0qDGNu37IuNFO1RJDW6mI4JMlEGpgBx2HXVrro37m3WPJhuI4uxylyRcE1EOAt+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FindB/f9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FindB/f9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A732EC4AF09
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772642472;
	bh=SM/Q4LQ/H8j6XmOswwrFxXe2Uog5f2j4sOGjUkxwQCM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=FindB/f91BXOuPQeKfShozKPm0I0nww2VKQal7bZSAPXWGWtdY6vA4sk8di8whmlZ
	 RV1MA6I9H3+gWP7oUcVzKM6ZQhDzH2M8nbcIJz0K8FH6rYjfGtRJk0jFqp2FPuu3mU
	 tXXmtNADsEXQPhsBt7dviC3eic9ZfOTt9VhN/v1M6Vv3hclKHTaJQb+2oyf1yHDl0x
	 PJaP7xJiVMGzUp3zdkYzjL5RjtCMLBOk2JRJT0+abQkXx6wPg0CJlWBNlIWTh6jbqS
	 VwpFO/CXQ//cLV8VKpPAszhpnF9kmnhSyLmN/Duy2LAmK7mNOAIWjrQLbJAjqmKOT0
	 PIS14F+JduUxA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a33a542aeso237211fa.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 08:41:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMkhtSLDB96fjrwyK8CbwDipwjomjtb6QePq7X/Nlp0VR3ZlPdItQv6bFyFXk4VpyOPCiCoV028IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhYkM0XgYagZIO77JVkwpe1l2PA2rY9SmIF0kAhi2jAIfP7lX
	YKg5cVKj91kk5NMfxcEfIIrXUtPQYr2h+7vePmx7NQpea3CZSlPYJDywEHl4og1PJEvnw+l279d
	HZz8iG678k5ZxY+BKeK/hqyA8WMSt0n6voBX68EXMTA==
X-Received: by 2002:a05:651c:e17:b0:37b:970f:d33b with SMTP id
 38308e7fff4ca-38a2c58d8a7mr23564001fa.3.1772642471248; Wed, 04 Mar 2026
 08:41:11 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Mar 2026 08:41:09 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Mar 2026 08:41:09 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260220194725.1341281-1-sergey.suloev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220194725.1341281-1-sergey.suloev@gmail.com>
Date: Wed, 4 Mar 2026 08:41:09 -0800
X-Gmail-Original-Message-ID: <CAMRc=McNXzDE48zX=eH_bfg+KBN=2-yeW6bjL1L=hCmHu6xv8w@mail.gmail.com>
X-Gm-Features: AaiRm52m3UMVyoSw5MtewEHGQ8Nw8pxDB6TbcL60L1_Zsndcu_PLovKnHNNp9Ls
Message-ID: <CAMRc=McNXzDE48zX=eH_bfg+KBN=2-yeW6bjL1L=hCmHu6xv8w@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: fix probe failure when
 CONFIG_RESET_GPIO is enabled
To: Sergey Suloev <sergey.suloev@gmail.com>
Cc: ulf.hansson@linaro.org, catalin.popescu@leica-geosystems.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Feb 2026 20:47:25 +0100, Sergey Suloev
<sergey.suloev@gmail.com> said:
> The driver uses a heuristic =E2=80=94 checking if exactly one entry exist=
s in
> 'reset-gpios' =E2=80=94 to decide whether to attempt reset controller API=
 usage
> via devm_reset_control_get_optional_shared(). This is semantically
> incorrect and causes a permanent probe failure when CONFIG_RESET_GPIO
> is enabled.
>
> When CONFIG_RESET_GPIO=3Dy, __of_reset_control_get() intercepts the
> 'reset-gpios' DT property and attempts to register the GPIO as a reset
> controller via __reset_add_reset_gpio_device(). If the GPIO controller
> is not yet fully initialized at probe time, this returns -ENOENT instead
> of -EPROBE_DEFER, and the error path does not respect the 'optional'

If this is what's happening, then it is not the expected behavior[1].

> flag, causing pwrseq_simple to fail permanently rather than defer.
> This prevents mmc1 from probing on boards that use 'reset-gpios' for
> WiFi power sequencing, such as BananaPi M2 Magic with AP6212/BCM43430
> on Allwinner R16.
>
> The correct indicator of reset controller intent is the explicit presence
> of a 'resets' property in the device tree node, not the count of
> 'reset-gpios' entries. A single 'reset-gpios' entry is just as likely
> to be a plain GPIO as multiple entries.
>

Am I getting it right? You have a node that has both the "resets" property
as well as "reset-gpios" with more than one entry? If that's the case then
it should be fixed in reset core, not in a user because there'll surely be
another one in no time.

> Replace the ngpio =3D=3D 1 heuristic with an explicit check for the 'rese=
ts'
> DT property, making the behavior unambiguous and immune to
> CONFIG_RESET_GPIO interference.
>
> Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset contr=
ol")
> Signed-off-by: Sergey Suloev <sergey.suloev@gmail.com>
> ---
>  drivers/mmc/core/pwrseq_simple.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_s=
imple.c
> index 4b47e6c3b04b..780c8818a273 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -124,7 +124,6 @@ static int mmc_pwrseq_simple_probe(struct platform_de=
vice *pdev)
>  {
>  	struct mmc_pwrseq_simple *pwrseq;
>  	struct device *dev =3D &pdev->dev;
> -	int ngpio;
>
>  	pwrseq =3D devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
>  	if (!pwrseq)
> @@ -134,8 +133,7 @@ static int mmc_pwrseq_simple_probe(struct platform_de=
vice *pdev)
>  	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) !=3D -ENOENT)
>  		return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock no=
t ready\n");
>
> -	ngpio =3D of_count_phandle_with_args(dev->of_node, "reset-gpios", "#gpi=
o-cells");
> -	if (ngpio =3D=3D 1) {
> +	if (device_property_present(dev, "resets")) {
>  		pwrseq->reset_ctrl =3D devm_reset_control_get_optional_shared(dev, NUL=
L);
>  		if (IS_ERR(pwrseq->reset_ctrl))
>  			return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
> --
> 2.43.0
>
>
>

I think reset core should check if the client node has both "reset" and
"reset-gpios". If so - it should assume the client wants to resolve "resets=
"
and only fall-back to "reset-gpios" if there's no "resets" and number of GP=
IOs
is 1.

Philipp, Krzysztof: what do you think?

Bart

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/reset/core.c#n910
