From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Wed, 23 Dec 2015 11:13:52 +0000
Message-ID: <20151223111352.GR8644@n2100.arm.linux.org.uk>
References: <CAONpWdsteBnqTcFbKpcOQFueyeJJWEmn9DJitD43f59xV8sDyg@mail.gmail.com>
 <BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
 <BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAPDyKFotgz3czCs8XaXwC4kT53Lp0h=n03OUMtO6BUTwTnDYzQ@mail.gmail.com>
 <BY2PR04MB18432C804C263313D2349C848FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
 <CAONpWdvo+b=Y26zsCYsHFHjJ+8yAnYfoJOsirdS-he2s1unDgg@mail.gmail.com>
 <CAONpWdsHJEHjedfQrjXru0fETRL3NfXG6cyoQAYtLYAKb5i-2Q@mail.gmail.com>
 <CY1PR04MB184843666E915C564A1858CB8FE50@CY1PR04MB1848.namprd04.prod.outlook.com>
 <CAPDyKFqMPfrTdF4JNU-QUBN-va+Xk0EAqHysQ_HpKkmMfQzQNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45183 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbLWLOE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2015 06:14:04 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFqMPfrTdF4JNU-QUBN-va+Xk0EAqHysQ_HpKkmMfQzQNg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Guo <peter.guo@bayhubtech.com>, Alex Ballas <alex@ballas.org>, "adam8157@gmail.com" <adam8157@gmail.com>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On Tue, Dec 22, 2015 at 09:30:00AM +0100, Ulf Hansson wrote:
> This quirk seems a bit strange. It looks like a generic problem being
> solved by the wrong approach. Although, my knowledge of sdhci HW is
> limited so I might be wrong.
> 
> Why doesn't sdhci *always* reset the related registers when the
> command or data transfer gets *completed*? Instead as currently,
> delaying that until the *next* request is started and via using
> SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD?

That would be additional overhead.  The real problem is that the tuning
paths compete with the normal request paths over how to set the registers.
This competition needs to be killed, and a saner structure for dealing
with requests and tuning commands needs to be created.

This is something I'm working on as I get time: I'm restructuring
sdhci_send_command() with the aim of getting to the point where the
tuning code is _not_ writing to any registers at all, and that's all
handled by code common to both paths.

> Sdhci's sdhci_execute_tuning() function must be converted to use
> mmc_send_tuning().

That will make the request path more complex, because we then need to
detect the tuning commands and have special handling for them.  With
SDHCI, they are not a standard data transfer command, which is what
mmc_send_tuning() wants.

This means we end up with more complexity in what is supposed to be a
fast path, which means more room for bugs to creep in.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
