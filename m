From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq handler
Date: Wed, 19 Feb 2014 15:39:35 +0530
Message-ID: <CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
	<E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
	<20140218175703.GJ21483@n2100.arm.linux.org.uk>
	<CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
	<20140219094322.GR21483@n2100.arm.linux.org.uk>
	<CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
	<20140219095212.GT21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:57293 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbaBSKJf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2014 05:09:35 -0500
Received: by mail-oa0-f43.google.com with SMTP id h16so168209oag.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Feb 2014 02:09:35 -0800 (PST)
In-Reply-To: <20140219095212.GT21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>, Chris Ball <chris@printf.net>

On 19 February 2014 15:22, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Are you aware that power control to the card is part of the MMC/SD/SDIO
> spec - and part of the protocol talking to the card?  Hence why the
> mmc layer has support for its control built-in.

Yeah, almost everything is part of the protocol and hence handled by core
sdhci.c layer.. We were handling some board specific issues here, that's it.

> If you don't want to use a regulator, then the right way to do this is to
> use the set_ios callback and check the power field - anything which is not
> MMC_POWER_OFF should result in power to the card being turned on.

I didn't get that completely here.. sorry completely out of touch on
this driver.
The power GPIO here is controlling the power to card socket. Once the card
is inserted, we need to enable power to the socket so that controller can
read back information from card.

And this set_ios callback is not available to drivers above sdhci.c, i.e. glues
like sdhci-pltfm or spear.. so, how we can we get that back in sdhci-spear.c?

Again, I can't test any modifications to this code and we need help from
Pratyush/Mohit on this..
