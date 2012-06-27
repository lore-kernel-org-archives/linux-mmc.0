From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: Allow CAPABILITY_1 Register to be overridden
Date: Wed, 27 Jun 2012 12:55:17 -0400
Message-ID: <87wr2s7kzu.fsf@octavius.laptop.org>
References: <prakity@marvell.com>
	<1338669006-2611-1-git-send-email-prakity@marvell.com>
	<CACwGpOA=wEVAdzBK9a1DsbO01OLQWRnBY0a-yfh8RJUjiq2jEQ@mail.gmail.com>
	<1F24854E-BA06-4BF2-90C6-4E19CDD4A686@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46997 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757764Ab2F0QzW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jun 2012 12:55:22 -0400
In-Reply-To: <1F24854E-BA06-4BF2-90C6-4E19CDD4A686@marvell.com> (Philip
	Rakity's message of "Tue, 5 Jun 2012 20:37:10 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "Mark F. Brown" <mark.brown314@gmail.com>, "philipspatches@gmail.com" <philipspatches@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Tue, Jun 05 2012, Philip Rakity wrote:
> On Jun 5, 2012, at 7:11 PM, Mark F. Brown wrote:
>
>> Hi Philip,
>> 
>> Minor nitpicks: You should reuse SDHCI_QUIRK_MISSING_CAPS rather than
>> adding SDHCI_QUIRK2_MISSING_CAPS2. The less quirks the better IMHO.
>
> I am not sure that this is a good idea.  It breaks the existing code
> for people using quirks
> for capability register 1.

But it doesn't seem likely that someone would have a missing caps1
register and not have a missing caps2 register, right?  (Probably
the current users of the quirk aren't even on SD 3.0 devices, else
someone would have yelled about this already.)

So I think we could give the quirk reuse a try and see what happens.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
