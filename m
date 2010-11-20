From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC]  sdhci: 8 bit bus width changes
Date: Sat, 20 Nov 2010 08:37:16 -0800
Message-ID: <06398BAF-110C-4802-B3A8-3D9923E5406F@marvell.com>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com>
 <20101119214002.GA19272@void.printf.net>
 <20101119215333.GB19272@void.printf.net>
 <20101120123553.GA11936@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51176 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754187Ab0KTQio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 20 Nov 2010 11:38:44 -0500
In-Reply-To: <20101120123553.GA11936@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 20, 2010, at 4:35 AM, Wolfram Sang wrote:

> I know it's too late, but...
> 
> On Fri, Nov 19, 2010 at 09:53:33PM +0000, Chris Ball wrote:
>> On Fri, Nov 19, 2010 at 09:40:02PM +0000, Chris Ball wrote:
>>> I don't see why we should re-read ctrl here, since we've already written
>>> it back to the device at this point, and we don't use it anywhere below
>>> this line.
>> 
>> Ah, I see why now; please ignore this. 
>> 
>> Here's a rebased version of the patch, with some more comments:
>> 
>> From: Philip Rakity <prakity@marvell.com>
>> Date: Fri, 19 Nov 2010 16:48:39 -0500
>> Subject: [PATCH] mmc: sdhci: 8-bit bus width changes
>> 
>> We now:
>> * check for a v3 controller before setting 8-bit bus width
>> * offer a callback for platform code to switch to 8-bit mode, which
>>   allows non-v3 controllers to support it
> 
> What does the platform_-prefix of the callback indicate?

used for controllers that can support 8 bits and NOT v3
> 
>> * introduce a quirk to specify that the board designers have indeed
>>   brought out all the pins for 8-bit to the slot.
> 
> This is not a quirk, this is platform_data, no?

No opinion -- if it makes sense to move to a platform define I am happy to do that
but
I would like to see some standard platform defines

eg 
This one and the one for CARD_PRESENT that can be used consistently across sdhci.c

> 
>> We were previously relying only on whether the controller supported
>> 8-bit, which doesn't tell us anything about the pin configuration in
>> the board design.
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> Tested-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> Signed-off-by: Chris Ball <cjb@laptop.org>
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

