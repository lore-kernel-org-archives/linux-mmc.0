From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
Date: Wed, 5 May 2010 17:21:51 +0530
Message-ID: <u2o618f0c911005050451l64e46271lf688c66d5b07b5bb@mail.gmail.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	 <4BE142D4.5010106@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f203.google.com ([209.85.223.203]:45588 "EHLO
	mail-iw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0EELvx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2010 07:51:53 -0400
In-Reply-To: <4BE142D4.5010106@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, May 5, 2010 at 3:35 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> Venkatraman S wrote:
>>>
>>> From d46f8a00728cc6c1fbdfce69435759c8cc49f25c Mon Sep 17 00:00:00 2=
001
>>
>> From: Venkatraman S <svenkatr@ti.com>
>> Date: Thu, 29 Apr 2010 22:34:04 +0530
>> Subject: [PATCH 1/2] sDMA: descriptor autoloading feature
>>
>> Add sDMA driver support for descriptor autoloading feature.
>> =A0Descriptor autoloading is OMAP sDMA v5 hardware capability that c=
an
>> be exploited for scatter gather
>> =A0scenarios, currently available in OMAP3630 and OMAP4430.
>>
>> =A0The feature works as described below.
>> =A01) A sDMA channel is programmed to be in 'linked list' mode.
>> =A02) The client (sDMA user) provides a list of descriptors in a lin=
ked
>> list format.
>> =A03) Each of the 'descriptor' (element in the linked list) contains=
 an
>> updated set of DMA
>> =A0configuration register values.
>> =A04) Client starts DMA transfer.
>> =A05) sDMA controller loads the first element to its register
>> configuration memory and executes the
>> =A0transfer.
>> =A06) After completion, loads the next element (in linked list) to
>> configuration memory and executes
>> =A0the transfer, without MCU intervention.
>> =A07) Interrupt is generated after all transfers are completed; this
>> can be configured to be done
>> =A0differently.
>>
>> =A0Configurations and additional features
>> =A01) Fast mode & non-fast mode
>> =A0 =A0 =A0 =A0Fast mode/non-fast decides on how the first transfer =
begins.
>> In non-fast mode, the first
>> =A0 =A0 =A0 =A0element in the linked list is loaded only after compl=
eting the
>> transfer according to the
>> =A0 =A0 =A0 =A0configurations already in the sDMA channel registers.=
 In fast mode,
>> the loading of the first
>> =A0 =A0 =A0 =A0element precedes the transfer.
>>
>> =A02) Pause / resume of transfers
>> =A0 =A0 =A0 =A0A transfer can be paused after a descriptor set has b=
een loaded,
>> provided the 'pause
>> =A0 =A0 =A0 =A0bit' is set in the linked list element.
>> =A0 =A0 =A0 =A0An ongoing transfer cannot be paused. If the 'pause b=
it' is set,
>> transfer is not
>> =A0 =A0 =A0 =A0started after loading the register set from memory.
>> =A0 =A0 =A0 =A0Such a transfer can be resumed later.
>>
>> =A03) Descriptor types
>> =A0 =A0 =A0 =A03 possible configurations of descriptors (initialized=
 as linked
>> list elements)
>> =A0 =A0 =A0 =A0are possible. Type 1 provides the maximum flexibility=
, which
>> contains most
>> =A0 =A0 =A0 =A0register definitions of a DMA logical channel. Fewer =
options are
>> present in type
>> =A0 =A0 =A0 =A02. Type 3 can just modify source/destinations address=
 of transfers.
>> In all
>> =A0 =A0 =A0 =A0transfers, unmodified registers settings are maintain=
ed for the
>> next transfer.
>>
>> =A0 =A0 =A0 =A0Patch provides options / API for
>> =A0 =A0 =A0 =A0 =A0 =A01) Setting up a descriptor loading for DMA ch=
annel for sg type
>> transfers
>> =A0 =A0 =A0 =A0 =A0 =A02) configuration with linked list elements
>> =A0 =A0 =A0 =A0 =A0 =A03) Starting / pause and resume of the said tr=
ansfers, query
>> state
>> =A0 =A0 =A0 =A0 =A0 =A04) Clearing the sglist mode
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> CC: Adrian Hunter <adrian.hunter@nokia.com>
>> CC: Madhusudhan C <madhu.cr@ti.com>
>> CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
>> CC: Tony Lindgren <tony@atomide.com>
>> ---
>> =A0Changes from v7:
>> =A0 * Added wmb() calls between descriptor data structure update and
>> start/resume of transfer
>> =A0 * Added proper commit log about the feature
>>
>> =A0arch/arm/plat-omap/dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0289
>> ++++++++++++++++++++++++++++++++-
>> =A0arch/arm/plat-omap/include/plat/dma.h | =A0170 ++++++++++++++++++=
+
>> =A02 files changed, 458 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index f6c9bdc..d8d4df8 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -46,12 +46,40 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE=
,
>> DMA_CH_STARTED,
>> =A0enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
>> =A0#endif
>>
>> +/* CDP Register bitmaps */
>> +#define DMA_LIST_CDP_DST_VALID (BIT(0))
>> +#define DMA_LIST_CDP_SRC_VALID (BIT(2))
>> +#define DMA_LIST_CDP_TYPE1 =A0 =A0 (BIT(4))
>> +#define DMA_LIST_CDP_TYPE2 =A0 =A0 (BIT(5))
>> +#define DMA_LIST_CDP_TYPE3 =A0 =A0 (BIT(4) | BIT(5))
>> +#define DMA_LIST_CDP_PAUSEMODE (BIT(7))
>> +#define DMA_LIST_CDP_LISTMODE =A0(BIT(8))
>> +#define DMA_LIST_CDP_FASTMODE =A0(BIT(10))
>> +/* CAPS register bitmaps */
>> +#define DMA_CAPS_SGLIST_SUPPORT =A0 =A0 =A0 =A0(BIT(20))
>> +
>> +#define DMA_LIST_DESC_PAUSE =A0 =A0(BIT(0))
>> +#define DMA_LIST_DESC_SRC_VALID =A0 =A0 =A0 =A0(BIT(24))
>> +#define DMA_LIST_DESC_DST_VALID =A0 =A0 =A0 =A0(BIT(26))
>> +#define DMA_LIST_DESC_BLK_END =A0(BIT(28))
>> +
>
> The () are not needed around BIT()
OK

>
>> =A0#define OMAP_DMA_ACTIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x01
>> =A0#define OMAP2_DMA_CSR_CLEAR_MASK =A0 =A0 =A0 0xffe
>>
>> =A0#define OMAP_FUNC_MUX_ARM_BASE =A0 =A0 =A0 =A0 (0xfffe1000 + 0xec=
)
>> +#define OMAP_DMA_INVALID_FRAME_COUNT =A0 (0xffff)
>> +#define OMAP_DMA_INVALID_ELEM_COUNT =A0 =A0(0xffffff)
>> +#define OMAP_DMA_INVALID_DESCRIPTOR_POINTER =A0 =A0(0xfffffffc)
>
> The () are not needed around literals
>
OK

>>
>> =A0static int enable_1510_mode;
>> +static int dma_caps0_status;
>> +
