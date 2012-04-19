From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] mmc: omap_hsmmc: Add fclk frequency to debufs
Date: Thu, 19 Apr 2012 00:36:21 -0400
Message-ID: <873980l4my.fsf@laptop.org>
References: <1334742553-11060-1-git-send-email-svenkatr@ti.com>
	<1334742553-11060-2-git-send-email-svenkatr@ti.com>
	<87obqolh7d.fsf@laptop.org>
	<CANfBPZ9iQRsaqDkcxNcu9BePZQhTGYc50pSUYNVdt00Ab5Tsrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40536 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667Ab2DSEgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Apr 2012 00:36:09 -0400
In-Reply-To: <CANfBPZ9iQRsaqDkcxNcu9BePZQhTGYc50pSUYNVdt00Ab5Tsrw@mail.gmail.com>
	(Venkatraman S.'s message of "Thu, 19 Apr 2012 09:55:52 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Viswanath Puttagunta <vishp@ti.com>

Hi,

On Thu, Apr 19 2012, S, Venkatraman wrote:
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_=
hsmmc.c
>>> index d15b149..d046ba2 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -1683,8 +1683,9 @@ static int omap_hsmmc_regs_show(struct seq_fi=
le *s, void *data)
>>> =C2=A0 =C2=A0 =C2=A0 if (host->pdata->get_context_loss_count)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_loss =3D h=
ost->pdata->get_context_loss_count(host->dev);
>>>
>>> - =C2=A0 =C2=A0 seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n=
",
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc->index, host->context_loss, context_loss);
>>> + =C2=A0 =C2=A0 seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n fclk:\t\=
t%lu Hz\n\nregs:\n",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc->index, host->conte=
xt_loss, context_loss,
>>
>> Minor nit, but it looks like this line breaks indentation.
>
> It does ? I thought I actually fixed the indentation of the original
> patch by removing a tabstop, as it was going
> too far into the right.
> checkpatch.pl doesn't complain about it.

After applying it, omap_hsmmc.c looks like this here:

        seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n fclk:\t\t%lu Hz\n\nr=
egs:\n",
                mmc->index, host->context_loss, context_loss,
                        clk_get_rate(host->fclk));

(That's with tabs converted to spaces for e-mail.)

So you're right that the original lines are indented a character too fa=
r
to the right, but after your patch there are different indentations use=
d
for lines 2 and 3 above, so that's worse than it was before.

All of the seq_printf() calls in omap_hsmmc.c have the same indentation
one space too far to the right.  I guess we should just stick with it.

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
