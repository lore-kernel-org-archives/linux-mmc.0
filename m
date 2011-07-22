From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: sdio add regulator vsdio
Date: Fri, 22 Jul 2011 09:05:56 -0700
Message-ID: <09FC057A-EABC-414A-A6AE-C5309825873A@marvell.com>
References: <1311215673-2489-1-git-send-email-zhangfei.gao@marvell.com>
 <1311215673-2489-2-git-send-email-zhangfei.gao@marvell.com>
 <CAGq3pz6-MQPpsyEWbDQBnnW4q2rXSKFF9qzRvTLtwmzvG+xJKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33448 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666Ab1GVQKF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jul 2011 12:10:05 -0400
In-Reply-To: <CAGq3pz6-MQPpsyEWbDQBnnW4q2rXSKFF9qzRvTLtwmzvG+xJKw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Pitre <nico@fluxnic.net>
Cc: Zhangfei Gao <zgao6@marvell.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>, "Frank@marvell.com" <Frank@marvell.com>, "Huang@marvell.com" <Huang@marvell.com>, Frank Huang <frankh@marvell.com>


Could we have an architecture discussion about how this is supposed to be done and a picture please !
(a pointer to good working code would be nice)

On brownstone the SDIO 8787 power is supplied by a ldo which is dedicated to the internal SDIO chip.  
The Power GPIO (PDn) is an on/off switch for the 8787.  It does not affect the power from the ldo.

What is the responsibility of the 8787 SDIO driver for power management ?  It is obviously called at
probe / init time.  Is it supposed to turn on power ?  I realize that it may not be aware of what device
to power on?  Does it register a call back ?  Is it responsible for turning itself on/off at suspend/resume
time?   Thought about open time but the firmware needs to be loaded before the device can respond.
Is firmware loading done at the right place ?  Should it be done at open and NOT at probe? That way
the driver could look present and open might handle firmware loading and power control.

What is the responsibilty of MMC layer.  Obviously it needs to supply power to the device on the bus.
Is there supposed to be a callback in the board file that handles these specifics ?  Would this call back
then call then set the ldo on and turn on the 8787 ?


regards,

Philip

 

On Jul 21, 2011, at 11:50 PM, Daniel Drake wrote:

> On 21 July 2011 03:34, Zhangfei Gao <zhangfei.gao@marvell.com> wrote:
>> sdio client may be required power on/off dynamically.
>> With regulator vsdio, sdio client power on/off could be executed by mmc_power_up/down
> 
> I think you can/should do this with vmmc. When the device gets powered
> down (e.g. in runtime suspend), the voltage should be cut, so it
> should be possible to use the existing regulator.
> 
> I also looked at doing this before, when it looked like we would have
> to manipulate a GPIO reset line for SD8686. I decided that the current
> vmmc implementation in sdhci wasn't quite complete enough, but it
> wouldn't be much effort to correct this.
> 
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

