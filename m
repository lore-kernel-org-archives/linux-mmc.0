From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: MMC block addressing mode.
Date: Thu, 20 Apr 2017 11:17:26 -0500
Message-ID: <ef902f01-96fb-a314-e57c-bde8e1545b66@cavium.com>
References: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
 <CAPDyKFqfEQ6POgoSFL=t0nP62CB13DNL0m8m-Vzqaw0GMAV3qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqfEQ6POgoSFL=t0nP62CB13DNL0m8m-Vzqaw0GMAV3qg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <david.daney@cavium.com>, Jan Glauber <jan.glauber@caviumnetworks.com>
List-Id: linux-mmc@vger.kernel.org

On 04/20/2017 09:18 AM, Ulf Hansson wrote:
>>
>> The Cavium hardware requires knowledge of the card addressing mode.
>> We need to either restore mmc_card_blockaddr(), or create another
>> way to generate the same information. You previously suggested use
>> of the 'blksz' value, however, it has the same value regardless of
>> the card capacity. What would you suggest? Cheers.
> 
> Right. Can you explain what the Cavium hardware need it for?
>
Uffe,

In Cavium's MMC controller, the DMA engine requires software to
specify the addressing mode of the card. For DMA write operations,
the CARD_ADDR field in the MIO_EMM_DMA register is programmed with
a byte address if the media card <= 2GB. If the card is > 2GB, the
address is interpreted as a 512 byte sector address. The SECTOR bit
tells the controller how to interpret the address in CARD_ADDR. If
set to 1, use 512 byte sector addressing, otherwise it is set to 0
and byte addressing is used.

Steve
