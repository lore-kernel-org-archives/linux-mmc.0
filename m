From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH RESEND v10 0/7] mmc: omap_hsmmc: pbias dt and cleanup
Date: Wed, 26 Feb 2014 20:13:29 +0530
Message-ID: <530DFD91.4090601@ti.com>
References: <1389627375-9107-1-git-send-email-balajitk@ti.com> <1392821801-29673-1-git-send-email-balajitk@ti.com> <530DF453.40201@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59192 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbaBZOnp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 26 Feb 2014 09:43:45 -0500
In-Reply-To: <530DF453.40201@epfl.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, tony@atomide.com, broonie@kernel.org, Stefan Roese <stefan.roese@gmail.com>

On Wednesday 26 February 2014 07:34 PM, Florian Vaussard wrote:
> Hi,
>
> On 02/19/2014 03:56 PM, Balaji T K wrote:
>> Few cleanups to reduce code indent,
>> Add pbias_regulator support and adapt omap_hsmmc to use pbias regulator
>> to configure required voltage on mmc1 pad(SD card) i/o rails on OMAP SoCs.
>>
>
> I tested on both OMAP3630 (Overo Storm) and OMAP4430 (DuoVero). The
> rootfs is mounted on mmc1 and works as usual. Here is what I can see:
>
> - pbias-supply is parsed from DT
> - VMMC1 is set to 3V
> - According to the debugfs entry, we are working at 3V signaling
> - By dumping CONTROL_PBIASLITE, bit MMC1_PBIASLITE_VMODE
> (PBIASLITEVMODE0 on OMAP3) is set to 1 (-> 3V)
>
> Do you see any other tests that I could run to validate your patches?

Nope, Stefan has tested the other use case of detecting sd card at kernel
without any sd card/pbias activity at u-boot.

> Otherwise:
>
> Tested-by: Florian Vaussard <florian.vaussard@epfl.ch>
>

Thanks Florian, Stefan for Testing.
