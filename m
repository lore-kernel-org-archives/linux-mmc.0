From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: set the clear transfer mode register
 quirk for O2Micro
Date: Tue, 25 Aug 2015 14:05:17 +0200
Message-ID: <CAPDyKFpxMcea65_WrUV1Am161ajwyK56aY95Tjkd7BYUs9DY7g@mail.gmail.com>
References: <1438583608-17777-1-git-send-email-adam.lee@canonical.com>
	<20150805054654.GA13200@adam-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37053 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbbHYMFS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:05:18 -0400
Received: by igui7 with SMTP id i7so9117214igu.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:05:17 -0700 (PDT)
In-Reply-To: <20150805054654.GA13200@adam-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adam Lee <adam.lee@canonical.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Peter Guo <peter.guo@bayhubtech.com>

On 5 August 2015 at 07:46, Adam Lee <adam.lee@canonical.com> wrote:
> On Mon, Aug 03, 2015 at 02:33:28PM +0800, Adam Lee wrote:
>> This patch fixes MMC not working issue on O2Micro/BayHub Host, which
>> requires transfer mode register to be cleared when sending no DMA
>> command.
>>
>> Signed-off-by: Peter Guo <peter.guo@bayhubtech.com>
>> Signed-off-by: Adam Lee <adam.lee@canonical.com>

Thanks, applied for next and adding the stable tag.

Kind regards
Uffe

>> ---
>>  drivers/mmc/host/sdhci-pci.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
>> index 94f54d2..b3b0a3e 100644
>> --- a/drivers/mmc/host/sdhci-pci.c
>> +++ b/drivers/mmc/host/sdhci-pci.c
>> @@ -618,6 +618,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
>>  static const struct sdhci_pci_fixes sdhci_o2 = {
>>       .probe = sdhci_pci_o2_probe,
>>       .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>> +     .quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
>>       .probe_slot = sdhci_pci_o2_probe_slot,
>>       .resume = sdhci_pci_o2_resume,
>>  };
>> --
>> 2.5.0
>>
>
> Hi, Ulf
>
> Please add a cc stable sign off when you apply it, I forgot it, thanks.
>
> "Cc: stable <stable@vger.kernel.org>"
>
> --
> Adam Lee
