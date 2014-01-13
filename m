From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: sdhci-esdhc-imx: fix access hardirq-unsafe
 lock in atomic context
Date: Mon, 13 Jan 2014 18:52:54 +0800
Message-ID: <CAA+hA=TFx4KpBpyUs0T6AJmLbZR36sxQNAA5yTANseQTrgxgbQ@mail.gmail.com>
References: <1388042634-17281-1-git-send-email-b29396@freescale.com>
	<20131231052436.GA22122@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:56759 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaAMKwz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 05:52:55 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so812582qac.31
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 02:52:54 -0800 (PST)
In-Reply-To: <20131231052436.GA22122@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Chris,

On Tue, Dec 31, 2013 at 1:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Dec 26, 2013 at 03:23:53PM +0800, Dong Aisheng wrote:
>> Sometimes we may meet the following lockdep issue.
>> The root cause is .set_clock callback is executed with spin_lock_irqsave
>> in sdhci_do_set_ios. However, the IMX set_clock callback will try to access
>> clk_get_rate which is using a mutex lock.
>>
>> The fix avoids access mutex in .set_clock callback by initializing the
>> pltfm_host->clock at probe time and use it later instead of calling
>> clk_get_rate again in atomic context.
>
> <snip>
>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>
> For both,
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
>> Fixes: 0ddf03c mmc: esdhc-imx: parse max-frequency from devicetree
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>
>

Can we make patch 1 go into 3.13 final since the issue exists
since 3.13 rc1.

Patch 2 in that series is the fix for sdhci-esdhc-imx runtime pm which is
newly added in chris/mmc-next and seems target for 3.14.

BTW, pls add:
Tested-by: Philippe De Muyter <phdm@macqel.be>

See:
https://lkml.org/lkml/2014/1/13/77

Regards
Dong Aisheng

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
