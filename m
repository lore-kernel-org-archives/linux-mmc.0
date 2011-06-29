From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 10:39:45 -0700
Message-ID: <87y60ksfj2.fsf@ti.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
	<BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
	<87ei2dy9zk.fsf@ti.com>
	<BANLkTimccmdwXW2=jnAhv4GbzhcNPsUDQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <BANLkTimccmdwXW2=jnAhv4GbzhcNPsUDQA@mail.gmail.com>
	(T. Krishnamoorthy's message of "Wed, 29 Jun 2011 20:03:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

"T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:

> On Wed, Jun 29, 2011 at 2:00 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:
>>
>>> On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> wr=
ote:
>>>> (cc'ing Adrian also)
>>>>
>>>> Hi Balaji
>>>>
>>>> On Wed, 22 Jun 2011, Balaji T K wrote:
>>>>
>>>>> Use runtime autosuspend APIs to enable auto suspend delay
>>>>
>>>> Does this really need to use runtime autosuspend? =C2=A0Seems to m=
e that since
>>>> PM runtime is just controlling the MMC IP blocks and not the regul=
ators in
>>>> this instance, this could simply use pm_runtime_put*() and just av=
oid the
>>>> extra power wastage and complexity involved in autosuspend.
>>>>
>>>
>>> I have seen some instabilities if delay is very less, on some produ=
ction boards.
>>> The previous implementation used 100ms delay before disabling the c=
locks.
>>
>> And your new one is using 50ms. =C2=A0How did this value come about?
>>

> I don't have any specific affinity to this number, but when requests
> are bursty, they arrive within a few 10s of ms within each
> other. Didn't want to have the context/save restore penalty associate=
d
> with every request.

Have you measured the context save/restore penalty when only the clocks
are gated (and no regulators involved) ?

In the current code, it's understandable why there were large latencies
that were avoided because the regulators were also cut.  With only the
clocks being cut, the latency involved will be significantly less.

>> As Paul mentioned, the timeout value here is probably usecase depeen=
d
>>
>
> There is no direct relationship to the use case. Block layer buffers
> and reworks the order of requests and they are usually queued
> together. Having no context save / restore penalty for each request i=
s
> definitely desirable. =20

Desirable for what?

What is implied in that statement is desirable for performance.

What if a different user would prefer the power savings gained by more
aggressively cuttting clocks over the performance gains of leaving
clocks enabled?

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
