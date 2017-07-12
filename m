From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Rebasing mmc/next
Date: Wed, 12 Jul 2017 17:26:13 +0200
Message-ID: <CAPDyKFq-dku-WRbMJq0eUo0ESRH33fUCGGHMs=Ohej82su1x3Q@mail.gmail.com>
References: <CAMuHMdW=aasYmZz-z+BgT0Qoco6DTyQxN3G1wiWVPETsbkRZTQ@mail.gmail.com>
 <CAPDyKFpuBJCArAHUL2i=zDL=-Bq908eDJ2_mRy7O=_4bJj2_dw@mail.gmail.com> <CAMuHMdWikrGTaEVWDdpgAN9+DEHXOYUZdtZgssRLDTWsyxa-fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWikrGTaEVWDdpgAN9+DEHXOYUZdtZgssRLDTWsyxa-fw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 June 2017 at 11:06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Tue, Jun 20, 2017 at 10:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 20 June 2017 at 09:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> It looks like you rebase mmc/next almost daily. Is there any specific reason
>>> for that?
>>
>> I don't do it daily, but often, yes. :-)
>
> A few years ago, I got bashed by Linus for rebasing the m68k "for-linus"
> branch on every -rc.

Perhaps something to be discussed a kernel/mainainer-summit, cause at
the moment I don't think there is given policy.

>
>>> I'm asking because I create a "renesas-drivers" tree on a regular basis
>>> (cfr. e.g. https://www.spinics.net/lists/linux-renesas-soc/msg15111.html).
>>> This tree is meant to ease development of platform support and drivers
>>> for Renesas ARM SoCs. It is created by merging (a) the for-next branches
>>> of various subsystem trees and (b) branches with driver code submitted
>>> or planned for submission to maintainers into the development branch of
>>> Simon Horman's renesas.git tree.
>>
>> If you are asking me to keep my next branch immutable, then please no,
>> I don't like to do that. Reason explained below.
>
> 100% immutable is not needed.
>
>> I don't have a problem to share specific renesas mmc branches with
>> you, if that helps?
>
> Hmm, that would be more work on your side. Plus communication overhead.

OK.

[...]

>
>> I am trying to understand the purpose of your renesas integration
>> tree, and why it's a problem for you to pick up my re-based branch?
>> Could you perhaps elaborate on this?
>
> The purpose is to make it easier for the upstream Renesas kernel team and
> associated testers to consume our work-in-progress.
>
> Hence I merge the for-next branches of selected subsystems, followed by
> topic branches with work-in-progress driver code.
>
> E.g. Simon had asked me to include
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
> topic/sdhi-gen3-dma-2017
> That branch was based on your mmc/next.

I guess there are two other options to deal with this.

1) Don't merge my next branch, in case there is another branch based
on it. Instead, in this case, it will be Simon's responsibility of
re-basing his branch on top of mmc next, as to get the latest changes.
2) Base your WIP branches on top of some commit from Linus tree. Then
you can keep merging my next branch and any other "for-next" branch
that is often being re-based.

>
> But by the time I created the renesas-drivers release, mmc/next had been
> rebased.  Hence after merging the new mmc/next, I had to rebase his work:
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/sdhi-gen3-dma-2017-rebased1
>
> I hope this explains our problem.

Yeah, thanks for the explanation - and apologize for the delay.

Kind regards
Uffe
