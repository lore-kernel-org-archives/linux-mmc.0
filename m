From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v5 2/2] OMAP4 HSMMC: Adding card detect support for MMC1
	Controller
Date: Mon, 28 Jun 2010 21:40:56 +0530
Message-ID: <AANLkTimVB7N0Oa9bDbYfSfcivy6afhvHW5Bdt-8dWVxD@mail.gmail.com>
References: <43584.10.24.255.17.1276788439.squirrel@dbdmail.itg.ti.com>
	<4C1FB2A0.6000503@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39187 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab0F1QK6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2010 12:10:58 -0400
In-Reply-To: <4C1FB2A0.6000503@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Adrian ,

Sorry for the late response

<snip>
>
> As per my email 5/5/10, I would suggest the only change to omap_hsmmc=
 is:

Agreed  and followed the changes mostly but made some more changes on t=
op of it.

>
<snip>
> And that the late init function is used to do the rest e.g.
> find a home for these 3 functions:

I agree just having the 3 functions makes it work.

>
> static int omap4_twl6030_hsmmc_late_init(struct device *dev)
> {
> =A0 =A0 =A0 =A0int ret =3D 0;
> =A0 =A0 =A0 =A0struct platform_device *pdev =3D container_of(dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct platform_device, dev);
> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platform=
_data;
>
> =A0 =A0 =A0 =A0/* MMC1 Card detect Configuration */
> =A0 =A0 =A0 =A0if (pdev->id =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D omap4_hsmmc1_card_detect_confi=
g();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Unable to conf=
igure Card detect for MMC1\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect =3D twl603=
0_mmc_card_detect;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect_irq =3D TW=
L6030_IRQ_BASE +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMCDETECT_INTR_OFFSET;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return ret;

<snip>

=46ew Comments below:

1) In the above function, initializing "card_detect"  in the driver as
done in omap_hsmmc_gpio_init might be more readable and this has been
done in nongpio_init instead.
Even having initialization of  "card_detect_irq" inside nongpio_init is=
 fine.

2)Also calling omap_hsmmc_gpio_init in case of a card detect line
which is not GPIO
doesn't make sense though it assigns -EINVAL to switch_pin in case of
invalid GPIO
which is intended for a non-removable card .

3) And also having some thing like GPIO and NON_GPIO flag to
distinguish might make sense.

Regards,
Kishore
