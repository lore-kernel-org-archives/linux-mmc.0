From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/9] mmc: tmio: Add UHS-I mode support
Date: Tue, 23 Aug 2016 14:34:16 +0200
Message-ID: <CAMuHMdW+R+cS3ttKiRrtme=9KLTsTeV+tT-aRM_0Qj4CA5hVbg@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-4-git-send-email-wsa@the-dreams.de> <CAMuHMdVyNsm+hpoJfjxLkKt_5zydx9csgPB0zqCdtPMipqmFFQ@mail.gmail.com>
 <20160817190804.GA11930@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160817190804.GA11930@tetsubishi>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Wed, Aug 17, 2016 at 9:08 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>     [<c02f9d04>] (__mmc_start_request) from [<c02f9fa0>]
>> (mmc_start_request+0x104/0x118)
>
> This function calls card_busy only for SDIO cards. I assume you don't
> have one inserted? Maybe the "broken-cd" property doesn't work correctly
> and causes side-effects? This would explain why it only affects SDHI1
> and not SDHI0.

Removing the "broken-cd" property fixes the issue.
However, I'm not in a position to verify SDHI1 works after that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
