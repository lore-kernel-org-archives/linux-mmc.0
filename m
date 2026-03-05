Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542283793B8
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703838; cv=none; b=JqnYSNN/0/ZyKXFAJkszpaRNnFpY/lCIwQuZ+SSuUxh6FZjTiRrSG10hC7oSqslZW+mUFH/S2zevGySf8Aksr+Lv7apHF5pIZMFPQJc2CSiD+tkz1B0MUwKqW+IZaPsqdytmxnJ8piksjtUKnYvC8Dw9taeO5mmwcjFvmrixUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703838; c=relaxed/simple;
	bh=9QadxLQ3fsfwnWI80wODSjIPRo9yuxmB7FX2lcal/kc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQxxLVZwM9cEJsKdd2Y4YdSP50uFQWgpPrBYuE/u0FlL0qZckF16iYXpmdPkruTOt0XgZ1vh1Rj/U9SC8zCqTxTiRTySF6NzWmOBpWS0Qm0mRu3L+Ppfrfpb+40d2lawlZ0G8AMI79bZN0m3umjQu+umddo8F+ZVblxupbOgcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vy5FL-0002HC-7C; Thu, 05 Mar 2026 10:43:55 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vy5FJ-003rRX-1b;
	Thu, 05 Mar 2026 10:43:54 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vy5FK-0000000037p-3DCa;
	Thu, 05 Mar 2026 10:43:54 +0100
Message-ID: <923d35430a633af4064d671f1cac1d47780cd14f.camel@pengutronix.de>
Subject: Re: [PATCH] mmc: pwrseq_simple: fix probe failure when
 CONFIG_RESET_GPIO is enabled
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@kernel.org>, Sergey Suloev
	 <sergey.suloev@gmail.com>
Cc: ulf.hansson@linaro.org, catalin.popescu@leica-geosystems.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski	 <krzk@kernel.org>, Linus Walleij <linusw@kernel.org>
Date: Thu, 05 Mar 2026 10:43:54 +0100
In-Reply-To: <CAMRc=McNXzDE48zX=eH_bfg+KBN=2-yeW6bjL1L=hCmHu6xv8w@mail.gmail.com>
References: <20260220194725.1341281-1-sergey.suloev@gmail.com>
	 <CAMRc=McNXzDE48zX=eH_bfg+KBN=2-yeW6bjL1L=hCmHu6xv8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

On Mi, 2026-03-04 at 08:41 -0800, Bartosz Golaszewski wrote:
> On Fri, 20 Feb 2026 20:47:25 +0100, Sergey Suloev
> <sergey.suloev@gmail.com> said:
> > The driver uses a heuristic =E2=80=94 checking if exactly one entry exi=
sts in
> > 'reset-gpios' =E2=80=94 to decide whether to attempt reset controller A=
PI usage
> > via devm_reset_control_get_optional_shared(). This is semantically
> > incorrect and causes a permanent probe failure when CONFIG_RESET_GPIO
> > is enabled.
> >=20
> > When CONFIG_RESET_GPIO=3Dy, __of_reset_control_get() intercepts the
> > 'reset-gpios' DT property and attempts to register the GPIO as a reset
> > controller via __reset_add_reset_gpio_device(). If the GPIO controller
> > is not yet fully initialized at probe time, this returns -ENOENT instea=
d
> > of -EPROBE_DEFER, and the error path does not respect the 'optional'
>=20
> If this is what's happening, then it is not the expected behavior[1].

Is this -ENOENT returned because of #gpio-cells !=3D 2 [1]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/reset/core.c#n883

It looks like it [2].

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm/boot/dts/allwinner/sunxi-bananapi-m2-plus.dtsi#n103

> > flag, causing pwrseq_simple to fail permanently rather than defer.
> > This prevents mmc1 from probing on boards that use 'reset-gpios' for
> > WiFi power sequencing, such as BananaPi M2 Magic with AP6212/BCM43430
> > on Allwinner R16.
> >=20
> > The correct indicator of reset controller intent is the explicit presen=
ce
> > of a 'resets' property in the device tree node, not the count of
> > 'reset-gpios' entries. A single 'reset-gpios' entry is just as likely
> > to be a plain GPIO as multiple entries.
> >=20
>=20
> Am I getting it right? You have a node that has both the "resets" propert=
y
> as well as "reset-gpios" with more than one entry?

According to the mmc-pwrseq-simple binding doc, a "resets" property is
not valid at all. Apparently, this is just a "reset-gpios" property
with a single GPIO with three cells.

> If that's the case then it should be fixed in reset core, not in a user
> because there'll surely be another one in no time.
>=20
> > Replace the ngpio =3D=3D 1 heuristic with an explicit check for the 're=
sets'
> > DT property, making the behavior unambiguous and immune to
> > CONFIG_RESET_GPIO interference.
> >=20
> > Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset con=
trol")
> > Signed-off-by: Sergey Suloev <sergey.suloev@gmail.com>
> > ---
> >  drivers/mmc/core/pwrseq_simple.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq=
_simple.c
> > index 4b47e6c3b04b..780c8818a273 100644
> > --- a/drivers/mmc/core/pwrseq_simple.c
> > +++ b/drivers/mmc/core/pwrseq_simple.c
> > @@ -124,7 +124,6 @@ static int mmc_pwrseq_simple_probe(struct platform_=
device *pdev)
> >  {
> >  	struct mmc_pwrseq_simple *pwrseq;
> >  	struct device *dev =3D &pdev->dev;
> > -	int ngpio;
> >=20
> >  	pwrseq =3D devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
> >  	if (!pwrseq)
> > @@ -134,8 +133,7 @@ static int mmc_pwrseq_simple_probe(struct platform_=
device *pdev)
> >  	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) !=3D -ENOENT)
> >  		return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock =
not ready\n");
> >=20
> > -	ngpio =3D of_count_phandle_with_args(dev->of_node, "reset-gpios", "#g=
pio-cells");
> > -	if (ngpio =3D=3D 1) {
> > +	if (device_property_present(dev, "resets")) {

This effectively turns the following into dead code because the binding
does not allow a "resets" property.

> >  		pwrseq->reset_ctrl =3D devm_reset_control_get_optional_shared(dev, N=
ULL);
> >  		if (IS_ERR(pwrseq->reset_ctrl))
> >  			return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
> > --
> > 2.43.0
> >=20
> >=20
> >=20
>=20
> I think reset core should check if the client node has both "reset" and
> "reset-gpios".

Why check both? If the "resets" property exists, we use it [3].
"reset-gpios" is only checked as a fallback if the "resets" property is
not present [4].

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/reset/core.c#n1019
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/reset/core.c#n1031

> If so - it should assume the client wants to resolve "resets"
> and only fall-back to "reset-gpios" if there's no "resets" and number of =
GPIOs
> is 1.

That is exactly what happens right now.

> Philipp, Krzysztof: what do you think?

I think this is a missing feature in reset-gpio.
This driver could fall back to to devm_gpiod_get_array() also if
devm_reset_control_get_optional_shared() returns -ENOENT instead of
erroring out (maybe -ENOTSUPP would be a better return code for [1]?).

regards
Philipp
