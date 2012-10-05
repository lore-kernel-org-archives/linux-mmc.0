From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 09.5/16] mmc: omap: Remove cpu_is_omap usage from the driver
Date: Fri, 05 Oct 2012 14:23:10 -0400
Message-ID: <87ipaog4mp.fsf@octavius.laptop.org>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
	<20121004220454.26676.10131.stgit@muffinssi.local>
	<20121005180840.GN3874@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121005180840.GN3874@atomide.com> (Tony Lindgren's message of
	"Fri, 5 Oct 2012 11:08:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Fri, Oct 05 2012, Tony Lindgren wrote:
> This is needed for the ARM common zImage support.
>
> We can use the existing slot features to pass omap1
> specific options to the driver. For omap2 we don't
> want to pass anything new as that will be eventually
> moved to use device tree based init.
>
> Note that this patch depends on earlier patch that
> moves plat/mmc.h into include/linux/platform_data.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> ---
>
> Chris, I can set up a minimal immutable branch with omap
> header changes that you can also pull into MMC tree if these
> two MMC patches look ackable to you.

Thanks, sounds good.

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
