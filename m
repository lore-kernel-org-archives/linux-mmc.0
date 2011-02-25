From: Eric Benard <eric@eukrea.com>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
 and	card detection
Date: Fri, 25 Feb 2011 22:29:16 +0100
Message-ID: <4D681F2C.20307@eukrea.com>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>	<87k4gp3bl1.fsf@lebrac.rtp-net.org> <4D66AAE4.4000308@eukrea.com> <874o7r29oa.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:54470 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076Ab1BYV30 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Feb 2011 16:29:26 -0500
In-Reply-To: <874o7r29oa.fsf@lebrac.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 25/02/2011 20:31, Arnaud Patard (Rtp) wrote:
> Eric Benard<eric@eukrea.com>  writes:
>> may you please test the attached patch. It may give someone with a
>> better knowledge of sdhci than me an idea of what is wrong.
>
> I've tested this patch on my efikamx and this patch does solve the
> issue. I didn't test on the efika smartbook but I guess it'll be fine
> here too. Thanks.
>
good. Now we have to find can how this code be integrated properly in the 
sdhci driver.
>>
>> Here are the workaround this patch add :
>> - we can't let enable or disable irq enabled when the card is
>> present/not present, else the irq triger again which explains why you
>> get the freeze ->  so we must rely on the card presence bit to enable
>> the right interrupt,
>
> so, we're getting an interrupt storm, right ? can't it be fixed by
> setting a different irq type ?
>
no this seems to be the way the SDHCI works, at least the i.MX51 ref manual says :
- When the CRM bit is cleared, if no card is inserted it is immediately set 
again: this can be prevented by clearing the card removal status enable bit in 
interrupt status enable register.
- When the CIN bit is cleared, if a card is inserted it is immediately set 
again: this can be prevented by clearing the card inserted status enable bit 
in interrupt status enable register.

As, unless I'm mistaken, sdhci host actually consider card detect as broken by 
default, I think this code in not actually used so it may not be really tested.

>> - we can't turn the clock off if we want the card detect to work when
>> the card is removed ->  as a quick workaround this patch prevents
>> sdhci_set_clock from turning off the clocks when the
>> SDHCI_INT_CARD_INSERT interrupt is enabled.
>>
>> Also, I had to change the MX51_PAD_GPIO1_0__SD1_CD pad setting as
>> follows to enable the internal pull up :
>> 	_MX51_PAD_GPIO1_0__SD1_CD | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
>> 			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
>> 			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
>
> It worked without changing this.
>
this could mean you have an external pull up resistor on the board which was 
not the case on the prototype I was working on which is partially mounted ;-)

Eric
