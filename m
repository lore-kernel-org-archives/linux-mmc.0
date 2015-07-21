From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v8 2/2] mmc: host: sdhci: Disable 1.8V signaling for
 arasan 4.9a version of SDHCI controller.
Date: Tue, 21 Jul 2015 18:55:15 +0530
Message-ID: <CAOHikRCRiLb+bDo0Cm8Wb-1R4t+EfYTjW3NxBaF9T3_qTsSggQ@mail.gmail.com>
References: <1434715227-27399-1-git-send-email-stripathi@apm.com>
	<1434715227-27399-3-git-send-email-stripathi@apm.com>
	<CAOHikRBkDinUfcOR3Dg12e2Xy_P5TABOpHSnkSpZhRyhLRWGFA@mail.gmail.com>
	<CAPDyKFqozGkHRSFYm=P61XnYj4F-kpoYG2CmVDc1tSkT_zQJ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:35452 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbbGUNZR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 09:25:17 -0400
Received: by lahh5 with SMTP id h5so117654969lah.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 06:25:16 -0700 (PDT)
In-Reply-To: <CAPDyKFqozGkHRSFYm=P61XnYj4F-kpoYG2CmVDc1tSkT_zQJ5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@deeprootsystems.com>, Olof Johansson <olof@lixom.net>, linux-mmc <linux-mmc@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

On Tue, Jul 21, 2015 at 6:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 19 June 2015 at 14:28, Suman Tripathi <stripathi@apm.com> wrote:
>> Hi ,
>>
>> On Fri, Jun 19, 2015 at 5:30 PM, Suman Tripathi <stripathi@apm.com> wrote:
>>> This patch disables the 1.8V signaling for arasan 4.9a version
>>> of SDHCI controller with the help SDHCI_QUIRK2_NO_1_8_V quirk.
>>>
>>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>>> ---
>>> ---
>>>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>> index 21c0c08..4c99ea4 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -171,7 +171,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>>
>>>         if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>>>                 host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>>> -               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>>> +               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23 |
>>> +                                SDHCI_QUIRK2_NO_1_8_V;
>>>         }
>>
>>
>> I think I am  wrong here. No-1.8v is something related to board
>> regulator circuitry not related to IP version. So it should be dts
>> driven.
>
> Agree!
>
> So I guess that will change patch1 and this one can be completely dropped?

yes.

>
> Kind regards
> Uffe



-- 
Thanks,
with regards,
Suman Tripathi
