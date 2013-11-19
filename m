From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/6] mmc: sdhci: clear auto cmd setting bits for no
 data cmds
Date: Tue, 19 Nov 2013 09:52:47 -0200
Message-ID: <CAOMZO5ANNpai2LuQxrW82scFdZw6aPRLZOobna60SsoVVwKS9Q@mail.gmail.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
	<1383142193-24950-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:52919 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab3KSLws (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Nov 2013 06:52:48 -0500
Received: by mail-ve0-f176.google.com with SMTP id oz11so271806veb.35
        for <linux-mmc@vger.kernel.org>; Tue, 19 Nov 2013 03:52:47 -0800 (PST)
In-Reply-To: <1383142193-24950-2-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 30, 2013 at 12:09 PM, Dong Aisheng <b29396@freescale.com> wrote:
> The auto cmd settings bits should be cleared before sending new commands
> or we may receive command timeout error for normal commands due to wrongly
> pre-sent auto cmd.
>
> e.g. we receive CMD13 timeout error due to ACMD23 is wrongly enabled
> by former data commands.
>
> mmc2: new high speed DDR MMC card at address 0001
> mmcblk1: mmc2:0001 SEM08G 7.39 GiB
> mmcblk1boot0: mmc2:0001 SEM08G partition 1 2.00 MiB
> mmcblk1boot1: mmc2:0001 SEM08G partition 2 2.00 MiB
> mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB
>  mmcblk1: p1 p2 p3 p4 < p5 p6 p7 >
> mmc2: Timeout waiting for hardware interrupt.
>  mmcblk1boot1: unknown partition table
> mmc2: Timeout waiting for hardware interrupt.
>  mmcblk1boot0: unknown partition table
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Thanks for the patch, Dong.

This fixes the eMMC interrupt timeout issue on mx6qsabresd.

I think we should mark it for stable. At least 3.11 and 3.12 have this
issue and your patch fixes it.

Regards,

Fabio Estevam
