From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Revert "mmc: dw_mmc: Add check for IDMAC configuration"
Date: Wed, 19 Sep 2012 02:03:26 -0400
Message-ID: <m3sjaeim6p.fsf@pullcord.laptop.org>
References: <00d801cd8fc4$738f8540$5aae8fc0$%jun@samsung.com>
	<CAFbHwiRWkCoxm553u8Ep3hF3XZpBihA-2_FW2Y0sVq1RC3riHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53510 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157Ab2ISGDG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 02:03:06 -0400
In-Reply-To: <CAFbHwiRWkCoxm553u8Ep3hF3XZpBihA-2_FW2Y0sVq1RC3riHg@mail.gmail.com>
	(Will Newton's message of "Mon, 17 Sep 2012 12:15:46 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, girish.shivananjappa@linaro.org, James Hogan <James.Hogan@imgtec.com>

Hi,

On Mon, Sep 17 2012, Will Newton wrote:
> On Tue, Sep 11, 2012 at 3:23 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> This reverts commit 94c6cee91(Add check for IDMAC configuration).
>> Synopsys says that only if internal dmac is not present, optional
>> external dma interface is present. When internal dmac is present,
>> '0' value in DMA_INTERFACE of HCON is reasonable. DMA_INTERFACE
>> indicates external dma interface. And idmac initialization is
>> prohibited now. So, let's revert this commit.
>>
>> CC: Girish K S <girish.shivananjappa@linaro.org>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |   15 ++-------------
>>  1 files changed, 2 insertions(+), 13 deletions(-)
>
> I think this revert is a good idea. The original patch tries to check
> whether IDMAC is supported and falls back to PIO, but it is not clear
> to me that HCON gives you the appropriate information to do this (at
> least in my version of the manual, I have not tried to clarify this
> with Synopsys). Also falling back to PIO mode seems like it would
> provide pretty awful performance, I would not expect to see instances
> of this block with no DMA support anywhere other than FPGA so
> configuring with IDMAC without it's presence would be a serious
> misconfiguration in any case.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
