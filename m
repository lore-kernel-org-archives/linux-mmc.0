From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 0/9] mmc: sdhci-pci: Respect PM flags when enabling
 card detect GPIO IRQ wakeup
Date: Tue, 16 Jan 2018 09:24:06 +0100
Message-ID: <CAPDyKFoUqTtXMKT+_JyJSE2FWUggbX=Fiv4YVBb6qLpJh27j5g@mail.gmail.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com> <08283b49-fdaf-d289-e375-20bce7dbbf8f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <08283b49-fdaf-d289-e375-20bce7dbbf8f@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 16 January 2018 at 08:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/01/18 09:52, Adrian Hunter wrote:
>> Hi
>>
>> Commit 03dbaa04a2e5 ("mmc: slot-gpio: Add support to enable irq wake on
>> cd_irq") enabled wakeup irrespective of the host controller's PM flags.
>> However, users also want to control it from sysfs power/wakeup attribute.
>> That means the driver needs to check the PM flags before enabling it in the
>> suspend callback.  Patch 9 adds support for that in sdhci-pci, which is the
>> only driver presently using the MMC_CAP_CD_WAKE flag.  Patches 1 - 7 tidy
>> up aspects of sdhci and sdhci-pci wakeup handling, and patch 8 adds a
>> helper function to make it easy for drivers.
>>
>> There are 2 contentious aspects to this patch set:
>>
>> 1) An existing problem with the SDIO API which does not let the host
>> controller driver know that the SDIO function driver has requested SDIO
>> card interrupt wakeup until the suspend callback - which results in the
>> host controller driver having to enable or disable wakeup in the suspend
>> callback.  Fixing the SDIO API is a separate issue IMHO.
>>
>> 2) In order to use the sysfs power/wakeup attribute, the driver must set the
>> device as wake capable even when it is really a GPIO that wakes the system.
>>
>
> Given that we have more-or-less agreed to use sysfs power/wakeup attribute,
> I don't see a problem with going ahead with these patches, and adjusting the
> API later.  Thoughts?

Let me have look again, I might be able to pick up at least some of
the changes in $subject series. No matter what, please re-post once
4.16 rc1 is out.

The reason for being conservative, is that I would prefer the
discussion [1] to conclude on how to handle out/in band wakeups, as
that would help to understand the final goal of $subject series.

Kind regards
Uffe

[1]
https://marc.info/?l=linux-pm&m=151600749514917&w=2
