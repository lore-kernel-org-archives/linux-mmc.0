From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 0/2] Pass n900 MMC slot names in pdata for legacy user
 space
Date: Thu, 28 Apr 2016 23:33:38 +0300
Message-ID: <572273A2.4050104@gmail.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35318 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbcD1Udm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 16:33:42 -0400
In-Reply-To: <1461714383-9956-1-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On 27.04.2016 02:46, Tony Lindgren wrote:
> Hi all,
>
> N900 needs the MMC slot names to work. Let's pass them in pdata
> for now to remove the last remaining blocker for removing omap3
> legacy booting support for v4.8.
>
> Then when we have a generic DT binding for the slot names, we
> can use that assuming it will work for the n900 legacy user space.
>
> Regards,
>
> Tony
>
>
> Tony Lindgren (2):
>    ARM: OMAP2+: n900 needs MMC slot names for legacy user space
>    mmc: omap_hsmmc: Check if MMC slot name is passed in pdata
>
>   arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
>   drivers/mmc/host/omap_hsmmc.c      | 6 +++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
>

For both patches, you may add:

Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Thanks,
Ivo
