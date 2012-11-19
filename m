From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v6 09/14] mmc: sdhci-pxav3: add quirks2
Date: Mon, 19 Nov 2012 10:34:00 +0800
Message-ID: <CADz5_g+rhJzRxAOyCe3CpW+ZywcwCQVH3MU8e0Z3JAdk+JStGw@mail.gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-10-git-send-email-keyuan.liu@gmail.com>
	<874nkn9916.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42619 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab2KSCeC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 21:34:02 -0500
Received: by mail-wi0-f172.google.com with SMTP id hj6so3297258wib.1
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 18:34:00 -0800 (PST)
In-Reply-To: <874nkn9916.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

2012/11/18 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Wed, Oct 17 2012, Kevin Liu wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c          |    2 ++
>>  include/linux/platform_data/pxa_sdhci.h |    2 ++
>>  2 files changed, 4 insertions(+), 0 deletions(-)
>
> It looks like you aren't using any of the quirks in quirks2, is that
> right?  I'm still hoping we might be able to get rid of quirks2, so
> I'd rather wait until you need it (or we get rid of it) before applying
> this.
>

My previous patch "[PATCH v6 08/14] mmc: sdhci: enhance preset value
function" introduced a quirk SDHCI_QUIRK2_PRESET_VALUE_BROKEN, which
aim to disable preset feature since the preset setting is fixed only
for 200Mhz base clock on pxav3 platform. So we should disable preset
if the base clock is other than 200Mhz.

Thanks
Kevin
