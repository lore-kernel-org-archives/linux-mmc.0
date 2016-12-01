From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Thu, 1 Dec 2016 12:09:17 +0800
Message-ID: <f64ea0f8-31be-c5b5-3a43-a30abd8aec30@rock-chips.com>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
 <56B21DDB.6050708@free.fr> <582ED9E0.5090506@free.fr>
 <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
 <582EF744.8090307@free.fr> <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com>
 <583C50E7.6030400@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:41954 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbcLAEJ3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 23:09:29 -0500
In-Reply-To: <583C50E7.6030400@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, Rameshwar Sahu <rsahu@apm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Zach Brown <zach.brown@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, Suneel Garapati <suneel.garapati@xilinx.com>, Russell King <linux@arm.linux.org.uk>

On 2016/11/28 23:44, Mason wrote:
> Hello,
>
> @Shawn Lin, could you take a look below and tell me exactly
> which IP core(s) Rockchip is using in its SoCs?
>

 From the Host Controller version register (0xfe)
bit[7:0]: 0x2 : specification version number is 3.00
bit[15:8]: 0x10: Vendor version number is 1.0


Command Queueing version register (0x200)
bit[11:8]: 0x5  eMMC Major version number
bit[7:4]: 0x1 eMMC manor version number
bit[3:0]: 0x0 eMMC version suffix

User guide "eMMC 5.1/SD3.0/SDIO3.0 Host Controller"
Revision number: 1.14
Released on Dec. 2014

> Based on the feedback I received, here is an updated list of
> compatible strings and controller versions dealt with by the
> drivers/mmc/host/sdhci-of-arasan.c code.
>
>
> Xilinx Zynq:
> "SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: 8.9a is the documentation revision (dated 2011-10-19)
> subsequent tweaks labeled 9.0a, 9.1a, 9.2a
>
> Xilinx ZynqMP:
> "SD3.0 / SDIO3.0 / eMMC4.51 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: using the same compatible string as Zynq
>
> Sigma SMP87xx
> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
> no compatible string yet, platform-specific init required
>
> APM:
> "SD3.0 / SDIO3.0 / eMMC4.41 AHB Host Controller"
> "arasan,sdhci-4.9a"
> NB: 4.9a appears to be the documentation revision
> no functional diff with "arasan,sdhci-8.9a"
>
> Rockchip
> Exact IP unknown, waiting for Shawn's answer
> "arasan,sdhci-5.1"
> NB: 5.1 appears to refer to the eMMC standard supported
>
>
> On a final note, there are many variations of the Arasan IP.
> I've tracked down at least the following:
>
> SD_2.0_SDIO_2.0__MMC_3.31_AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.41_OCP_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller.pdf
>
> It seems to me the compatible string should specify
> the SD/SDIO version AND the eMMC version, since it
> seems many combinations are allowed, e.g. eMMC 4.51
> has two possible SD versions.
>
> What do you think?
>
> Regards.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

