From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
Date: Fri, 10 Feb 2012 18:57:56 +0530
Message-ID: <CANrkHUbXHrQ=LowgNq9nt+rnrcE-fTqLuOs2+MeCtodv_H-_Cw@mail.gmail.com>
References: <1328367090-10402-1-git-send-email-rnayak@ti.com>
	<CANfBPZ-pD55YgneQSyfs1kKB-DUH8g7TQkKO7O6B95Ydfc8cFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANfBPZ-pD55YgneQSyfs1kKB-DUH8g7TQkKO7O6B95Ydfc8cFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 7, 2012 at 3:32 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> On Sat, Feb 4, 2012 at 8:21 PM, Rajendra Nayak <rnayak@ti.com> wrote:
>> This series mainly cleans up all instances of hardcoding's in
>> the driver based on pdev->id. This is cleanup leading to the
>> DT adaptation of omap_hsmmc driver.
>>
>> Patches are based on 3.3-rc2 and can be found here
>> git://gitorious.org/omap-pm/linux.git omap_hsmmc_cleanup
>>
>> Tested the patches on my omap4 boards (panda and SDP) but
>> haven't tested yet on omap3/2 since I did'nt have boards
>> handy. So any testing on any omap3/2 boards is really
>> appreciated.

Tested this series on 2430SDP with FS on SD card

>
> I gave it a spin on Beagleboard-XM (OMAP3630) with root filesystem
> on the SD card, and checked again on 4430SDP.
>
> Tested-by: Venkatraman S <svenkatr@ti.com>
>
>>
>> regards,
>> Rajendra
>>
>> Balaji T K (3):
>> =A0mmc: omap_hsmmc: use platform_get_resource_byname for tx/rx DMA
>> =A0 =A0channels
>> =A0mmc: omap_hsmmc: remove unused .set_sleep function
>> =A0mmc: omap_hsmmc: Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT flag to remove
>> =A0 =A0host->id based hardcoding
>>
>> Rajendra Nayak (3):
>> =A0mmc: omap_hsmmc: Get rid of omap_hsmmc_1_set_power function
>> =A0mmc: omap_hsmmc: Get rid of omap_hsmmc_4_set_power function
>> =A0mmc: omap_hsmmc: Don't expect MMC1 to always have vmmc supply
>>
>> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 =A02 -
>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0158 +++-------=
-----------------------
>> =A02 files changed, 14 insertions(+), 146 deletions(-)
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
