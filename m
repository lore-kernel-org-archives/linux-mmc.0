From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 2/4] mmc: sdio: Add capability to skip SDIO reset at scan
Date: Tue, 25 Apr 2017 09:52:21 +0200
Message-ID: <CAPDyKFpDjx9EWLFCR5yejJg5bu3x--ksuOAE33+a_L0FNUW9dw@mail.gmail.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
 <1492769288-7474-3-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFq7qWGgyXStJU3XZnGRcqMXZs_z21nJ2vUnCe0Pn-q19Q@mail.gmail.com> <ff496ea4-ba9b-387b-2d3b-3bf59b878973@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <ff496ea4-ba9b-387b-2d3b-3bf59b878973@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-mmc@vger.kernel.org

+Grygorii Strashko

On 25 April 2017 at 08:21, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 24/04/17 23:33, Ulf Hansson wrote:
>> On 21 April 2017 at 12:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> The SDIO card state might be being preserved during hibernation, for
>>> example a SDIO wifi card supporting WOWLAN. That state will be lost if an
>>> SDIO reset is done. One way to avoid that would be to build mmc core as a
>>> module and simply not load it until after attempting to restore the
>>> hibernation image. However that won't work if the hibernation image is
>>> stored on eMMC which, of course, requires mmc core.
>>
>> I don't follow here. Are you saying the SDIO card is kept powered in
>> hibernation, as to be able to support WOWLAN, right?
>
> Yes

Okay, makes sense!

>
>>
>> Then, it feels plain wrong the mmc_rescan() tries to re-initialize it.
>> That should never happen, unless something is broken of course.
>
> The thing to note about hibernation is that there is a regular boot in
> between saving the hibernation image and restoring it again.  At boot time,
> the kernel knows almost nothing about whether there is a hibernation image
> and whether or not it will be restored.  Consequently it becomes difficult
> to avoid mmc_rescan().  As mentioned above, we need mmc_rescan() to
> initialize the eMMC so that the hibernation image can be read.

What's wrong with using the hibernation callbacks in the struct
dev_pm_ops? We already do this.

To manage the eMMC/SD/SDIO card device, we do this in /drivers/mmc/core/bus.c:

static const struct dev_pm_ops mmc_bus_pm_ops = {
        SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume, NULL)
        SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
};

To mange the sdio func device, we do this in /drivers/mmc/core/sdio_bus.c

static const struct dev_pm_ops sdio_bus_pm_ops = {
        SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
        SET_RUNTIME_PM_OPS(
                pm_generic_runtime_suspend,
                pm_generic_runtime_resume,
                NULL
        )
};

In other words, we are re-using the same callbacks for system PM
suspend as for system PM hibernation.

I do imagine there are something broken for SDIO in this path, mainly
because I haven't heard much from people using it.

However, for (e)MMC/SD card point of view, restoring from hibernation
should work. I remember that Grygorii Strashko has been working on
this, perhaps he can confirm some of his observations.

Kind regards
Uffe
