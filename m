From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
Date: Wed, 14 Feb 2018 18:43:48 +0900
Message-ID: <CAK7LNAQaEJFH7Y+XsGEWDbrDkXTt35Yqd5DBmk0hpd6bggy+hQ@mail.gmail.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com>
 <20180207191152.kvqrugblst2cko3c@ninjato> <CAPDyKFoxp7p0atQTV=PoQ7Bwt0fOs2aEq1KJHPtrq+zA3eFYgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:59149 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966503AbeBNJoc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Feb 2018 04:44:32 -0500
In-Reply-To: <CAPDyKFoxp7p0atQTV=PoQ7Bwt0fOs2aEq1KJHPtrq+zA3eFYgw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>

Hi Ulf,


2018-02-14 18:36 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 7 February 2018 at 20:11, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>> I picked patch5 and patch6, as those seemed trivial. Unless there is a
>>> rc9, let's aim for 4.17 for the rest.
>>
>> I can't find the branch where you picked these patches? I wanted to use
>> it to apply the rest of the patches. They don't seem to fit on v4.15
>> or current linus/master. Can you share this branch?
>
> You need to check again. :-)
>
> Patches up and to patch6 is already in Linus' tree v.16rc1, those I
> carried for quite a while on my next branch before sending them in the
> PR to Linus.
>
>>
>> I will do reviewing now "visually". But please wait until I tested them
>> before applying.
>
> I am eager to apply those patches you already have reviewed (to
> patch14), as those mostly seemed rather trivial and should be nice
> cleanups.
>
> Do you mind me going ahead, then you can continue and review/test the rest?
>


If you move forward, please fix-up the commit log of the patch 11.
(https://patchwork.kernel.org/patch/10170007/)


Documentation/devicetree/bindings/mmc/tmio_mmc.txt

  ->

Documentation/devicetree/bindings/mmc/mmc.txt



Thanks.


-- 
Best Regards
Masahiro Yamada
