From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
Date: Thu, 19 May 2016 11:36:18 +0530
Message-ID: <573D57DA.20900@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
 <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, tony@atomide.com
Cc: rogerq@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Peter,

On Wednesday 18 May 2016 03:54 PM, Peter Ujfalusi wrote:
> On 05/18/16 11:45, Kishon Vijay Abraham I wrote:
>> omap hsmmc host controller has ADMA2 feature. Enable it here
>> for better read and write throughput. Add a new dt binding
>> "ti,use_adma" to enable ADMA2.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>>  drivers/mmc/host/omap_hsmmc.c                      |  320 ++++++++++++++++----
>>  include/linux/platform_data/hsmmc-omap.h           |    1 +
>>  3 files changed, 256 insertions(+), 66 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> index 74166a0..eb5ceec2 100644
>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> @@ -28,6 +28,7 @@ specifier is required.
>>  dma-names: List of DMA request names. These strings correspond
>>  1:1 with the DMA specifiers listed in dmas. The string naming is
>>  to be "rx" and "tx" for RX and TX DMA requests, respectively.
>> +ti,use_adma: enable adma2 feature
> 
> Do we have use case when you want to fall back to generic DMA instead of aDMA2?
> IMHO if the driver supports aDMA2, it is going to use it instead of the
> generic s/eDMA.
> What I mean is:
> the driver implements the aDMA2 support.
> if the IP has support for aDMA2, then it is going to use it, otherwise it will
> use the generic DMA.

hmm.. how will the driver know if the IP has support for aDMA2. Using dt
binding is one way. Using MMCHS_HL_HWINFO is another way but then the register
offsets in omap_hsmmc driver has to be modified for omap4+.

Thanks
Kishon
