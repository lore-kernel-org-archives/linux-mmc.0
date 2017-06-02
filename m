From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: SDHI clock imbalance
Date: Fri, 2 Jun 2017 12:37:18 +0200
Message-ID: <CAPDyKFpfff0AwbKwJEhH_-Vkn+i+1bXp5P-OWiZ2O=71s+s5vw@mail.gmail.com>
References: <CAMuHMdX7_u_3TFK22inUp367LR3R77S72RAtRWPFnKE9-cUtpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34032 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdFBKhU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jun 2017 06:37:20 -0400
Received: by mail-qt0-f181.google.com with SMTP id c13so56004892qtc.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jun 2017 03:37:19 -0700 (PDT)
In-Reply-To: <CAMuHMdX7_u_3TFK22inUp367LR3R77S72RAtRWPFnKE9-cUtpw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 2 June 2017 at 10:47, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Wolfram, Ulf, Simon,
>
> While investigating suspend/resume for the R-Car Gen3 clock driver, I
> noticed a clock imbalance for SDHI on Salvator-X.
>
> After boot:
>
> # head -2 /sys/kernel/debug/clk/clk_summary
>    clock         enable_cnt prepare_cnt  rate  accuracy phase
> -------------------------------------------------------------
> # grep sd /sys/kernel/debug/clk/clk_summary
>          .sdsrc           3        3 399999984      0 0
>         sd3               1        1     6250000      0 0
>            sdif3          1        2     6250000      0 0
>         sd2               1        1   199999992      0 0
>            sdif2          1        2   199999992      0 0
>         sd1               0        0   199999992      0 0
>            sdif1          0        0   199999992      0 0
>         sd0               1        1     6250000      0 0
>            sdif0          1        2     6250000      0 0
>
> After s2idle suspend/resume:
>
> # grep sd /sys/kernel/debug/clk/clk_summary
>          .sdsrc           3        3   399999984      0 0
>         sd3               1        1     6250000      0 0
>            sdif3          2        2     6250000      0 0
>         sd2               1        1   199999992      0 0
>            sdif2          2        2   199999992      0 0
>         sd1               0        0   199999992      0 0
>            sdif1          0        0   199999992      0 0
>         sd0               1        1     6250000      0 0
>            sdif0          2        2     6250000      0 0
>
> Enable counts are 1 before suspend, and 2 after resume.
>
>
> Boot: Enabled once (also at hardware level):
>
>     platform_drv_probe
>         renesas_sdhi_sys_dmac_probe
>             renesas_sdhi_probe
>                 tmio_mmc_host_probe
>                     renesas_sdhi_clk_enable

The driver calls pm_runtime_set_active() during ->probe(), which means
genpd's ->runtime_resume() callback isn't invoked during that point.
In other words, the clocks managed by the clock domain isn't enabled
during ->probe() as genpd's doesn't get to run pm_clk_resume() from
its ->runtime_resume() callback. Unless I am missing something. :-)

I think this is the reason to the following problems. How to fix it?

The driver needs to call pm_runtime_get_sync() instead of
pm_runtime_set_active(), however that may requires some careful
changes if one wants the driver to be able to enable clocks also when
CONFIG_PM is unset. If not, it's pretty easy, else I would do
something like below.

Add a "init" flag to host struct, and set that flag before calling
pm_runtime_get_sync() in ->probe(). When the driver's
->runtime_resume() callbacks get called when the "init" flag is set,
just do an early return 0, as t means ->probe() is running and has
already taken care of the enabling the clock. When probe is done, and
before dropping runtime usage count with pm_runtime_put(), reset the
"init" flag.

>
>
> Suspend: Disabled once (also at hardware level):
>
>     suspend_devices_and_enter
>         dpm_suspend_start
>             dpm_suspend
>                 __device_suspend
>                     dpm_run_callback
>                         pm_runtime_force_suspend
>                             genpd_runtime_suspend
>                                 pm_generic_runtime_suspend
>                                     tmio_mmc_host_runtime_suspend
>                                         renesas_sdhi_clk_disable
>
>
> Resume: Enabled twice (first one enables at hardware level):
>
>     dpm_resume_noirq
>         device_resume_noirq
>             dpm_run_callback
>                 pm_genpd_resume_noirq
>                     pm_runtime_force_resume
>                         genpd_runtime_resume
>                             genpd_start_dev
>                                 pm_clk_resume                   (1)
>                             __genpd_runtime_resume
>                                 pm_generic_runtime_resume
>                                     tmio_mmc_host_runtime_resume
>                                         renesas_sdhi_clk_enable (2)
>
>
> During subsequent suspends, the clock is disabled twice (last one disables
> at hardware level), as expected:
>
>     suspend_devices_and_enter
>         dpm_suspend_start
>             dpm_suspend
>                 __device_suspend
>                     dpm_run_callback
>                         pm_runtime_force_suspend
>                             genpd_runtime_suspend
>                                 pm_generic_runtime_suspend
>                                     tmio_mmc_host_runtime_suspend
>                                         renesas_sdhi_clk_disable (1)
>                                 genpd_stop_dev
>                                     pm_clk_suspend               (2)
>
>
> From now on, the imbalance is gone.
>
> Note that at boot and initial suspend, genpd does not seem to call into the
> clock domain operations at all.
> Presumable some call to pm_runtime_get_sync() is missing?
>
> Thanks.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
