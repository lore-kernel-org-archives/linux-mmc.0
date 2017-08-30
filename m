From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: bounce limit in mmc?
Date: Wed, 30 Aug 2017 14:14:30 +0800
Message-ID: <9df8e5a2-b802-72fb-f28e-13c60ba27c49@rock-chips.com>
References: <20170828174808.GA8384@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:60640 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdH3GOh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 02:14:37 -0400
In-Reply-To: <20170828174808.GA8384@infradead.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com

Hi Christoph,

On 2017/8/29 1:48, Christoph Hellwig wrote:
> Hi all, any idea why the mmc driver defaults to bouncing highmem
> pages if the device doesn't have a DMA mask?  highmem is defined
> different on different architectures or even based on config options,
> so it seems like a very odd choice.

Not sure why mmc stack defaults to use BLK_BOUNCE_HIGH as it seems that
it has been there when mmc was added into linux.

I *guess* this is a copy-and-paste from other block drivers, especially
see drivers/memstick/core/ms_block.c which does actual the same thing.

And that raises another question that if mmc stack doesn't defaults to
boucing highmem pages but host drivers don't provide DMA mask either, so
what should we use for saftly limiting bouncing for DMA capable?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

