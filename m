From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: Changing the way MMC block request ends
Date: Fri, 6 Apr 2012 19:38:01 +0530
Message-ID: <000001cd13fe$af084c70$0d18e550$@codeaurora.org>
References: <000001cd12ef$69e743e0$3db5cba0$@codeaurora.org>	<000001cd13bb$b774ce30$265e6a90$@codeaurora.org> <87y5q92cg3.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:63280 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757254Ab2DFOIE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Apr 2012 10:08:04 -0400
In-Reply-To: <87y5q92cg3.fsf@laptop.org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi Chris,

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Chris Ball
> Sent: Friday, April 06, 2012 7:24 PM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org
> Subject: Re: Changing the way MMC block request ends
> 
> Hi Subhash,
> 
> On Fri, Apr 06 2012, Subhash Jadavani wrote:
> > I looked into blk_update_bidi_request() function and it mainly updates
> > bio's of a request and doesn't look to do any manipulation with
> > request queue structure of block device. There are many block drivers
> > (SCSI, IDE etc .) other than MMC uses blk_end_request() rather than
> > __blk_end_request(). Was there any special reason we are using
> > __blk_end_request() in MMC block driver? If there is no specific
> > reason, I would like to post a patch which would make MMC driver to use
> blk_end_request().
> 
> It looks like we've been using __blk_end_request() since fd539832c in
2007,
> which is as long as we've been using the blk_end_request API.
> 
> I haven't looked into it more closely, but it seems so far like there is
no
> specific reason, and you should go ahead and post a patch along with your
> experimental results.  Thanks!

Thanks. Sure, will post the patch along with my test results.

Regards,
Subhash

> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

