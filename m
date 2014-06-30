From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Query regarding suspend/resume support in MMC
Date: Mon, 30 Jun 2014 21:58:31 +0530
Message-ID: <CAGAs2Am1UyVrZ=VZyGVASM1p45TECy-4jaavmQvRFmz2rKtLqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

I am trying to understand the suspend/resume mechanism in mmc.

The kernel ( in hibernation as well as in suspend to ram) first calls
suspend_thaw_processes() and then calls
pm_notifier_call_chain(PM_POST_SUSPEND/HIBERNATION). The mmc driver
schedules mmc_rescan on receiving the notification of
PM_POST_SUSPEND/HIBERNATION. Thus before mmc_rescan() gets called, the
mmc card is not ready to be used.

So if any processes before hibernation/suspend were using mmc device,
then on resume when these processes would be unfrozen( from
thaw_processes ) and if it tries to access the mmc device( before
mmc_rescan gets scheduled), then it would hit a problem.

Please let me know if my understanding is correct or not.

Regards,
Ayan Kumar Halder
