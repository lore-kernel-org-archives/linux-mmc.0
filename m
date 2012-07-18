From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Wed, 18 Jul 2012 03:26:24 -0400
Message-ID: <87vchlmswv.fsf@octavius.laptop.org>
References: <1338576911-17089-1-git-send-email-merez@codeaurora.org>
	<1338576911-17089-2-git-send-email-merez@codeaurora.org>
	<CAFR8uefCD_WXDM6m+-XwG10+W0UXqOtK7_sxWD3uVckh3pnR-Q@mail.gmail.com>
	<CAFR8uee7hWLC-h_abZOCEuqeUeuhDuJp74x3R-3n+c61xyfaPQ@mail.gmail.com>
	<fb2303ea3a3a5470e76d1faa2abd471b.squirrel@www.codeaurora.org>
	<CAFR8ueecGqw=JzAGVHV61-SqOnn_C-ryT54KCQCbKkJpXUGY9w@mail.gmail.com>
	<87629qkvgp.fsf@octavius.laptop.org>
	<CAFR8uedwb1_gB-j6=riUuiJcEPY13rNJCLv1bxXc6aebnhonYw@mail.gmail.com>
	<87pq7wjudy.fsf@octavius.laptop.org>
	<CAFR8uefP0VV2fbBLv27y2KnMPRFPbGssm6EUdaqhZXXyQ2+k2Q@mail.gmail.com>
	<87pq7ungsw.fsf@octavius.laptop.org>
	<31ba3fefcfc5352a6c41955a4e07ae8f.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <31ba3fefcfc5352a6c41955a4e07ae8f.squirrel@www.codeaurora.org>
	(merez@codeaurora.org's message of "Tue, 17 Jul 2012 23:34:38 -0700
	(PDT)")
Sender: linux-arm-msm-owner@vger.kernel.org
To: merez@codeaurora.org
Cc: Muthu Kumar <muthu.lkml@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,  [removing Jens and the documentation list, since now we're
talking about the MMC side only]

On Wed, Jul 18 2012, merez@codeaurora.org wrote:
> Is there anything else that holds this patch from being pushed to mmc-next?

Yes, I'm still uncomfortable with the write packing patchsets for a
couple of reasons, and I suspect that the sum of those reasons means
that we should probably plan on holding off merging it until after 3.6.

Here are the open issues; please correct any misunderstandings:

With Seungwon's patchset ("Support packed write command"):

* I still don't have a good set of representative benchmarks showing
  what kind of performance changes come with this patchset.  It seems
  like we've had a small amount of testing on one controller/eMMC part
  combo from Seungwon, and an entirely different test from Maya, and the
  results aren't documented fully anywhere to the level of describing
  what the hardware was, what the test was, and what the results were
  before and after the patchset.

With the reads-during-writes regression:

* Venkat still has open questions about the nature of the read
  regression, and thinks we should understand it with blktrace before
  trying to fix it.  Maya has a theory about writes overwhelming reads,
  but Venkat doesn't understand why this would explain the observed
  bandwidth drop.

With Maya's patchset ("write packing control"):

* Venkat thinks that HPI should be used, and the number-of-requests
  metric is too coarse, and it doesn't let you disable packing at the
  right time, and you're essentially implementing a new I/O scheduler
  inside the MMC subsystem without understanding the root cause for
  why that's necessary.

My sense is that there's no way we can solve all of these to
satisfaction in the next week (which is when the merge window will
open), but that by waiting a cycle we might come up with some good
answers.

What do other people think?  If you're excited about these patchsets,
now would be a fine time to come forward with your benchmarking results
and to help understand the reads-during-writes regression.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
