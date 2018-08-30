From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
Date: Thu, 30 Aug 2018 13:51:49 +0200
Message-ID: <CAPDyKFq6wX9jP0c5688fWVAmnZja9OZXbECwoKbKBXuM2r5cbg@mail.gmail.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com> <20180829084913.fgdrigpeu3vi7vqs@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829084913.fgdrigpeu3vi7vqs@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 August 2018 at 10:49, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> +     if (divisor <= 1) {
>> +             clk_sel = 1;
>> +             clk = 0;
>> +     } else {
>> +             clk_sel = 0;
>> +             /* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2 */
>> +             clk = roundup_pow_of_two(divisor) >> 2;
>> +     }
>
> What about
>
>         clk_sel = (divisor <= 1);
>         clk = clk_sel ? 0 : (roundup_pow_of_two(divisor) >> 2)
>
> More concise, but I think still readable. I don't mind super much,
> though.

Right. So, may I apply Yamada-san's original patch (adding your
tested/reviewed-by tag) and the above as a code-cleanup for you to
address on top?

Kind regards
Uffe
