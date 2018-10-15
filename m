From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
Date: Mon, 15 Oct 2018 12:12:29 +0900
Message-ID: <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com> <20181014223311.GE3260@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181014223311.GE3260@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 15, 2018 at 7:33 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > In further testing in uniphier-sd.c,
> > I found my stupid mistakes.
>
> I don't have the uniphier HW but I still had a look at these patches.
> You never know if there is something interesting for SDHI in there :)
>
> > Can you squash this series into
> > 3fd784f745dd
> > "mmc: uniphier-sd: add UniPhier SD/eMMC controller driver"
> > if you have a chance to do rebase?
>
> Please don't rebase!

Some sub-systems rebase, and some do not.
It is up to the sub-system maintainer.

I am not asking to rebase just for my two fixes.
I see linux-mmc regularly rebase anyway.

I'd prefer cleaner git history
if Ulf just happens to do one more rebase in this cycle.




> We actually develop on top of mmc/next and rebasing
> creates a lot of pain because we lose the base for that work.

I know what you are saying, but this is how we develop in linux-next.
You need to use "git rebase --onto".




--
Best Regards
Masahiro Yamada
