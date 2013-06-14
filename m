From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH v2 0/3] omap_hsmmc DT DMA Client support
Date: Fri, 14 Jun 2013 13:10:11 -0500
Message-ID: <CAD=GYpbmFyZxwpRwSVjasehhmR5UzMQaGCZf_5Gfo9biQyb0Ww@mail.gmail.com>
References: <1362518004-7083-1-git-send-email-mporter@ti.com>
	<201303052126.01572.arnd@arndb.de>
	<20130306133717.GJ6209@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130306133717.GJ6209@beef>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux OMAP List <linux-omap@vger.kernel.org>, Balaji T K <balajitk@ti.com>, Vinod Koul <vinod.koul@intel.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Dan Williams <djbw@fb.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 6, 2013 at 7:37 AM, Matt Porter <mporter@ti.com> wrote:
> On Tue, Mar 05, 2013 at 09:26:01PM +0000, Arnd Bergmann wrote:
>> On Tuesday 05 March 2013, Matt Porter wrote:
>> > Changes since v1:
>> >         - rebase to 3.9-rc1, previous dependencies upstream
>> >
>> > This series adds DT DMA Engine Client support to the omap_hsmmc.
>> > It leverages the generic DMA OF helpers in -next and the
>> > dma_request_slave_channel_compat() wrapper introduced in the
>> > AM33XX DMA Engine series to support DMA in omap_hsmmc on platforms
>> > booting via DT. These platforms include omap2/3/4/5 and am33xx.
>> >
>> > These patches were split out from the v5 version of the AM33XX DMA
>> > series and split from the EDMA-specific omap_hsmmc changes.
>> >
>>
>> The description seems stale, but the patches all look good to me.
>>
>> I guess they can now get merged in any order.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Yes, missed updating that to indicating that those are now in
> 3.9-rc1.

If there are no more changes, could this patch please be merged in for
3.10 or if not, could Matt please update the description as requested
and repost?

Thanks,
Joel
