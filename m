From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: Re: FLUSH mechanism implementation in block layer
Date: Mon, 08 Apr 2013 07:19:19 +0300
Message-ID: <51624547.6000500@codeaurora.org>
References: <51617172.10300@codeaurora.org> <20130407163345.GC12038@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:52896 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab3DHETY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 00:19:24 -0400
In-Reply-To: <20130407163345.GC12038@htj.dyndns.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mmc@vger.kernel.org, merez@codeaurora.org, kdorfman@codeaurora.org

Hi Tejun,

Thank you for the prompt response.
>
> Which version of kernel are you looking at?  The barrier / flush
> implementation went through several iterations and in the current
> iteration ordering of requests around the flush request is the
> responsibility of higher layer - ie. filesystems are required to wait
> for completions of commands which should come before flush before
> issuing it.
>
> Thanks.
>


That is the conclusion I came to as well. I was looking at kernel3.4 but 
if I'm not mistaken it's the same at kernel3.7 as well.
Could you please tell me why it was designed this way? It seems to me 
that if the application is issuing async requests it shouldn't be the 
applications responsibility to wait for their completion if the 
execution order is important. I mean, it feels like the FLUSH should be 
implemented by the lower layers (block, device driver, card) and in the 
current situation, you may say that FLUSH is partially implemented by 
the application.
At first I didn't understand why in case of FLUSH the elevator is not 
drained. Later I understood that it's not efficient since there might be 
requests from other tasks as well there that can be completed after the 
FLUSH. But perhaps there is a correct way to move the implementation of 
"ordering around the flush" to the block layer? Not that it would work 
better, it just feels that logically - block layer is the place to do it 
at.
What do you think?

Best Regards,
Tanya Brokhman
-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
