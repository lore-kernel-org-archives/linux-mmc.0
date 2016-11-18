From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Fri, 18 Nov 2016 14:22:34 +0100
Message-ID: <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
 <56B21DDB.6050708@free.fr> <582ED9E0.5090506@free.fr>
 <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
 <582EF744.8090307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <582EF744.8090307@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <slash.tmp@free.fr>, Rameshwar Sahu <rsahu@apm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Suman Tripathi <stripathi@apm.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, Russell King <linux@arm.linux.org.uk>, Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>, P L Sai Krishna <lakshmis@xilinx.com>, Zach Brown <zach.brown@ni.com>, Sebastian Frias <sf84@laposte.net>, Arnd Bergmann <arnd@arndb.de>, Suneel Garapati <suneel.garapati@xilinx.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, linux-mmc <linux-mmc@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Xiaobo Xie <x.xie@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On 18.11.2016 13:42, Mason wrote:
> On 18/11/2016 11:49, Rameshwar Sahu wrote:
> 
>> Mason wrote:
>>
>>> Suman/APM added "arasan,sdhci-4.9a" in 308f3f8d8112
>>> @Suman, @Rameshwar: what specific IP block does your SoC embed?
>>> What does 4.9a refer to? The documentation revision number?
>>
>> We have Arasan SD3.0/ SDIO3.0/ eMMC4.41 AHB Host Controller IP
>> embedded in our SoC and 4.9a is documentation revision number which
>> was given by Arasan.
>> FYI this documentation date was May, 2012.
> 
> Hello Ram,
> 
> Thanks for the information.
> 
>   Xilinx is using "SD2.0/SDIO2.0/MMC3.31 AHB Host Controller"

in Xilinx Zynq device

and
Xilinx ZynqMP device is using
"SD3.0/SDIO3.0/eMMC4.51 AHB Host Controller"

Thanks,
Michal
