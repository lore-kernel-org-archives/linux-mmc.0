From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 09/14] mmc: sdhci-pxav3: add quirks2
Date: Sun, 25 Nov 2012 14:26:40 -0500
Message-ID: <87r4nh8owf.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-10-git-send-email-keyuan.liu@gmail.com>
	<874nkn9916.fsf@octavius.laptop.org>
	<CADz5_g+rhJzRxAOyCe3CpW+ZywcwCQVH3MU8e0Z3JAdk+JStGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47888 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab2KYT0s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 14:26:48 -0500
In-Reply-To: <CADz5_g+rhJzRxAOyCe3CpW+ZywcwCQVH3MU8e0Z3JAdk+JStGw@mail.gmail.com>
	(Kevin Liu's message of "Mon, 19 Nov 2012 10:34:00 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Sun, Nov 18 2012, Kevin Liu wrote:
>>> From: Kevin Liu <kliu5@marvell.com>
>>>
>>> Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
>>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>>> ---
>>>  drivers/mmc/host/sdhci-pxav3.c          |    2 ++
>>>  include/linux/platform_data/pxa_sdhci.h |    2 ++
>>>  2 files changed, 4 insertions(+), 0 deletions(-)
>>
>> It looks like you aren't using any of the quirks in quirks2, is that
>> right?  I'm still hoping we might be able to get rid of quirks2, so
>> I'd rather wait until you need it (or we get rid of it) before applying
>> this.
>
> My previous patch "[PATCH v6 08/14] mmc: sdhci: enhance preset value
> function" introduced a quirk SDHCI_QUIRK2_PRESET_VALUE_BROKEN, which
> aim to disable preset feature since the preset setting is fixed only
> for 200Mhz base clock on pxav3 platform. So we should disable preset
> if the base clock is other than 200Mhz.

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
