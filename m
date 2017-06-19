From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
Date: Mon, 19 Jun 2017 12:06:33 +0530
Message-ID: <810fba3e-a488-fa0d-5639-47f1c76ea2b6@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com> <20170619060256.GK3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:20824 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdFSGh3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2017 02:37:29 -0400
In-Reply-To: <20170619060256.GK3730@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On Monday 19 June 2017 11:32 AM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170616 05:47]:
>> The data manual of J6/J6 Eco recommends to set different IODELAY values
>> depending on the mode in which the MMC/SD is enumerated in order to
>> ensure IO timings are met.
>>
>> Add support to set the IODELAY values depending on the various MMC
>> modes using the pinctrl APIs.
> 
> This does not seem to apply against Linux next for me for
> the binding. Fixing that, compile fails for me with:
> 
> drivers/mmc/host/omap_hsmmc.c:2384:13: error:
> 'struct omap_hsmmc_platform_data' has no member named 'version'

This series has a dependency with
https://www.spinics.net/lists/arm-kernel/msg586215.html series

*version* member is added in patch with $subject
"ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM"

Thanks
Kishon
