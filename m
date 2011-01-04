From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Wed, 5 Jan 2011 00:25:32 +0100
Message-ID: <AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
	<1294175416-12358-4-git-send-email-ohad@wizery.com>
	<AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
	<AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63132 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab1ADXZd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 18:25:33 -0500
Received: by qwa26 with SMTP id 26so15092582qwa.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 15:25:32 -0800 (PST)
In-Reply-To: <AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

> =A0static struct omap2_hsmmc_info mmc[] __initdata =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "externa=
l",
> @@ -221,6 +233,7 @@ static struct omap2_hsmmc_info mmc[] __initdata =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.nonremovable =A0 =3D true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .init_card =A0 =A0 =A0=3D zoom_wl1271_i=
nit_card,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> =A0};
>
> This applies on the ZOOM board. in your case it would be a bit
> different, but the core principle should stay the same.
Mmmh...
There is no such platform data in intel_mid platforms.. Sound like
another platform hack will be needed for wl1271 to be integrated. :-(

Our first idea to resolve this problem was to hardcode wl1273 vendor
id/product id in a black list table near read_fbr...

Regards,
Pierre
