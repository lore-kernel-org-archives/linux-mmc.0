From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: TMIO MMC: full patchset.
Date: Fri, 2 Oct 2009 08:23:09 +0100
Message-ID: <c09aa50a0910020023l22478ac2v1205f6c90994b3f8@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	<aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	<c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	<aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	<20090930183932.7b90456f.akpm@linux-foundation.org> <aec7e5c30910012317w52c639f0lc87a60c9fc1b51e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:38147 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbZJBHXZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 03:23:25 -0400
Received: by fxm27 with SMTP id 27so750839fxm.17
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2009 00:23:29 -0700 (PDT)
In-Reply-To: <aec7e5c30910012317w52c639f0lc87a60c9fc1b51e2@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com

I'd prefer to see both the superH and ASIC3 MFD core drivers working
with the new tmio-mmc.c without needing changes made to tmoi-mmc.c
before we merge anything. I expect you can get the superH MFD driver
written in about 15 minutes (copy tc6387xb, drop the CNF related io,
and tweak to taste), so it shouldnt be much of a hardship.

I *think* I've done enough to support superH now, but I'd like to be
sure, and thus wait for Philipp to have his say.

It wont take long, be patient.

-Ian

2009/10/2 Magnus Damm <magnus.damm@gmail.com>:
> On Thu, Oct 1, 2009 at 10:39 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Thu, 1 Oct 2009 10:30:42 +0900 Magnus Damm <magnus.damm@gmail.com> wrote:
>>
>>> Any chance we can get at least the ian-0001 patch and the kconfig bit
>>> merged in 2.6.32-rc?
>>
>> <wakes up>
>>
>> Please flag the proposed merge plans clearly in the description when
>> you send out the patch series and lets take a look at it then.
>
> I propose the following merge order:
>
> 1) The following MMC specific patch from Ian gets merged first:
> [PATCH 1/5] MMC: hardware abstraction for CNF area
> (maybe we need a new version of that one?)
>
> 2) My series is then merged through the SuperH tree:
> [PATCH 00/07] sh: SuperH Mobile SDHI changes
> (I may need to rework some patches after feedback)
>
> I'd like to see this in 2.6.32 since it's a fairly insular change and
> we've been struggling with this issue for more than half a year now.
> It would be nice to not delay it any further.
>
> Cheers,
>
> / magnus
>



-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
