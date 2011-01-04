From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: add MMC_QUIRK_BROKEN_CLK_GATING
Date: Wed, 5 Jan 2011 00:52:28 +0100
Message-ID: <AANLkTi=uqcFrWujZTG8zy9zQoZ+=O6N1VBSjzgQbfX3Q@mail.gmail.com>
References: <AANLkTin7OYXzCYty8pDxyzE_Bg83=+L8jmcaoEMSf4QM@mail.gmail.com>
	<1294002510-2324-1-git-send-email-tardyp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34822 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1ADXw2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 18:52:28 -0500
In-Reply-To: <1294002510-2324-1-git-send-email-tardyp@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: "Gao, Yunpeng" <yunpeng.gao@intel.com>, "Yuan, Hang" <hang.yuan@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>

2011/1/2 Pierre Tardy <tardyp@gmail.com>:

> Some sdio card are not following sdio standard, and does not work
> when the sdio bus's clock is gated

Seem to me like it's pretty straight-forward and will work...
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 82f4b90..6df1ead 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -785,6 +785,12 @@ int mmc_attach_sdio(struct mmc_host *host, u32 o=
cr)
>
> =A0 =A0 =A0 =A0mmc_release_host(host);
>
> + =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0 * see comments in mmc_host_may_gate_card()
> + =A0 =A0 =A0 =A0 * this can be overidden by function drivers if they=
 know that
> + =A0 =A0 =A0 =A0 * their sdio card works with clock gating
> + =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0card->quirks |=3D MMC_QUIRK_BROKEN_CLK_GATING;

=2E..so the function driver will do something like this:

/* May gate clock */
card->quirks &=3D ~MMC_QUIRK_BROKEN_CLK_GATING;

Do you have a candidate function driver to do this ...?

Yours,
Linus Walleij
