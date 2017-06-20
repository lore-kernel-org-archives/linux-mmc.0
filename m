From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Rebasing mmc/next
Date: Tue, 20 Jun 2017 11:06:15 +0200
Message-ID: <CAMuHMdWikrGTaEVWDdpgAN9+DEHXOYUZdtZgssRLDTWsyxa-fw@mail.gmail.com>
References: <CAMuHMdW=aasYmZz-z+BgT0Qoco6DTyQxN3G1wiWVPETsbkRZTQ@mail.gmail.com>
 <CAPDyKFpuBJCArAHUL2i=zDL=-Bq908eDJ2_mRy7O=_4bJj2_dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpuBJCArAHUL2i=zDL=-Bq908eDJ2_mRy7O=_4bJj2_dw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, Jun 20, 2017 at 10:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 20 June 2017 at 09:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> It looks like you rebase mmc/next almost daily. Is there any specific reason
>> for that?
>
> I don't do it daily, but often, yes. :-)

A few years ago, I got bashed by Linus for rebasing the m68k "for-linus"
branch on every -rc.

>> I'm asking because I create a "renesas-drivers" tree on a regular basis
>> (cfr. e.g. https://www.spinics.net/lists/linux-renesas-soc/msg15111.html).
>> This tree is meant to ease development of platform support and drivers
>> for Renesas ARM SoCs. It is created by merging (a) the for-next branches
>> of various subsystem trees and (b) branches with driver code submitted
>> or planned for submission to maintainers into the development branch of
>> Simon Horman's renesas.git tree.
>
> If you are asking me to keep my next branch immutable, then please no,
> I don't like to do that. Reason explained below.

100% immutable is not needed.

> I don't have a problem to share specific renesas mmc branches with
> you, if that helps?

Hmm, that would be more work on your side. Plus communication overhead.

>> If for (b), people submit driver code based on mmc/next, it may start
>> to conflict
>> with subsequent mmc/next releases soon, requiring the submitter or me to
>> rebase the code before including it in renesas-drivers.
>>
>> Most subsystem maintainers don't rebase their for-next branch, unless there's
>> a very good reason for it (e.g. a serious breakage hindering bisection).
>
> I do it for a couple of reasons.
>
> First, sometimes I apply changes before people have provided enough
> tested by tags, to instead allow the changes to be tested in
> linux-next. This may lead to some situations when I need to re-base my
> next branch.
> *) Something breaks, then I need to drop the changes. Revert doesn't
> play well here, especially if it's a series of changes.
> **) Avoid breaking bisect.

OK.

> ***) I want to give people cred, adding peoples tested-by, reviewed-by
> tags, after the changes have been queued on my next branch.

I think you're about the only one who does that ;-)

> Second, even if the changes queued on next has been thoroughly tested,
> sometimes error reports still show up. I most cases I prefer to avoid
> breaking bisect, which then leaves me in no other option, but
> re-basing my branch (to either drop changes or amend them).
>
> I guess what I can do, is to host a pre-next branch, which serves as
> my pre-integration branch, before I moves things to next. However,
> this does put some more administrative work on me, so I would like to
> avoid that.

OK.

> I am trying to understand the purpose of your renesas integration
> tree, and why it's a problem for you to pick up my re-based branch?
> Could you perhaps elaborate on this?

The purpose is to make it easier for the upstream Renesas kernel team and
associated testers to consume our work-in-progress.

Hence I merge the for-next branches of selected subsystems, followed by
topic branches with work-in-progress driver code.

E.g. Simon had asked me to include
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
topic/sdhi-gen3-dma-2017
That branch was based on your mmc/next.

But by the time I created the renesas-drivers release, mmc/next had been
rebased.  Hence after merging the new mmc/next, I had to rebase his work:
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/sdhi-gen3-dma-2017-rebased1

I hope this explains our problem.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
