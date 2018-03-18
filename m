From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 11/16] mmc: tmio: deprecate "toshiba,mmc-wrprotect-disable"
 DT property
Date: Sun, 18 Mar 2018 11:46:48 +0900
Message-ID: <CAK7LNATy=VzKXS-uZBgYm5A1k6E-87qDGNBTi=zFi9JGa2xrng@mail.gmail.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-12-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg@mail.gmail.com> <20180207193227.hu6cyh2e27dmrqwt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180207193227.hu6cyh2e27dmrqwt@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

2018-02-08 4:32 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jan 18, 2018 at 10:58:36AM +0900, Masahiro Yamada wrote:
>> 2018-01-18 1:28 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> > This property is equivalent to "disable-wp" defined in
>> > Documentation/devicetree/bindings/mmc/tmio_mmc.txt
>>
>> This is mistake.
>>
>> "disable-wp" is defined in
>>
>> Documentation/devicetree/bindings/mmc/mmc.txt
>
> With that fixed:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>

BTW, the subject of the applied version is wrong.

In my original post:
https://patchwork.kernel.org/patch/10170007/
"toshiba,mmc-wrprotect-disable"
No space after the vendor prefix.


But, applied commit (788778b0d21a6d5cd5)
I see a space, like
"toshiba, mmc-wrprotect-disable"


I think this is a bug of patchwork.


I have seen various bugs that break
the patch format.

I filed some bug reports for patchwork,
but not sure what happened.

-- 
Best Regards
Masahiro Yamada
