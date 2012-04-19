From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 2/3] mmc: omap_hsmmc: Add fclk frequency to debufs
Date: Thu, 19 Apr 2012 09:55:52 +0530
Message-ID: <CANfBPZ9iQRsaqDkcxNcu9BePZQhTGYc50pSUYNVdt00Ab5Tsrw@mail.gmail.com>
References: <1334742553-11060-1-git-send-email-svenkatr@ti.com>
 <1334742553-11060-2-git-send-email-svenkatr@ti.com> <87obqolh7d.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87obqolh7d.fsf@laptop.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Viswanath Puttagunta <vishp@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 19, 2012 at 5:34 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Apr 18 2012, Venkatraman S wrote:
>> From: Viswanath Puttagunta <vishp@ti.com>
>>
>> Add mmc functional clock frequency to list of
>> internal state variables to display for debug.
>>
>> Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A05 +++--
>> =A01 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index d15b149..d046ba2 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1683,8 +1683,9 @@ static int omap_hsmmc_regs_show(struct seq_fil=
e *s, void *data)
>> =A0 =A0 =A0 if (host->pdata->get_context_loss_count)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_loss =3D host->pdata->get_contex=
t_loss_count(host->dev);
>>
>> - =A0 =A0 seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->index, host->context_=
loss, context_loss);
>> + =A0 =A0 seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n fclk:\t\t%lu Hz=
\n\nregs:\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->index, host->context_loss, context_lo=
ss,
>
> Minor nit, but it looks like this line breaks indentation.

It does ? I thought I actually fixed the indentation of the original
patch by removing a tabstop, as it was going
too far into the right.
checkpatch.pl doesn't complain about it.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_get_rate(host->fclk));
>>
>> =A0 =A0 =A0 if (host->suspended) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "host suspended, can't rea=
d registers\n");
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
