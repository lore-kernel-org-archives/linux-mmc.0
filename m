From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] MMC/core: Make sure the power is up, when detect the card
Date: Wed, 7 Dec 2011 10:04:44 +0100
Message-ID: <CACRpkdZ6FjrjtarzyLe_bmrZ6m6N=j07zaTxCFMuF6AsraKa4Q@mail.gmail.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
	<1323077026-12071-2-git-send-email-r66093@freescale.com>
	<1323077026-12071-3-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51945 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab1LGJEp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2011 04:04:45 -0500
Received: by iakc1 with SMTP id c1so623040iak.19
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2011 01:04:45 -0800 (PST)
In-Reply-To: <1323077026-12071-3-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Mon, Dec 5, 2011 at 10:23 AM,  <r66093@freescale.com> wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> Before running get_cd() recall function to detect whether the card is
> present, must make sure the power is up.
(...)
> + =A0 =A0 =A0 mmc_power_up(host);
> =A0 =A0 =A0 =A0if (host->ops->get_cd && host->ops->get_cd(host) =3D=3D=
 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> + =A0 =A0 =A0 mmc_power_off(host);

NAK, I don't get it.

mmc_power_up() mmc_power_off() is about powering up/down the
*card*.

If you need to read a register in your MMC host or so, control power
and clocking of your silicon in the driver itself. You can use
runtime PM or whatever including explicit clk_enable()/clk_disable()
etc.

I have a strong feeling that the bug you're trying to fix is in the
host controller you're using, not in the MMC core.

Yours,
Linus Walleij
