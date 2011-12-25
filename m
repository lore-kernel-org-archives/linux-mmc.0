From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4] mmc: Kill block requests if card is removed
Date: Sat, 24 Dec 2011 20:58:07 -0500
Message-ID: <m2sjk9za34.fsf@bob.laptop.org>
References: <1323333350-14315-1-git-send-email-sthumma@codeaurora.org>
	<4EE081CF.3010303@intel.com> <4EF1BDA7.6070903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55930 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758021Ab1LYB6c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Dec 2011 20:58:32 -0500
In-Reply-To: <4EF1BDA7.6070903@codeaurora.org> (Sujit Reddy Thumma's message
	of "Wed, 21 Dec 2011 16:36:15 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, per.lkml@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Wed, Dec 21 2011, Sujit Reddy Thumma wrote:
> On 12/8/2011 2:52 PM, Adrian Hunter wrote:
>> On 08/12/11 10:35, Sujit Reddy Thumma wrote:
>>> Kill block requests when the host realizes that the card is
>>> removed from the slot and is sure that subsequent requests
>>> are bound to fail. Do this silently so that the block
>>> layer doesn't output unnecessary error messages.
>>>
>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>
>> Acked-by: Adrian Hunter<adrian.hunter@intel.com>
>>
>
> Thanks Adrian.
>
> Chris can you pull this patch with Adrian's ack?

Thanks, pushed to mmc-next for 3.3 with Adrian's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
