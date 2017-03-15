From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH resend 2/2] mmc: sdhci: sdio-intel: Set
 SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk
Date: Wed, 15 Mar 2017 17:27:43 +0100
Message-ID: <efc9c7af-605a-e590-b07d-727780c9eb3f@redhat.com>
References: <20170308084945.5084-1-hdegoede@redhat.com>
 <20170308084945.5084-3-hdegoede@redhat.com>
 <CAPDyKFow_7cDGiWOeCzCBXsZN9YeVFpMFTxjKibxNBFGUZsYhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbdCOQ1r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Mar 2017 12:27:47 -0400
In-Reply-To: <CAPDyKFow_7cDGiWOeCzCBXsZN9YeVFpMFTxjKibxNBFGUZsYhQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Dong Aisheng <b29396@freescale.com>

Hi,

On 15-03-17 14:48, Ulf Hansson wrote:
> On 8 March 2017 at 09:49, Hans de Goede <hdegoede@redhat.com> wrote:
>> From: Dong Aisheng <b29396@freescale.com>
>>
>> SDIO cards may need clock to send the card interrupt to the host.
>> Set SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON to prevent the clock resource
>> being released.
>>
>> Hans de Goede:
>>
>> It looks like we still need this patch, on a cherrytrail tablet with
>> a RTL8723BS wifi chip, without this patch pinging the tablet results in:
>>
>> PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
>> 64 bytes from 192.168.1.14: icmp_seq=1 ttl=64 time=78.6 ms
>> 64 bytes from 192.168.1.14: icmp_seq=2 ttl=64 time=1760 ms
>> 64 bytes from 192.168.1.14: icmp_seq=3 ttl=64 time=753 ms
>> 64 bytes from 192.168.1.14: icmp_seq=4 ttl=64 time=3.88 ms
>> 64 bytes from 192.168.1.14: icmp_seq=5 ttl=64 time=795 ms
>> 64 bytes from 192.168.1.14: icmp_seq=6 ttl=64 time=1841 ms
>> 64 bytes from 192.168.1.14: icmp_seq=7 ttl=64 time=810 ms
>> 64 bytes from 192.168.1.14: icmp_seq=8 ttl=64 time=1860 ms
>> 64 bytes from 192.168.1.14: icmp_seq=9 ttl=64 time=812 ms
>> 64 bytes from 192.168.1.14: icmp_seq=10 ttl=64 time=48.6 ms
>>
>> Where as with this patch I get:
>>
>> PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
>> 64 bytes from 192.168.1.14: icmp_seq=1 ttl=64 time=3.96 ms
>> 64 bytes from 192.168.1.14: icmp_seq=2 ttl=64 time=1.97 ms
>> 64 bytes from 192.168.1.14: icmp_seq=3 ttl=64 time=17.2 ms
>> 64 bytes from 192.168.1.14: icmp_seq=4 ttl=64 time=2.46 ms
>> 64 bytes from 192.168.1.14: icmp_seq=5 ttl=64 time=2.83 ms
>> 64 bytes from 192.168.1.14: icmp_seq=6 ttl=64 time=1.40 ms
>> 64 bytes from 192.168.1.14: icmp_seq=7 ttl=64 time=2.10 ms
>> 64 bytes from 192.168.1.14: icmp_seq=8 ttl=64 time=1.40 ms
>> 64 bytes from 192.168.1.14: icmp_seq=9 ttl=64 time=2.04 ms
>> 64 bytes from 192.168.1.14: icmp_seq=10 ttl=64 time=1.40 ms
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> [hdegoede@redhat.com: Updated commit msg with sdio wifi ping output]
>> [hdegoede@redhat.com: Add quirk to both acpi and pci intel-sdio entries]
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note an alternative approach would be to add a new flag for this and do
>> a runtime_pm_get on sdio_irq_enable and runtime_pm_put on
>> sdio_irq_disable, that would safe some power if the sdio-driver properly
>> disables the irq when e.g. wifi is turned off, or an oob interrupt is
>> used.
>
> That approach seems more reasonable. Can you please try this instead?

Ok, done (just completed testing it) I will send a v2 of this set
with that approach right after this mail.

Regards,

Hans


>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/host/sdhci-acpi.c     | 1 +
>>  drivers/mmc/host/sdhci-pci-core.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 237f318..c107757 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -288,6 +288,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
>>         .quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>>         .quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
>> +                  SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
>>                    SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>         .caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
>>                    MMC_CAP_WAIT_WHILE_BUSY,
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 982b3e3..7cb54b0 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -498,6 +498,7 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
>> +                       SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
>>                         SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>         .allow_runtime_pm = true,
>>         .probe_slot     = byt_sdio_probe_slot,
>> --
>> 2.9.3
>>
