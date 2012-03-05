From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card detect
Date: Mon, 5 Mar 2012 15:55:56 +0530
Message-ID: <CANrkHUZysOnHKKUuLm0Vbo1KsNp0yUd=udjGvQ43=gTTXbWeCw@mail.gmail.com>
References: <20120301185044.29210.44521.stgit@kaulin.local>
	<20120301185535.29210.71546.stgit@kaulin.local>
	<4F50643B.9050500@ti.com>
	<20120302172251.GJ18901@atomide.com>
	<4F548457.5050205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45313 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756476Ab2CEKZ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Mar 2012 05:25:57 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so5822943lah.23
        for <linux-mmc@vger.kernel.org>; Mon, 05 Mar 2012 02:25:56 -0800 (PST)
In-Reply-To: <4F548457.5050205@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Venkatraman S <svenkatr@ti.com>

On Mon, Mar 5, 2012 at 2:46 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 02 March 2012 10:52 PM, Tony Lindgren wrote:
>>
>> BTW, with -rc5, looks like re-inserting omap_hsmmc on omap4 fails
>> to detect any cards, and then fails to unload. This works on omap3
>> just fine. Any ideas why that would be?
>
>
> Yeah, looks like thats broken. I am not sure whats going wrong though=
=2E
> I just enabled CONFIG_MMC_DEBUG and saw these logs below.
>
> Venkat/Balaji, care to look at this one?
>

Let me check this

> # insmod omap_hsmmc.ko
> [ =A0 43.358398] omap_hsmmc omap_hsmmc.0: context was not lost
> [ =A0 43.364105] omap_hsmmc omap_hsmmc.0: enabled
> [ =A0 44.434661] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wid=
th 0
> timing 0
> [ =A0 44.442352] omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
> [ =A0 44.474365] omap_hsmmc omap_hsmmc.0: disabled
> [ =A0 44.482208] omap_hsmmc omap_hsmmc.4: context was not lost
> [ =A0 44.482208] omap_hsmmc omap_hsmmc.4: enabled
> [ =A0 44.546600] omap_hsmmc omap_hsmmc.0: context was not lost
> [ =A0 44.552276] omap_hsmmc omap_hsmmc.0: enabled
> [ =A0 44.552276] mmc0: mmc_rescan_try_freq: trying to init card at 40=
0000 Hz
> [ =A0 44.563720] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 18 wi=
dth 0
> timing 0
> [ =A0 44.572174] omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
> [ =A0 44.613800] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd =
18 width
> 0 timing 0
> [ =A0 44.621887] omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
> [ =A0 44.735290] mmc0: starting CMD52 arg 00000c00 flags 00000195
> [ =A0 44.741271] omap_hsmmc omap_hsmmc.0: mmc0: CMD52, argument 0x000=
00c00
> [ =A0 45.560241] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wid=
th 0
> timing 0
> [ =A0 45.567871] omap_hsmmc omap_hsmmc.4: Set clock to 0Hz
> [ =A0 45.591491] omap_hsmmc omap_hsmmc.4: disabled
> #
> #
> # rmmod omap_hsmmc
> [ =A0607.302307] omap_hsmmc omap_hsmmc.4: context was not lost
> [ =A0607.308044] omap_hsmmc omap_hsmmc.4: enabled
> [ =A0607.312591] omap_hsmmc omap_hsmmc.4: disabled
> [ =A0607.317199] omap_hsmmc omap_hsmmc.4: context was not lost
> [ =A0607.322875] omap_hsmmc omap_hsmmc.4: enabled
>
