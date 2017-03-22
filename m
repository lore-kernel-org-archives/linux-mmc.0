From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: intel: Disable runtime pm when the
 sdio_irq is enabled.
Date: Wed, 22 Mar 2017 14:06:43 +0200
Message-ID: <2d388dd3-a024-0eea-dc07-c207be0a044c@intel.com>
References: <20170315163145.15475-1-hdegoede@redhat.com>
 <20170315163145.15475-2-hdegoede@redhat.com>
 <CAPDyKFpaqJDCxR7eTtgOVCn7SUNeCFPPTc884fe7yjXi-LRGow@mail.gmail.com>
 <7e093710-03d0-30f1-4088-5f68217cb109@intel.com>
 <CAPDyKFp-w9jORUUC=eqwPnnZcxQKCu_d2y9pqvX3cq_rx67gYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10440 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934267AbdCVMMx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Mar 2017 08:12:53 -0400
In-Reply-To: <CAPDyKFp-w9jORUUC=eqwPnnZcxQKCu_d2y9pqvX3cq_rx67gYA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Dong Aisheng <b29396@freescale.com>

On 21/03/17 16:54, Ulf Hansson wrote:
> On 21 March 2017 at 13:34, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 21/03/17 12:00, Ulf Hansson wrote:
>>> On 15 March 2017 at 17:31, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> SDIO cards may need clock to send the card interrupt to the host.
>>>>
>>>> On a cherrytrail tablet with a RTL8723BS wifi chip, without this patch
>>>> pinging the tablet results in:
>>>>
>>>> PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
>>>> 64 bytes from 192.168.1.14: icmp_seq=1 ttl=64 time=78.6 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=2 ttl=64 time=1760 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=3 ttl=64 time=753 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=4 ttl=64 time=3.88 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=5 ttl=64 time=795 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=6 ttl=64 time=1841 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=7 ttl=64 time=810 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=8 ttl=64 time=1860 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=9 ttl=64 time=812 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=10 ttl=64 time=48.6 ms
>>>>
>>>> Where as with this patch I get:
>>>>
>>>> PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
>>>> 64 bytes from 192.168.1.14: icmp_seq=1 ttl=64 time=3.96 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=2 ttl=64 time=1.97 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=3 ttl=64 time=17.2 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=4 ttl=64 time=2.46 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=5 ttl=64 time=2.83 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=6 ttl=64 time=1.40 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=7 ttl=64 time=2.10 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=8 ttl=64 time=1.40 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=9 ttl=64 time=2.04 ms
>>>> 64 bytes from 192.168.1.14: icmp_seq=10 ttl=64 time=1.40 ms
>>>>
>>>> Cc: Dong Aisheng <b29396@freescale.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> Changes in v2:
>>>> -New patch replacing "mmc: sdhci: sdio-intel: Set
>>>>  SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk"
>>>> ---
>>>>  drivers/mmc/host/sdhci-acpi.c     | 1 +
>>>>  drivers/mmc/host/sdhci-pci-core.c | 1 +
>>>>  drivers/mmc/host/sdhci.c          | 6 ++++++
>>>>  drivers/mmc/host/sdhci.h          | 2 ++
>>>>  4 files changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>>> index 237f318..53b431a 100644
>>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>>> @@ -288,6 +288,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>>>>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
>>>>         .quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>>>>         .quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
>>>> +                  SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM |
>>>>                    SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>>>         .caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
>>>>                    MMC_CAP_WAIT_WHILE_BUSY,
>>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>>> index 982b3e3..a3b242e 100644
>>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>>> @@ -498,6 +498,7 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>>>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>>>>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>>>>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
>>>> +                       SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM |
>>>>                         SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>>>         .allow_runtime_pm = true,
>>>>         .probe_slot     = byt_sdio_probe_slot,
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 6fdd7a7..59c5cad 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1828,6 +1828,9 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>>>         struct sdhci_host *host = mmc_priv(mmc);
>>>>         unsigned long flags;
>>>>
>>>> +       if ((host->quirks2 & SDHCI_QUIRK2_SDIO_IRQ_NO_RUNTIME_PM) && enable)
>>>> +               pm_runtime_get(host->mmc->parent);
>>>
>>> There are currently no sdhci variant for any SoC that implements
>>> wakeup support in runtime suspend for SDIO irqs. In other words, it
>>> seems all sdhci hosts suffers from the same problem.
>>
>> There might still be drivers that expect SDIO interrupts during
>> runtime suspend, considering this patch:
>>
>>         https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be138554a7923658ded799b0e8794d9c1d08a6e5
> 
> Right. Thanks for pointing it out.
> 
> However I don't think that is how runtime PM should be deployed when
> it is used for controlling devices like sdhci. Let's change that once
> we  have the common issue for sdhci and SDIO irqs resolved.

Yes, then perhaps we could accept the inverted quirk on the basis that it
will be removed.

Hans, as I wrote somewhere else, we can use pm_runtime_get_noresume() and
pm_runtime_put_noidle() since sdhci_enable_sdio_irq() must be called with
the host claimed and therefore runtime resumed.

