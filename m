From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v11 2/9] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Fri, 3 Mar 2017 10:39:11 -0800
Message-ID: <59986cad-be37-27fd-f9fe-bb11579bc0ea@caviumnetworks.com>
References: <20170206133953.8390-1-jglauber@cavium.com>
 <20170206133953.8390-3-jglauber@cavium.com>
 <CAPDyKFpZs-WZ32NQTc3zY6RdWJecZkUvbEbszAJfv4H2Rw2JCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:41376
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751976AbdCCTPk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 14:15:40 -0500
In-Reply-To: <CAPDyKFpZs-WZ32NQTc3zY6RdWJecZkUvbEbszAJfv4H2Rw2JCQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On 03/03/2017 03:47 AM, Ulf Hansson wrote:
> On 6 February 2017 at 14:39, Jan Glauber <jglauber@cavium.com> wrote:
[...]
>> +}
>> +
>> +static void prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq,
>> +                           union mio_emm_dma *emm_dma)
>> +{
>> +       struct cvm_mmc_slot *slot = mmc_priv(mmc);
>> +
>> +       /*
>> +        * Our MMC host hardware does not issue single commands,
>> +        * because that would require the driver and the MMC core
>> +        * to do work to determine the proper sequence of commands.
>
> I don't get this. The allowed sequence of the commands is determined
> by the SD/(e)MMC/SDIO spec and much of this knowledge is the
> responsibility of the mmc core.
>
>> +        * Instead, our hardware is superior to most other MMC bus
>
> No need to brag about your HW. Let's just describe how it works instead.
>
>> +        * hosts. The sequence of MMC commands required to execute
>> +        * a transfer are issued automatically by the bus hardware.
>
> What does this really mean? Is this about HW support for better
> dealing with data requests?


The entire comment should be removed.   It is laced with sarcasm that is 
very difficult for people not intimately familiar with the discussions 
to detect and decipher.

The real story is that the Cavium MMC hardware was designed based on a 
defective premise.  Hardwired in to the core of the MMC bus interface 
hardware is a multi-command synthesizer/sequencer that is hard coded to 
work with a limited subset of MMC-only command sequences.  This allows 
you to read data from the first few MB of an MMC device with only a 
handful of assembly language instructions contained in the on-die 
mask-ROM of the SoC.

When it comes to actually using the MMC/SD bus interface from within the 
Linux MMC framework, we have to apply a transform to the command 
sequences supplied by the Linux MMC core so that the command sequence 
synthesized by Cavium MMC hardware matches as closely as possible what 
was actually requested.  For many command sequences, the match between 
what is synthesized by the hardware and what was requested is not exact.

>
>> +        *
>> +        * - David Daney <ddaney@cavium.com>
>> +        */
>> +       emm_dma->val = 0;
>> +       emm_dma->s.bus_id = slot->bus_id;
>> +       emm_dma->s.dma_val = 1;
>> +       emm_dma->s.sector = (mrq->data->blksz == 512) ? 1 : 0;
>> +       emm_dma->s.rw = (mrq->data->flags & MMC_DATA_WRITE) ? 1 : 0;
>> +       emm_dma->s.block_cnt = mrq->data->blocks;
>> +       emm_dma->s.card_addr = mrq->cmd->arg;
>> +       if (mmc_card_mmc(mmc->card) || (mmc_card_sd(mmc->card) &&
>> +           (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
>> +               emm_dma->s.multi = 1;

Here is a prefect example.

If a multi-block transfer was requested, the hardware command 
synthesizer uses the "multi" bit to determine if it should generate a 
command sequence for a single multi-block transfer, or multiple 
single-block transfers.

Probably the MMC core would never request a multi-block transfer from a 
device that doesn't support it, but we check here just-in-case.



>> +
>> +       pr_debug("[%s] blocks: %u  multi: %d\n", (emm_dma->s.rw) ? "W" : "R",
>> +                mrq->data->blocks, emm_dma->s.multi);
>> +}
>> +

