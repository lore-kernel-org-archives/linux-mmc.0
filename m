From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Enable runtime PM management of host devices
Date: Mon, 30 Mar 2015 10:48:27 +0200
Message-ID: <CAPDyKFr0xQGcAmbapPnb1U7uz+DJ7+K+GmNCxD-6nu0cB=tfpg@mail.gmail.com>
References: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org>
	<20150328085242.5e1e1acc@notabene.brown>
	<5517D9C1.5080302@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34683 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbbC3Is2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 04:48:28 -0400
Received: by qcay5 with SMTP id y5so64671884qca.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 01:48:27 -0700 (PDT)
In-Reply-To: <5517D9C1.5080302@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: NeilBrown <neilb@suse.de>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 29 March 2015 at 12:53, Konstantin Dorfman <kdorfman@codeaurora.org> wrote:
>
>
> On 03/28/2015 12:52 AM, NeilBrown wrote:
>>
>> On Fri, 27 Mar 2015 12:15:15 +0100 Ulf Hansson <ulf.hansson@linaro.org>
>> wrote:
>>
>>> Currently those host drivers which have deployed runtime PM, deals with
>>> the runtime PM reference counting entirely by themselves.
>>>
>>> Since host drivers don't know when the core will send the next request
>>> through some of the host_ops callbacks, they need to handle runtime PM
>>> get/put between each an every request.
>>>
>>> In quite many cases this has some negative effects, since it leads to a
>>> high frequency of scheduled runtime PM suspend operations. That due to
>>> the runtime PM reference count will normally reach zero in-between
>>> every request.
>
>
> It would be nice to have some numbers about this suspend/resume jitter of
> platform device pm due to time between consecutive requests within burst of
> requests.
>
> Probably we can tune autosuspend timer of specific platform device to avoid
> this.

No, that's not going to do the trick.

What $subject patch does, is to decrease the frequency for when the
host device's runtime PM reference count reaches zero. Thus preventing
us from telling the runtime PM core to schedule a suspend operation,
when we actually know it isn't needed.

>
> Implementing the patch in a way that you are suggesting will imply that the
> mmc core will always use double buffering request polling scheme and the
> existing mechanism of "request burst" definition.

$subject patch will improve behaviour when handling "bursts", but
that's just one case for when mmc core knows that it's going to send a
sequence of commands/requests.

For example, the core also send sequences from the mmc_rescan() work,
system PM suspend, etc.

Kind regards
Uffe
