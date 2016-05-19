From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
Date: Thu, 19 May 2016 11:07:28 +0300
Message-ID: <0d463add-9fa5-a768-2ba6-34c4126c7817@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
 <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com>
 <20160518193028.GT5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:39921 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbcESIJd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 May 2016 04:09:33 -0400
In-Reply-To: <20160518193028.GT5995@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, rogerq@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com

On 05/18/2016 10:30 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160518 03:26]:
>> On 05/18/16 11:45, Kishon Vijay Abraham I wrote:
>>> omap hsmmc host controller has ADMA2 feature. Enable it here
>>> for better read and write throughput. Add a new dt binding
>>> "ti,use_adma" to enable ADMA2.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>>>  drivers/mmc/host/omap_hsmmc.c                      |  320 ++++++++=
++++++++----
>>>  include/linux/platform_data/hsmmc-omap.h           |    1 +
>>>  3 files changed, 256 insertions(+), 66 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.tx=
t b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> index 74166a0..eb5ceec2 100644
>>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> @@ -28,6 +28,7 @@ specifier is required.
>>>  dma-names: List of DMA request names. These strings correspond
>>>  1:1 with the DMA specifiers listed in dmas. The string naming is
>>>  to be "rx" and "tx" for RX and TX DMA requests, respectively.
>>> +ti,use_adma: enable adma2 feature
>>
>> Do we have use case when you want to fall back to generic DMA instea=
d of aDMA2?
>=20
> Yes my guess is that PM runtime breaks with these currently..
>=20
>> IMHO if the driver supports aDMA2, it is going to use it instead of =
the
>> generic s/eDMA.
>> What I mean is:
>> the driver implements the aDMA2 support.
>> if the IP has support for aDMA2, then it is going to use it, otherwi=
se it will
>> use the generic DMA.
>=20
> Ideally the adma support would be a separate loadable module,
> similar how the cppi41dma is a child of the OTG controller.

The Master DMA is part of the hsmmc IP block. If the same ADMA module i=
s
present on other IPs it might be beneficial to have a helper library to=
 handle
it (allocating the descriptor pool, wrinting, updating descriptors, etc=
).

> That way the systems wanting to use adma can just specify it
> in the binding, and adma PM runtime support can be added later
> on.
>=20
> Of course this won't work if the adma registers are sprinkled
> within the MMC controller registers..
>=20
> Regards,
>=20
> Tony
>=20


--=20
P=E9ter
