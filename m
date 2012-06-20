From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: Fix null dma_ops access when use_dma is false
Date: Wed, 20 Jun 2012 02:34:57 -0400
Message-ID: <87boke4hke.fsf@octavius.laptop.org>
References: <1339695115-606-1-git-send-email-kliegs@chromium.org>
	<4FDAE34C.1030102@samsung.com>
	<CAFbHwiRo9J+ZkaK7YUcVvtxN5TkmvxUy-q-EDgngve-t+oJ0CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58321 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab2FTGfC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 02:35:02 -0400
In-Reply-To: <CAFbHwiRo9J+ZkaK7YUcVvtxN5TkmvxUy-q-EDgngve-t+oJ0CQ@mail.gmail.com>
	(Will Newton's message of "Fri, 15 Jun 2012 14:14:48 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Jonathan Kliegman <kliegs@chromium.org>, linux-mmc@vger.kernel.org, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Hi,

On Fri, Jun 15 2012, Will Newton wrote:
> On Fri, Jun 15, 2012 at 8:25 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> It looks good to me.
>>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> On 06/15/2012 02:31 AM, Jonathan Kliegman wrote:
>>
>>> host->dma_ops is not valid if host->usa dma is 0 so protect
>>> host->dma_ops reference in dw_mci_resume
>>>
>>> Signed-off-by: Jonathan Kliegman <kliegs@chromium.org>
>
> Yes, looks good to me too.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
