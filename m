From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] MMC fixes for v.4.12 rc3 - take 2/2
Date: Sun, 28 May 2017 12:26:00 +0200
Message-ID: <CAPDyKFr8xHRsztpMHjodpQZXH4bNMfVh_ZZvYDLpWS0Rc0JBMQ@mail.gmail.com>
References: <CAPDyKFofp6qdgcqha6uNWJz4ApEc2y5dEkEo51LQyq-U3onpgQ@mail.gmail.com>
 <CAOesGMj=jG9RHy1WdNFy18kaCY8GjF2-srypigP1wuWzPzw5qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOesGMj=jG9RHy1WdNFy18kaCY8GjF2-srypigP1wuWzPzw5qQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Olof,

+Daniel

On 26 May 2017 at 18:24, Olof Johansson <olof@lixom.net> wrote:
> Hi Ulf,
>
>
> On Fri, May 26, 2017 at 6:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Hi Linus,
>>
>> Here are a couple of mmc and arm64-dts fixes intended for v4.12 rc3.
>> They are based on v4.12-rc2.
>>
>> Details are as usual found in the signed tag. Please pull this in!
>>
>> Kind regards
>> Ulf Hansson
>>
>>
>> The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:
>>
>>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.12-rc2
>>
>> for you to fetch changes up to ea452678734eb782126f999bf5c4fb3e71d3b196:
>>
>>   arm64: dts: hikey: Fix WiFi support (2017-05-23 14:18:10 +0200)
>>
>> ----------------------------------------------------------------
>> This pull request contains fixes to make the WiFi work again for the ARM64
>> Hikey board.  Together with a couple of DTS updates for the Hikey board we have
>> also extended the mmc pwrseq_simple, to support a new power-off-delay-us DT
>> property, as that was required to enable a graceful power off sequence for the
>> WiFi chip.
>>
>> ----------------------------------------------------------------
>> Daniel Lezcano (2):
>>       mfd: dts: hi655x: Add clock binding for the pmic
>>       arm64: dts: hikey: Add clock for the pmic mfd
>>
>> Ulf Hansson (6):
>>       mmc: dt: pwrseq-simple: Invent power-off-delay-us
>>       mmc: pwrseq_simple: Parse DTS for the power-off-delay-us property
>>       arm64: dts: hi6220: Move the fixed_5v_hub regulator to the hikey dts
>>       arm64: dts: hikey: Add the SYS_5V and the VDD_3V3 regulators
>>       arm64: dts: hi6220: Move board data from the dwmmc nodes to hikey dts
>>       arm64: dts: hikey: Fix WiFi support
>
>
> These are a lot of changes to fix a regression. How was it introduced?

It was several releases ago it got broken, exactly which one I can't
really tell.

I suspect this also is related to an upgrade of the boot loader, as in
the earlier version of the series there where a pmic clock driver
included, however it got picked up for 4.12.

Looping in Daniel, just to see if he have some comments on this.

No matter what, I still think it makes sense to pick this for 4.12
rcs, because it also simplifies for us for how to deal with the
mmc+arm64 dependency, since this needs to go together (to avoid
damaging the WiFi chip when power off)

>
> It would also have been useful if you pointed out the DT contents was
> already acked by Arnd (I had to go look at the contents since you only
> looped him in, and no other ARM-SoC maintainers).
>

Apologize about that! I will make that clear, if/when next time!

>
> -Olof

Kind regards
Uffe
