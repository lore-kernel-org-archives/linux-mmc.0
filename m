From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
Date: Mon, 5 Mar 2018 09:45:07 +0100
Message-ID: <CAPDyKFq_1mR=b3iu6o4ZJQeAjRnWf_tzb=__7SxvZYqDNCo2bg@mail.gmail.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com> <20180304224248.mzhsvl4ccmtzg5am@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180304224248.mzhsvl4ccmtzg5am@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

On 4 March 2018 at 23:42, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Jan 18, 2018 at 01:28:00AM +0900, Masahiro Yamada wrote:
>>
>> In the previous batch (https://lkml.org/lkml/2017/11/24/428)
>> I sent 22 patches for TMIO MMC.
>>
>> 14 patches were applied, the rest is under discussion.
>>
>> This series consists of 16 patches.
>
> Which I tested now, so we can add
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> to the patches except for
>
>> Patch 12: updated per Wolfram
>
> this one which needs a fix. I will send it as an incremental patch.
>

Yamada-san, Wolfram,

I have added Wolframs tags to the already applied patches and applied
that last two, 15 and 16.

They are all present in my next branch. The fix that Wolfram sent on
top, is added immediately after the commit it fixes.

Kind regards
Uffe
