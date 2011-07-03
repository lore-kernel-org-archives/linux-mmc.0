From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
Date: Sun, 3 Jul 2011 15:47:41 +0100
Message-ID: <20110703144741.GK21898@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org> <20110621075319.GN26089@n2100.arm.linux.org.uk> <BANLkTimnuEK_9RedmD1OgcunX3rPvd-O0Q@mail.gmail.com> <20110627110234.GC16103@n2100.arm.linux.org.uk> <BANLkTin80Z34=_uQaP=Dbv7eDxU1PH_qSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38605 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab1GCOsF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2011 10:48:05 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin80Z34=_uQaP=Dbv7eDxU1PH_qSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Per Forlin <per.forlin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Chris Ball <cjb@laptop.org>, linaro-dev@lists.linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 28, 2011 at 09:22:20AM +0300, saeed bishara wrote:
> On Mon, Jun 27, 2011 at 2:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jun 27, 2011 at 01:34:48PM +0300, saeed bishara wrote:
> >> Russell,
> >> =A0 I'm curious about the correctness of this patch for systems wi=
th
> >> outer cache. shouldn't the dsb be issued before the outer cache
> >> maintenance?
> >
> > Maybe we should do two passes over SG lists then - one for the inne=
r and
> > another for the outer cache?
> >
> > In effect we could do three passes:
> >
> > 1. Calculate the total size of the SG list to determine whether ful=
l
> > =A0 cache flush is more efficient.
> > 2. Flush inner cache
> > =A0 Then dsb()
> > 3. Flush outer cache
> > =A0 Another dsb()
> >
> looking at l2x0 cache, it seems to me that it would be possible to do
> asynchronous l2 cache maintenance for
> range operations, so maybe that can be utilized in order to
> parallelism between inner cache and outer cache maintenance,
> so the flow can be:
> 2. Flush sg buffer from inner cache
> 3. dsb()
> 4. start Flush outer cache for that buffer
> 5. Flush next sg buffer from inner cache
> 6. dsb
> 7. goto 4.
> 8. when no more buffers left, wait for outer cache operations

I'm not sure how practical that is given the architecture of the L2x0
controllers - where we need to wait for the previous operation to
complete by reading the operation specific register and then issue a
sync.

Having looked at this again, I think trying to do any optimization of
this code will be fraught, because of the dmabounce stuff getting in
the way.  If only dmabounce didn't exist... if only crap hardware didn'=
t
exist...  dmabounce really needs to die.
