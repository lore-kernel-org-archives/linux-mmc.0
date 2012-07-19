From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: reset sigal voltage on power up
Date: Thu, 19 Jul 2012 02:20:54 -0400
Message-ID: <87hat49sqh.fsf@octavius.laptop.org>
References: <1341910537-13647-1-git-send-email-aaron.lu@amd.com>
	<CANfBPZ8ASnXFnz92DMZwd-03UQg_7cTdiR_CC41=BwvR08Aw5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40494 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2GSGVD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jul 2012 02:21:03 -0400
In-Reply-To: <CANfBPZ8ASnXFnz92DMZwd-03UQg_7cTdiR_CC41=BwvR08Aw5Q@mail.gmail.com>
	(Venkatraman S.'s message of "Tue, 17 Jul 2012 16:46:25 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Aaron Lu <aaron.lu@amd.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Philip Rakity <prakity@marvell.com>, Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Tue, Jul 17 2012, S, Venkatraman wrote:
> On Tue, Jul 10, 2012 at 2:25 PM, Aaron Lu <aaron.lu@amd.com> wrote:
>> Add a call to mmc_set_signal_voltage to set signal voltage to 3.3v in
>> mmc_power_up so that we do not need to touch signal voltage setting in
>> mmc/sd/sdio init functions and rescan function.
>>
>> For mmc/sd cards, when doing a suspend/resume cycle, consider the unsafe
>> resume case, the card will lose its power and when powered on again, we
>> will set signal voltage to 3.3v in mmc_power_up before its resume function
>> gets called, which will re-init the card.
>>
>> And for sdio cards, when doing a suspend/resume cycle, consider the unsafe
>> resume case, the card will either lose its power or not depending on if it
>> wants to wakeup the host. If power is not maintained, it is the same case as
>> mmc/sd cards. If power is maintained, mmc_power_up will not be called and
>> the card's signal voltage will remain at the last setting.
>>
>> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
>
> Nice cleanup. I tested this patch on my OMAP board for MMC and SD,
> but not for SDIO..
> Tested-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
