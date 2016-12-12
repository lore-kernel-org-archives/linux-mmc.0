From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
Date: Mon, 12 Dec 2016 19:16:51 +0000
Message-ID: <20161212191651.GV14217@n2100.armlinux.org.uk>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
 <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
 <20161209200729.GO14217@n2100.armlinux.org.uk>
 <87bmwhdrx7.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53560 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbcLLTRK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2016 14:17:10 -0500
Content-Disposition: inline
In-Reply-To: <87bmwhdrx7.fsf@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gm>

On Mon, Dec 12, 2016 at 05:37:56PM +0100, Gregory CLEMENT wrote:
> Hi Russell King,
>  
>  On ven., déc. 09 2016, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Fri, Dec 09, 2016 at 11:30:07AM +0100, Gregory CLEMENT wrote:
> >> Also enable it on the Armada 7040 DB board
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> > Hi,
> >
> > Can this also be added to the cp110 on the 7k/8k SoCs as well, or does
> > it rely on other unmerged support?
> 
> I did not add this one because until now I had not the hardware setup
> available to test it.
> 
> But at least I can add the ressources in the device tree and now I can
> test it partially.

There's another option: add the DT resources in a separate patch, send
it out for someone else to test.  When it comes back with a tested-by,
then it can be included along with the rest of the patch set.

I'd send something, but I don't know what the GIC interrupt number
would be without using the CP110's ICU (which isn't supported in
mainline yet.)  I've already tested your previous patch set (along with
ICU support + needed DT bits) on the SR Macchiatobin board... it seems
to work fine.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
