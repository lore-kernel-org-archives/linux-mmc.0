From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v9 1/9] ARM: davinci: move private EDMA API to arm/common
Date: Fri, 07 Jun 2013 07:15:39 -0400
Message-ID: <878v2m5fz8.fsf@octavius.laptop.org>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
	<1362586540-10393-2-git-send-email-mporter@ti.com>
	<51B17AE7.4070403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <51B17AE7.4070403@ti.com> (Sekhar Nori's message of "Fri, 7 Jun
	2013 11:47:11 +0530")
Sender: linux-doc-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Matt Porter <matt@ohporter.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Jun 07 2013, Sekhar Nori wrote:
> + Chris since the patch has some davinci_mmc.c changes.
>
> Chris, Mark,
>
> On 3/6/2013 9:45 PM, Matt Porter wrote:
>> Move mach-davinci/dma.c to common/edma.c so it can be used
>> by OMAP (specifically AM33xx) as well.
>> 
>> Signed-off-by: Matt Porter <mporter@ti.com>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>
> Can you please ack changes in mmc and sound respectively? I would like
> to take the patch for v3.11.

For davinci_mmc.c:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
