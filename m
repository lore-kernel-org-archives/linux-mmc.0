From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Fri, 15 Dec 2017 17:34:51 +0100
Message-ID: <CAPDyKFpUE1s8+OXuyyRszFnpt5CN4G8d2vhwRhs-PkaL_VU7oQ@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFqE7Pg8fJFyOtihdRnma+dFQd3+YPWGn6pXbpzhpERK9Q@mail.gmail.com>
 <CAK7LNASQfsnQY6henk5RvAysQUh3=cPXV1GPNeWeXgBxZvadAw@mail.gmail.com>
 <20171215111225.ekrau5e27xknb3jf@ninjato> <CAPDyKFopKm2psU19vGQfGL6WizXQA0vvzQubqsypvytbpRtyAA@mail.gmail.com>
 <20171215163055.vxxiswgsvfybf4hi@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171215163055.vxxiswgsvfybf4hi@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 December 2017 at 17:30, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > Ulf, this patch then in deed should ideally be applied before 1-8 here.
>>
>> Okay, once you post it to linux-mmc I will pick it up, and put it in front.
>
> Bad news, that patch didn't help. The problem is that sparc64 doesn't
> include 'asm-generic/io.h' and also has no own 'readsw'. No surprise
> that just adding this include will cause lots of redefines which are way
> too much to handle as a side-task.
>
> So, the best option I see here is to drop COMPILE_TEST for now, report
> this to the sparc64 maintainers (I assume they know already), and see if
> they can fix it.

Okay!

If some of you send a patch on top, I can fold it into the offending commit.

>
> Other thoughts?

Nope.

Kind regards
Uffe
