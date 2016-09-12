From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Mon, 12 Sep 2016 14:00:51 +0200
Message-ID: <CAMuHMdV1KnmWJZEKgJHNuCYmSE5igCDYT3UsOqFuhsrar48-Dg@mail.gmail.com>
References: <20160909155238.17852-1-chris.brandt@renesas.com>
 <20160909155238.17852-3-chris.brandt@renesas.com> <CAMuHMdXihVRcmn2Ep0cRdg2U0=boJohxzzL1=32Ek+17ivTwWg@mail.gmail.com>
 <SG2PR06MB1165272B3CB9B0A00F1E06CE8AFC0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdUAZpNoPGJZO3CHHt6_BAe+7Fdh2Bqn0qGfjO2UnuFiMA@mail.gmail.com> <SG2PR06MB1165675269953DC9789587948AFF0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB1165675269953DC9789587948AFF0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Mon, Sep 12, 2016 at 1:56 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On 9/11/12016, Geert Uytterhoeven wrote:
>> > So would you say sd_ctrl_write16_rep should also be changed to be 'const
>> u16 *buf'?
>> >
>> > Currently it is:
>> > static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int
>> addr,
>> >                 u16 *buf, int count)
>> > {
>> >         writesw(host->ctl + (addr << host->bus_shift), buf, count);
>>
>> Ideally it should become const, too.
>
> I can add another patch at the end of this series that changes it to match sd_ctrl_write32_rep.
>
> (unless for some reason you think it should be a separate patch that is not associated with this series)

Well, it's not really related to this series, so it can be a separate patch.
But including it in this series won't hurt much, I guess.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
