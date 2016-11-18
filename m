From: Mason <slash.tmp@free.fr>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Fri, 18 Nov 2016 13:42:44 +0100
Message-ID: <582EF744.8090307@free.fr>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
 <56B21DDB.6050708@free.fr> <582ED9E0.5090506@free.fr>
 <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:59532 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbcKRMnn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Nov 2016 07:43:43 -0500
In-Reply-To: <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rameshwar Sahu <rsahu@apm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Zach Brown <zach.brown@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, Suneel Garapati <sunee>

On 18/11/2016 11:49, Rameshwar Sahu wrote:

> Mason wrote:
>
>> Suman/APM added "arasan,sdhci-4.9a" in 308f3f8d8112
>> @Suman, @Rameshwar: what specific IP block does your SoC embed?
>> What does 4.9a refer to? The documentation revision number?
> 
> We have Arasan SD3.0/ SDIO3.0/ eMMC4.41 AHB Host Controller IP
> embedded in our SoC and 4.9a is documentation revision number which
> was given by Arasan.
> FYI this documentation date was May, 2012.

Hello Ram,

Thanks for the information.

  Xilinx is using "SD2.0/SDIO2.0/MMC3.31 AHB Host Controller"
     APM is using "SD3.0/SDIO3.0/eMMC4.41 AHB Host Controller"
   Sigma is using "SD3.0/SDIO3.0/eMMC4.4 AHB Host Controller"
Rockchip is using ? (Shawn could you specify exactly which IP you use?)

And it looks like Arasan is using different revision numbers for
every documentation they have.

The "SD3.0/SDIO3.0/eMMC4.4 AHB Host Controller" doc I have is
at rev number 6.0, dated 2010-02-19.

Regards.

