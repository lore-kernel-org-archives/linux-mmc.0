From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V6 1/3] mmc: mmci: add hardware busy timeout feature
Date: Fri, 4 Oct 2019 14:59:16 +0200
Message-ID: <da9072ce-852c-a46c-ecdf-ea6bfd89ef79@st.com>
References: <20190905122112.29672-1-ludovic.Barre@st.com>
 <20190905122112.29672-2-ludovic.Barre@st.com>
 <CAPDyKFpcb=dT0XBAGVL68t--xi5853Dzsgak-vbx5VcvxLZ4zA@mail.gmail.com>
 <CAPDyKFrRDHeVs6RpM=qTT1AogLnFWJLh2S4-wCcrYAON9XVKCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrRDHeVs6RpM=qTT1AogLnFWJLh2S4-wCcrYAON9XVKCA@mail.gmail.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

hi Ulf

Le 10/4/19 à 8:20 AM, Ulf Hansson a écrit :
> On Fri, 4 Oct 2019 at 08:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Thu, 5 Sep 2019 at 14:21, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> In some variants, the data timer starts and decrements
>>> when the DPSM enters in Wait_R or Busy state
>>> (while data transfer or MMC_RSP_BUSY), and generates a
>>> data timeout error if the counter reach 0.
>>
>>
>>>
>>> -Define max_busy_timeout (in ms) according to clock.
>>> -Set data timer register if the command has rsp_busy flag.
>>>   If busy_timeout is not defined by framework, the busy
>>>   length after Data Burst is defined as 1 second
>>>   (refer: 4.6.2.2 Write of sd specification part1 v6-0).
>>
>> How about re-phrasing this as below:
>>
>> -----
>> In the stm32_sdmmc variant, the datatimer is active not only during
>> data transfers with the DPSM, but also while waiting for the busyend
>> IRQs from commands having the MMC_RSP_BUSY flag set. This leads to an
>> incorrect IRQ being raised to signal MCI_DATATIMEOUT error, which
>> simply breaks the behaviour.
>>
>> Address this by updating the datatimer value before sending a command
>> having the MMC_RSP_BUSY flag set. To inform the mmc core about the
>> maximum supported busy timeout, which also depends on the current
>> clock rate, set ->max_busy_timeout (in ms).

Thanks for the re-phrasing.

>> -----
>>
>> Regarding the busy_timeout, the core should really assign it a value
>> for all commands having the RSP_BUSY flag set. However, I realize the
>> core needs to be improved to cover all these cases - and I am looking
>> at that, but not there yet.
>>
>> I would also suggest to use a greater value than 1s, as that seems a
>> bit low for the "undefined" case. Perhaps use the max_busy_timeout,
>> which would be nice a simple or 10s, which I think is used by some
>> other drivers.

OK, I will set 10s, the max_busy_timeout could be very long for small 
frequencies (example, 25Mhz => 171s).

>>
>>> -Add MCI_DATATIMEOUT error management in mmci_cmd_irq.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c | 42 ++++++++++++++++++++++++++++++++++++-----
>>>   drivers/mmc/host/mmci.h |  3 +++
>>>   2 files changed, 40 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index c37e70dbe250..c30319255dc2 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1075,6 +1075,7 @@ static void
>>>   mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>>   {
>>>          void __iomem *base = host->base;
>>> +       unsigned long long clks;
>>>
>>>          dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
>>>              cmd->opcode, cmd->arg, cmd->flags);
>>> @@ -1097,6 +1098,16 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>>                  else
>>>                          c |= host->variant->cmdreg_srsp;
>>>          }
>>> +
>>> +       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
>>> +               if (!cmd->busy_timeout)
>>> +                       cmd->busy_timeout = 1000;
>>> +
>>> +               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
>>> +               do_div(clks, MSEC_PER_SEC);
>>> +               writel_relaxed(clks, host->base + MMCIDATATIMER);
>>> +       }
>>> +
>>>          if (/*interrupt*/0)
>>>                  c |= MCI_CPSM_INTERRUPT;
>>>
>>> @@ -1201,6 +1212,7 @@ static void
>>>   mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>               unsigned int status)
>>>   {
>>> +       u32 err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
>>>          void __iomem *base = host->base;
>>>          bool sbc, busy_resp;
>>>
>>> @@ -1215,8 +1227,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>           * handling. Note that we tag on any latent IRQs postponed
>>>           * due to waiting for busy status.
>>>           */
>>> -       if (!((status|host->busy_status) &
>>> -             (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
>>> +       if (host->variant->busy_timeout && busy_resp)
>>> +               err_msk |= MCI_DATATIMEOUT;
>>> +
>>> +       if (!((status | host->busy_status) &
>>> +             (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
>>>                  return;
>>>
>>>          /* Handle busy detection on DAT0 if the variant supports it. */
>>> @@ -1235,8 +1250,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>                   * while, to allow it to be set, but tests indicates that it
>>>                   * isn't needed.
>>>                   */
>>> -               if (!host->busy_status &&
>>> -                   !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>>> +               if (!host->busy_status && !(status & err_msk) &&
>>>                      (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>>>
>>>                          writel(readl(base + MMCIMASK0) |
>>> @@ -1290,6 +1304,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>                  cmd->error = -ETIMEDOUT;
>>>          } else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
>>>                  cmd->error = -EILSEQ;
>>> +       } else if (host->variant->busy_timeout && busy_resp &&
>>> +                  status & MCI_DATATIMEOUT) {
>>> +               cmd->error = -ETIMEDOUT;
>>
>> It's not really clear to me what happens with the busy detection
>> status bit (variant->busy_detect_flag), in case a MCI_DATATIMEOUT IRQ
>> is raised, while also having host->busy_status set (waiting for
>> busyend).
>>
>> By looking at the code a few lines above this, we may do a "return;"
>> while waiting for the busyend IRQ even if MCI_DATATIMEOUT also is
>> raised, potentially losing that from being caught. Is that really
>> correct?
> 
> A second thought. That "return;" is to manage the busyend IRQ being
> raised of the first edge due to broken HW. So I guess, this isn't an
> issue for stm32_sdmmc variant after all?
>
> I have a look at the next patches in the series..

you're referring to "return" of ?
	if (host->busy_status &&
	    (status & host->variant->busy_detect_flag)) {
		writel(host->variant->busy_detect_mask,
		       host->base + MMCICLEAR);
		return;
	}

For stm32 variant (in patch 3/3): the "busy completion" is
released immediately if there is an error or busyd0end,
and cleans: irq, busyd0end mask, busy_status variable.

I could add similar action in patch 2/3 function: "ux500_busy_complete"

static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 
err_msk)
{
	void __iomem *base = host->base;

	if (status & err_msk)
		goto complete;
...
complete:
	/* specific action to clean busy detection, irq, mask, busy_status */
}

what do you think about it?

> 
> [...]
> 
> Kind regards
> Uffe
> 
