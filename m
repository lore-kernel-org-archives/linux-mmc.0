From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] ARM: SAMSUNG: change the name from s3c-sdhci to
 exynos4-sdhci
Date: Tue, 06 Mar 2012 01:51:27 -0800
Message-ID: <4F55DE1F.9010405@samsung.com>
References: <4F45D343.6020409@samsung.com>
 <CAJuYYwTh8tVdA0X-TLEU-9O_M0_PmJR=i3WYAQXsaRcPF3MbJA@mail.gmail.com>
 <4F557692.8090102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F557692.8090102@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 03/05/12 18:29, Jaehoon Chung wrote:
> Hi Kukjin.
>
> Is it merged?
>
> Best Regards,
> Jaehoon Chung
>
> On 02/24/2012 06:56 PM, Thomas Abraham wrote:
>
>> On 23 February 2012 11:18, Jaehoon Chung<jh80.chung@samsung.com>  wrote:
>>> Thomas Arbrahams's patchset have changed the device name in sdhci-s3c.c
>>> (mmc: sdhci-s3c: Rework platform data and add device tree support)
>>> But didn't change the regulator_consumer name.
>>> So maybe didn't initialize the mmc/sd card for exynos4.
>>>
>>> This patch is fixed that (based-on linux-samsung for-next branch)
>>>
>>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
>>> Signed-off-by: kyungmin Park<kyungmin.park@samsung.com>
>>> ---
>>>   arch/arm/mach-exynos/mach-nuri.c           |    4 ++--
>>>   arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
>>> index a6b9162..251dd7a 100644
>>> --- a/arch/arm/mach-exynos/mach-nuri.c
>>> +++ b/arch/arm/mach-exynos/mach-nuri.c
>>> @@ -116,7 +116,7 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
>>>   };
>>>
>>>   static struct regulator_consumer_supply emmc_supplies[] = {
>>> -       REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
>>> +       REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
>>>         REGULATOR_SUPPLY("vmmc", "dw_mmc"),
>>>   };
>>>
>>> @@ -415,7 +415,7 @@ static struct regulator_consumer_supply __initdata max8997_ldo12_[] = {
>>>         REGULATOR_SUPPLY("vddio", "6-003c"), /* HDC802 */
>>>   };
>>>   static struct regulator_consumer_supply __initdata max8997_ldo13_[] = {
>>> -       REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"), /* TFLASH */
>>> +       REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.2"), /* TFLASH */
>>>   };
>>>   static struct regulator_consumer_supply __initdata max8997_ldo14_[] = {
>>>         REGULATOR_SUPPLY("inmotor", "max8997-haptic"),
>>> diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
>>> index 6017a21..320cb1d 100644
>>> --- a/arch/arm/mach-exynos/mach-universal_c210.c
>>> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
>>> @@ -749,7 +749,7 @@ static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
>>>   };
>>>
>>>   static struct regulator_consumer_supply mmc0_supplies[] = {
>>> -       REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
>>> +       REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
>>>   };
>>>
>>>   static struct regulator_init_data mmc0_fixed_voltage_init_data = {
>>
>> Reviewed-by: Thomas Abraham<thomas.abraham@linaro.org>

Looks OK, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
