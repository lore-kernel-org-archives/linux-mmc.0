From: Chris Ball <cjb@laptop.org>
Subject: Re: cd-gpio and SDHCI presence
Date: Mon, 17 Sep 2012 04:45:32 -0400
Message-ID: <m3ehm1yr4j.fsf@pullcord.laptop.org>
References: <m3y5k9yxfz.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1209170834170.1689@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50786 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263Ab2IQIpT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 04:45:19 -0400
In-Reply-To: <Pine.LNX.4.64.1209170834170.1689@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 17 Sep 2012 09:28:03 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi Guennadi, thanks for replying so quickly,

On Mon, Sep 17 2012, Guennadi Liakhovetski wrote:
>> "present" is false because SDHCI_PRESENT_STATE doesn't have the presence
>> bit sent (if it did, we wouldn't need a cd-gpio, right?) and the command
>> fails.
>> 
>> And we can't just set SDHCI_QUIRK_BROKEN_CARD_DETECTION, because that
>> would turn on polling, which we don't want.  How's this supposed to work?
>
> Sorry, I'm not very familiar with the SDHCI hardware or the driver, so, 
> I'll be speculating here.
>
> cd-gpio can function in two modes: polling and IRQ. IRQ is enabled if a 
> number of conditions is satisfied: gpio_to_irq() returns a non-negative 
> number, the user doesn't force polling by setting MMC_CAP_NEEDS_POLL and 
> request(_threaded)_irq() is successful. If either of the three conditions 
> fail, GPIO polling will be used.

Right, I'm in IRQ mode.

> Now, concerning SDHCI. cd-gpio doesn't magically make all MMC drivers 
> capable of using GPIO card detection, sorry:-) To use it you should first 
> make sure your driver can take card-present or card-detect information 
> from a GPIO. Then the slot-gpio module shall be used to add this GPIO CD 
> functionality to your driver instead of cooking it up by yourself.
>
> From the above it seems to me, that your SDHCI instance is not yet quite 
> trained to take GPIO input for card-detection:-) Looking through various 
> SDHCI implementations I see several drivers already implementing and using 
> various GPIO slot services internally: tegra, spear, s3c, pci, esdhc-imx. 
> They all seem to work with their own GPIO CD implementations, which are 
> very similar to the slot-gpio one and it shouldn't be too difficult to 
> replace them with the latter.

I'm using sdhci-pxav3, which is a small sdhci-pltfm driver.

I see now, thanks; what I was missing is that the other drivers are either:

* using IO accessors to fake the presence bit being set (esdhc-imx)
* using the ugly hack of just falling back to polling (s3c)
* running on a controller that doesn't have this problem (tegra?)

So the answer to "how's this supposed to work?" was "your driver needs
a workaround for reporting the presence bit", I guess.  Hopefully making
the change below should let us remove this unnecessary code from
esdhc-imx and s3c.

> Concerning how specifically it should work in your case - I'm not sure, 
> sorry. What platform are you working with? Does it already have GPIO 
> support? If it did, it should have been pretty simple to replace it with 
> the generic one from slot-gpio. Looking at the code, it seems to me, that 
> even on SDHCI systems, where a GPIO is used for card detection, the 
> controller is sometimes still able to recognise the card's presence. This 
> seems to be the case on tegra, pci (except cafe),... However, e.g., s3c 
> uses a dirty hack of setting and clearing 
> SDHCI_QUIRK_BROKEN_CARD_DETECTION in their CD routine... In general, I 
> think, it should suffice to do in sdhci_request() (and others) something 
> like
>
> 	/* If polling, assume that the card is always present. */
> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> 		present = true;
> 	else
> 		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> 				SDHCI_CARD_PRESENT;
>
> 	if (!present) {
> 		int ret = mmc_gpio_get_cd(host->mmc);
> 		if (ret > 0)
> 			present = true;
> 	}

Makes sense, and works fine.  I'll prepare a formal patch and send it
out now -- please could you reply with your Signed-off-by, since I'll
put you in the From field?

> Also, once a card has been detected, shouldn't it be possible to use 
> mmc_card_present() to check its presence?

Sounds right, although that happens too late to help here.

Thanks very much!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
