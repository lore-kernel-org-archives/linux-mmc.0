From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] mmc: mmci: Put power register deviations in variant data
Date: Wed, 28 Sep 2011 07:23:06 +0200
Message-ID: <CACRpkdZoXmQiUJbLkzgTkRnjukS18RvcZASXzZshnuDSQDE1aQ@mail.gmail.com>
References: <1317123725-29832-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61791 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab1I1FXH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 01:23:07 -0400
Received: by iaqq3 with SMTP id q3so6497230iaq.19
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2011 22:23:07 -0700 (PDT)
In-Reply-To: <1317123725-29832-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>

On Tue, Sep 27, 2011 at 1:42 PM, Ulf Hansson <ulf.hansson@stericsson.co=
m> wrote:

> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 4da20ec..32de82b 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -53,6 +53,7 @@ static unsigned int fmax =3D 515633;
> =A0* @st_clkdiv: true if using a ST-specific clock divider algorithm
> =A0* @blksz_datactrl16: true if Block size is at b16..b30 position in=
 datactrl register
> =A0* @non_power_of_2_blksize: true if block sizes can be other than p=
ower of two
> + * @pwrreg_powerup: power up value for MMCIPOWER register
> =A0*/
> =A0struct variant_data {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0clkreg;
> @@ -64,18 +65,21 @@ struct variant_data {
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0st_clkdiv;
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blksz_data=
ctrl16;
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0non_power_=
of_2_blksize;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0pwrreg_powerup;

This should probably be u32, no big deal but easy to fix.
Can be done when putting it into Russells patch tracker I guess.

Yours,
Linus Walleij
