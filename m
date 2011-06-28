From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Tue, 28 Jun 2011 13:30:39 -0700
Message-ID: <87ei2dy9zk.fsf@ti.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
	<BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58588 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708Ab1F1Uao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 16:30:44 -0400
In-Reply-To: <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
	(T. Krishnamoorthy's message of "Tue, 28 Jun 2011 23:18:03 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, adrian.hunter@nokia.com

"T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:

> On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> (cc'ing Adrian also)
>>
>> Hi Balaji
>>
>> On Wed, 22 Jun 2011, Balaji T K wrote:
>>
>>> Use runtime autosuspend APIs to enable auto suspend delay
>>
>> Does this really need to use runtime autosuspend? =C2=A0Seems to me =
that since
>> PM runtime is just controlling the MMC IP blocks and not the regulat=
ors in
>> this instance, this could simply use pm_runtime_put*() and just avoi=
d the
>> extra power wastage and complexity involved in autosuspend.
>>
>
> I have seen some instabilities if delay is very less, on some product=
ion boards.
> The previous implementation used 100ms delay before disabling the clo=
cks.

And your new one is using 50ms.  How did this value come about?

As Paul mentioned, the timeout value here is probably usecase depeend

Kevin
