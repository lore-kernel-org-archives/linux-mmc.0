From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa
 board
Date: Wed, 8 Oct 2014 11:31:15 +0200
Message-ID: <CAPDyKFrb+-jHB_RX8fmCJxBTkzV2h6Dkqqp+Jd+havbvGfMgeg@mail.gmail.com>
References: <2750153.I3nVqzmXTP@amdc1032> <2384118.ElmRrZpdEv@amdc1032>
 <CAD=FV=X7hStwYj2tOCBKH0ncUmhTeUi8qWZjFGjFaMO8rxiZCA@mail.gmail.com>
 <3279284.CeYhVCr5f3@amdc1032>
 <CAD=FV=VrdVs0cBoAZJq_viAfsdZs4ndVW55KanvW01tB6fn8oQ@mail.gmail.com>
 <5434832C.1010402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5434832C.1010402@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@google.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, ALIM AKHTAR <alim.akhtar@samsung.com>, Seung-Won Jeon <tgih.jun@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, SUNIL JOSHI <joshi@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, "cpgs ." <cpgs@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chris Ball <cjb@laptop.org>, Sonny Rao <sonnyrao@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 8 October 2014 02:19, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> On 10/07/2014 01:51 AM, Doug Anderson wrote:
>> Bartlomiej,
>>
>> On Thu, Oct 2, 2014 at 10:24 AM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>>>
>>> Hi,
>>>
>>> On Thursday, October 02, 2014 09:45:41 AM Doug Anderson wrote:
>>>> Bartiomiej
>>>>
>>>> On Thu, Oct 2, 2014 at 9:39 AM, Bartlomiej Zolnierkiewicz
>>>> <b.zolnierkie@samsung.com> wrote:
>>>>> On Thursday, October 02, 2014 09:19:08 AM Doug Anderson wrote:
>>>>>> Bartiomiej,
>>>>>>
>>>>>> On Thu, Oct 2, 2014 at 9:10 AM, Bartlomiej Zolnierkiewicz
>>>>>> <b.zolnierkie@samsung.com> wrote:
>>>>>>> Regulators for MMC2 (SD card) are PVDD_TFLASH_2V8 (LDO19) for vmmc
>>>>>>> and PVDD_APIO_MMCOFF_2V8 (LDO13) for vqmmc.  Currently the device
>>>>>>> tree entry for MMC2 uses PVDD_PRE_1V8 (LDO10) for vmmc and vqmmc is
>>>>>>> not specified.  Fix it.
>>>>>>>
>>>>>>> Without this patch:
>>>>>>> - "mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators"
>>>>>>>   patch causes a SD card detection to fail
>>>>>>> - "mmc: dw_mmc: Support voltage changes" patch causes a boot hang
>>>>>>>
>>>>>>> This patch fixes both above problems.
>>>>>>>
>>>>>>> Suggested-by: Doug Anderson <dianders@google.com>
>>>>>>> Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |    3 ++-
>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> Index: b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>>>>>>> ===================================================================
>>>>>>> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts     2014-10-02 15:44:53.014826886 +0200
>>>>>>> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts     2014-10-02 17:35:24.110600398 +0200
>>>>>>> @@ -74,7 +74,8 @@
>>>>>>>                 samsung,dw-mshc-ddr-timing = <1 2>;
>>>>>>>                 pinctrl-names = "default";
>>>>>>>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>>>>>>> -               vmmc-supply = <&ldo10_reg>;
>>>>>>> +               vmmc-supply = <&ldo19_reg>;
>>>>>>> +               vqmmc-supply = <&ldo13_reg>;
>>>>>>
>>>>>> This looks right to me.  ...but I notice that ldo13 and ldo19 are not
>>>>>> "always-on" in the DTS.  Are you sure card detect works for you if you
>>>>>> eject your card and try to put it back in?
>>>>>>
>>>>>> ...eventually the "always-on" won't be needed, but for now I think it is...
>>>>>
>>>>> Card detection works fine without "always-on".
>>>>
>>>> That's weird.
>>>>
>>>> 1. In the schematics I see XMMC2CDN has an external pullup to PVDD_TFLASH_2V8.
>>>>
>>>> 2. The internal pullup should (I think) be to VDDQ_MMC2 which is
>>>> PVDD_APIO_MMCOFF_2V8.
>>>>
>>>> 3. In (51da224 mmc: dw_mmc: use mmc_regulator_get_supply to handle
>>>> regulators) we should be turning off both regulators in
>>>> "MMC_POWER_OFF".
>>>>
>>>> 4. If I understand correctly MMC_POWER_OFF is called when the card is
>>>> ejected, which means that both regulators should be off when the card
>>>> is ejected.
>>>>
>>>> 5. I don't think card detect can work if neither regulator is powered.
>>>>
>>>>
>>>> One of the above points must be wrong.  Any idea which one?  Can you
>>>> check to see if MMC_POWER_OFF is called for you when the card is
>>>> ejected?  Can you check to see if these regulators are off?
>>>
>>> MMC_POWER_OFF is called on card removal and both regulators get disabled
>>> (I have verified that they are really off with regulator_is_enabled() which
>>> returns 1 before and 0 after disabling regulator).  It seems that 5. is
>>> wrong?
>>
>> This really doesn't make a lot of sense to me, so I'm still kinda
>> confused.  If you want to call it good then that's your (and Ulf's)
>> decision, but it's the kind of thing that would keep me up at night.
>> How can this pin be high if all the regulators pulling it up are off?
>> Is there a current leak somewhere and that's why it's working?
>>
>> How this is supposed to work (as I understand it):
>>
>> 1. When no card is inserted then this pin is supposed to be pulled up
>> to VDDQ_MMC2.  That could be either an internal or an external pullup.
>> It should be pulled up to VDDQ_MMC2 (as opposed to any other voltage)
>> since the exynos manual documents that this pin lives in the VDDQ_MMC2
>> io domain.  Note that it could be pulled up externally to a different
>> supply than the one going to VDDQ_MMC2, but for correctness it should
>> be the same voltage.
>>
>> 2. When a card is inserted, the pin will be grounded (AKA this is an
>> open drain pin).
>>
>>
>> With your patch, can you probe the pin and see if card detect is high
>> when all the regulators are off?  Any idea how it gets high?  If you
>> turn off the internal pullup is it still high?
>
> I remembered that I and Doug were discussed for this problem with exynos5420-peach board(?), right?
> Is arndale-octa board the same circuit with peach?
> If it's same, I think Doug's comment is right.
> But if card-detect pis is used with other power, we don't need to consider the VDDQ_MMC2 power domain.
> It needs more information and checks its schematic.

May I suggest we go ahead and apply this patch to fix the problems for
Arndale Octa!? I am soon about to send the PR for 3.18.

We should then follow up on this discussion and sort out why/how it
actually works.

So, I need an ack from some of the ARM SOC maintainers. I have looped
in Arnd Bergmann, if Kukjin is busy.

Kind regards
Uffe
