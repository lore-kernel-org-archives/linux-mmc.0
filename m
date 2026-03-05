Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABB374191
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705081; cv=none; b=IprjvlL7H2UmQIz3s1HfbR7ozrzuKAbchW//akZ2c7Gqm8gam8uwceo7tFLuWwgPChJchHs9Sr2ndgR8RabU78g/bUxhE5GwrgieBzzerTXrqMGicMyBi7YdYjVTM0eoedKjgD3luh/5AkjG4DkxvVZKnnNPEsevJiAO1fyaarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705081; c=relaxed/simple;
	bh=0d2hmGJkzrPu0JbqS7/7e0eBjh8hrdRKF9PZP3WEdWw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhU2js8r/YTMwjW1FdMoKicUtrASh/Rp4Sc2z2m7abXKKvxBCuYxLh/0F6stsNPX2uAE119ZH6VRJb9PjU94mGk9aNds0VRANZH0m6Uy+CGgbrCEnR4j7HQpS07XKimCg1hhjCUIJh2NoN2nZlqAY/OB6JOakX13qxnzWxvD1kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/+AS9bf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/+AS9bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB0EC19425
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772705081;
	bh=0d2hmGJkzrPu0JbqS7/7e0eBjh8hrdRKF9PZP3WEdWw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=O/+AS9bfLCH7x1I1U46bO2A86IkXlNB/FNkRUg1FJO7E3jRV3EQ4zWoN8bGqwRTvV
	 EmXFE2Y6WrKPJoyrmcv8h4wxXB1ThiBCfgEpMD1G9AjYLGVVk1sjiyT6VCw1kjOZdJ
	 ntsEhuSn9/Jc5y/8jmXiHJlgZ84JlLT4GCOR0CmOGvVjF9JoT/+c/5R+rPKcOoIp2R
	 v94NtxtcO4v1BrPT/kwIpWk7VPu85pV5i6WCoDXRJ/cF+HtinUAjNh1XK3wMHhZyX/
	 tStj924Y1O2zuG7q2Kx7CjXg4tVVYCU6PKfdksP3c0v5C2pthN2QugbL0mljeUZ6e4
	 qYD0CO5zJvd9Q==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso20345941fa.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 02:04:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWA3ysP+t3CkPd5vDdPvLXhEL3gwiNcl8ft/+IUjmkwxkhCCviyXadiaUyxdv+ReS55ARd0sR6yn+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXHWcF9n8WsuryINj2SmVHLyPjreG6LFCRXiu/rfmKTK4LLVja
	5WpE+6GEB12ORDwpjbUsnbcRz9IL/+I6W45uYnv8abdsii+Oq7FhuhRDf7jGxk8kImUwTDz90lT
	jubTIqW7kb6uZdWNrjpiDMbbwYQlT5myot19J84HdbQ==
X-Received: by 2002:a2e:a98c:0:b0:38a:1a50:d843 with SMTP id
 38308e7fff4ca-38a2c7bd73bmr32104591fa.36.1772705079815; Thu, 05 Mar 2026
 02:04:39 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 05:04:38 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 05:04:38 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <923d35430a633af4064d671f1cac1d47780cd14f.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220194725.1341281-1-sergey.suloev@gmail.com>
	 <CAMRc=McNXzDE48zX=eH_bfg+KBN=2-yeW6bjL1L=hCmHu6xv8w@mail.gmail.com> <923d35430a633af4064d671f1cac1d47780cd14f.camel@pengutronix.de>
Date: Thu, 5 Mar 2026 05:04:38 -0500
X-Gmail-Original-Message-ID: <CAMRc=MdAp9fgp2zoU0AXow2avejqB=ZjiKanVgFVxokcmFAvuQ@mail.gmail.com>
X-Gm-Features: AaiRm515nCAy7JdlLp-3C1vI8S45CKXCdjxvF6QLRhc-uJL5pXi7PbN_GW-1SFY
Message-ID: <CAMRc=MdAp9fgp2zoU0AXow2avejqB=ZjiKanVgFVxokcmFAvuQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: fix probe failure when
 CONFIG_RESET_GPIO is enabled
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Sergey Suloev <sergey.suloev@gmail.com>, ulf.hansson@linaro.org, 
	catalin.popescu@leica-geosystems.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Mar 2026 10:43:54 +0100, Philipp Zabel <p.zabel@pengutronix.de> s=
