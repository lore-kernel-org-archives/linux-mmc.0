From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/7] ARM: dts: MMC fixes for DRA7 based boards
Date: Wed, 5 Aug 2015 20:36:25 +0530
Message-ID: <55C22671.1060906@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com> <20150805105400.GF16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbbHEPHW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Aug 2015 11:07:22 -0400
In-Reply-To: <20150805105400.GF16878@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, nsekhar@ti.com

Hi,

On Wednesday 05 August 2015 04:24 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150730 01:16]:
>> Miscellaneous fixes in dts files for MMC device tree nodes.
>>
>> Did basic read/write test in J6, J6 Eco and Beagle-x15
>>
>> Balaji T K (1):
>>   ARM: dts: dra7-evm: add evm_3v3_sd regulator
>>
>> Kishon Vijay Abraham I (5):
>>   ARM: dts: dra72-evm: add evm_3v3_sd regulator
>>   ARM: dts: dra72-evm: Set max clock frequency of MMC1 and MMC2
>>   ARM: dts: am57xx-beagle-x15: mmc1: remove redundant pbias-supply
>>     property
>>   ARM: dts: dra7-evm: Fix spurious card insert/removal interrupt
>>   ARM: dts: dra72-evm: Fix spurious card insert/removal interrupt
>>
>> Nishanth Menon (1):
>>   ARM: dts: dra7-evm: Add MMCSD card removal GPIO
>>
>>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
>>  arch/arm/boot/dts/dra7-evm.dts          |   18 +++++++++++++++++-
>>  arch/arm/boot/dts/dra72-evm.dts         |   16 ++++++++++++++--
>>  3 files changed, 31 insertions(+), 4 deletions(-)
> 
> Thanks applying all these into omap-for-v4.3/dt.

Thanks. Please take [1] one too.

[1] -> https://lkml.org/lkml/2015/8/5/443

Thanks
Kishon
