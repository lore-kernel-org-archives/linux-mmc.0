From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 20:03:58 +0530
Message-ID: <BANLkTimccmdwXW2=jnAhv4GbzhcNPsUDQA@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
	<BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
	<87ei2dy9zk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53443 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755885Ab1F2OeK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 10:34:10 -0400
In-Reply-To: <87ei2dy9zk.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com

On Wed, Jun 29, 2011 at 2:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> "T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:
>
>> On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> wro=
te:
>>> (cc'ing Adrian also)
>>>
>>> Hi Balaji
>>>
>>> On Wed, 22 Jun 2011, Balaji T K wrote:
>>>
>>>> Use runtime autosuspend APIs to enable auto suspend delay
>>>
>>> Does this really need to use runtime autosuspend? =A0Seems to me th=
at since
>>> PM runtime is just controlling the MMC IP blocks and not the regula=
tors in
>>> this instance, this could simply use pm_runtime_put*() and just avo=
id the
>>> extra power wastage and complexity involved in autosuspend.
>>>
>>
>> I have seen some instabilities if delay is very less, on some produc=
tion boards.
>> The previous implementation used 100ms delay before disabling the cl=
ocks.
>
> And your new one is using 50ms. =A0How did this value come about?
>
I don't have any specific affinity to this number, but when requests
are bursty, they arrive
within a few 10s of ms within each other. Didn't want to have the
context/save restore
penalty associated with every request.

> As Paul mentioned, the timeout value here is probably usecase depeend
>

There is no direct relationship to the use case. Block layer buffers
and reworks the order
of requests and they are usually queued together. Having no context
save / restore
penalty for each request is definitely desirable.
(As I understand, MMC can lose context independent of MPU on OMAP4).
