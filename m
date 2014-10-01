From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V2 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to
 handle regulators
Date: Wed, 1 Oct 2014 08:38:19 -0700
Message-ID: <CAD=FV=WHMDABaLA-3+PXX6r5hY=Yfq3XgDz6Mhg7b2aaKnPt7g@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
	<28242432.noIRZ0lve1@amdc1032>
	<CAD=FV=W_KiXUU7SmGxTu-JzagW-zEs6AYAbrRMFU3KvppVk_BA@mail.gmail.com>
	<15187164.uVE1eDb0Di@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <15187164.uVE1eDb0Di@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Oct 1, 2014 at 6:06 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Tuesday, September 30, 2014 10:22:34 AM Doug Anderson wrote:
>> Bartlomiej
>>
>> On Mon, Sep 29, 2014 at 5:31 AM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>> >
>> > Hi,
>> >
>> > On Friday, August 29, 2014 01:34:44 PM Ulf Hansson wrote:
>> >> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>> >> > This patch makes use of mmc_regulator_get_supply() to handle
>> >> > the vmmc and vqmmc regulators.Also it moves the code handling
>> >> > the these regulators to dw_mci_set_ios().It turned on the vmmc
>> >> > and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
>> >> > during MMC_POWER_OFF.
>> >> >
>> >> > Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> >>
>> >> Thanks! Applied for next.
>> >
>> > Unfortunately this patch breaks mmc1 card (Kingston 32GB micro SDHC)
>> > detection on Exynos5420 Arndale Octa for me:
>> >
>> > [   10.797979] dwmmc_exynos 12220000.mmc: no support for card's volts
>> > [   10.797998] mmc1: error -22 whilst initialising SD card
>> >
>> > Without the patch:
>> >
>> > [   10.866926] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
>> > [   10.866977] mmc1: new high speed SDHC card at address 1234
>> > [   10.868730] mmcblk1: mmc1:1234 SA32G 29.3 GiB
>> > [   10.915054]  mmcblk1: p1 p2 p3
>> >
>> > The config is attached (exynos_defconfig doesn't work correctly for
>> > this board yet).
>>
>> Yup, this is an expected behavior, unfortunately.  This was talked
>> about extensively during the review of this patch series.
>
> Do you mean that a patch with a known regression has been merged
> into next branch of mmc tree?  It would be quite sad if it would be
> true.

...so looking at your "dts" file, it looks like this _isn't_ your
problem.  Your "vmmc" regulator is listed as "always on", so I believe
that you're OK.  Your regulator probably _shouldn't_ be "always on"
(it prevents power cycling the SD card) but right now it's good that
it is...

If any board has a "vmmc" that is not listed as always on then it
would regress with the first two patches applied (and without the
3rd), but there are none that I personally know of that do.
