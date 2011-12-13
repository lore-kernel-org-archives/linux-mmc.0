From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] MMC/SD: Add callback function to detect card
Date: Tue, 13 Dec 2011 12:26:36 +0200
Message-ID: <4EE7285C.3070503@intel.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com> <1323077026-12071-2-git-send-email-r66093@freescale.com> <4EE1DCEB.5030102@intel.com> <8A2FC72B45BB5A4C9F801431E06AE48F11644BF7@039-SN1MPN1-006.039d.mgd.msft.net> <4EE7063F.9090900@intel <4EE712B1.6030706@intel.com> <8A2FC72B45BB5A4C9F801431E06AE48F11644F37@039-SN1MPN1-006.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55222 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab1LMK0t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Dec 2011 05:26:49 -0500
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11644F37@039-SN1MPN1-006.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 13/12/11 11:55, Huang Changming-R66093 wrote:
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: Tuesday, December 13, 2011 4:54 PM
>> To: Huang Changming-R66093
>> Cc: linux-mmc@vger.kernel.org
>> Subject: Re: [PATCH 2/4] MMC/SD: Add callback function to detect card
>>
>> On 13/12/11 10:26, Huang Changming-R66093 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>>>> Sent: Tuesday, December 13, 2011 4:01 PM
>>>> To: Huang Changming-R66093
>>>> Cc: linux-mmc@vger.kernel.org
>>>> Subject: Re: [PATCH 2/4] MMC/SD: Add callback function to detect card
>>>>
>>>> On 13/12/11 09:25, Huang Changming-R66093 wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>>>>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>>>>>> Sent: Friday, December 09, 2011 6:03 PM
>>>>>> To: Huang Changming-R66093
>>>>>> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093
>>>>>> Subject: Re: [PATCH 2/4] MMC/SD: Add callback function to detect
>>>>>> card
>>>>>>
>>>>>> On 05/12/11 11:23, r66093@freescale.com wrote:
>>>>>>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>>>>>>>
>>>>>>> In order to check whether the card has been removed, the function
>>>>>>> mmc_send_status() will send command CMD13 to card and ask the card
>>>>>>> to send its status register to sdhc driver, which will generate
>>>>>>> many interrupts repeatedly and make the system performance bad.
>>>>>>
>>>>>> That should not be true.  sdhci.c will not send a command to the
>>>>>> card if the card is not present i.e. see this excerpt from
>>>>>> sdhci_request():
>>>>>>
>>>>>>
>>>>>> 	/* If polling, assume that the card is always present. */
>>>>>> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>>>>>> 		present = true;
>>>>>> 	else
>>>>>> 		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>>>>>> 				SDHCI_CARD_PRESENT;
>>>>>>
>>>>>> 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>>>>>> 		host->mrq->cmd->error = -ENOMEDIUM;
>>>>>> 		tasklet_schedule(&host->finish_tasklet);
>>>>>> --
>>>>> But, for some controller, this field of SDHCI_PRESENT_STATE register
>>>>> is
>>>> reserved and always is 1. When the card is absent, many command will
>>>> try to send to the card, and generate many interrupt.
>>>>> If even controller can detect the card state, if the card is absent
>>>>> as
>>>> you said, this command can't send to card. But, when card is present,
>>>> there will be many command to the card and many interrupts will be
>>>> generated, that will affect the performance.
>>>>> So, I don't think this comment is not correct.
>>>>>
>>>>>
>>>>>
>>>>
>>>> You patch uses (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL) Does that mean
>>>> SDHCI_CARD_CDPL does work in that case?
>>> No.
>>> The SDHCI_CARD_CDPL[bit13] reflect the pin level:
>>> CDPL: Card detect pin level. This bit reflects the inverse value of the
>> SDHC_CD pin for the card socket.
>>> 0 No card present (SDHC_CD = 1)
>>> 1 Card present (SDHC_CD = 0)
>>>
>>> So, this bit has the same effect as SDHCI_CARD_PRESENT[bit15], the
>> difference is that debouncing is not performed on this bit.
>>>
>>> Freescale's controller supports the card detection, if card is present,
>> none-zero will be returned, otherwise, zero will be returned.
>>>
>>> You can see my other patch [3/4], I add one callback to detect the card
>> state in special platform: if the controller supports card detection,
>> this callback will be performed in special platform (e.g. sdhci-of-
>> esdhc.c) and return the card state (present or absent), if controller
>> doesn't support card detection, this callback will be not performed and
>> return -ENOSYS.
>>
>> OK, but the point is, the request can be stopped in sdhci_request().
>> Can you just add your callback there?
> Why can the request be stopped? Just because of card absent or SDHCI_DEVICE_DEAD?

Yes, both

