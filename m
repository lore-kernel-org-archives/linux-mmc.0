From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] mmc: sdhci: add quirk for voltage switch callback
Date: Sun, 13 Jul 2014 09:21:36 +0100
Message-ID: <20140713082136.GJ21766@n2100.arm.linux.org.uk>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com> <1405228870-5088-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36927 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752246AbaGMIVz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jul 2014 04:21:55 -0400
Content-Disposition: inline
In-Reply-To: <1405228870-5088-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, arnd@arndb.de, olof@lixom.net, chris@printf.net, anton@enomsg.org, t.takinishi@jp.fujitsu.com, mollie.wu@linaro.org

On Sun, Jul 13, 2014 at 01:21:07PM +0800, Vincent Yang wrote:
> @@ -1763,6 +1763,11 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>  		ctrl |= SDHCI_CTRL_VDD_180;
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  
> +		/* Some controller need to do more when switching */
> +		if ((host->quirks2 & SDHCI_QUIRK2_VOLTAGE_SWITCH) &&
> +		    host->ops->voltage_switch)
> +			host->ops->voltage_switch(host);
> +

Why do you heed SDHCI_QUIRK2_VOLTAGE_SWITCH?  Isn't populating
ops->voltage_switch enough? to indicate that something needs to be
done?

It would also be better to turn sdhci.c into a library, and have
the platform driver call the appropriate functions in sdhci rather
than having sdhci be a core driver with loads of quirks.  This is
what I've done in my previous series where I changed stuff such as
the set_bus_width(), set_uhs_signaling() and similar callbacks.

So, it probably makes more sense to split
sdhci_do_start_signal_voltage_switch() into a load of smaller library
functions which drivers can call in an appropriate sequence, rather
than having a quirk hook.

The problem with quirk hooks is that what is right for one device
is not right for another device - eventually you end up with lots
of quirk callbacks scattered on every alternate line.  That doesn't
scale.

Experienced kernel programmers know this and this is why words like
"framework" fill those who have encountered this problem with dread.
sdhci.c is a prime example of this kind of design mistake.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
