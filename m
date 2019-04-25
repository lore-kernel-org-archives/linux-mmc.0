From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
Date: Thu, 25 Apr 2019 16:09:35 +0200
Message-ID: <30eae958-fd66-96a2-52a2-661c0646a302@st.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFoZuQ+hshZpj-qjchKf7enW4ChPd=r_QhK2xtuJcSvqxQ@mail.gmail.com>
 <fd57fd63-093e-dd23-5ca4-6bd4f99ecda9@st.com>
 <CAPDyKFrmTX6w1ZgwBkEmieCQ5swUQx_O864mHofhNsz3LFC32A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrmTX6w1ZgwBkEmieCQ5swUQx_O864mHofhNsz3LFC32A@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org


On 4/25/19 12:08 PM, Ulf Hansson wrote:
> On Thu, 25 Apr 2019 at 11:22, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> hi Ulf
>>
>> On 4/23/19 3:39 PM, Ulf Hansson wrote:
>>> On Tue, 5 Mar 2019 at 17:10, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> The busy status bit could occurred even if no busy response is
>>>> expected (example cmd11). On sdmmc variant, the busy_detect_flag
>>>> reflects inverted value of d0 state, it's sampled at the end of a
>>>> CMD response and a second time 2 clk cycles after the CMD response.
>>>> To avoid a fake busy, the busy status could be checked and polled
>>>> only if the command has RSP_BUSY flag.
>>>
>>> I would appreciate a better explanation of what this patch really changes.
>>>
>>> The above is giving some background to the behavior of sdmmc variant,
>>> but at this point that variant doesn't even have the
>>> ->variant->busy_detect flag set.
>>>
>>
>> Yes, I will try to explain more and focus on common behavior.
>>
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>> ---
>>>>    drivers/mmc/host/mmci.c | 19 +++++++++++++------
>>>>    1 file changed, 13 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>>> index 387ff14..4901b73 100644
>>>> --- a/drivers/mmc/host/mmci.c
>>>> +++ b/drivers/mmc/host/mmci.c
>>>> @@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>>                unsigned int status)
>>>>    {
>>>>           void __iomem *base = host->base;
>>>> -       bool sbc;
>>>> +       bool sbc, busy_resp;
>>>>
>>>>           if (!cmd)
>>>>                   return;
>>>>
>>>>           sbc = (cmd == host->mrq->sbc);
>>>> +       busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>>>>
>>>>           /*
>>>>            * We need to be one of these interrupts to be considered worth
>>>> @@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>>           /*
>>>>            * ST Micro variant: handle busy detection.
>>>>            */
>>>> -       if (host->variant->busy_detect) {
>>>> -               bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>>>> +       if (busy_resp && host->variant->busy_detect) {
>>>>
>>>>                   /* We are busy with a command, return */
>>>>                   if (host->busy_status &&
>>>> @@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>>                    * that the special busy status bit is still set before
>>>>                    * proceeding.
>>>>                    */
>>>> -               if (!host->busy_status && busy_resp &&
>>>> +               if (!host->busy_status &&
>>>>                       !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>>>>                       (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>>>
>>> All the changes above makes perfect sense to me, but looks more like a
>>> cleanup of the code, rather than actually changing the behavior.
>>
>> yes, few changing (this just avoid to enter in
>> "if (host->variant->busy_detect)") at each time.
>> I could move this part in cleanup patch (before this patch)
> 
> Sounds good to me!
> 
>>
>>>
>>>>
>>>> @@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>>    {
>>>>           struct mmci_host *host = dev_id;
>>>>           u32 status;
>>>> +       bool busy_resp;
>>>>           int ret = 0;
>>>>
>>>>           spin_lock(&host->lock);
>>>> @@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>>                   }
>>>>
>>>>                   /*
>>>> -                * Don't poll for busy completion in irq context.
>>>> +                * Don't poll for:
>>>> +                * -busy completion in irq context.
>>>> +                * -no busy response expected.
>>>>                    */
>>>> -               if (host->variant->busy_detect && host->busy_status)
>>>> +               busy_resp = host->cmd ?
>>>> +                       !!(host->cmd->flags & MMC_RSP_BUSY) : false;
>>>
>>> This doesn't make sense to me, but I may be missing something.
>>>
>>> host->busy_status is being updated by mmci_cmd_irq() and only when
>>> MMC_RSP_BUSY is set for the command in flight. In other words,
>>> checking for MMC_RSP_BUSY here as well is redundant. No?
>>
>> In mmci_irq the "do while" loops until the status is totally cleared.
>>
>> Today (for variant with busy_detect option), the status busy_detect_flag
>> is excluded only while busy_status period (command with MMC_RSP_BUSY and
>> while busy line is low => "busy_status=1")
>>
>> On SDMMC variant I noticed that busy_detect_flag status could be enabled
>> even if the command is not MMC_RSP_BUSY, for example sdmmc variant stay
>> in loop while cmd11 voltage switch.
> 
> Right, I see.
> 
>>
>> So I wish extend host->variant->busy_detect_flag exclusion for all
>> commands which is not a MMC_RSP_BUSY. I suppose that other variants
>> could have the same behavior, and else there is no impact, normally.
> 
> I am guessing this is because the variant->busy_dpsm_flag has been set
> in the datactrl register, which is needed for mmci_card_busy().
> 
> That said, I am kind of wondering if we ever should need repeat the
> while loop if 'status' contains the bit for
> host->variant->busy_detect_flag. I mean we have already called
> mmci_cmd_irq() to handle it.
> 
> So, couldn't we just always do:
> 
> if (host->variant->busy_detect_flag)
>      status &= ~host->variant->busy_detect_flag;
> 
> No?

yes that make sense, I launched tests on sdmmc and it's ok.
I think, that we could take on this solution.

If it's ok for you, I resend a series with all modifications.

Regards
Ludo

> 
>>
>>>
>>>> +
>>>> +               if (host->variant->busy_detect &&
>>>> +                   (!busy_resp || host->busy_status))
>>>>                           status &= ~host->variant->busy_detect_flag;
>>>>
>>>>                   ret = 1;
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> Kind regards
>>> Uffe
>>>
> 
> Kind regards
> Uffe
> 
