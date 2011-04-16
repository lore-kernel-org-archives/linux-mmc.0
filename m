From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
Date: Sat, 16 Apr 2011 05:04:30 -0500
Message-ID: <BANLkTikc1x5K7X+tZ-rHLYeO+frZ7YXJkg@mail.gmail.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<1302863942-1774-2-git-send-email-arindam.nath@amd.com>
	<BANLkTimZGonC+D0czjiY4i7pFFW=upj_qw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB443FB6@SAUSEXMBP01.amd.com>
	<BANLkTimEKQceSiuL=dX2yhMw+MLu7BzLvQ@mail.gmail.com>
	<BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
	<BANLkTikoAWEMGOAHrxJT4jNknVFtyuhdqw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB44434B@SAUSEXMBP01.amd.com>
	<BANLkTimUrvnkg5dxiSh6cmToR_QTpYtnyw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB44436E@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:46581 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1DPKEd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 06:04:33 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GA4tEp006389
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:04:55 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GA4coD006378
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:04:54 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so4665843wyb.15
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 03:04:30 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB44436E@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Apr 16, 2011 at 4:40 AM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
> Hi Andrei,
>
>
>> -----Original Message-----
>> From: Andrei Warkentin [mailto:andreiw@motorola.com]
>> Sent: Saturday, April 16, 2011 2:38 PM
>> To: Nath, Arindam
>> Cc: linux-mmc@vger.kernel.org
>> Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
>>
>> On Sat, Apr 16, 2011 at 12:25 AM, Nath, Arindam <Arindam.Nath@amd.com>
>> wrote:
>> > Hi Andrei,
>> >
>> > I saw in one of the community threads that you also have a patch
>> ready for supporting Auto CMD23 for SDHCI. Can you share the same with
>> us? I would like to take a look at your patch first before deciding
>> whether it would make sense for controllers which comply with Host
>> Controller Spec v3.00.
>> >
>>
>> Will send updated patch set in a few. You and Subhash are on the Cc.
>> Once again, the Auto-CMD23 is completely untested. I would be
>> extremely grateful if you can verify it.
>
> Yes, I can do that. On that note, I have a suggestion. Since the Auto CMD23 feature is separate and none of my other patches depend on this, I would rather re-submit V3 patches except for the Auto CMD23 feature. Then once your patches have been accepted and tested, we can enable Auto CMD23 feature in the kernel. Let me know what you think.

Sure, great! I've just mailed the v3 of my patch set, so I'm looking
forward to any comments you have and any problems you uncover with
Auto-CMD23.

>
>> Is there any kind of error injection mechanism you guys use to verify
>> the error paths for Auto 12/23?
>
> None in particular.
>

I am starting to wish I had a "fake" MMC or SD card I could program to
fail in various spectacular ways...

A
