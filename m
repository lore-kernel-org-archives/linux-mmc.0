From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Sun, 15 Jul 2012 22:46:01 -0400
Message-ID: <87pq7wjudy.fsf@octavius.laptop.org>
References: <1338576911-17089-1-git-send-email-merez@codeaurora.org>
	<1338576911-17089-2-git-send-email-merez@codeaurora.org>
	<CAFR8uefCD_WXDM6m+-XwG10+W0UXqOtK7_sxWD3uVckh3pnR-Q@mail.gmail.com>
	<CAFR8uee7hWLC-h_abZOCEuqeUeuhDuJp74x3R-3n+c61xyfaPQ@mail.gmail.com>
	<fb2303ea3a3a5470e76d1faa2abd471b.squirrel@www.codeaurora.org>
	<CAFR8ueecGqw=JzAGVHV61-SqOnn_C-ryT54KCQCbKkJpXUGY9w@mail.gmail.com>
	<87629qkvgp.fsf@octavius.laptop.org>
	<CAFR8uedwb1_gB-j6=riUuiJcEPY13rNJCLv1bxXc6aebnhonYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFR8uedwb1_gB-j6=riUuiJcEPY13rNJCLv1bxXc6aebnhonYw@mail.gmail.com>
	(Muthu Kumar's message of "Sun, 15 Jul 2012 18:49:09 -0700")
Sender: linux-doc-owner@vger.kernel.org
To: Muthu Kumar <muthu.lkml@gmail.com>
Cc: merez@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, DOCUMENTATION <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Jul 15 2012, Muthu Kumar wrote:
>> I've already replied to a later version of the patch, but just to get
>> this comment in at the appropriate point of the discussion as well:
>>
>> Even though it would result in a cleaner sysfs, I don't want to do
>> this now because it will break userspace scripts that are depending
>> on the current locations of these attributes.
>
> Maya is adding a new sysfs attribute with that patch. So, there should
> not be any user space stuff that depends on it.

In the later patchset, Maya's "[PATCH v4 1/2] mmc: card: Move MMC
specific attributes to mmc sub-directory" moves the existing attributes
into the mmc/ directory.

It's that move that I'm objecting to, rather than the creation of a new
directory -- although since we're going to leave the current attributes
where they are, it might not make sense to add the new directory.

We'd be creating two places that people have to look for mmc-related
attributes, which is arguably less clean than having one place to look
even though it's mixed in with the other block device attributes.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
