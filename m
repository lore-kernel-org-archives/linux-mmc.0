From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: convert the variable type of irq
Date: Tue, 23 Oct 2012 17:03:53 -0400
Message-ID: <873914j3ye.fsf@octavius.laptop.org>
References: <00f901cd9d39$2f84c720$8e8e5560$%jun@samsung.com>
	<CAFbHwiSZ9Wi+cTxvMWLm2U84jOVstrZNhwjDgXJZzW3ZSCB8gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55224 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933695Ab2JWVD6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 17:03:58 -0400
In-Reply-To: <CAFbHwiSZ9Wi+cTxvMWLm2U84jOVstrZNhwjDgXJZzW3ZSCB8gg@mail.gmail.com>
	(Will Newton's message of "Fri, 28 Sep 2012 11:00:24 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Hi,

On Fri, Sep 28 2012, Will Newton wrote:
> On Fri, Sep 28, 2012 at 6:21 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> Even though platform_get_irq returns error, 'host->irq'
>> always has an unsigned value. Less-than-zero comparison
>> of an unsigned value is never true. Type of 'unsigned int'
>> will be changed for 'int'.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>  include/linux/mmc/dw_mmc.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
