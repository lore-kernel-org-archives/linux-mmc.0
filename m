From: Chris Ball <cjb@laptop.org>
Subject: Re: Changing the way MMC block request ends
Date: Fri, 06 Apr 2012 09:54:04 -0400
Message-ID: <87y5q92cg3.fsf@laptop.org>
References: <000001cd12ef$69e743e0$3db5cba0$@codeaurora.org>
	<000001cd13bb$b774ce30$265e6a90$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <000001cd13bb$b774ce30$265e6a90$@codeaurora.org> (Subhash
	Jadavani's message of "Fri, 6 Apr 2012 11:38:38 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Subhash,

On Fri, Apr 06 2012, Subhash Jadavani wrote:
> I looked into blk_update_bidi_request() function and it mainly updates bio's
> of a request and doesn't look to do any manipulation with request queue
> structure of block device. There are many block drivers (SCSI, IDE etc .) other
> than MMC uses blk_end_request() rather than __blk_end_request(). Was
> there any special reason we are using __blk_end_request() in MMC block
> driver? If there is no specific reason, I would like to post a patch which would
> make MMC driver to use blk_end_request().

It looks like we've been using __blk_end_request() since fd539832c in
2007, which is as long as we've been using the blk_end_request API.

I haven't looked into it more closely, but it seems so far like there
is no specific reason, and you should go ahead and post a patch along
with your experimental results.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
