From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RESEND 0/9] mmc: sdhci-pci: Respect PM flags when enabling
 card detect GPIO IRQ wakeup
Date: Tue, 16 Jan 2018 09:43:04 +0200
Message-ID: <08283b49-fdaf-d289-e375-20bce7dbbf8f@intel.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 09/01/18 09:52, Adrian Hunter wrote:
> Hi
> 
> Commit 03dbaa04a2e5 ("mmc: slot-gpio: Add support to enable irq wake on
> cd_irq") enabled wakeup irrespective of the host controller's PM flags.
> However, users also want to control it from sysfs power/wakeup attribute.
> That means the driver needs to check the PM flags before enabling it in the
> suspend callback.  Patch 9 adds support for that in sdhci-pci, which is the
> only driver presently using the MMC_CAP_CD_WAKE flag.  Patches 1 - 7 tidy
> up aspects of sdhci and sdhci-pci wakeup handling, and patch 8 adds a
> helper function to make it easy for drivers.
> 
> There are 2 contentious aspects to this patch set:
> 
> 1) An existing problem with the SDIO API which does not let the host
> controller driver know that the SDIO function driver has requested SDIO
> card interrupt wakeup until the suspend callback - which results in the
> host controller driver having to enable or disable wakeup in the suspend
> callback.  Fixing the SDIO API is a separate issue IMHO.
> 
> 2) In order to use the sysfs power/wakeup attribute, the driver must set the
> device as wake capable even when it is really a GPIO that wakes the system.
> 

Given that we have more-or-less agreed to use sysfs power/wakeup attribute,
I don't see a problem with going ahead with these patches, and adjusting the
API later.  Thoughts?
