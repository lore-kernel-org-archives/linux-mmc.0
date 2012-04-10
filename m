From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: Fix switch from DMA to PIO
Date: Tue, 10 Apr 2012 10:18:54 -0400
Message-ID: <87aa2jwtyp.fsf@laptop.org>
References: <000601cd16b4$5a409a40$0ec1cec0$%jun@samsung.com>
	<CAFbHwiRAE0G9Yr5Af5cUGsAxw8VNFu0s_NWQ6T3NsLZwGX_Y0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46109 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab2DJOS4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 10:18:56 -0400
In-Reply-To: <CAFbHwiRAE0G9Yr5Af5cUGsAxw8VNFu0s_NWQ6T3NsLZwGX_Y0Q@mail.gmail.com>
	(Will Newton's message of "Tue, 10 Apr 2012 10:54:22 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

Hi,

On Tue, Apr 10 2012, Will Newton wrote:
> On Tue, Apr 10, 2012 at 1:53 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> When dw_mci_pre_dma_transfer returns failure in some reasons,
>> dw_mci_submit_data will prepare to switch the PIO mode from DMA.
>> After switching to PIO mode, DMA(IDMAC in particular) is still
>> enabled. This makes the corruption in handling interrupt and
>> the driver lock-up.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> This looks ok to me.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
