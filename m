From: Koen Beel <koen.beel.barco@gmail.com>
Subject: Re: [PATCH v2] mxs-mmc: fix clock rate setting
Date: Fri, 15 Jul 2011 11:47:14 +0200
Message-ID: <CAHMSPgN433ZWj20bnAtBwkpx6gMXR0joBLYQ4aBgsw2ekh7O4w@mail.gmail.com>
References: <CAHMSPgNWherMTU9kLDH7zLQL0N_er5SpLz2v1xjzXvgckv+C2g@mail.gmail.com>
	<20110711202621.GA5811@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:57095 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab1GOJrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2011 05:47:16 -0400
Received: by fxd18 with SMTP id 18so2590269fxd.11
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2011 02:47:15 -0700 (PDT)
In-Reply-To: <20110711202621.GA5811@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@freescale.com>

Hi,

On Mon, Jul 11, 2011 at 10:26 PM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
> Hi Koen,
>
> thanks for v2.
>
> On Mon, Jul 11, 2011 at 09:52:01PM +0200, Koen Beel wrote:
>
>> (Sorry, patch in attachment as I still don't have a decent mail setu=
p
>> at my company)
>
> That's bad :(
>
> =3D=3D=3D=3D
>
>> Fix clock rate setting on mxs-mmc driver.
>> Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
>> have been 255 instead of 0.
>> Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
>> (TIMING_CLOCK_RATE + 1) where not correctly defined.
>
> Very minor nit: No paragraphs I'd say.
>
>> Can easily be reproduced on mx23evk: default clock for high speed sd=
io
>> cards is 50 MHz. With a SSP_CLK of 28.8 MHz default), this resulted =
in
>> an actual clock rate of about 56 kHz.
>> Tested on mx23evk.
>>
>> Changes in V2 patch:
>> - use DIV_ROUND_UP to make sure the actual clock rate is not higher
>> then the requested clock rate.
>> - rename variables to reflect naming in datasheet and to make things
>> more clear
>
> Changelogs are good, but should go below "---"
>
>>
>> Signed-off-by: Koen Beel <koen.beel@barco.com>
>> ---
>> =C2=A0drivers/mmc/host/mxs-mmc.c | =C2=A0 30 ++++++++++++++---------=
-------
>> =C2=A01 files changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
>> index 99d39a6..d513d47 100644
>> --- a/drivers/mmc/host/mxs-mmc.c
>> +++ b/drivers/mmc/host/mxs-mmc.c
>> @@ -564,40 +564,38 @@ static void mxs_mmc_request(struct mmc_host *m=
mc, struct mmc_request *mrq)
>>
>> =C2=A0static void mxs_mmc_set_clk_rate(struct mxs_mmc_host *host, un=
signed int rate)
>> =C2=A0{
>> - =C2=A0 =C2=A0 unsigned int ssp_rate, bit_rate;
>> - =C2=A0 =C2=A0 u32 div1, div2;
>> + =C2=A0 =C2=A0 unsigned int ssp_clk, ssp_sck;
>
> ssp_sck is not really needed? Value could directly go to host->clk_ra=
te.
>
>> + =C2=A0 =C2=A0 u32 clock_divide, clock_rate;
>> =C2=A0 =C2=A0 =C2=A0 u32 val;
>>
>> - =C2=A0 =C2=A0 ssp_rate =3D clk_get_rate(host->clk);
>> + =C2=A0 =C2=A0 ssp_clk =3D clk_get_rate(host->clk);
>>
>> - =C2=A0 =C2=A0 for (div1 =3D 2; div1 < 254; div1 +=3D 2) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 div2 =3D ssp_rate / rate=
 / div1;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (div2 < 0x100)
>> + =C2=A0 =C2=A0 for (clock_divide =3D 2; clock_divide <=3D 254; cloc=
k_divide +=3D 2) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clock_rate =3D DIV_ROUND=
_UP(ssp_clk, rate * clock_divide);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clock_rate =3D (clock_ra=
te > 0) ? clock_rate - 1 : 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (clock_rate <=3D 255)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 if (div1 >=3D 254) {
>> + =C2=A0 =C2=A0 if (clock_divide > 254) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(mmc_dev(hos=
t->mmc),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "%s: cannot set clock to %d\n", __func__, rate);
>
> Didn't you want to set some minimal values instead of just returning?
> Just wondering, could be a seperate patch in my book...
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 if (div2 =3D=3D 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit_rate =3D ssp_rate / =
div1;
>> - =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit_rate =3D ssp_rate / =
div1 / div2;
>> + =C2=A0 =C2=A0 ssp_sck =3D ssp_clk / clock_divide / (1 + clock_rate=
);
>>
>> =C2=A0 =C2=A0 =C2=A0 val =3D readl(host->base + HW_SSP_TIMING);
>> =C2=A0 =C2=A0 =C2=A0 val &=3D ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_=
TIMING_CLOCK_RATE);
>> - =C2=A0 =C2=A0 val |=3D BF_SSP(div1, TIMING_CLOCK_DIVIDE);
>> - =C2=A0 =C2=A0 val |=3D BF_SSP(div2 - 1, TIMING_CLOCK_RATE);
>> + =C2=A0 =C2=A0 val |=3D BF_SSP(clock_divide, TIMING_CLOCK_DIVIDE);
>> + =C2=A0 =C2=A0 val |=3D BF_SSP(clock_rate, TIMING_CLOCK_RATE);
>> =C2=A0 =C2=A0 =C2=A0 writel(val, host->base + HW_SSP_TIMING);
>>
>> - =C2=A0 =C2=A0 host->clk_rate =3D bit_rate;
>> + =C2=A0 =C2=A0 host->clk_rate =3D ssp_sck;
>>
>> =C2=A0 =C2=A0 =C2=A0 dev_dbg(mmc_dev(host->mmc),
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s: div1 %d, div2 %d, s=
sp %d, bit %d, rate %d\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, div1, div2, ss=
p_rate, bit_rate, rate);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s: clock_divide %d, cl=
ock_rate %d, ssp_clk %d, rate_actual %d, rate_requested %d\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, clock_divide, =
clock_rate, ssp_clk, ssp_sck, rate);
>> =C2=A0}
>>
>
> Rest looks good to me, and test was also successful.
>
> Chris, if you want to take this version already:

Still need me to do something on this or is it ok?

Koen

>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
