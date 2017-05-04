From: =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit@wsystem.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-esdhc: Add SDHCI_QUIRK_32BIT_DMA_ADDR
Date: Thu, 4 May 2017 11:00:50 +0200
Message-ID: <19f1fd58-6b56-4ba5-4fdf-9cc845b55c27@wsystem.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
 <CAK8P3a2PTrDEKbvGRDcq6dhDaALbEQbUwO-TpjricgJPREFK=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from authsmtp79.register.it ([195.110.122.164]:15244 "EHLO
        authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751565AbdEDJBH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 May 2017 05:01:07 -0400
In-Reply-To: <CAK8P3a2PTrDEKbvGRDcq6dhDaALbEQbUwO-TpjricgJPREFK=g@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa@the-dreams.de>

On 04/05/2017 10:47, Arnd Bergmann wrote:
> On Wed, May 3, 2017 at 12:05 PM, Benoît Thébaudeau <benoit@wsystem.com> wrote:
>> The eSDHC can only DMA from 32-bit-aligned addresses.
>>
>> This fixes the following test cases of mmc_test:
>>   11:   Badly aligned write
>>   12:   Badly aligned read
>>   13:   Badly aligned multi-block write
>>   14:   Badly aligned multi-block read
>>
>> Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
> 
> Is this the right description? I thought that SDHCI_QUIRK_32BIT_DMA_ADDR
> was for devices that cannot address high memory above 0xffffffff, rather than
> requiring a specific alignment.
> 
> If this is indeed an address range problem rather than an alignment problem,
> are you sure it is the SD controller that is wrong here, rather than having a
> 64-bit DMA capable  SDHCI connected to a 32-bit parent bus? In the
> latter case, the dma-ranges property in the parent bus should limit
> the addressing, not the device.

No, this is the right description. This quirk really is about alignment, and not
about address range. See:

drivers/mmc/host/sdhci.h:
>---
/* Controller can only DMA from 32-bit aligned addresses */
#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
<---

drivers/mmc/host/sdhci.c @ sdhci_prepare_data():
>---
		offset_mask = 0;
[...]
			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR)
				offset_mask = 3;
[...]
				if (sg->offset & offset_mask) {
					DBG("Reverting to PIO because of bad alignment\n");
					host->flags &= ~SDHCI_REQ_USE_DMA;
					break;
				}
<---

Benoît
