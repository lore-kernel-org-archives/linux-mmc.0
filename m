From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Tue, 17 Jul 2012 09:45:21 +0530
Message-ID: <CANfBPZ-qbm58+kypgYChjUmpWdJbiD2oPhWNq9PF1mT1kmpDbw@mail.gmail.com>
References: <1338576911-17089-1-git-send-email-merez@codeaurora.org>
 <1338576911-17089-2-git-send-email-merez@codeaurora.org> <CAFR8uefCD_WXDM6m+-XwG10+W0UXqOtK7_sxWD3uVckh3pnR-Q@mail.gmail.com>
 <CAFR8uee7hWLC-h_abZOCEuqeUeuhDuJp74x3R-3n+c61xyfaPQ@mail.gmail.com>
 <fb2303ea3a3a5470e76d1faa2abd471b.squirrel@www.codeaurora.org>
 <CAFR8ueecGqw=JzAGVHV61-SqOnn_C-ryT54KCQCbKkJpXUGY9w@mail.gmail.com>
 <87629qkvgp.fsf@octavius.laptop.org> <CAFR8uedwb1_gB-j6=riUuiJcEPY13rNJCLv1bxXc6aebnhonYw@mail.gmail.com>
 <87pq7wjudy.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43350 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750712Ab2GQEPn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 00:15:43 -0400
Received: by vbbfr13 with SMTP id fr13so4507015vbb.34
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jul 2012 21:15:41 -0700 (PDT)
In-Reply-To: <87pq7wjudy.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Muthu Kumar <muthu.lkml@gmail.com>, merez@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, DOCUMENTATION <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Jul 16, 2012 at 8:16 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Sun, Jul 15 2012, Muthu Kumar wrote:
>>> I've already replied to a later version of the patch, but just to get
>>> this comment in at the appropriate point of the discussion as well:
>>>
>>> Even though it would result in a cleaner sysfs, I don't want to do
>>> this now because it will break userspace scripts that are depending
>>> on the current locations of these attributes.
>>
>> Maya is adding a new sysfs attribute with that patch. So, there should
>> not be any user space stuff that depends on it.
>
> In the later patchset, Maya's "[PATCH v4 1/2] mmc: card: Move MMC
> specific attributes to mmc sub-directory" moves the existing attributes
> into the mmc/ directory.
>
> It's that move that I'm objecting to, rather than the creation of a new
> directory -- although since we're going to leave the current attributes
> where they are, it might not make sense to add the new directory.
>
> We'd be creating two places that people have to look for mmc-related
> attributes, which is arguably less clean than having one place to look
> even though it's mixed in with the other block device attributes.
>

It's better to normalise this eventually. It would be better if we create a
duplicate sysfs entry within MMC, which is identical to the current
block layer attribute. Then schedule the block layer attribute to be
removed by, say, 3.9. [Add it to Documentation/feature-removal-schedule.txt]

Since it is a MMC specific attribute, generic tools wouldn't depend on it.
