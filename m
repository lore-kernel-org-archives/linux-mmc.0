From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: "Prevent too long response times for suspend" breaks libertas_sdio
Date: Thu, 19 Apr 2012 10:36:13 +0200
Message-ID: <4F8FCE7D.1080900@stericsson.com>
References: <CAMLZHHTTD-jbSrwW9JA_KGxfXj4_WwwC=0KV4PCDHGr25VQ+yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:57424 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753227Ab2DSIgl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Apr 2012 04:36:41 -0400
In-Reply-To: <CAMLZHHTTD-jbSrwW9JA_KGxfXj4_WwwC=0KV4PCDHGr25VQ+yQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Daniel,

On 04/16/2012 10:25 PM, Daniel Drake wrote:
> Hi,
>
> This commit breaks libertas_sdio suspend:
>
> commit b6ad726e3fe69e1ff3c3b2ad272ba3e4c376cd6a
> Author: Ulf Hansson<ulf.hansson@stericsson.com>
> Date:   Thu Oct 13 16:03:58 2011 +0200
>
>      mmc: core: Prevent too long response times for suspend
>
>      While trying to suspend the mmc host there could still be
>      ongoing requests that we need to wait for. At the same time
>      a device driver must respond to a suspend request rather quickly.
>
> This patch causes the device to be claimed while the driver's suspend
> method is called. This seems questionable to me. It should be up to
> the driver to deal with or cancel any pending requests in the
> interests of suspend performance. Even if they take a while to
> complete, it might be best to let them complete rather than discard
> the user's data.
>
> In this case in the suspend handler we have to communicate with the
> card. In libertas_sdio we do the communication in a workqueue
> (because, outside of the suspend routine, sometime we need to initiate
> communication from atomic context), but that seems like an
> implementation detail that shouldn't be trampled upon by the higher
> layers.

Alright, I think I realize your problem.

The workqueue will be hanging waiting for the host to be claimed. At the 
same time libertas_sdio suspend handler, which is called from 
"mmc_sdio_suspend" function will wait for the work to be "synced", but 
since the host is pre-claimed from mmc_suspend_host, it will hang 
forever. Have I got it right?

Not good. :-)

In principle that means the host must not be claimed when calling the 
sdio drivers suspend/resume callbacks.

>
> This method of punishing "badly-behaved" drivers (for some definition
> of the phrase) is also quite harsh. Maybe its just my incompetence but
> it took me a couple of hours to track down why my driver was suddenly
> hanging with no warning message during its suspend routine.

The idea with my patch was to prevent scenarios that kind of should not 
occur, were for example and SDIO driver work queue suddenly wanted to do 
a sdio request at the same time when the host is being suspended. I will 
have to think of another way to handle that then.

Reverting the patch is likely not a good idea, since there has been 
other pieces of code adding the try_claim_host call in the 
mmc_suspend_host function. I think we shall create a "cleanup" patch 
instead, which removes the try_claim_host thing, at least as a first 
step. I am on it immediately.

Then we can you can think of a more long term solution, if still needed.

What do you think?

>
> Can we revisit this?
>
> Thanks,
> Daniel

Kind regards
Ulf Hansson
