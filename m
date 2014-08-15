From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: tmio: Fix hang during suspend
Date: Fri, 15 Aug 2014 17:10:53 +0200
Message-ID: <CAMuHMdVpAJdFEpGsXmf2kVUZ4_qRwW8QS9c=iTtDkYu-XFX8OQ@mail.gmail.com>
References: <1408029833-6970-1-git-send-email-geert+renesas@glider.be>
	<CAPDyKFpuCyRVJe_oRTukoryDAMK9iN5qoR4VU2wrjnvjMA-+Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpuCyRVJe_oRTukoryDAMK9iN5qoR4VU2wrjnvjMA-+Bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Fri, Aug 15, 2014 at 4:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 August 2014 17:23, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> On R-Car Gen 2, the SDHI registers cannot be accessed while the SDHI
>> module clock is disabled. Doing so will cause a lock-up.
>>
>> When suspending, enable the module clock before disabling the SDHI
>> interrupts, and disable the clock again afterwards.
>>
>> This fixes suspend and resume on r8a7791/koelsch.
>
> Out of curiosity, are you using CONFIG_PM_RUNTIME to trigger this bug?

Yes I am:

$ grep CONFIG_PM .config
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM_RUNTIME=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_OPP=y
CONFIG_PM_CLK=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_PM_DEVFREQ is not set
$

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
