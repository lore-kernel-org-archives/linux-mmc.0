From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 22 Dec 2010 11:22:50 -0800
Message-ID: <AANLkTikaA6wQyAuyY5OYTbAKy1N9GwWOB0V010yNcvBP@mail.gmail.com>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
	<1293004871-1918-4-git-send-email-olof@lixom.net>
	<20101222162231.GC30951@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55491 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0LVTWw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 14:22:52 -0500
In-Reply-To: <20101222162231.GC30951@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Mike Rapoport <mike@compulab.co.il>

Hi,

Thanks for the review. All good points (and I forgot to do a last run
through checkpatch, my bad).

All have been addressed in the next version (not yet posted).

-Olof

On Wed, Dec 22, 2010 at 8:22 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> Hi Olof,
>
> looks good to me. Just some minor comments, but in general
>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>
> On Wed, Dec 22, 2010 at 02:01:11AM -0600, Olof Johansson wrote:
>> SDHCI driver for Tegra. Pretty straight forward, a few pieces of
>> functionality left to fill in but nothing that stops it from going
>> upstream. Board enablement submitted separately.
>
> I'd think this can go below the "---" line?
>
> ...
>> This driver plugs in as a new variant of sdhci-pltfm, using the plat=
form
>> data structure passed in to specify the GPIOs to use for card detect=
,
>> write protect and card power enablement.
>>
>> Original driver (of which only the header file is left):
>> Signed-off-by: Yvonne Yip <y@palm.com>
>>
>> The rest, which has been rewritten by now:
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> Cc: Wolfram Sang <w.sang@pengutronix.de>
>> Cc: Mike Rapoport <mike@compulab.co.il>
>> +static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
>> +{
>> + =A0 =A0 struct platform_device *pdev =3D to_platform_device(mmc_de=
v(sdhci->mmc));
>> + =A0 =A0 struct tegra_sdhci_platform_data *plat;
>> +
>> + =A0 =A0 plat =3D pdev->dev.platform_data;
>> +
>> + =A0 =A0 if (gpio_is_valid(plat->wp_gpio))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return gpio_get_value(plat->wp_gpio);
>> +
>> + =A0 =A0 return -1;
>
> So, read_only is the default case? I would have gone for returning 0.
> Well, safety vs. convenience...
>
> ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc)=
,
>
> Trailing white space
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to=
 allocate power gpio\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 tegra_gpio_enable(plat->power_gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(plat->power_gpio, 1)=
;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (gpio_is_valid(plat->cd_gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D gpio_request(plat->cd_gpio, "sdhci_=
cd");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc)=
,
>
> ditto
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to=
 allocate cd gpio\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_power;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 tegra_gpio_enable(plat->cd_gpio);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(gpio_to_irq(plat->cd_gp=
io), carddetect_irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_TR=
IGGER_FALLING | IRQF_TRIGGER_RISING,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hos=
tname(host->mmc), host);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc)=
, "request irq error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_cd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (gpio_is_valid(plat->wp_gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D gpio_request(plat->wp_gpio, "sdhci_=
wp");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc)=
,
>
> ditto
>
> Kind regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk0SJccACgkQD27XaX1/VRtnbgCdH8+R7hjsq4YjJIjvQgtkwOrF
> GHwAoJBRrdEv6+5d2sxZ5J/AqWsTXLb4
> =3DRLqI
> -----END PGP SIGNATURE-----
>
>
