From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card detect
Date: Wed, 7 Mar 2012 21:06:42 +0530
Message-ID: <CANrkHUaYDpv=p0p81oKWCoewyjheyZYkCqvZY7_ZQxWi_=8YFw@mail.gmail.com>
References: <20120301185044.29210.44521.stgit@kaulin.local>
	<20120301185535.29210.71546.stgit@kaulin.local>
	<4F50643B.9050500@ti.com>
	<20120302172251.GJ18901@atomide.com>
	<4F548457.5050205@ti.com>
	<CANrkHUZysOnHKKUuLm0Vbo1KsNp0yUd=udjGvQ43=gTTXbWeCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANrkHUZysOnHKKUuLm0Vbo1KsNp0yUd=udjGvQ43=gTTXbWeCw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 5, 2012 at 3:55 PM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:
> On Mon, Mar 5, 2012 at 2:46 PM, Rajendra Nayak <rnayak@ti.com> wrote:
>> On Friday 02 March 2012 10:52 PM, Tony Lindgren wrote:
>>>
>>> BTW, with -rc5, looks like re-inserting omap_hsmmc on omap4 fails
>>> to detect any cards, and then fails to unload. This works on omap3
>>> just fine. Any ideas why that would be?
>>
>>
>> Yeah, looks like thats broken. I am not sure whats going wrong thoug=
h.
>> I just enabled CONFIG_MMC_DEBUG and saw these logs below.
>>
>> Venkat/Balaji, care to look at this one?
>>
>
> Let me check this

OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
Addng the offset to platform_device resource structure
increments the start address for every insmod operation.
MMC command fails on re-insertion as module due incorrect register base=
=2E
=46ix this by updating the ioremap base address only.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
Note:  eMMC detection is still failing on resertion due to card vcc
power off on rmmod

 drivers/mmc/host/omap_hsmmc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index fd0c661..4e1f8f6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1870,8 +1870,6 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)
 	if (res =3D=3D NULL || irq < 0)
 		return -ENXIO;

-	res->start +=3D pdata->reg_offset;
-	res->end +=3D pdata->reg_offset;
 	res =3D request_mem_region(res->start, resource_size(res), pdev->name=
);
 	if (res =3D=3D NULL)
 		return -EBUSY;
@@ -1896,7 +1894,7 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)
 	host->irq	=3D irq;
 	host->id	=3D pdev->id;
 	host->slot_id	=3D 0;
-	host->mapbase	=3D res->start;
+	host->mapbase	=3D res->start + pdata->reg_offset;
 	host->base	=3D ioremap(host->mapbase, SZ_4K);
 	host->power_mode =3D MMC_POWER_OFF;
 	host->next_data.cookie =3D 1;
--=20
1.7.0.4

>
>> # insmod omap_hsmmc.ko
>> [ =A0 43.358398] omap_hsmmc omap_hsmmc.0: context was not lost
>> [ =A0 43.364105] omap_hsmmc omap_hsmmc.0: enabled
>> [ =A0 44.434661] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wi=
dth 0
>> timing 0
>> [ =A0 44.442352] omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
>> [ =A0 44.474365] omap_hsmmc omap_hsmmc.0: disabled
>> [ =A0 44.482208] omap_hsmmc omap_hsmmc.4: context was not lost
>> [ =A0 44.482208] omap_hsmmc omap_hsmmc.4: enabled
>> [ =A0 44.546600] omap_hsmmc omap_hsmmc.0: context was not lost
>> [ =A0 44.552276] omap_hsmmc omap_hsmmc.0: enabled
>> [ =A0 44.552276] mmc0: mmc_rescan_try_freq: trying to init card at 4=
00000 Hz
>> [ =A0 44.563720] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 18 w=
idth 0
>> timing 0
>> [ =A0 44.572174] omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
>> [ =A0 44.613800] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd=
 18 width
>> 0 timing 0
>> [ =A0 44.621887] omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
>> [ =A0 44.735290] mmc0: starting CMD52 arg 00000c00 flags 00000195
>> [ =A0 44.741271] omap_hsmmc omap_hsmmc.0: mmc0: CMD52, argument 0x00=
000c00
>> [ =A0 45.560241] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wi=
dth 0
>> timing 0
>> [ =A0 45.567871] omap_hsmmc omap_hsmmc.4: Set clock to 0Hz
>> [ =A0 45.591491] omap_hsmmc omap_hsmmc.4: disabled
>> #
>> #
>> # rmmod omap_hsmmc
>> [ =A0607.302307] omap_hsmmc omap_hsmmc.4: context was not lost
>> [ =A0607.308044] omap_hsmmc omap_hsmmc.4: enabled
>> [ =A0607.312591] omap_hsmmc omap_hsmmc.4: disabled
>> [ =A0607.317199] omap_hsmmc omap_hsmmc.4: context was not lost
>> [ =A0607.322875] omap_hsmmc omap_hsmmc.4: enabled
>>



--=20
Thanks and Regards,
Balaji T K
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
