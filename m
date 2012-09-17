From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: [PATCH] mmc: mxs-mmc: implement broken-cd
Date: Mon, 17 Sep 2012 17:40:51 +0300
Message-ID: <50573673.6050506@bluegiga.com>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com> <20120910060840.GT26709@S2101-09.ap.freescale.net> <504DBB10.9030702@bluegiga.com> <CAKGA1bm990BXJuZ=sQFgaciJxeP_ytPV2tfm1rHi=s=w7b-OYg@mail.gmail.com> <505096EF.8060208@bluegiga.com> <50572907.6000700@bluegiga.com> <m3boh4n3z7.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:61781 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756320Ab2IQOkx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 10:40:53 -0400
In-Reply-To: <m3boh4n3z7.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Matt Sealey <matt@genesi-usa.com>, Shawn Guo <shawn.guo@linaro.org>, veli-pekka.peltola@bluegiga.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 09/17/2012 05:01 PM, Chris Ball wrote:
> Hi,
>
> On Mon, Sep 17 2012, Lauri Hintsala wrote:
>> Is it OK to use broken-cd? broken-cd feature is documented as "There
>> is no card detection available; polling must be used". In this case
>> the card detect is not broken but it is unrouted so it is unavailable.
>>
>> Documentation about broken-cd has been added by commit:
>> https://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commitdiff;h=abe1e05da365350ac282ba5f6831aae13d97074e
>
> I'm having trouble following the problem; it sounds like perhaps all you
> need is:
>
>          if (of_find_property(np, "non-removable", NULL))
>                  mmc->caps |= MMC_CAP_NONREMOVABLE;
>
> Have you tried that?

Yes I have and it does not work. Current mxs-mmc driver uses polling 
method and it reads the CARD_DETECT bit of STATUS register. In our case 
card detect is signal is unrouted so SDIO device is never detect.

Another problem with NONREMOVABLE feature is in case where power cycle 
or reset is done for SDIO device. A device drive doesn't detect HW 
reset. After reset the device driver is still in running state and it 
does not reinitialize the device. So after reset device stops to work.

Lauri
