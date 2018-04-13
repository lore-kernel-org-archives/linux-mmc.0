From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V4 2/2] mmc: sdhci-msm: support voltage pad switching
Date: Fri, 13 Apr 2018 10:08:06 -0700
Message-ID: <CAD=FV=W0HfWV0t1SirQRpr3ZQtz3PUHi_OdF9xv3fRSf8EUCOQ@mail.gmail.com>
References: <1522242500-10556-1-git-send-email-vviswana@codeaurora.org>
 <1522242500-10556-3-git-send-email-vviswana@codeaurora.org>
 <CAD=FV=XepJMGFmYyj85yC7xbaB5XQKWd1vRX-rott4CMgU9EdA@mail.gmail.com> <637147e3-5006-3593-3b01-9516375f8995@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <637147e3-5006-3593-3b01-9516375f8995@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org, Krishna Konda <kkonda@codeaurora.org>, Asutosh Das <asutoshd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Apr 6, 2018 at 2:48 AM, Vijay Viswanath <vviswana@codeaurora.org> wrote:
>
>
> On 3/29/2018 4:23 AM, Doug Anderson wrote:
>>
>> Hi,
>>
>> On Wed, Mar 28, 2018 at 6:08 AM, Vijay Viswanath
>> <vviswana@codeaurora.org> wrote:
>>>
>>> From: Krishna Konda <kkonda@codeaurora.org>
>>>
>>> The PADs for SD card are dual-voltage that support 3v/1.8v. Those PADs
>>> have a control signal  (io_pad_pwr_switch/mode18 ) that indicates
>>> whether the PAD works in 3v or 1.8v.
>>>
>>> SDHC core on msm platforms should have IO_PAD_PWR_SWITCH bit set/unset
>>> based on actual voltage used for IO lines. So when power irq is
>>> triggered for io high or io low, the driver should check the voltages
>>> supported and set the pad accordingly.
>>>
>>> Signed-off-by: Krishna Konda <kkonda@codeaurora.org>
>>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>>> ---
>>>   drivers/mmc/host/sdhci-msm.c | 64
>>> ++++++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 62 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>> index 2fcd9010..bbf9626 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -78,12 +78,15 @@
>>>   #define CORE_HC_MCLK_SEL_DFLT  (2 << 8)
>>>   #define CORE_HC_MCLK_SEL_HS400 (3 << 8)
>>>   #define CORE_HC_MCLK_SEL_MASK  (3 << 8)
>>> +#define CORE_IO_PAD_PWR_SWITCH_EN      (1 << 15)
>>> +#define CORE_IO_PAD_PWR_SWITCH  (1 << 16)
>>>   #define CORE_HC_SELECT_IN_EN   BIT(18)
>>>   #define CORE_HC_SELECT_IN_HS400        (6 << 19)
>>>   #define CORE_HC_SELECT_IN_MASK (7 << 19)
>>>
>>>   #define CORE_3_0V_SUPPORT      (1 << 25)
>>>   #define CORE_1_8V_SUPPORT      (1 << 26)
>>> +#define CORE_VOLT_SUPPORT      (CORE_3_0V_SUPPORT | CORE_1_8V_SUPPORT)
>>>
>>>   #define CORE_CSR_CDC_CTLR_CFG0         0x130
>>>   #define CORE_SW_TRIG_FULL_CALIB                BIT(16)
>>> @@ -1109,7 +1112,7 @@ static void sdhci_msm_handle_pwr_irq(struct
>>> sdhci_host *host, int irq)
>>>          u32 irq_status, irq_ack = 0;
>>>          int retry = 10;
>>>          u32 pwr_state = 0, io_level = 0;
>>> -
>>> +       u32 config;
>>>
>>>          irq_status = readl_relaxed(msm_host->core_mem +
>>> CORE_PWRCTL_STATUS);
>>>          irq_status &= INT_MASK;
>>> @@ -1166,6 +1169,45 @@ static void sdhci_msm_handle_pwr_irq(struct
>>> sdhci_host *host, int irq)
>>>           */
>>>          writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
>>>
>>> +       /*
>>> +        * If we don't have info regarding the voltage levels supported
>>> by
>>> +        * regulators, don't change the IO PAD PWR SWITCH.
>>> +        */
>>> +       if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
>>> +               /* Ensure order between core_mem and hc_mem */
>>> +               mb();
>>
>>
>> Like in v2, I don't understand why you need a mb() before the read
>> from CORE_VENDOR_SPEC.  No reads or writes to the core_mem will affect
>> the value you're reading here, so you need no barrier.
>>
>> If you need a barrier before the _write_ to CORE_VENDOR_SPEC then add
>> it below.  Then in the case where the config doesn't change you have
>> no barriers.
>>
>>
>>> +               /*
>>> +                * We should unset IO PAD PWR switch only if the register
>>> write
>>> +                * can set IO lines high and the regulator also switches
>>> to 3 V.
>>> +                * Else, we should keep the IO PAD PWR switch set.
>>> +                * This is applicable to certain targets where eMMC vccq
>>> supply
>>> +                * is only 1.8V. In such targets, even during
>>> REQ_IO_HIGH, the
>>> +                * IO PAD PWR switch must be kept set to reflect actual
>>> +                * regulator voltage. This way, during initialization of
>>> +                * controllers with only 1.8V, we will set the IO PAD bit
>>> +                * without waiting for a REQ_IO_LOW.
>>> +                */
>>
>>
>> For the above comment, what about just:
>>
>> new_config = config
>> if (msm_host->caps_0 == CORE_1_8V_SUPPORT) {
>>    new_config |= CORE_IO_PAD_PWR_SWITCH;
>> } else if (msm_host->caps_0 == CORE_3_3V_SUPPORT) {
>>    new_config &= ~CORE_IO_PAD_PWR_SWITCH;
>> } else if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
>>    if (io_level & REQ_IO_HIGH)
>>      new_config &= ~CORE_IO_PAD_PWR_SWITCH;
>>    else if (io_level & REQ_IO_LOW)
>>      new_config |= CORE_IO_PAD_PWR_SWITCH;
>> }
>
>
> This looks a big mess of if/else. Does the above implementation have better
> performance compared to having two if/else with bit operations inside ? The
> latter looks much cleaner and faster.
>
> If regulator only supports 3V and we get a io_low from BUS_OFF ( REQ_IO_LOW
> should never come if we don't support 1.8V), it is ok to set io pad.

Yeah, I think it's ugly no matter what.  Personally I find the
if/then/else easier to follow than the complicated conditions split
across multiple lines.  I seem to remember there was something that my
version did differently than yours too (hence the "this might be more
important if you get rid of the initial setting"), let's see if I can
figure it out again.

Mine says:
- if it has exactly 1.8 or 3.3 support: set that.
- else if it supports both: set whatever is requested
- else (it support neither): do nothing

Yours says:
- if it supports high and requests high: set it high
- if it supports low and requests low: set it low

...so your code assumes that it was already set to the right thing if
it only supports 1.8 or only support 3.3.  Hence my comment about this
being important if you get rid of the initial settings as I was
suggesting.


>> if (config != new_config) {
>>   ...
>> }
>>
>> AKA: first check if it only supports one voltage and pick that one.
>> Else if it supports both you can use the request.  This might be more
>> important if you get rid of the initial setting in
>> sdhci_msm_set_regulator_caps() as I'm suggesting.
>>
>>
>>> +               config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
>>> +
>>> +               if (((io_level & REQ_IO_HIGH) && (msm_host->caps_0 &
>>> +                               CORE_3_0V_SUPPORT)) &&
>>> +                               (config & CORE_IO_PAD_PWR_SWITCH)) {
>>> +                       config &= ~CORE_IO_PAD_PWR_SWITCH;
>>> +                       writel_relaxed(config,
>>> +                                       host->ioaddr + CORE_VENDOR_SPEC);
>>> +                       /* IO PAD register is in different memory space
>>> */
>>> +                       mb();
>>
>>
>> Wow, for a driver that tries so hard to use "relaxed" versions of
>> writes to avoid barriers you sure end up needing to sprinkle a lot of
>> these around "just in case".  :(  ...this one seems extra fishy
>> because:
>>
>> * There are no more accesses after this one in this function.
>>
>> * If you're worried about something that happens outside of the
>> context of the IRQ needing this wb() then that's a silly concern.
>> Presumably if they were doing anything that could race with you they'd
>> have a lock and locking routines are implicit barriers.
>>
>> * In the context of the IRQ itself the next call is
>> sdhci_msm_complete_pwr_irq_wait(), which eventually calls wake_up.
>> This has a locking primitive and thus an implicit barrier.
>>
>
> Sorry, I didn't get implicit barrier in locking primitive.

My understanding is locking primitives (spin locks and mutexes) always
act as a barrier.  This is why most of the time you shouldn't need to
think about barriers.  As long as you've got things protected by
spinlocks and/or mutexes then the ordering will work out right.

Specifically, see
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/memory-barriers.txt>

> Some of the other functions in the linux kernel imply memory barriers, amongst
> which are locking and scheduling functions.

Said another way, if you have two routines:

routine_a() {
  lock(driver_global_lock);
  writel_relaxed(region_a);
  unlock(driver_global_lock);
}

routine_b() {
  lock(driver_global_lock);
  writel_relaxed(region_b);
  unlock(driver_global_lock);
}

If you call:
  routine_a();
  routine_b();

You can be assured that the write to region_a will take place before
the write to region_b.  As I understand it, no extra barriers are
required.  This is why most people don't need to worry about
barriers--they just use locks.  The only argument you have for
barriers at all in this file is that you have two different memory
regions that you've iomapped.

...basically if something you do causes both a lock() and unlock() you
can be sure that your memory has been written by the time the unlock()
finishes.


> In mmc_set_signal_voltage switch:
>         1. Send cmd 11.
>         2. Switch 1.8V in SDHCI_HOST_CONTROL2
>         3. Wait for pwr_irq wake_up().
>         4. pwr_irq context comes up & does register read/writes in core mem.
> Updates IO PAD in HC mem.
>         5. pwr_irq calls wake_up.
>         6. mmc_set_signal_voltage_switch context does further register
> read/writes which expects IO_PAD change within pwr_irq context is complete
> before step 6.
>
> Can wake_up() ensure that any update to CORE_VENDOR_SPEC happens before any
> register writes in HC after the wake_up() ?

I guess I will leave it to the wisdom of others if wake_up is
guaranteed to always acquire and release a lock.  Today it does and
that means that any memory writes that happen before the call to
wake_up() will finish by the time wake_up() finishes.

Of course, my overall advice remains to get rid of the "relaxed" usage
everywhere except in places were you truly believe it's performance
critical.


>> * There's a direct call of sdhci_msm_handle_pwr_irq() from probe, and
>> it has a big fat mb().  I have a hard time believing that matters too
>> because I'd bet "platform_get_irq_byname" has at least one lock in it.
>>
>>
>> IMHO these "_relaxed" calls are just not worth it except in _very_
>> targeted usage.
>>
>>
>>> +               } else if (((io_level & REQ_IO_LOW) ||
>>> +                               (msm_host->caps_0 & CORE_1_8V_SUPPORT))
>>> &&
>>> +                               !(config & CORE_IO_PAD_PWR_SWITCH)) {
>>> +                       config |= CORE_IO_PAD_PWR_SWITCH;
>>> +                       writel_relaxed(config,
>>> +                                       host->ioaddr + CORE_VENDOR_SPEC);
>>> +                       /* IO PAD bit is in different memory space */
>>> +                       mb();
>>> +               }
>>> +       }
>>> +
>>>          if (pwr_state)
>>>                  msm_host->curr_pwr_state = pwr_state;
>>>          if (io_level)
>>> @@ -1322,7 +1364,8 @@ static int sdhci_msm_set_regulator_caps(struct
>>> sdhci_msm_host *msm_host)
>>>   {
>>>          struct mmc_host *mmc = msm_host->mmc;
>>>          struct regulator *supply = mmc->supply.vqmmc;
>>> -       u32 caps = 0;
>>> +       u32 caps = 0, config;
>>> +       struct sdhci_host *host = mmc_priv(mmc);
>>>
>>>          if (!IS_ERR(mmc->supply.vqmmc)) {
>>>                  if (regulator_is_supported_voltage(supply, 1700000,
>>> 1950000))
>>> @@ -1335,6 +1378,23 @@ static int sdhci_msm_set_regulator_caps(struct
>>> sdhci_msm_host *msm_host)
>>>                                          mmc_hostname(mmc), __func__);
>>>          }
>>>
>>> +       if (caps) {
>>> +               /*
>>> +                * Set the PAD_PWR_SWITCH_EN bit so that the
>>> PAD_PWR_SWITCH
>>> +                * bit can be used as required later on.
>>> +                */
>>> +               u32 io_level = msm_host->curr_io_level;
>>> +
>>> +               config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
>>> +               config |= CORE_IO_PAD_PWR_SWITCH_EN;
>>> +
>>> +               if ((io_level & REQ_IO_HIGH) && (caps &
>>> CORE_3_0V_SUPPORT))
>>
>>
>> Slight nit that there's a tab character after "caps &".  Please
>> replace it with a space.
>>
>>
>
> Will do
>
>>> +                       config &= ~CORE_IO_PAD_PWR_SWITCH;
>>> +               else if ((io_level & REQ_IO_LOW) || (caps &
>>> CORE_1_8V_SUPPORT))
>>> +                       config |= CORE_IO_PAD_PWR_SWITCH;
>>
>>
>> Are you sure that's right?  In English:
>>
>> * If we requested high and we support high then set to high.
>> * else if we requested low __or__ we support low then set low.
>>
>> Things that are weird above that:
>>
>> * If we request low but don't support low, switch to low anyway.
>
>
>> * If we request high but only support low, switch to low anyway.
>>
>> If nothing else seems like this would deserve a comment, but I'd be
>> curious of the justification for that logic.
>>
>>
>> Also: seems like this is duplicated code between here and
>> sdhci_msm_handle_pwr_irq().  Does it even need to be here?  Can't you
>> just move the call to sdhci_msm_set_regulator_caps() before the call
>> to sdhci_msm_handle_pwr_irq() in probe?  Then just let that first call
>> to to sdhci_msm_handle_pwr_irq() do this work?  In
>> sdhci_msm_handle_pwr_irq() you can always just "OR" in
>> CORE_IO_PAD_PWR_SWITCH_EN
>>
>>
>> -Doug
>> --
>
>
>
> If we don't support 1.8V, then the only time io_low will happen is during
> BUS_OFF. For BUS_OFF, enabling IO_PAD_PWR_SWITCH is ok.
>
> This logic is same as what is there in pwr_irq. Added the same stuff here
> because by the time we get regulator info from mmc layer, some power irqs
> would have already come and gone.

Did you try my suggestion of: "Can't you just move the call to
sdhci_msm_set_regulator_caps() before the call to
sdhci_msm_handle_pwr_irq() in probe?  Then just let that first call to
sdhci_msm_handle_pwr_irq() do this work?" or did I miss something
there?  Specifically that will make the caps_0 get set early.  ...now
when sdhci_msm_probe() manually calls sdhci_msm_handle_pwr_irq()
caps_0 will be set and it can do all this work there.  That should
avoid this duplicated code.

-Doug
