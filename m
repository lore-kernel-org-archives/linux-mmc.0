From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: mmc: sdio add regulator vsdio
Date: Fri, 22 Jul 2011 11:19:32 +0800
Message-ID: <CAMj5Bkjtjn9PvGy1_OxGevjNuk-=ACk7rP-=6fZG1hWQXYB3Zg@mail.gmail.com>
References: <37C1B996-A455-4EA9-A916-F4ED8C034167@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33787 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab1GVDTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2011 23:19:33 -0400
Received: by qyk9 with SMTP id 9so1074096qyk.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2011 20:19:32 -0700 (PDT)
In-Reply-To: <37C1B996-A455-4EA9-A916-F4ED8C034167@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>, Frank Huang <frankh@marvell.com>

>>+
>>+static int __init brownstone_init_mmc(void)
>>+{
>>+ =A0 =A0 =A0/*
>>+ =A0 =A0 =A0 * PDn: GPIO58; RESETn: GPIO57
>>+ =A0 =A0 =A0 * 8787, RESETn keeps high, PDn control power
>>+ =A0 =A0 =A0 * on: PDn 1; off: PDn 0;
>>+ =A0 =A0 =A0 */
>
> Comment unclear
>
> GPIO57 is power
> GPIO58 is reset

yes, typo, thanks
>
>
>
>>+ =A0 =A0 =A0int RESETn =3D mfp_to_gpio(MFP_PIN_GPIO58);
>>+
>>+ =A0 =A0 =A0if (gpio_request(RESETn, "sdio RESETn")) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Failed to request sdio RESETn gp=
io\n");
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
>>+ =A0 =A0 =A0}
>>+ =A0 =A0 =A0gpio_direction_output(RESETn, 1);
>>+ =A0 =A0 =A0gpio_free(RESETn);
>
>
> The 8787 =A0data sheet indicated that PDn should be inactive as well =
as reset before
> initiating power up.
>
> Pull PDn high.

The PDn is super-set of RESETn, keep RESETn high, and control 8787
with PDn is enough.
The "Internal Reset" in data sheet is not RESET pin.
