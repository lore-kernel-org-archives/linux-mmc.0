From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch] mmc: fix init f_min
Date: Tue, 28 Sep 2010 11:34:02 +0800
Message-ID: <AANLkTimOHbSTVStnDLUJ+ka62NzmQrAAksrNR1LP_yLo@mail.gmail.com>
References: <AANLkTi=8ScP4Lm-an7bjXhj8doUVu+nM0KnVTa3WK4p3@mail.gmail.com>
	<4C9770E4.7000801@csr.com>
	<AANLkTi=toSZuEUBYBeGi=sq4QNnqZ=c-Ai1L32Bnpi=V@mail.gmail.com>
	<4CA064DD.6040705@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44118 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757987Ab0I1DeD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 23:34:03 -0400
Received: by iwn5 with SMTP id 5so5427272iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2010 20:34:03 -0700 (PDT)
In-Reply-To: <4CA064DD.6040705@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

On Mon, Sep 27, 2010 at 5:33 PM, David Vrabel <david.vrabel@csr.com> wr=
ote:
> zhangfei gao wrote:
>> On Mon, Sep 20, 2010 at 10:34 AM, David Vrabel <david.vrabel@csr.com=
> wrote:
>>> zhangfei gao wrote:
>>>> index 5db49b1..9114c87 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -910,9 +910,9 @@ static void mmc_power_up(struct mmc_host *host=
)
>>>> =A0 =A0 =A0 if (host->f_min > 400000) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Minimum clock frequenc=
y too high for "
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ident=
ification mode\n", mmc_hostname(host));
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D host->f_min;
>>>> - =A0 =A0 } else
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D 400000;
>>>> + =A0 =A0 } else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D host->f_min;
>>> NAK.
>>>
>>> The code is already correctly requesting 400 kHz (unless the contro=
ller
>>> can't go that slow).
>>
>> Original code
>> if (host->f_min > 400000) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Minimum clock freque=
ncy too high for "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ide=
ntification mode\n", mmc_hostname(host));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D host->f_min;
>> =A0 =A0 =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D 400000;
>>
>> With this code, the init clock is would be at lease 400 kHz, and no
>> matter how bigger the host->f_min it is, is this really correct?
>
> It's not clear what you're saying or why you think the original code =
is
> wrong. =A0Consider a host controller that reports a minimum frequency=
 of 1
> Hz. =A0Obviously we wouldn't want to do the card identification at th=
is
> clock rate, yes?

Thanks for your explanation.

The issue you met is f_min is too slow.
The issue we met is f_min is too high which also cause init fail,
But it is OK, we could prevent in other place, duringinit set
mmc->f_min =3D host->max_clk/256 in sdc 2.0 and mmc->f_min =3D
host->max_clk/2046 in sdc 3.0

Just curious how to get 400000, which is slowest speed for
initializaion, is this OK for all card?

>
> David
> --
> David Vrabel, Senior Software Engineer, Drivers
> CSR, Churchill House, Cambridge Business Park, =A0Tel: +44 (0)1223 69=
2562
> Cowley Road, Cambridge, CB4 0WZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 http:=
//www.csr.com/
>
>
> Member of the CSR plc group of companies. CSR plc registered in Engla=
nd and Wales, registered number 4187346, registered office Churchill Ho=
use, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United K=
ingdom
>
