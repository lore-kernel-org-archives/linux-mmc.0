From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Thu, 4 Nov 2010 15:25:04 +0100
Message-ID: <4CD2C240.8030400@stericsson.com>
References: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com> <4CD2B1FF.6030708@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:57845 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab0KDOzA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2010 10:55:00 -0400
In-Reply-To: <4CD2B1FF.6030708@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>

David Vrabel wrote:
> Linus Walleij wrote:
>> @@ -148,14 +148,19 @@ static int mmc_runtime_suspend(struct device *dev)
>>  {
>>  	struct mmc_card *card = mmc_dev_to_card(dev);
>>  
>> +	mmc_gate_clock(card->host);
>>  	return mmc_power_save_host(card->host);
>>  }
> 
> Haven't you tied the clock gating to the power on/off state of the
> card/host?  This looks like the wrong thing to me.  Surely we want to
> gate the clock even if the card (or SDIO functions) are active?

You're probably right :-/

Since the runtime_pm_get/put calls are balanced for the host
enable/disable case and the clock gating is orthogonal,
I need to create an orthogonal instance of hooks, maybe it's
easiest to just spawn a second dummy device like mmc0_clk
for this to be able to use the runtime PM hooks?

Back to hacking!

Yours,
Linus Walleij
