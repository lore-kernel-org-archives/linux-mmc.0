From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: Re: FLUSH mechanism implementation in block layer
Date: Wed, 10 Apr 2013 09:13:01 +0300
Message-ID: <516502ED.8040307@codeaurora.org>
References: <51617172.10300@codeaurora.org> <20130407163345.GC12038@htj.dyndns.org> <51624547.6000500@codeaurora.org> <20130409190336.GG6186@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:62263 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3DJGNG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Apr 2013 02:13:06 -0400
In-Reply-To: <20130409190336.GG6186@mtj.dyndns.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mmc@vger.kernel.org, merez@codeaurora.org, kdorfman@codeaurora.org

Hi Tejun

Thank you for the detailed explanation!

Best Regards
Tanya Brokhman
-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation

On 4/9/2013 10:03 PM, Tejun Heo wrote:
> Hey,
>
> On Mon, Apr 08, 2013 at 07:19:19AM +0300, Tanya Brokhman wrote:
>> completed after the FLUSH. But perhaps there is a correct way to
>> move the implementation of "ordering around the flush" to the block
>> layer? Not that it would work better, it just feels that logically -
>> block layer is the place to do it at.
>> What do you think?
>
> It used to be implemented that way - REQ_BARRIER.  The problem was
> that filesystems wanted multiple dependency streams - ie. fdatasync()
> of a file doesn't need to drain all other IOs in progress.  We could
> do coloring of IOs - ie. give IOs which may need flushing later but
> belong to different dependency streams different colors and let block
> layer figure out partial drainining, which would work but at the same
> time be pretty nasty and complex.  The thing was that most filesystems
> were already drainings IOs and didn't need any ordering guarantee from
> block layer.  hch took care of the outliers which were depending on
> REQ_BARRIER ordering guarantees and we just stripped the ordering
> mechanism which immediately improved performance noticeably in certain
> workloads.
>
> It was done that way mostly out of convenience at that time but now I
> think of it it's the correct thing to do.  It just is too much
> information to communicate downwards and the extra communication
> overhead doesn't really buy anything.
>
> Thanks.
>



