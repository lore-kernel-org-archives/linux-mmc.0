From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: Warnings for invalid VDD (sdhci-s3c)
Date: Thu, 24 Mar 2016 14:30:28 +0100
Message-ID: <56F3EBF4.400@math.uni-bielefeld.de>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, ludovic.desroches@atmel.com, Jisheng Zhang <jszhang@marvell.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello Krzysztof,

I'm seeing a similar problem on my Odroid-X2. I've fixed the issue by
letting sdhci_set_power() (in drivers/mmc/host/sdhci.c) handle
MMC_VDD_28_29 as well.

I'm not sure though what's the rationale behind only handling certain
MMC_VDD_x values in the switch statement.

With best wishes,
Tobias



Krzysztof Kozlowski wrote:
> Hi,
> 
> After 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD via
> external regulator") On Trats2 board I see warnings for invalid VDD
> value (2.8V):
> 
> [    3.119656] ------------[ cut here ]------------
> [    3.119666] WARNING: CPU: 3 PID: 90 at
> ../drivers/mmc/host/sdhci.c:1234 sdhci_do_set_ios+0x4cc/0x5e0
> [    3.119669] mmc0: Invalid vdd 0x10
> [    3.119673] Modules linked in:
> [    3.119679] CPU: 3 PID: 90 Comm: kworker/3:1 Tainted: G        W
>    4.5.0-next-20160324 #23
> [    3.119681] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    3.119690] Workqueue: events_freezable mmc_rescan
> [    3.119708] [<c010e0ac>] (unwind_backtrace) from [<c010ae10>]
> (show_stack+0x10/0x14)
> [    3.119719] [<c010ae10>] (show_stack) from [<c0323260>]
> (dump_stack+0x88/0x9c)
> [    3.119728] [<c0323260>] (dump_stack) from [<c011b754>] (__warn+0xe8/0x100)
> [    3.119734] [<c011b754>] (__warn) from [<c011b7a4>]
> (warn_slowpath_fmt+0x38/0x48)
> [    3.119740] [<c011b7a4>] (warn_slowpath_fmt) from [<c0527d28>]
> (sdhci_do_set_ios+0x4cc/0x5e0)
> [    3.119748] [<c0527d28>] (sdhci_do_set_ios) from [<c0528018>]
> (sdhci_runtime_resume_host+0x60/0x114)
> [    3.119758] [<c0528018>] (sdhci_runtime_resume_host) from
> [<c0402570>] (__rpm_callback+0x2c/0x60)
> [    3.119767] [<c0402570>] (__rpm_callback) from [<c04025c4>]
> (rpm_callback+0x20/0x80)
> [    3.119773] [<c04025c4>] (rpm_callback) from [<c04034b8>]
> (rpm_resume+0x36c/0x558)
> [    3.119780] [<c04034b8>] (rpm_resume) from [<c04036f0>]
> (__pm_runtime_resume+0x4c/0x64)
> [    3.119788] [<c04036f0>] (__pm_runtime_resume) from [<c0512728>]
> (__mmc_claim_host+0x170/0x1b0)
> [    3.119795] [<c0512728>] (__mmc_claim_host) from [<c0514e2c>]
> (mmc_rescan+0x54/0x348)
> [    3.119807] [<c0514e2c>] (mmc_rescan) from [<c0130dac>]
> (process_one_work+0x120/0x3f4)
> [    3.119815] [<c0130dac>] (process_one_work) from [<c01310b8>]
> (worker_thread+0x38/0x554)
> [    3.119823] [<c01310b8>] (worker_thread) from [<c01365a4>]
> (kthread+0xdc/0xf4)
> [    3.119831] [<c01365a4>] (kthread) from [<c0107878>]
> (ret_from_fork+0x14/0x3c)
> [    3.119834] ---[ end trace a22d652aa3276886 ]---
> 
> The device seems to work correctly but I suppose the patch still has
> an effect - the mmc_regulator_set_ocr() is not called.
> 
> Any ideas for fixing this?
> 
> The board is Trats2 (Exynos4412).
> 
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
