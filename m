From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: Make sure we don't get stuck when we get an
 error
Date: Fri, 16 May 2014 10:46:30 +0900
Message-ID: <001101cf70a8$a8ed89f0$fac89dd0$%jun@samsung.com>
References: <1395901126-6141-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAKuRcOL_JVjOfLNspb14kRxcAXjpEwX4WkvmM+izryZbZBE4XA@mail.gmail.com>
 <CAPz6YkVwT0PrcLP1MJy0vVRw811+_7PwsV_ggKxQkqrjOWeWWw@mail.gmail.com>
 <002001cf6c59$b5b5e680$2121b380$%jun@samsung.com>
 <CAD=FV=X=9cTvST5cM=H9H23SMD28cHSExXt3YR=v2AQ6dFJY5w@mail.gmail.com>
 <001b01cf6e67$2183b400$648b1c00$%jun@samsung.com>
 <CAD=FV=XKvN9+cs1aMFZhR97SE-UaU7mEB4g_fm1BEUfraRPiYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38266 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaEPBqd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 May 2014 21:46:33 -0400
In-reply-to: <CAD=FV=XKvN9+cs1aMFZhR97SE-UaU7mEB4g_fm1BEUfraRPiYQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Sonny Rao' <sonnyrao@chromium.org>, 'Yuvaraj Kumar' <yuvaraj.cd@gmail.com>, 'Grant Grundler' <grundler@chromium.org>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'sunil joshi' <joshi@samsung.com>, 'Tomasz Figa' <t.figa@samsung.com>

On Wed, May 14, 2014, Doug Anderson wrote:
> Seungwon,
> 
> On Mon, May 12, 2014 at 9:52 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Hi Doug,
> >
> > On Tue, May 13, 2014, Doug Anderson wrote:
> >> Seungwon,
> >>
> >> On Sat, May 10, 2014 at 7:11 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> > On Fri, May 09, 2014, Sonny Rao wrote:
> >> >> On Thu, May 8, 2014 at 2:42 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
> >> >> > Any comments on this patch?
> >> >> >
> >> >>
> >> >> I'll just add that without this fix, running the tuning loop for UHS
> >> >> modes is not reliable on dw_mmc because errors will happen and you
> >> >> will eventually hit this race and hang.  This can happen any time
> >> >> there is tuning like during boot or during resume from suspend.
> >> >>
> >> >> > On Thu, Mar 27, 2014 at 11:48 AM, Yuvaraj Kumar C D
> >> >> > <yuvaraj.cd@gmail.com> wrote:
> >> >> >> From: Doug Anderson <dianders@chromium.org>
> >> >> >>
> >> >> >> If we happened to get a data error at just the wrong time the dw_mmc
> >> >> >> driver could get into a state where it would never complete its
> >> >> >> request.  That would leave the caller just hanging there.
> >> >> >>
> >> >> >> We fix this two ways and both of the two fixes on their own appear to
> >> >> >> fix the problems we've seen:
> >> >> >>
> >> >> >> 1. Fix a race in the tasklet where the interrupt setting the data
> >> >> >>    error happens _just after_ we check for it, then we get a
> >> >> >>    EVENT_XFER_COMPLETE.  We fix this by repeating a bit of code.
> >> > I think repeating is not good approach to fix race.
> >> > In your case, XFER_COMPLETE preceded data error and DTO didn't come?
> >> > It seems strange case.
> >> > I want to know actual error value if you can reproduce.
> >>
> >> XFER_COMPLETE didn't necessarily precede data error.  Imagine this scenario:
> >>
> >> 1. Check for data error: nope
> >> 2. Interrupt happens and we get a data error and immediately xfer complete
> >> 3. Check for xfer complete: yup
> >>
> >> That's the state that we are handling.
> >>
> >> The system that dw_mmc uses where the interrupt handler has no locking
> >> makes it incredibly difficult to get things right.  Can you propose an
> >> alternate fix that would avoid the race?
> > Thank you for detailed scenario.
> > You're right.
> > Have you consider using spin_lock() in interrupt handler?
> > Then, we'll need to change spin_lock() to spin_lock_irqsave() in tasklet func.
> > And other locks in driver may need to be adjusted properly.
> 
> I have certainly considered it and I think it's the right way to go,
> but I believe that this would be a pretty massive change to the design
> of dw_mmc.  Someone appeared to try very hard not to use a spinlock in
> the interrupt handler and came up with the whole tasklet / pending
> events / completed events to deal with it.
Yes. It might be not small changes. Moreover, it needs to test heavily.
But it should be done before long. As we experienced, there are some race issue
in current way. Will you update this patch? Please let me know.

> 
> In this particular case it would be pretty easy to just add the
> spinlock around the data error / xfer complete checks, though once we
> have a spinlock here it seems like we'd want to start using it in
> other places.  It would be confusing if the interrupt handler grabbed
> a spinlock the whole time but then only used it to protect a single
> small check.
> 
> I'm really curious, though, why this driver can't just use a threaded
> irq handler and eliminate the whole interrupt / tasklet split.  That
> seems saner in the long run.
I think dw_mmc conforms itself to typical driver's implementation,
which it may be about a choice of driver's design.

> 
> 
> > To return above scenario:
> > 1. Check for data error: nope
> > 2. Check for xfer complete: nope -> escape tasklet.
> > 3. Interrupt happens and we get a data error and immediately xfer complete
> > 4. Check for data error (Again in tasklet) : yup
> >
> > How about this change?
> 
> I'm not sure I understand.  Are you suggesting a change to my code, or
> wondering how my code handles the above scenario?
Ah, the above-mentioned steps describes scenario when changing lock scheme.

Thanks,
Seungwon

> 
> I think your scenario works find either with or without my patch.
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

