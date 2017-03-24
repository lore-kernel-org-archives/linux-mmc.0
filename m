From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/2] mmc: factor out getting dma direction from host
 drivers
Date: Fri, 24 Mar 2017 07:44:08 +0100
Message-ID: <baaf544d-5b9d-220a-1209-50afedca6d31@gmail.com>
References: <44d784c1-ab30-db59-9037-db8c87935b43@gmail.com>
 <bb5f5138-6d64-1eb0-39a2-277c16dc6ca8@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36102 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbdCXGtZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 02:49:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so1327186wmf.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2017 23:49:24 -0700 (PDT)
In-Reply-To: <bb5f5138-6d64-1eb0-39a2-277c16dc6ca8@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Am 24.03.2017 um 02:14 schrieb Shawn Lin:
> Hi Heiner,
> 
> On 2017/3/24 5:17, Heiner Kallweit wrote:
>> Several host drivers contain identical code for determining the
>> DMA direction. Therefore factor this out to the core.
> 
> I like this patchset, at least it removes more lines than insertions :)
> 
> Only a small nit,
> 
> s3cmci_prepare_dma seems need some more cleanup as the rw variable
> isn't useful personally. Anyway,
> 
rw is still used for setting conf.direction, therefore I decided to
keep it (at least for now, however this variable might be a victim of
some later, more general refactoring).

However I found few more places where the new function can be applied.
So I'll send a v2 anyway.

> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
Thanks for the quick review.

> 
> 
>>
>> Heiner Kallweit (2):
>>   mmc: core: add mmc_get_dma_dir
>>   mmc: use new core function mmc_get_dma_dir
>>
>>  drivers/mmc/host/android-goldfish.c | 10 ++--------
>>  drivers/mmc/host/atmel-mci.c        |  6 ++----
>>  drivers/mmc/host/davinci_mmc.c      | 10 +++-------
>>  drivers/mmc/host/dw_mmc.c           | 14 +++-----------
>>  drivers/mmc/host/jz4740_mmc.c       |  9 ++-------
>>  drivers/mmc/host/mmc_spi.c          |  5 +----
>>  drivers/mmc/host/mtk-sd.c           |  8 ++------
>>  drivers/mmc/host/mvsdio.c           | 11 +++++------
>>  drivers/mmc/host/omap_hsmmc.c       | 17 ++++-------------
>>  drivers/mmc/host/s3cmci.c           |  4 ++--
>>  drivers/mmc/host/sdhci.c            |  9 +++------
>>  drivers/mmc/host/sunxi-mmc.c        | 14 +++-----------
>>  include/linux/mmc/host.h            |  6 ++++++
>>  13 files changed, 38 insertions(+), 85 deletions(-)
>>
> 
> 

