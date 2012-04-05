From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: Changing the way MMC block request ends
Date: Thu, 5 Apr 2012 11:16:11 +0530
Message-ID: <000001cd12ef$69e743e0$3db5cba0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

For completing any block request, MMC block driver is calling:
       spin_lock_irq(queue-lock)
       __blk_end_request()
       spin_unlock_irq(queue-lock)

But if we analyze the sources of latency in kernel using ftrace, __blk_end_request() function seems to hold a spinlock with interrupts disabled for up to 6.5 ms sometimes. __blk_end_request() calls couple of functions and ftrace output shows that blk_update_bidi_request() function is almost taking 6ms. So I was wondering why can't we use the blk_end_request() rather than __blk_end_request(). Both function does the same thing except blk_end_request() doesn't take up the spinlock while calling the blk_update_bidi_request(). Is there any race condition which could occur if we call blk_update_bidi_request() without queue lock? 

I looked into blk_update_bidi_request() function and it mainly updates bio's of a request and doesn't look to do any manipulation with request queue structure of block device. There are many block drivers (SCSI, IDE etc .) other than MMC uses blk_end_request() rather than __blk_end_request(). Was there any special reason we are using __blk_end_request() in MMC block driver? If there is no specific reason, I would like to post a patch which would make MMC driver to use blk_end_request().

Let me know your thoughts on this.

Regards,
Subhash

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
