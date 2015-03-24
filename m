From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 0/4] mmc: sdhci: Support maximum DMA latency request via PM QoS
Date: Tue, 24 Mar 2015 21:13:01 +0100
Message-ID: <4768637.QcvINVrrJ9@vostro.rjw.lan>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64452 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752897AbbCXTs6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2015 15:48:58 -0400
In-Reply-To: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, March 24, 2015 03:40:36 PM Adrian Hunter wrote:
> Hi
> 
> Here are some patches to address an issue with SDHCI
> in Intel Baytrail. Intel Baytrail has been observed
> sometimes to hang if host controllers are using DMA
> while deep C-states are used. Workaround that by
> specifying a maximum DMA latency that will prevent
> deep C-states.
> 
> The first patch adds a new PM QOS function so that
> the SDHCI driver can do a "lazy" cancel of the QoS
> request from within its "finish" tasklet.
> 
> The second patch adds support to SDHCI for specifying a
> maximum DMA latency.
> 
> The third and fourth patches take that facility into
> use for Baytrail.
> 
> Ad hoc testing with Lenovo Thinkpad 10 showed a stress
> test could run for at least 24 hours with the patches,
> compared to less than an hour without.
> 
> These patches are on top of my driver strength patches
> which are on top of my re-tuning patches.
> 
> 
> Adrian Hunter (4):
>       PM / QoS: Add pm_qos_cancel_request_lazy() that doesn't sleep
>       mmc: sdhci: Support maximum DMA latency request via PM QOS
>       mmc: sdhci-acpi: Fix device hang on Intel BayTrail
>       mmc: sdhci-pci: Fix device hang on Intel BayTrail

I'm a bit concerned about the CPUID-based blacklisting of things and
whether or not the SDHCI driver is the right place for doing that.

Maybe we should do it from within the LPSS driver instead?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
