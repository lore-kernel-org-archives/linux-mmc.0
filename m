From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: dw_mmc: Does anyone use multiple slots?
Date: Fri, 09 Aug 2013 12:18:07 +0900
Message-ID: <000e01ce94af$12710ef0$37532cd0$%jun@samsung.com>
References: <CAD=FV=U3aT1KKtSwAFhYURJJerp70ij8h647=xyV51et4jYipg@mail.gmail.com>
 <CAOesGMjaF2K0CnuWBj7xdXGAQk-XRetBstaQdd9EZzBYrmDjeA@mail.gmail.com>
 <86mworfzsf.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46415 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967411Ab3HIDSL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2013 23:18:11 -0400
In-reply-to: <86mworfzsf.fsf@void.printf.net>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Olof Johansson' <olof@lixom.net>
Cc: 'Doug Anderson' <dianders@google.com>, 'James Hogan' <james.hogan@imgtec.com>, linux-mmc@vger.kernel.org, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Doug Anderson' <dianders@chromium.org>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Sonny Rao' <sonnyrao@chromium.org>

On Fri, August 09, 2013, Chris Ball wrote:
> On Fri, Aug 09 2013, Olof Johansson wrote:
> > On Thu, Aug 8, 2013 at 5:16 PM, Doug Anderson <dianders@google.com> wrote:
> >
> >> I guess my overall question is: if there are no actual implementations
> >> of multislot, shouldn't we kill it and simplify the code a whole lot?
> >> If someone out there has a real multislot device they can step back in
> >> and do it more correctly?
> >>
> >> Of course we need to find someone to actually go through and do the
> >> killing of multislot, but finding that person might be easier if there
> >> was some agreement that it was good to do.
> >
> > There clearly seems to be no in-tree users of multislot. If someone
> > new comes in, we have the code in the history and can revert the
> > removal (or at least use it as reference for re-introduction).
> >
> > I vote for removing it. It adds really annoying complexity for
> > something that nobody uses.
> 
> I agree with Olof, for what it's worth.  (The maintainers of the
> driver are Jaehoon and Seungwon, though.)

I feel like there is no actual use case for that though origin Synopsys IP supports.
Multi-slot  might be not useful in terms of performance because shared bus should be allowed.
(At least this is the way I see it, though)
As Exynos's host does so, other hosts which are introduced in Linux seems use one card per host.
If it's really not found now, I could agree on this topic.

Thanks,
Seungwon Jeon