aid:
> On Mi, 2026-03-04 at 08:41 -0800, Bartosz Golaszewski wrote:
>> On Fri, 20 Feb 2026 20:47:25 +0100, Sergey Suloev
>> <sergey.suloev@gmail.com> said:
>> > The driver uses a heuristic =E2=80=94 checking if exactly one entry ex=
ists in
>> > 'reset-gpios' =E2=80=94 to decide whether to attempt reset controller =
API usage
>> > via devm_reset_control_get_optional_shared(). This is semantically
>> > incorrect and causes a permanent probe failure when CONFIG_RESET_GPIO
>> > is enabled.
>> >
>> > When CONFIG_RESET_GPIO=3Dy, __of_reset_control_get() intercepts the
>> > 'reset-gpios' DT property and attempts to register the GPIO as a reset
>> > controller via __reset_add_reset_gpio_device(). If the GPIO controller
>> > is not yet fully initialized at probe time, this returns -ENOENT inste=
ad
>> > of -EPROBE_DEFER, and the error path does not respect the 'optional'
>>
>> If this is what's happening, then it is not the expected behavior[1].
>
> Is this -ENOENT returned because of #gpio-cells !=3D 2 [1]?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/reset/core.c#n883
>
> It looks like it [2].
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi#n103
>
>> > flag, causing pwrseq_simple to fail permanently rather than defer.
>> > This prevents mmc1 from probing on boards that use 'reset-gpios' for
>> > WiFi power sequencing, such as BananaPi M2 Magic with AP6212/BCM43430
>> > on Allwinner R16.
>> >
>> > The correct indicator of reset controller intent is the explicit prese=
nce
>> > of a 'resets' property in the device tree node, not the count of
>> > 'reset-gpios' entries. A single 'reset-gpios' entry is just as likely
>> > to be a plain GPIO as multiple entries.
>> >
>>
>> Am I getting it right? You have a node that has both the "resets" proper=
ty
>> as well as "reset-gpios" with more than one entry?
>
> According to the mmc-pwrseq-simple binding doc, a "resets" property is
> not valid at all. Apparently, this is just a "reset-gpios" property
> with a single GPIO with three cells.
>
>> If that's the case then it should be fixed in reset core, not in a user
>> because there'll surely be another one in no time.
>>
>> > Replace the ngpio =3D=3D 1 heuristic with an explicit check for the 'r=
esets'
>> > DT property, making the behavior unambiguous and immune to
>> > CONFIG_RESET_GPIO interference.
>> >
>> > Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset co=
ntrol")
>> > Signed-off-by: Sergey Suloev <sergey.suloev@gmail.com>
>> > ---
>> >  drivers/mmc/core/pwrseq_simple.c | 4 +---
>> >  1 file changed, 1 insertion(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrse=
q_simple.c
>> > index 4b47e6c3b04b..780c8818a273 100644
>> > --- a/drivers/mmc/core/pwrseq_simple.c
>> > +++ b/drivers/mmc/core/pwrseq_simple.c
>> > @@ -124,7 +124,6 @@ static int mmc_pwrseq_simple_probe(struct platform=
_device *pdev)
>> >  {
>> >  	struct mmc_pwrseq_simple *pwrseq;
>> >  	struct device *dev =3D &pdev->dev;
>> > -	int ngpio;
>> >
>> >  	pwrseq =3D devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
>> >  	if (!pwrseq)
>> > @@ -134,8 +133,7 @@ static int mmc_pwrseq_simple_probe(struct platform=
_device *pdev)
>> >  	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) !=3D -ENOENT=
)
>> >  		return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock=
 not ready\n");
>> >
>> > -	ngpio =3D of_count_phandle_with_args(dev->of_node, "reset-gpios", "#=
gpio-cells");
>> > -	if (ngpio =3D=3D 1) {
>> > +	if (device_property_present(dev, "resets")) {
>
> This effectively turns the following into dead code because the binding
> does not allow a "resets" property.
>
>> >  		pwrseq->reset_ctrl =3D devm_reset_control_get_optional_shared(dev, =
NULL);
>> >  		if (IS_ERR(pwrseq->reset_ctrl))
>> >  			return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
>> > --
>> > 2.43.0
>> >
>> >
>> >
>>
>> I think reset core should check if the client node has both "reset" and
>> "reset-gpios".
>
> Why check both? If the "resets" property exists, we use it [3].
> "reset-gpios" is only checked as a fallback if the "resets" property is
> not present [4].
>
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/reset/core.c#n1019
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/reset/core.c#n1031
>
>> If so - it should assume the client wants to resolve "resets"
>> and only fall-back to "reset-gpios" if there's no "resets" and number of=
 GPIOs
>> is 1.
>
> That is exactly what happens right now.
>

Right.

>> Philipp, Krzysztof: what do you think?
>
> I think this is a missing feature in reset-gpio.
> This driver could fall back to to devm_gpiod_get_array() also if
> devm_reset_control_get_optional_shared() returns -ENOENT instead of
> erroring out (maybe -ENOTSUPP would be a better return code for [1]?).
>

I did not write the initial version but Krzysztof: is there any reason we o=
nly
support a single, two-cell GPIO? Would it be problematic to support any kin=
d of
reset GPIO setup?

Bartosz
