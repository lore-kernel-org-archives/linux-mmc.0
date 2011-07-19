From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC/RFT] MMC: CORE: eMMC in Sleep mode before suspend
Date: Tue, 19 Jul 2011 12:48:17 -0400
Message-ID: <m21uxm9pym.fsf@bob.laptop.org>
References: <1310567787-14697-1-git-send-email-balajitk@ti.com>
	<CANfBPZ-dwv1e1JweRR5jFu2rLRxQCWd+ibuaN2RHv+gCZcQeOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58813 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab1GSQs0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jul 2011 12:48:26 -0400
In-Reply-To: <CANfBPZ-dwv1e1JweRR5jFu2rLRxQCWd+ibuaN2RHv+gCZcQeOw@mail.gmail.com>
	(Venkatraman S.'s message of "Tue, 19 Jul 2011 21:31:46 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org

Hi,

On Tue, Jul 19 2011, S, Venkatraman wrote:
> On Wed, Jul 13, 2011 at 8:06 PM, Balaji T K <balajitk@ti.com> wrote:
>> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
>> in the mmc suspend to minimize power consumption.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>
> Balaji,
>   Would you mind reposting the patch without the RFC and s/CORE/core
> in subject line ?
> You can add my
> Acked-by: Venkatraman S <svenkatr@ti.com>

No need to resend, thanks -- pushed to mmc-next with these changes and
the ACK.

Anyone object to letting this soak in mmc-next for a release and merging
it in 3.2?  I'm worried that we'll find card or host quirks around this,
and the 3.0 release is probably happening today.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
