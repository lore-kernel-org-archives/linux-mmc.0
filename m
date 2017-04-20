From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: MMC block addressing mode.
Date: Thu, 20 Apr 2017 10:12:41 -0700
Message-ID: <c503aae1-4162-4398-1645-9e2acab5d002@caviumnetworks.com>
References: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
 <CAPDyKFqfEQ6POgoSFL=t0nP62CB13DNL0m8m-Vzqaw0GMAV3qg@mail.gmail.com>
 <ef902f01-96fb-a314-e57c-bde8e1545b66@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0046.outbound.protection.outlook.com ([104.47.40.46]:14515
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S945922AbdDTRMr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 13:12:47 -0400
In-Reply-To: <ef902f01-96fb-a314-e57c-bde8e1545b66@cavium.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@cavium.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <david.daney@cavium.com>

On 04/20/2017 09:17 AM, Steven J. Hill wrote:
> On 04/20/2017 09:18 AM, Ulf Hansson wrote:
>>>
>>> The Cavium hardware requires knowledge of the card addressing mode.
>>> We need to either restore mmc_card_blockaddr(), or create another
>>> way to generate the same information. You previously suggested use
>>> of the 'blksz' value, however, it has the same value regardless of
>>> the card capacity. What would you suggest? Cheers.
>>
>> Right. Can you explain what the Cavium hardware need it for?
>>
> Uffe,
> 
> In Cavium's MMC controller, the DMA engine requires software to
> specify the addressing mode of the card. For DMA write operations,
> the CARD_ADDR field in the MIO_EMM_DMA register is programmed with
> a byte address if the media card <= 2GB. If the card is > 2GB, the
> address is interpreted as a 512 byte sector address. The SECTOR bit
> tells the controller how to interpret the address in CARD_ADDR. If
> set to 1, use 512 byte sector addressing, otherwise it is set to 0
> and byte addressing is used.
> 

... In other words:

The Cavium MMC controller doesn't directly send the commands supplied by 
the MMC core to the target device.  The driver analyzes the intent of 
the commands, and then programs the MMC bus interface unit to synthesize 
an equivalent, but perhaps different, set of commands to the target 
device.  As part of this synthesis, hardware needs to be told if sector 
or byte addressing is used by the target device.

Steven and Jan:  Can we get around this requirement by:

   - Always set MIO_EMM_DMA[MULTI] = 1;  This way by SECTOR mode may be 
unimportant.

   - Always set MIO_EMM_DMA[SECTOR] = SUITABLE_CONSTANT.

