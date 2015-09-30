From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: MMC card removal during suspend
Date: Wed, 30 Sep 2015 12:24:29 +0200
Message-ID: <CAPDyKFraSBSeRebD7VXbo8TTquSK4qUnqO6GvfRa-ye--7JXuA@mail.gmail.com>
References: <CAJ=nTsuXgR4Fmjriy32LvbO49Yk_q0RYBV1S2FwHG+hZgG3aRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38760 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbbI3KYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2015 06:24:30 -0400
Received: by wiclk2 with SMTP id lk2so54566688wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2015 03:24:29 -0700 (PDT)
In-Reply-To: <CAJ=nTsuXgR4Fmjriy32LvbO49Yk_q0RYBV1S2FwHG+hZgG3aRw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 30 September 2015 at 08:46, Mirza Krak <mirza.krak@hostmobility.com>=
 wrote:
> Hi.
>
> I have a questing regard of what happens during suspend with the MMC
> card, or even more correctly what does not happen.
>
> I am running the 4.1.5 kernel on a Colibri VF SOM.
>
> What I would like to happen when i suspend my system to memory is tha=
t
> the MMC card is removed before suspend. The reason is that we will cu=
t
> the power rail to the MMC card during suspend on our board, which
> means that it will fail on resume if we do not remove the card before
> suspending.

At suspend, the mmc core tries to power off the card. Whether that's
actually done is up to each and every host driver to deal with via the
host_ops->set_ios() callback.

At resume, the mmc core expect the card to be powered off and starts
new round of power up and initialization cycle of the card.

This is the short story, obviously for eMMC which has specific
commands to deal with power management more things get involved.

>
> From what I read on the "internet", above behavior used to be default=
=2E
> It no longer is it seems.

Unfortunate the kernel doc for MMC is very poor. It certainly would
need some update.

In this case you better read the code, since what you read on the
internet seems to tell you something different.

>
> My question is, is there a "correct" way of getting the behavior I wo=
uld like?
>
> My hack today is to declare a pre_suspend callback in mmc.c returning=
 -ENOSYS.
>
> --
> Med V=C3=A4nliga H=C3=A4lsningar / Best Regards
>
> *******************************************************************
> Mirza Krak
> Host Mobility AB
> mirza.krak@hostmobility.com
> Anders Personsgatan 12, 416 64 G=C3=B6teborg
> Sweden
> http://www.hostmobility.com
> Direct: +46 31 31 32 704
> Phone: +46 31 31 32 700
> Fax: +46 31 80 67 51
> Mobile: +46 730 28 06 22
> *******************************************************************
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
