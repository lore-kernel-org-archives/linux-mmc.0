From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: SDHI clock imbalance
Date: Fri, 2 Jun 2017 10:47:15 +0200
Message-ID: <CAMuHMdX7_u_3TFK22inUp367LR3R77S72RAtRWPFnKE9-cUtpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram, Ulf, Simon,

While investigating suspend/resume for the R-Car Gen3 clock driver, I
noticed a clock imbalance for SDHI on Salvator-X.

After boot:

# head -2 /sys/kernel/debug/clk/clk_summary
   clock         enable_cnt prepare_cnt  rate  accuracy phase
-------------------------------------------------------------
# grep sd /sys/kernel/debug/clk/clk_summary
         .sdsrc           3        3   399999984      0 0
        sd3               1        1     6250000      0 0
           sdif3          1        2     6250000      0 0
        sd2               1        1   199999992      0 0
           sdif2          1        2   199999992      0 0
        sd1               0        0   199999992      0 0
           sdif1          0        0   199999992      0 0
        sd0               1        1     6250000      0 0
           sdif0          1        2     6250000      0 0

After s2idle suspend/resume:

# grep sd /sys/kernel/debug/clk/clk_summary
         .sdsrc           3        3   399999984      0 0
        sd3               1        1     6250000      0 0
           sdif3          2        2     6250000      0 0
        sd2               1        1   199999992      0 0
           sdif2          2        2   199999992      0 0
        sd1               0        0   199999992      0 0
           sdif1          0        0   199999992      0 0
        sd0               1        1     6250000      0 0
           sdif0          2        2     6250000      0 0

Enable counts are 1 before suspend, and 2 after resume.


Boot: Enabled once (also at hardware level):

    platform_drv_probe
        renesas_sdhi_sys_dmac_probe
            renesas_sdhi_probe
                tmio_mmc_host_probe
                    renesas_sdhi_clk_enable


Suspend: Disabled once (also at hardware level):

    suspend_devices_and_enter
        dpm_suspend_start
            dpm_suspend
                __device_suspend
                    dpm_run_callback
                        pm_runtime_force_suspend
                            genpd_runtime_suspend
                                pm_generic_runtime_suspend
                                    tmio_mmc_host_runtime_suspend
                                        renesas_sdhi_clk_disable


Resume: Enabled twice (first one enables at hardware level):

    dpm_resume_noirq
        device_resume_noirq
            dpm_run_callback
                pm_genpd_resume_noirq
                    pm_runtime_force_resume
                        genpd_runtime_resume
                            genpd_start_dev
                                pm_clk_resume                   (1)
                            __genpd_runtime_resume
                                pm_generic_runtime_resume
                                    tmio_mmc_host_runtime_resume
                                        renesas_sdhi_clk_enable (2)


During subsequent suspends, the clock is disabled twice (last one disables
at hardware level), as expected:

    suspend_devices_and_enter
        dpm_suspend_start
            dpm_suspend
                __device_suspend
                    dpm_run_callback
                        pm_runtime_force_suspend
                            genpd_runtime_suspend
                                pm_generic_runtime_suspend
                                    tmio_mmc_host_runtime_suspend
                                        renesas_sdhi_clk_disable (1)
                                genpd_stop_dev
                                    pm_clk_suspend               (2)


>From now on, the imbalance is gone.

Note that at boot and initial suspend, genpd does not seem to call into the
clock domain operations at all.
Presumable some call to pm_runtime_get_sync() is missing?

Thanks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
