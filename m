From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 1/6] mmc: block: Resume multi-block reads after transient
 read errors.
Date: Wed, 27 Apr 2011 03:42:55 -0500
Message-ID: <BANLkTim9APC_WwdZM0ODVghrTi9vzakfpg@mail.gmail.com>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
	<1303520502-32171-2-git-send-email-john.stultz@linaro.org>
	<201104261519.26622.arnd@arndb.de>
	<4DB7D0D7.2000402@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:51369 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab1D0Im5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 04:42:57 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R8etBc000522
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 04:40:55 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3R8eEGm000300
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 04:40:55 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1424147wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 01:42:55 -0700 (PDT)
In-Reply-To: <4DB7D0D7.2000402@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, linux-mmc@vger.kernel.org, David Ding <david.j.ding@motorola.com>, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>, Bentao Zou <bzou1@motorola.com>, San Mehat <san@google.com>

On Wed, Apr 27, 2011 at 3:16 AM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> On 26/04/11 16:19, Arnd Bergmann wrote:
>>
>> On Saturday 23 April 2011, John Stultz wrote:
>>>
>>> From: David Ding<david.j.ding@motorola.com>
>>>
>>> CC: Chris Ball<cjb@laptop.org>
>>> CC: Arnd Bergmann<arnd@arndb.de>
>>> CC: Dima Zavin<dima@android.com>
>>> Signed-off-by: Bentao Zou<bzou1@motorola.com>
>>> Signed-off-by: David Ding<david.j.ding@motorola.com>
>>> Signed-off-by: San Mehat<san@google.com>
>>> Signed-off-by: John Stultz<john.stultz@linaro.org>
>>
>> The disable_multi logic was introduced in 6a79e391 "mmc_block: ensure
>> all sectors that do not have errors are read" by Adrian Hunter. Maybe
>> he can comment on this.
>>
>> My impression is that the code makes more sense without this
>> add-on patch, because the flag is set for exactly one request
>> and makes mmc_blk_issue_rw_rq issue all blocks in that request
>> one by one up to the first error, while after the patch,
>> we would read one sector, then read the remaining request at
>> once, fail, and read the next sector, and so on.
>>

You could definitely interpret the retry path as being:
- do a probe sector-sized read/write
- if it succeeds, pretend everything is fine and retry with disable_multi=0
- else the probed sector must the point of failure

...it would mean more retrying in the case of an actual card failure
mode (at which point you're not doing much anyway), and drastic
improvement in the case of some one-time (or not so one-time) host
glitches...

The other thought I have is that it's not ideal to overcomplicate the
logic inside issue_rw_rq (i.e. bisection stuff). Until Per's
refactoring as part of async issue it was already too big :-).

What do you think?

Anyway I hope the patch owner weighs in.

A
