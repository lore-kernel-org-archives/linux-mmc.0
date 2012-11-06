From: yongd <yongd@marvell.com>
Subject: Re: [PATCH V2 1/3] mmc: esdhc: enable polling to detect card by itself
Date: Tue, 06 Nov 2012 16:49:42 +0800
Message-ID: <5098CF26.3060202@marvell.com>
References: <1351589403-26398-1-git-send-email-yongd@marvell.com> <1351589403-26398-2-git-send-email-yongd@marvell.com> <20121031152030.GE8100@S2100-06.ap.freescale.net> <5093BE95.6040709@marvell.com> <20121105015421.GA26512@S2100-06.ap.freescale.net> <509733D9.2060807@marvell.com> <20121105124809.GA27260@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:54823 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147Ab2KFIt7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Nov 2012 03:49:59 -0500
In-Reply-To: <20121105124809.GA27260@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>, Zhangfei Gao <zgao6@marvell.com>, Kevin Liu <kliu5@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2012=E5=B9=B411=E6=9C=8805=E6=97=A5 20:48, Shawn Guo wrote:
> On Mon, Nov 05, 2012 at 11:34:49AM +0800, yongd wrote:
>>  From the code logic, without SDHCI_QUIRK_BROKEN_CARD_DETECTION for =
ESDHC_CD_GPIO, when your card (using
>> GPIO detection) is removed, we can know the card's absence through t=
he fake CARD_PRESENT flag in esdhc_readl_le().
>> As a result, we can quickly return ENOMEDIUM error without command s=
ending. Finally mmc_rescan can know the card
>> is removed.
>>
> Yes, that's the existing implementation, which does not require retry
> sending MMC_SEND_STATUS to know if card is removed.
>
>> On the other hand, with SDHCI_QUIRK_BROKEN_CARD_DETECTION for ESDHC_=
CD_GPIO, we will just send MMC_SEND_STATUS
>> command (cd_irq->sdhci_tasklet_card->mmc_recan->mmc_sd_detect->mmc_s=
d_alive), and we will find error since the card
>> is already gone. Finally, we shall also know the card is removed.
>>
>> This is really strange why the removal message shows up together wit=
h the next card inserting message.
>> Could u pls tell us more about what actually happened when the card =
is removed with my patches? Did the GPIO interrupt
>> happen? Was mmc_rescan() called? Did mmc_sd_detect() finally find er=
ror when it sent MMC_SEND_STATUS? What step did
>> the card removing procedure arrive at? Really really thanks a lot:-)
>>
> I just tracked it down a little bit.  Interesting enough, it depends =
on
> how I remove the card.  If I do it slowly, when the gpio interrupt
> triggers the MMC_SEND_STATUS query, the command can still retrieve
> the card status successfully.  Thus driver does not detect the card
> removal.  If I remove the card from slot quickly, I can see the remov=
al
> message.

Shawn,
Thanks for your interesting input.

 From your info, we can see that on your platform, those pins (includin=
g
power, clk, DATA) necessary for MMC_SEND_STATUS transaction still keep
connected for some time just after the GPIO's level changes due to card
removable. And if we remove the card very slowly, such time duration ca=
n be
such long that the MMC_SEND_STATUS query can still succeed.

So I think we can add a proper delay(maybe 100ms) before the gpio inter=
rupt
triggers the MMC_SEND_STATUS query, and maybe this can probably fix thi=
s issue:-)


> With your patch series, in ESDHC_CD_GPIO case the driver will have
> to send MMC_SEND_STATUS (with retry) to card for knowing its presence=
=2E
> This is also an unpleasant behavior comparing to the existing code.
> I think we should query gpio state to know card presence for this cas=
e.
>
> Shawn
>

Anyway, I 100% agree with you that for a ESDHC_CD_GPIO card, we shall q=
uery gpio
state to know such card's presence rather than sending MMC_SEND_STATUS =
rudely.

But just as I mentioned before, I don't think using SDHCI_QUIRK_BROKEN_=
CARD_DETECTION
as the flag to determine whether and how we can know card's presence be=
fore sending
command is a proper way.

I haven't gotten any good idea. Do u have any idea on this?







