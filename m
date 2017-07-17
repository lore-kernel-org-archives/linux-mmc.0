From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: add quirk
 SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
Date: Mon, 17 Jul 2017 15:47:42 +0300
Message-ID: <2440f065-ccd4-4575-4443-2acd1c23d6c4@intel.com>
References: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
 <20170628133504.17422-2-srinivas.kandagatla@linaro.org>
 <CAPDyKFq-wnu2=9TqKBLGEEmbbqVLDKQ+rht8X2j8quNtuMzn9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7773 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdGQMx5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 17 Jul 2017 08:53:57 -0400
In-Reply-To: <CAPDyKFq-wnu2=9TqKBLGEEmbbqVLDKQ+rht8X2j8quNtuMzn9A@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On 11/07/17 16:49, Ulf Hansson wrote:
> On 28 June 2017 at 15:35,  <srinivas.kandagatla@linaro.org> wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds quirk to sdhci controllers which are broken when
>> HOST SDMA Buffer Boundary is programmed in Block Size Register (0x04)
>> when using ADMA. Qualcomm sdhci controller is one of such type, writing
>> to this bits is un-supported.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++------
>>  drivers/mmc/host/sdhci.h |  2 ++
>>  2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ecd0d4350e8a..d68ff1955761 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -765,6 +765,20 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>         }
>>  }
>>
>> +static void sdhci_set_blk_size_reg(struct sdhci_host *host,
>> +                                  unsigned int sdma_boundary,
>> +                                  unsigned int blksz)
>> +{
>> +       if ((host->quirks2 & SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER) &&
>> +                       (host->flags & SDHCI_USE_ADMA)) {
>> +               sdhci_writew(host, SDHCI_MAKE_BLKSZ(0, blksz),
>> +                            SDHCI_BLOCK_SIZE);
>> +       } else {
>> +               sdhci_writew(host, SDHCI_MAKE_BLKSZ(sdma_boundary, blksz),
>> +                            SDHCI_BLOCK_SIZE);
>> +       }
>> +}
>> +
>>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>  {
>>         u8 ctrl;
>> @@ -897,8 +911,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>         sdhci_set_transfer_irqs(host);
>>
>>         /* Set the DMA boundary value and block size */
>> -       sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
>> -               data->blksz), SDHCI_BLOCK_SIZE);
>> +       sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, data->blksz);
>>         sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>>  }
>>
>> @@ -2052,9 +2065,9 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>>          */
>>         if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200 &&
>>             mmc->ios.bus_width == MMC_BUS_WIDTH_8)
>> -               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128), SDHCI_BLOCK_SIZE);
>> +               sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, 128);
>>         else
>> -               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
>> +               sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, 64);
>>
>>         /*
>>          * The tuning block is sent by the card to the host controller.
>> @@ -2998,8 +3011,7 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
>>                 ctrl |= SDHCI_CTRL_ADMA32;
>>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>
>> -       sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 512),
>> -                    SDHCI_BLOCK_SIZE);
>> +       sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, 512);
>>
>>         /* Set maximum timeout */
>>         sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 0469fa191493..9a1343509bb5 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -435,6 +435,8 @@ struct sdhci_host {
>>  #define SDHCI_QUIRK2_ACMD23_BROKEN                     (1<<14)
>>  /* Broken Clock divider zero in controller */
>>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN             (1<<15)
>> +/* Controller doesn't support sdma boundray buffer setup when using ADMA */
>> +#define SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER       (1<<16)
>>
>>         int irq;                /* Device IRQ */
>>         void __iomem *ioaddr;   /* Mapped address */
>> --
>> 2.11.0
>>
> 
> This change seems like a reasonable justification for adding a new
> SDHCI quirk, even if we in general wants to avoid that.
> 
> Adrian?

If we add a quirk for every register we end up with a very ugly version of
CONFIG_MMC_SDHCI_IO_ACCESSORS.  So CONFIG_MMC_SDHCI_IO_ACCESSORS is a better
option.  Another possibility is to add a member to struct sdhci_host,
initialized to SDHCI_DEFAULT_BOUNDARY_ARG, and write that.  Drivers could
then change the value if necessary.
