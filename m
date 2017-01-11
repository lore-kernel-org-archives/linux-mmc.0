From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Wed, 11 Jan 2017 09:42:09 +0100
Message-ID: <CAMuHMdWM=_jhVzJD5GBojGROKyqSPO_-X5EDHetTXSCJLjX9pg@mail.gmail.com>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se> <20170110223043.GA2710@katana> <20170111083541.GB25542@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170111083541.GB25542@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Niklas,

On Wed, Jan 11, 2017 at 9:35 AM, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2017-01-10 23:30:43 +0100, Wolfram Sang wrote:
>> > Oddly enough the error are only printed when I insert the SD card in t=
he
>> > mmc0 slot. I can insert/eject the card multiple times in mmc1 and no
>> > error but the first insertion in mmc0 and boom. Only difference I can
>> > see are the clock speed between mmc0 and mmc1.
>>
>> Can you try this patch?
>>
>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Date: Sun, 13 Nov 2016 11:10:09 +0100
>> Subject: [PATCH] pinctrl: pfc: r8a7795: WIP: hardcode TDSEL value
>>
>> Otherwise, AC-180M won't get probed with SDR50 and EMMY-W1 has more
>> tuning errors with SDR104.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-p=
fc/pfc-r8a7795.c
>
> I'm doing my tests on Koelsch so I'm afraid setting the TDSEL in
> pfc-r8a7795.c won't do much ;-) Nevertheless I tried to mimic the patch
> for Koelsch but found the documentation lacking and where unable to do
> so. That is I found a TDSEL register but no documentation of its
> content.

The datasheet does mention which bits are for SD[023]_CLK.
Actual bit patterns should be the same as on r8a7795.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
