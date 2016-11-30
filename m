From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Wed, 30 Nov 2016 14:17:10 +0100
Message-ID: <215d077d-cba8-3c95-eb36-9d5a7afb9bcd@xilinx.com>
References: <56B07BA5.4060407@free.fr>
 <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com> <583C50E7.6030400@free.fr>
 <14771688.Q8f97gHC2H@wuerfel> <583C60CC.2020408@free.fr>
 <CAFd313zQHmFQ61Y4UEvQAvhhVeNFe=nNyjXUKfYXiTKnvm9VWQ@mail.gmail.com>
 <648bd95b-5be0-b39f-a956-af741c6407e4@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:48123
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754961AbcK3NRa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Nov 2016 08:17:30 -0500
In-Reply-To: <648bd95b-5be0-b39f-a956-af741c6407e4@laposte.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>, Rameshwar Sahu <rsahu@apm.com>, Mason <slash.tmp@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh@kernel.org>, Zach Brown <zach.brown@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, Suneel Garapati

On 30.11.2016 11:51, Sebastian Frias wrote:
> On 29/11/16 08:29, Rameshwar Sahu wrote:
>> Hi Mason,
>>
>> Nowhere in the documentation do they specify an "IP version".
>> Some documents do provide a revision number, but that's just
>> a *documentation* revision number, e.g.
>>
>> changes in version 3.6 : fix typos
>> changes in version 9.1a : update company logo
>>
>> That's why Xilinx used "arasan,sdhci-8.9a" and APM used
>> "arasan,sdhci-4.9a". These are documentation revisions.
>> In my opinion, that information is mostly worthless.
>>
> 
> For the record, the important information conveyed by Rameshwar's
> email is the following:
> 
> Arasan SD/SDIO/eMMC IP has a register which tells about the SD
> specification version and  Vendor version number
> Reg Name: Host controller version register (offset 0FEh)
> bit [15:8] is for vendor version number,
> But, I have seen that Arasaan vendor version number is same as
> document revision number.
> 
> (At first I had ignored the email because it repeated Mason's email
> without quoting, but then I realised it contained some information)
> 
> 

Values on real HW.

ZynqMP device
xsdb% mrd 0xFF1600FC
FF1600FC:   10020000

Zynq device:
xsdb% mrd 0xE01000FC
E01000FC:   89010000

Based on docs I have access to.

Specification_Version_Number (bits:23:16)
00 - SD Host Specification version 1.0
01 - SD Host Specification version 2.00 including only the feature of
the Test Register
02 - SD Host Specification version 3.00


Vendor_Version_Number 	31:24

with 32bit access from FC

Thanks,
Michal

