From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH 0/4] mmc: sdhci: Support maximum DMA latency request
 via PM QoS
Date: Wed, 1 Apr 2015 15:59:10 -0400
Message-ID: <CAJvTdK=kKBOeg=vj40EdMR2cnHzagxsFB1dMOKHbsnPLkMauvQ@mail.gmail.com>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

> Ad hoc testing with Lenovo Thinkpad 10 showed a stress
> test could run for at least 24 hours with the patches,
> compared to less than an hour without.

There is a patch in linux-next to delete C1E from BYT,
since it is problematic on multiple platforms.
I don't suppose that just disabling that state without disabling C6
is sufficient to fix the Thinkpad 10?  (I'm betting not, but
it can't hurt to try -- you can use the "disable" attribute for the state
in /sys/devices/system/cpu/cpu*/cpuidle/stateN)

I think your choice of the PM_QOS sub-system here is the right one,
and that your selection of 20usec threshold is also a good choice
for what you want to do -- though on non-intel_idle machine somplace,
there may be some ACPI BIOS _CST with random number for C6 latency.

It would be interesting to see how your C6 residency (turbostat
--debug will show this to you)
and your battery life are changed by disabling C6 during MMC activity.

cheers,
Len Brown, Intel Open Source Technology Center
