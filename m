From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: FW: Regulator API ignored return values
Date: Tue, 12 Mar 2013 14:03:09 +0000
Message-ID: <201303121403.09315.arnd@arndb.de>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB0547F@SC-VEXCH1.marvell.com> <CADz5_g+KfxL43BKKsgZZ3Xg4sZWE4-ZaFpFhphKrfj9yK59-XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54622 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab3CLODd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 10:03:33 -0400
In-Reply-To: <CADz5_g+KfxL43BKKsgZZ3Xg4sZWE4-ZaFpFhphKrfj9yK59-XA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus Walleij <linus.walleij@linaro.org>, Axel Lin <axel.lin@ingics.com>, Jingoo Han <jg1.han@samsung.com>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dtor@mail.ru>, linux-mmc@vger.kernel.org

On Tuesday 12 March 2013, Kevin Liu wrote:
> > -               regulator_enable(host->vqmmc);
> > +               ret = regulator_enable(host->vqmmc);
> >                 if (!regulator_is_supported_voltage(host->vqmmc, 1700000,
> >                         1950000))
> >                         caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
> >                                         SDHCI_SUPPORT_SDR50 |
> >                                         SDHCI_SUPPORT_DDR50);
> > +               if (ret) {
> > +                       pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
> > +                               mmc_hostname(mmc), ret);
> 
> Need add regulator_put here since regulator_get has succeed?

Hmm, we still don't actually bail out if the error is encountered, so
the reference count is balanced with the current patch, but I maybe
a failed regulator_enable() should actually be a fatal error?

If we do that, using devm_regulator_get() would be a nice way to
track the reference counts.

	Arnd
