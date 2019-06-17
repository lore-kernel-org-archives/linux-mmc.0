From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Date: Mon, 17 Jun 2019 16:23:28 +0200
Message-ID: <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com>
 <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, rajan.vaja@xilinx.com, nava.manne@xilinx.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Manish Narani <manish.narani@xilinx.com>, jolly.shah@xilinx.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 17. 06. 19 14:21, Ulf Hansson wrote:
> On Mon, 17 Jun 2019 at 13:28, Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Hi,
>>
>> On 17. 06. 19 13:15, Ulf Hansson wrote:
>>> On Tue, 11 Jun 2019 at 11:57, Manish Narani <manish.narani@xilinx.com> wrote:
>>>>
>>>> Apart from taps set by auto tuning, ZynqMP platform has feature to set
>>>> the tap values manually. Add support to read tap delay values from
>>>> DT and set the same in HW via ZynqMP SoC framework. Reading Tap
>>>> Delays from DT is optional, if the property is not available in DT the
>>>> driver will use the pre-defined Tap Delay Values.
>>>>
>>>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-of-arasan.c | 173 ++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 172 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>>> index b12abf9..7af6cec 100644
>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>> @@ -22,6 +22,7 @@
>>>>  #include <linux/phy/phy.h>
>>>>  #include <linux/regmap.h>
>>>>  #include <linux/of.h>
>>>> +#include <linux/firmware/xlnx-zynqmp.h>
>>>>
>>>>  #include "cqhci.h"
>>>>  #include "sdhci-pltfm.h"
>>>> @@ -32,6 +33,10 @@
>>>>
>>>>  #define PHY_CLK_TOO_SLOW_HZ            400000
>>>>
>>>> +/* Default settings for ZynqMP Tap Delays */
>>>> +#define ZYNQMP_ITAP_DELAYS {0, 0x15, 0x15, 0, 0x15, 0, 0, 0x3D, 0x12, 0, 0}
>>>> +#define ZYNQMP_OTAP_DELAYS {0, 0x5, 0x6, 0, 0x5, 0x3, 0x3, 0x4, 0x6, 0x3, 0}
>>>> +
>>>>  /*
>>>>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>>>>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
>>>> @@ -81,6 +86,7 @@ struct sdhci_arasan_soc_ctl_map {
>>>>   * @sdcardclk:         Pointer to normal 'struct clock' for sdcardclk_hw.
>>>>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>>>>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
>>>> + * @of_data:           Platform specific runtime data storage pointer
>>>>   */
>>>>  struct sdhci_arasan_data {
>>>>         struct sdhci_host *host;
>>>> @@ -101,6 +107,15 @@ struct sdhci_arasan_data {
>>>>  /* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
>>>>   * internal clock even when the clock isn't stable */
>>>>  #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
>>>> +
>>>> +       void *of_data;
>>>> +};
>>>> +
>>>> +struct sdhci_arasan_zynqmp_data {
>>>> +       void (*set_tap_delay)(struct sdhci_host *host);
>>>> +       const struct zynqmp_eemi_ops *eemi_ops;
>>>> +       u8 tapdly[MMC_TIMING_MMC_HS400 + 1][2]; /* [0] for input delay, */
>>>> +                                               /* [1] for output delay */
>>>>  };
>>>
>>> Please use two different structs, one for the clock provider data and
>>> one for the mmc variant/platform data. This makes the code more
>>> readable.
>>
>> Origin version before sending that out was using two fields.
>> +       u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
>> +       u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
>>
>> I did asked for putting it together to two dimensional array for
>> improving readability of this code. The reason was that you need to take
>> care about input/output together.
>> One thing I was also suggesting was to use instead of 2 just enum values
>> to specify IN=0/OUT/MAX to improve readability of this.
>> Do you think that using enum should be enough?
> 
> Not sure I understand what you suggest here, sorry. I have no problem
> with the enums.
> 
> The important point I am trying to make here, is that we should split
> the clock provider data and the mmc variant data, simply because those
> doesn't really belong to each each other.
> 
> Something like this:
> 
> struct sdhci_arasan_zynqmp_data {
>          bool tap_delays;
>          u8 tapdly[MMC_TIMING_MMC_HS400 + 1][2]; /* [0] for input
> delay, [1] for output delay */
>          + other variant specific data one may want to put here
> }
> 
> These are just regular mmc OF data that are parsed as any other
> property of the mmc device.
> 
> The "const struct zynqmp_eemi_ops *eemi_ops; should then be moved into
> a clock provider specific struct, which is assigned when calling
> sdhci_arasan_register_sdclk. I understand that all the clock data is
> folded into struct sdhci_arasan_data today, but I think that should be
> moved into a "sub-struct" for the clock specifics.
> 
> Moreover, when registering the clock, we should convert from using
> devm_clk_register() into devm_clk_hw_register() as the first one is
> now deprecated.

Ok. I got your point.


>>
>>
>>> In regards to the mmc data part, I suggest to drop the
>>> ->set_tap_delay() callback, but rather use a boolean flag to indicate
>>> whether clock phases needs to be changed for the variant. Potentially
>>> that could even be skipped and instead call clk_set_phase()
>>> unconditionally, as the clock core deals fine with clock providers
>>> that doesn't support the ->set_phase() callback.
>>
>> In connection to another version of this driver for latest Xilinx chip
>> it would be better to keep set_tap_delay callback in the driver. The
>> reason is that new chip/ip is capable to setup tap delays directly
>> without asking firmware to do it. That's why for versal IP there is a
>> need to call different setup_tap_delay function.
> 
> The ->set_tap_delay() callback is for ZyncMp pointing to
> sdhci_arasan_zynqmp_set_tap_delay(). This function calls the
> clk_set_phase() API.
> 
> What does ->set_tap_delay() do for the latest version?

There is different set of default tap delays which should be programmed
and it is done just via writing to registers which are the part of
controller address space.

>>
>>>
>>> [...]
>>>
>>> Otherwise this looks good to me!
>>>
>>> When it comes to patch1, I need an ack from Michal to pick it up.
>>
>> I am waiting till Rob ack dt binding and then I wanted to talk to you if
>> you want to take it with 1/3 or if you want me to take all of them via
>> my tree.
>> In previous releases I was taking them via my tree because there were
>> several subsystem changing firmware interface. In this cycle there are
>> just small changes to firmware interface that's why taking it via your
>> tree shouldn't be a problem too.
> 
> Okay, then let's target this via my mmc tree this time.

okay. Not a problem.

Thanks,
Michal
