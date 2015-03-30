From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Enable runtime PM management of host devices
Date: Mon, 30 Mar 2015 10:58:34 +0200
Message-ID: <CAPDyKFqRLjAoJRH-K_qKTU2B+yb-L_xXrV9XP73u2tXTUdP0UA@mail.gmail.com>
References: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org>
	<20150328085242.5e1e1acc@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36210 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbbC3I6f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 04:58:35 -0400
Received: by qgf60 with SMTP id 60so163516501qgf.3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 01:58:34 -0700 (PDT)
In-Reply-To: <20150328085242.5e1e1acc@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 27 March 2015 at 22:52, NeilBrown <neilb@suse.de> wrote:
> On Fri, 27 Mar 2015 12:15:15 +0100 Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> Currently those host drivers which have deployed runtime PM, deals with
>> the runtime PM reference counting entirely by themselves.
>>
>> Since host drivers don't know when the core will send the next request
>> through some of the host_ops callbacks, they need to handle runtime PM
>> get/put between each an every request.
>>
>> In quite many cases this has some negative effects, since it leads to a
>> high frequency of scheduled runtime PM suspend operations. That due to
>> the runtime PM reference count will normally reach zero in-between
>> every request.
>
> I don't understand why this is a problem.
> All the drivers use put_autosuspend, so the suspend doesn't happen for
> (typically) 50ms, so the actually suspend won't happen if there is a sequence
> of requests.

It's not a problem, but it's suboptimal.

>
> Is it just the scheduling of a suspend - even without the suspend happening -
> that is causing problems?  If so, maybe the runtime_pm code needs optimising?

Correct. Though, I don't think we can improve the behaviour of the
runtime PM core in this regards.

If the reference count reaches zero, due to a "put", it will need to
perform some actions to schedule the suspend operation - no matter
what.

So to me, this is only an optimization of how we make use of the runtime PM API.

Kind regards
Uffe
