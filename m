From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V3 1/3] mmc: mmci: fix read status for busy detect
Date: Fri, 26 Jul 2019 11:41:57 +0200
Message-ID: <dd5c1e86-f0b1-cdfa-1b91-486f99d4e50c@st.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <1559577325-19266-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpJPbpTnfA2cynFURyxFY_YCm7MRXw3m2nQyU+z=ZWsFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpJPbpTnfA2cynFURyxFY_YCm7MRXw3m2nQyU+z=ZWsFA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

hi Ulf

Thanks to your "Clarify comments ..." commit, like is closes
I resumed upstream of this series.

On 7/15/19 6:31 PM, Ulf Hansson wrote:
> On Mon, 3 Jun 2019 at 17:55, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> "busy_detect_flag" is used to read & clear busy value of mmci status.
>> "busy_detect_mask" is used to manage busy irq of mmci mask.
>> So to read mmci status the busy_detect_flag must be take account.
>> if the variant does not support busy detect feature the flag is null
>> and there is no impact.
> 
> By reading the changelog, it doesn't tell me the purpose of this
> change. When going forward, please work harder on your changelogs.
> 
> Make sure to answer the questions, *why* is this change needed,
> *what/how* does the change do.

Ok, I will explain the differences with the legacy and the needs of 
sdmmc variant about busy detection.

> 
>>
>> Not need to re-read the status register in mmci_cmd_irq, the
>> status parameter can be used.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 356833a..5b5cc45 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1240,7 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>                   */
>>                  if (!host->busy_status &&
>>                      !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>> -                   (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>> +                   (status & host->variant->busy_detect_flag)) {
> 
> I suggested you to do this change through some of my earlier comments,
> however I think it should be made as a stand alone change.
> 
> Anyway, when looking at the details in your series, I decided to try
> to help out a bit, so I have prepared a couple of related patches for
> cleaning up and clarifying the busy detection code/comments in mmci. I
> have incorporated the above change, so let me post them asap.
> 
>>
>>                          /* Clear the busy start IRQ */
>>                          writel(host->variant->busy_detect_mask,
>> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>                   * to make sure that both start and end interrupts are always
>>                   * cleared one after the other.
>>                   */
>> -               status &= readl(host->base + MMCIMASK0);
>> +               status &= readl(host->base + MMCIMASK0) |
>> +                       host->variant->busy_detect_flag;
> 
> As I told earlier in the review, this looks wrong to me.
> 
> It means that you will add the bit for the ->busy_detect_flag to the
> status field we have just read from the MMCISTATUS register. That
> means the busy status may be set when it shouldn't.
> 
>>                  if (host->variant->busy_detect)
>>                          writel(status & ~host->variant->busy_detect_mask,
>>                                 host->base + MMCICLEAR);
>> --
>> 2.7.4
>>
> 
> By looking at the other changes in the series, I assume @subject patch
> is intended to prepare for the other changes on top. But it's not
> really clear.
> 
> Anyway, in that regards, the below is my observations of what seems to
> be important part, when supporting busy detection for the stm32 sdmmc
> variant (except the timeout things in patch2, which I intend to
> comment separately on).
> 
> I figured, these are the involved register bits/masks:
> 
> MMCISTATUS:
> MCI_STM32_BUSYD0 BIT(20)
> MCI_STM32_BUSYD0END BIT(21)
> 
> MMCIMASK0:
> MCI_STM32_BUSYD0ENDMASK BIT(21)

it's exact:
MCI_STM32_BUSYD0 BIT(20): This is a hardware status flag only (inverted 
value of d0 line), it does not generate an interrupt, and so no mask
bit.

MCI_STM32_BUSYD0ENDMASK BIT(21): This indicates only end of busy
following a CMD response. On busy to Not busy changes, an interrupt
is generated (if unmask) and BUSYD0END status flag is set.
status flag is cleared by writing corresponding interrupt clear bit in 
MMCICLEAR.

> 
> For the legacy ST variant, there is only one register bit in
> MMCISTATUS that is used for indicating busy (MCI_ST_CARDBUSY BIT(24)).
> There is no dedicated busy-end bit for the busy-end IRQ, which I
> believe is the reason to why the current code also is bit messy.

yes

> 
> It seems like the stm32 sdmmc variant have a separate status bit for
> the busy-end IRQ, correct?

yes

> 
> If I understand correctly by looking at patch3, you don't use the
> dedicated busy-end status bit (MCI_STM32_BUSYD0END), right? Then why
> not?

like your are clarify in previous series, the busy detection is done
in 3 steps.

if I use:
.busy_detect_flag	= MCI_STM32_BUSYD0ENDMASK,
.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,

the sdmmc request will be not correctly completed, because the third 
step can't be happen.

chronologies:
step1: when busyd0end change to 1
  => busyd0end interrupt is unmasked
  => busy_status = cmd_sent | respend
  => return to mmci_irq
step2: busyd0end is yet to 1
  => clear the busyd0end interrupt
	=> the hardware clear busyd0end status flag on interrupt clear
  => return to mmci_irq

like MCI_STM32_BUSYD0END interrupt is generated only on change
busy to not busy, when the interrupt is cleared (status is 0)
the step 3 can't happen (no irq pending to re-enter in mmci_cmd_irq).
sdmmc can't complete the request.

If I use:
.busy_detect_flag	= MCI_STM32_BUSYD0,
.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,

Like there is no MCI_STM32_BUSYD0 irq mask, the status read in mmci_irq
"status &= readl(host->base + MMCIMASK0)" can't take account the 
busy_detect_flag (for sdmmc). So the  step 2 can't be passed.
However we could share re-read between step 1 and step 2.

proposal:

+
+		u32 busy_val = readl(base + MMCISTATUS) &
+			host->variant->busy_detect_flag;
+
  		if (!host->busy_status &&
-		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
-		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
+		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) && busy_val) {

  			writel(readl(base + MMCIMASK0) |
  			       host->variant->busy_detect_mask,
@@ -1262,8 +1265,7 @@ mmci_cmd_irq(struct mmci_host *host, struct 
mmc_command *cmd,
  		 * both the start and the end interrupts needs to be cleared,
  		 * one after the other. So, clear the busy start IRQ here.
  		 */
-		if (host->busy_status &&
-		    (status & host->variant->busy_detect_flag)) {
+		if (host->busy_status && busy_val) {


what do you think about it ?

> 
> Thoughts?
> 
> Kind regards
> Uffe
> 

Regards
Ludo
