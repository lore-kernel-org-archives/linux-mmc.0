From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: Changing the way MMC block request ends
Date: Fri, 6 Apr 2012 11:38:38 +0530
Message-ID: <000001cd13bb$b774ce30$265e6a90$@codeaurora.org>
References: <000001cd12ef$69e743e0$3db5cba0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <000001cd12ef$69e743e0$3db5cba0$@codeaurora.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Any thoughts or suggestions on this?

Regards,
Subhash

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
> Sent: Thursday, April 05, 2012 11:16 AM
> To: linux-mmc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Subject: Changing the way MMC block request ends
> 
> Hi,
> 
> For completing any block request, MMC block driver is calling:
>        spin_lock_irq(queue-lock)
>        __blk_end_request()
>        spin_unlock_irq(queue-lock)
> 
> But if we analyze the sources of latency in kernel using ftrace,
> __blk_end_request() function seems to hold a spinlock with interrupts
> disabled for up to 6.5 ms sometimes. __blk_end_request() calls couple of
> functions and ftrace output shows that blk_update_bidi_request() function
> is almost taking 6ms. So I was wondering why can't we use the
> blk_end_request() rather than __blk_end_request(). Both function does the
> same thing except blk_end_request() doesn't take up the spinlock while
> calling the blk_update_bidi_request(). Is there any race condition which
> could occur if we call blk_update_bidi_request() without queue lock?
> 
> I looked into blk_update_bidi_request() function and it mainly updates bio's
> of a request and doesn't look to do any manipulation with request queue
> structure of block device. There are many block drivers (SCSI, IDE etc .) other
> than MMC uses blk_end_request() rather than __blk_end_request(). Was
> there any special reason we are using __blk_end_request() in MMC block
> driver? If there is no specific reason, I would like to post a patch which would
> make MMC driver to use blk_end_request().
> 
> Let me know your thoughts on this.
> 
> Regards,
> Subhash
> 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
