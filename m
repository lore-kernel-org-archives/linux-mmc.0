From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Wed, 11 Apr 2012 00:21:30 +0530
Message-ID: <000201cd174a$f3019b80$d904d280$@codeaurora.org>
References: <1334082412-2821-1-git-send-email-subhashj@codeaurora.org> <87pqbfv3e1.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <87pqbfv3e1.fsf@laptop.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, April 11, 2012 12:08 AM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org
> Subject: Re: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with
> blk_end_request()
> 
> Hi,
> 
> On Tue, Apr 10 2012, Subhash Jadavani wrote:
> > This patch replaces all __blk_end_request() calls with
> > blk_end_request() and __blk_end_request_all() calls with
> > blk_end_request_all().
> >
> > Testing done: 20 process concurrent read/write on sd card and eMMC.
> > Ran this test for almost a day on multicore system and no errors
> > observed.
> 
> Is there a measurable improvement in throughput or latency that you can
show
> data for?

This change was not meant for improving MMC throughput; it's basically about
becoming fair to other threads/interrupts in the system. By holding spin
lock and interrupts disabled for longer duration, we won't allow other
threads/interrupts to run at all.
Actually slight performance degradation at file system level can be expected
as we are not holding the spin lock during blk_update_bidi_request() which
means our mmcqd thread may get preempted for other high priority thread or
any interrupt in the system.

These are performance numbers (100MB file write) with eMMC running in DDR
mode:

Without this patch:
	Name of the Test	Value	Unit	
	LMDD Read Test	53.79	MBPS
	LMDD Write Test	18.86	MBPS
	IOZONE  Read Test	51.65	MBPS
	IOZONE  Write Test	24.36	MBPS

With this patch:

	Name of the Test	Value	Unit	
	LMDD Read Test	52.94	MBPS	
	LMDD Write Test	16.70	MBPS	
	IOZONE  Read Test	52.08	MBPS	
	IOZONE  Write Test	23.29	MBPS	

Read numbers are fine. Write numbers are bit down (especially LMDD write),
may be because write requests normally have large transfer size and which
means there are chances that while mmcq is executing
blk_update_bidi_request(), it may get interrupted by interrupts or other
high priority thread.

Regards,
Subhash

> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
