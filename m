From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
Date: Mon, 15 Oct 2018 14:51:15 +0200
Message-ID: <CAPDyKFpAa=ucJvTLhNi-fQ3Fvd1in8rstxQouPY+_k_bFoAjZQ@mail.gmail.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <20181014223311.GE3260@kunai> <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
 <20181015073339.GB981@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015073339.GB981@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 October 2018 at 09:33, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Some sub-systems rebase, and some do not.
>> It is up to the sub-system maintainer.
>
> We used to have a very strict rule to not rebase anything which ends up
> in linux-next. Dunno what happened to this rule but I liked it.
>
>> I know what you are saying, but this is how we develop in linux-next.
>
> I wonder about that...
>
>> You need to use "git rebase --onto".
>
> And what about lists with commit IDs tracking patches on their way
> upstream? Yes, there is git-patch-id, yet I think it is easier to admit
> that incremental changes happen anyway. I know Ulf view differs...
>

For this particular case I can avoid the re-base, as you prefer.
However, in general can't commit to not rebase, as it depends on case
by case basis.

Kind regards
Uffe
