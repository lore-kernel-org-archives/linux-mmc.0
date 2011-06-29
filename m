From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 19:47:28 +0530
Message-ID: <BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
	<BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
	<alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38355 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755947Ab1F2OYn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 10:24:43 -0400
In-Reply-To: <alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com

On Wed, Jun 29, 2011 at 12:11 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 28 Jun 2011, T Krishnamoorthy, Balaji wrote:
>
>> On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> >
>> > On Wed, 22 Jun 2011, Balaji T K wrote:
>> >
>> >> Use runtime autosuspend APIs to enable auto suspend delay
>> >
>> > Does this really need to use runtime autosuspend? =A0Seems to me t=
hat since
>> > PM runtime is just controlling the MMC IP blocks and not the regul=
ators in
>> > this instance, this could simply use pm_runtime_put*() and just av=
oid the
>> > extra power wastage and complexity involved in autosuspend.
>>
>> I have seen some instabilities if delay is very less, on some produc=
tion boards.
>
> Could you be more specific? =A0What type of instabilities did you see=
?

There have been some experiments on our customer programs to reduce thi=
s
value to a few ms and infrequent crashes were observed (stress testing
for several hours) while
trying to access the controller registers.

>
>> The previous implementation used 100ms delay before disabling the cl=
ocks.
>> Is there any specific issue I should be aware of, for using _autosus=
pend ?
>
>
> - Paul
