From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: use the generic config for omap2plus
 devices
Date: Fri, 16 Aug 2013 22:05:44 +0530
Message-ID: <520E54E0.9040609@ti.com>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com> <1373472384-13067-1-git-send-email-a-bindra@ti.com> <20130711130921.GD30970@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60413 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab3HPQfv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Aug 2013 12:35:51 -0400
In-Reply-To: <20130711130921.GD30970@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: a-bindra@ti.com, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nishanth Menon <nm@ti.com>

On Thursday 11 July 2013 06:39 PM, Felipe Balbi wrote:
> On Wed, Jul 10, 2013 at 09:36:24PM +0530, a-bindra@ti.com wrote:
>> From: Amarinder Bindra <a-bindra@ti.com>
>>
>> OMAP's hs_mmc driver is used for MMC controller operation on many
>> omap2plus SoCs (OMAP2430, OMAP3, 4, 5 and AM335x).
>>
>> Considering that the device tree entries are already present for these,
>> allow the driver to be built using the config ARCH_OMAP2PLUS rather
>> than individually adding a config for each SoC to enable the
>> support.
>>
>> Use COMPILE_TEST to enable the build for other platforms.
>>
>> Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
>> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>
> Acked-by: Felipe Balbi <balbi@ti.com>
>

Acked-by: Balaji T K <balajitk@ti.com>
