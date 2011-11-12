From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Fri, 11 Nov 2011 20:21:44 -0500
Message-ID: <878vnmjftj.fsf@laptop.org>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com>
	<CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
	<4EA7EEBC.2070109@st.com>
	<CAAgDR1NhqOkDZ8M18Uc6CtWtZSy153wOnuxjhQ-m7aitPwitLQ@mail.gmail.com>
	<4EAA5F02.2080702@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35673 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846Ab1KLBVq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 20:21:46 -0500
In-Reply-To: <4EAA5F02.2080702@st.com> (Giuseppe CAVALLARO's message of "Fri,
	28 Oct 2011 09:51:30 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Sebastian Rasmussen <sebras@gmail.com>, linux-mmc@vger.kernel.org

Hi Giuseppe,

On Fri, Oct 28 2011, Giuseppe CAVALLARO wrote:
> On 10/27/2011 4:19 PM, Sebastian Rasmussen wrote:
>> Hi!
>> 
>>> Before the patch the output from /sys/kernel/debug/mmc0/mmc0:0001/ext_csd
>>> was a big number and I had many problems parsing it in real-time.
>>> [...]
>>> In any case, the patch wants to help to directly get the ext_csd in a
>>> human format.
>> 
>> Yes, I realize this. However I'm unsure whether this parsing should be
>> done in kernelspace at all. If your patch is accepted then it is obvious
>> that people think this belongs in kernelspace rather than in userspace.
>
> I've found really useful to have this kind of parsing in Kernel space
> because, fortunately, we are also using the kernel to validate the HW on
> our platforms.

sysfs has a strict one-value-per-file rule which this patch breaks, but
I can see putting something like this in debugfs instead.  I'm wary of
committing to maintaining a parser for this information in the kernel,
though -- does anyone have advice on where this ought to be done?

I wonder if we should start an MMC userspace tools repository containing
code for features like the cmd passthrough ioctl, secure erase/trim/discard
requests, and debugging output of the type this patch provides.  On the
other hand, maybe existing similar tools should just be modified to
learn about how to deal with MMC?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
