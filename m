From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Thu, 30 Jun 2011 10:56:41 +0530
Message-ID: <BANLkTin8vYXwc8cWhDWMQ9O7xuK+1RYnHg@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
	<BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
	<87ei2dy9zk.fsf@ti.com>
	<BANLkTimccmdwXW2=jnAhv4GbzhcNPsUDQA@mail.gmail.com>
	<alpine.DEB.2.00.1106291813580.2874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41995 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752705Ab1F3F0n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jun 2011 01:26:43 -0400
In-Reply-To: <alpine.DEB.2.00.1106291813580.2874@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, Kevin Hilman <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, cjb <cjb@laptop.org>, tony <tony@atomide.com>, "madhu.cr" <madhu.cr@ti.com>, b-cousson <b-cousson@ti.com>

On Thu, Jun 30, 2011 at 6:10 AM, Paul Walmsley <paul@pwsan.com> wrote:
> + Venkat
>
> Hi Balaji
>
> On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:
>
>> On Wed, Jun 29, 2011 at 2:00 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> > "T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:
>> >>
>> >> I have seen some instabilities if delay is very less, on some
>> >> production boards. The previous implementation used 100ms delay
>> >> before disabling the clocks.
>> >
>> > And your new one is using 50ms. =A0How did this value come about?
>>
>> I don't have any specific affinity to this number, but when requests=
 are
>> bursty, they arrive within a few 10s of ms within each other. Didn't
>> want to have the context/save restore penalty associated with every
>> request.
>
> Kevin and I just chatted a little bit about this. =A0It seems best to
> separate the work done on the autosuspend timeout from the runtime PM
> conversion.
>
> So how about this: please send a new version of these patches with th=
e
> previous value, 100ms, for the autosuspend timeout. =A0That should ho=
pefully
> minimize the behavior change here for existing users. =A0And hopefull=
y we'll
> be able to get the series in for this merge window.
>
> Then later, we need to come back to this autosuspend timeout issue.
>

Ok.
