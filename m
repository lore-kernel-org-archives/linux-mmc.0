From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: SDHI clock imbalance
Date: Fri, 2 Jun 2017 11:52:26 +0200
Message-ID: <CAMuHMdUNF8=HkCt+k1STKofZ00vk0V31OnF1rmupyHrrFZce5Q@mail.gmail.com>
References: <CAMuHMdX7_u_3TFK22inUp367LR3R77S72RAtRWPFnKE9-cUtpw@mail.gmail.com>
 <20170602093701.3kn52zfmpgy7kcqo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170602093701.3kn52zfmpgy7kcqo@ninjato>
Sender: linux-pm-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Fri, Jun 2, 2017 at 11:37 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> While investigating suspend/resume for the R-Car Gen3 clock driver, I
>> noticed a clock imbalance for SDHI on Salvator-X.
>
> Thanks for the heads up! Which branch did you use?
> renesas-drivers/master? This is important since we had quite some
> refactoring going on lately.

Yes, a tree based on renesas-drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
