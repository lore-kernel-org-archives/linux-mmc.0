From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: Update driver to support without regulators
Date: Wed, 22 Jul 2015 14:07:52 +0200
Message-ID: <CAPDyKFpVh3EDJLX--h3H4qa4EDy2nDJQeRZtPQ8+uU9K43b_Tg@mail.gmail.com>
References: <1436902186-6542-1-git-send-email-fcooper@ti.com>
	<CAPDyKFq8NVqkZQ_8oL_5JM0_wYK6-gTaXr9ExHLa767tmcpxxA@mail.gmail.com>
	<55AEA008.6050808@ti.com>
	<55AF822F.8060507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AF822F.8060507@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kishon <kishon@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-mmc@vger.kernel.org

[...]

> Hi Ulf,
>
> Just to clarify do you have an issue with this patch or in general
> you rather nothave !CONFIG_REGULATOR supported? If its the latter
> then wouldit be better to remove the !CONFIG_REGULATOR portion from
> this driver all together.

I don't like this patch as is, as it seems like you are replacing the
VMMC regulator that actually exist in HW by parsing a DT property.

I think mmc_of_parse_voltage() shall *only* be used when the OCR mask
(->ocr_avail) can't be fetched by using a regulator. Typically that's
when the VMMC voltage levels are managed within the mmc controller
itself.

I don't have a strong opinion on how you solve that, but I guess you
have two options.

1.
Make sure the driver can be build and used both for CONFIG_REGULATOR
and !CONFIG_REGULATOR. What you need to take care of then, is to
assign the ->ocr_avail mask to a default value in the case when it
can't be fetched from a regulator. Most mmc drivers has some kind of
fall-back mechanism like this.

For those SoC where you need/can control the VMMC regulator, make sure
those enables CONFIG_REGULATOR to get the proper behaviour by
omap_hsmmc.

2.
Force omap_hsmmc to be build with CONFIG_REGULATOR.

Kind regards
Uffe
