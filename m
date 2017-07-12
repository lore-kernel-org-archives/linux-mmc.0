From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: tmio-mmc: fix bad pointer math
Date: Wed, 12 Jul 2017 08:50:20 +0200
Message-ID: <CAMuHMdW6Sz59JNVEp_b6qw0VD_0_JAeetMrN9K2GUcPL++uipA@mail.gmail.com>
References: <20170711162911.39114-1-chris.brandt@renesas.com>
 <CAMuHMdX=Y5cpNiSd1wwXV_SOCpBs64+VpHnE_Svgd2E6P8Gm6w@mail.gmail.com> <SG2PR06MB11651FF11350240AA95EDCD28AAE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35155 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756611AbdGLGuW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jul 2017 02:50:22 -0400
In-Reply-To: <SG2PR06MB11651FF11350240AA95EDCD28AAE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dan Carpenter <dan.carpenter@oracle.com>, Simon Horman <horms+renesas@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Chris,

On Tue, Jul 11, 2017 at 9:37 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tuesday, July 11, 2017, Geert Uytterhoeven wrote:
>> > zeroing out the bottom 2 bits of count for out math.
>>
>> s/out/our/
>
> Thank you!
>
>> > -               buf8 = (u8 *)(buf + (count >> 2));
>> > +               buf8 = (u8 *)buf + (count & ~3);
>> >                 count %= 4;
>>
>> While correct, this is IMHO still difficult to understand for the casual
>> reader.
>>
>> Given the code before casts to "u32 *", and uses "count >>2", and the code
>> after also casts to "u32 *", what about getting rid of all casts like:
>>
>>         u32 data = 0;
>>         u32 *buf32 = buf;
>>
>>         if (is_read)
>>                 sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, buf32,
>>                                    count >> 2);
>>         else
>>                 sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, buf32,
>>                                     count >> 2);
>>
>>         /* if count was multiple of 4 */
>>         if (!(count & 0x3))
>>                 return;
>>
>>         buf32 += count >> 2;
>>         count %= 4;
>>
>>         if (is_read) {
>>                 sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, &data, 1);
>>                 memcpy(buf32, &data, count);
>>         } else {
>>                 memcpy(&data, buf32, count);
>>                 sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, &data, 1);
>>         }
>>
>>                 return;
>>         }
>>
>
> Good idea. I just tried it and it seems to work. I'll resend a patch.
>
>
>>         u32 *buf32 = buf;
>
> GCC didn't like this line without casting buf to a u32 *. It threw an
> error, not just a warning. Go figure.

Sorry, the cast is indeed missing, as buf is not a void *.

> Question:
>>         u32 data = 0;
>
> Any special reason why you are initializing this to 0????

I think the original code did that, too. Hmm, I got mislead by the curly braces,
there's no "0" in between them.

It's also a bit safer to not write uninitialized data to the CTL_SD_DATA_PORT
register.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
