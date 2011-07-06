From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v3] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Wed, 6 Jul 2011 08:21:19 -0700
Message-ID: <931B2731-7B03-4514-85C5-180F77D8D721@marvell.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
	<20110427093328.GU17290@n2100.arm.linux.org.uk>
	<161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
	<1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
	<20110428095127.GX17290@n2100.arm.linux.org.uk>
	<3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
	<CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
	<CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
	<CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
	<67F311C7-B489-41E6-BC85-C06DACC7263A@marvell.com>
	<CAMj5BkjQNQtnU1s+KqGjX0i9j+oQkbcY9cOonp1fNu=DEy-YyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMj5BkjQNQtnU1s+KqGjX0i9j+oQkbcY9cOonp1fNu=DEy-YyA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Eric Miao <eric.y.miao@gmail.com>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>
List-Id: linux-mmc@vger.kernel.org


On Jul 6, 2011, at 12:19 AM, zhangfei gao wrote:

> On Wed, Jul 6, 2011 at 4:20 AM, Philip Rakity <prakity@marvell.com> wrote:
>> Subject: [PATCH V3] arm: mach-mmp: brownstone.c support multiple sd slots
>> 
>> V3
>> ==
>> Change since V2 -- delete mmc3 since it was committed
>> to linux next.
>> 
>> enable mmc1 used for wifi (8688) and marked PERMANENT.
>> Wifi requires enabling of power on the device by
>> toggling the gpio lines for power and reset.  Enable eMMC first to work
>> around problem in booting order due to workqueue bug.
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>>  arch/arm/mach-mmp/brownstone.c |   41 +++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 40 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
>> index c79162a..940982c 100644
>> --- a/arch/arm/mach-mmp/brownstone.c
>> +++ b/arch/arm/mach-mmp/brownstone.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/regulator/max8649.h>
>>  #include <linux/regulator/fixed.h>
>>  #include <linux/mfd/max8925.h>
>> +#include <linux/delay.h>
>> 
>>  #include <asm/mach-types.h>
>>  #include <asm/mach/arch.h>
>> @@ -180,6 +181,11 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
>>        .clk_delay_cycles = 0x1f,
>>  };
>> 
>> +static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
>> +       .clk_delay_cycles = 0x1f,
>> +       .flags          = PXA_FLAG_CARD_PERMANENT,
>> +};
>> +
>>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
>>        .clk_delay_cycles = 0x1f,
>>        .flags = PXA_FLAG_CARD_PERMANENT
>> @@ -187,6 +193,38 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
>>  };
>> 
>> 
>> +static void __init mmc_sdio_wifi(void)
>> +{
>> +       int poweron;
>> +       int reset;
>> +
>> +       poweron = mfp_to_gpio(GPIO57_GPIO);
>> +       reset = mfp_to_gpio(GPIO58_GPIO);
>> +
>> +       if (gpio_request(reset, "sd8xxx reset")) {
>> +               printk(KERN_INFO "gpio %d request failed\n", reset);
>> +               return;
>> +       }
>> +
>> +       if (gpio_request(poweron, "sd8xxx PDn")) {
>> +               gpio_free(reset);
>> +               printk(KERN_INFO "gpio %d request failed\n", poweron);
>> +               return;
>> +       }
>> +
>> +       gpio_direction_output(poweron, 0);
>> +       msleep(1);
>> +       gpio_direction_output(poweron, 1);
>> +       msleep(1);
>> +       gpio_direction_output(reset, 0);
>> +       msleep(1);
>> +       gpio_direction_output(reset, 1);
>> +       gpio_free(reset);
>> +       gpio_free(poweron);
>> +
>> +       mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* Wifi */
>> +}
>> +
> 
> The method keeps power on wifi chip, without dynamically
> enable/disable wifi power, which is not final solution.
> How about pushing later with dynamically control power, which is in
> debugging here.
> 

Good Point -- Will do.  

What is the correct method to handle this ? 

>>  static void __init brownstone_init(void)
>>  {
>>        mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
>> @@ -195,8 +233,9 @@ static void __init brownstone_init(void)
>>        mmp2_add_uart(1);
>>        mmp2_add_uart(3);
>>        mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
>> -       mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
>>        mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
>> +       mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
>> +       mmc_sdio_wifi();
>> 
>>        /* enable 5v regulator */
>>        platform_device_register(&brownstone_v_5vp_device);
>> --
>> 1.7.0.4
