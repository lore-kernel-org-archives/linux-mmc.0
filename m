From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] MMC-4.5 Power OFF Notify Rework
Date: Fri, 15 Jun 2012 18:27:04 +0530
Message-ID: <CANfBPZ8yK1YOC=MBs6dvwj=sghuKUmvYDwCH17P-g9D99D_Vkg@mail.gmail.com>
References: <1339733331-8563-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38014 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756838Ab2FOM51 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 08:57:27 -0400
Received: by bkvi18 with SMTP id i18so3957467bkv.27
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jun 2012 05:57:24 -0700 (PDT)
In-Reply-To: <1339733331-8563-1-git-send-email-saugata.das@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, saugata.das@linaro.org, girish.shivananjappa@linaro.org, asutoshd@codeaurora.org, subhashj@codeaurora.org

On Fri, Jun 15, 2012 at 9:38 AM, Saugata Das <saugata.das@stericsson.com> wrote:
> From: Saugata Das <saugata.das@linaro.org>
>
> This is a rework of the existing POWER OFF NOTIFY patch. The current problem
> with the patch comes from the ambiguity on the usage of POWER OFF NOTIFY
> together with SLEEP and misunderstanding on the usage of MMC_POWER_OFF
> power_mode from mmc_set_ios in different host controller drivers.
>
> This new patch works around this problem by adding a new host CAP,
> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends a
> POWER OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected that host
> controller drivers will set this CAP, if they switch off both Vcc and Vccq
> from MMC_POWER_OFF condition within mmc_set_ios. However, note that there
> is no harm in sending MMC_POWER_NOTIFY even if Vccq is not switched off.
>
> This patch also sends POWER OFF NOTIFY from power management routines (e.g.
> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE, mmc_stop_host), which
> does reinitialization of the eMMC on the return path of the power management
> routines (e.g. mmc_power_restore_host, mmc_pm_notify/PM_POST_RESTORE,
> mmc_start_host).
>
> This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is sent from
> the suspend sequence. If it is sent from shutdown sequence then it is set to
> POWER_OFF_LONG.
>
> Earlier implementation of PowerOff Notify as a core function is replaced as
> a device's bus operation.
>
> For the cards that cannot cut vccq can sleep during suspend. But the after
> suspend->sleep->poweroff the ios values are modified. which results in
> malfunction of card after resume. This patch fixes that issue by saving the
> ios before sleep and restoring the saved values before resume.
>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
>
I just had a chance to test this on OMAP. I only have v4.41 card on
this one, so it doesn't do
Power Off Notify, but suspend resume works with just CMD5, and hasn't caused a
regression. FWIW,
 Partially Tested-by: Venkatraman S<svenkatr@ti.com>
