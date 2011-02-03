From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH 0/4] omap4: hsmmc: Adding ADMA support
Date: Thu, 3 Feb 2011 11:44:28 +0530
Message-ID: <AANLkTi=8LGDj91uU6_VM+5aWaWW4i6G=XPet294Nt-MF@mail.gmail.com>
References: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com> <20110120174226.GX4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42811 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751982Ab1BCGOt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Feb 2011 01:14:49 -0500
In-Reply-To: <20110120174226.GX4957@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com

Tony,

On Thu, Jan 20, 2011 at 11:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kishore Kadiyala <kishore.kadiyala@ti.com> [110118 09:19]:
>> This patch series adds support for ADMA on MMC1 & MMC2 controllers on OMAP4.
>> There is no performance improvement observed using ADMA over SDMA.
>> Advantage using ADMA could be reducing contention over SDMA.
>> Also the series includes some cleanup.
>
> To me it seems that the only sane way to deal with multiple different
> DMA enginges is to implement them all with drivers/dma/dmaengine.c.
> Otherwise we'll end up with multiple custom ADMA implementations in
> each driver. We need to also make SDMA use the dmaengine code.
>
> If the current dmaengine code does not support this, we need to
> improve it to deal with cases like these.

Ok, I will check the feasibility of implementing ADMA through dmaengine .


-- 
Regards,
Kishore

>
> Regards,
>
> Tony
>
