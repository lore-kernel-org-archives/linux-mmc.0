From: Philip Rakity <prakity@marvell.com>
Subject: Re: eMMC sector/byte access mode validation
Date: Tue, 4 Jan 2011 19:02:50 -0800
Message-ID: <C4E7BAFA-1C7B-45E9-B025-F0BA5DD86B5A@marvell.com>
References: <AANLkTinn8EOuiB7ufMFxu=4vCf1K1==oj7Yqni_pbMjc@mail.gmail.com>
 <AANLkTi=HAY1MSMwhRvkae2c1VotJgcKp2oTa8Vjc_FD+@mail.gmail.com>
 <AANLkTinz7ff0EtnoGA6us8zN2AZpSpf-A3mH0j6Axo7H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37536 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751010Ab1AEDHz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 22:07:55 -0500
In-Reply-To: <AANLkTinz7ff0EtnoGA6us8zN2AZpSpf-A3mH0j6Axo7H@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ethan Du <ethan.too@gmail.com>
Cc: Sujit Reddy <sujitreddy243@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>


The patch was submitted because we did see the issue.

On Jan 4, 2011, at 5:43 PM, Ethan Du wrote:

> Hi:
> 
>   I have not seen case (1) and (2) across >20 types of micro SD
> cards, and >10 types of Sandisk/Toshiba eMMC chips, so I believe the
> 2GB condition is ok.
>   Probing of the OCR bit to chose between byte and sector mode will
> also work, which I have tried in a large scope.
> 
> Regards,
> -Ethan
> 
> On Wed, Jan 5, 2011 at 12:59 AM, Sujit Reddy <sujitreddy243@gmail.com> wrote:
>> Hi,
>> 
>> Any comments on below mentioned query?
>> 
>> Thanks
>> Sujit
>> 
>> On Thu, Dec 23, 2010 at 1:35 PM, Sujit Reddy <sujitreddy243@gmail.com> wrote:
>>> Hi,
>>> 
>>> According to eMMC spec v4.3, Section 6.1 says that greater than 2GB
>>> density cards are sector addressable and less than 2GB are byte addressable.
>>> But Section 7.3.3 says that OCR bit 30 needs to be used which access mode
>>> the host must use for all its future transactions.
>>> 
>>> In mainline kernel the support for less than 2GB cards is by checking
>>> the density of card.
>>> If it is greater than 2GB it is assumed to be supporting sector addressing.
>>> 
>>> But actually we need to check the OCR value to determine the correct access mode
>>> See patch (http://www.spinics.net/lists/linux-mmc/msg01466.html) by Philip.
>>> 
>>> Some eMMC cards even though less than 2GB have SEC_COUNT value defined
>>> in EXT_CSD register but does not support sector access mode.
>>> 
>>> I have a couple of questions here:
>>> 1) Are there any cards that support only byte access mode even though
>>> the density is
>>> greater than 2GB?
>>> 2) If there are cards which have capacity less than 2GB and supports only sector
>>> access mode then what's the solution? I am not sure If there are any such cards.
>>> 
>>> Philip's patch handles both these scenarios effectively.
>>> Can anyone mention the reason not taking Philip's patch into account,
>>> which I feel is much
>>> more fool proof than the implementation in mainline kernel
>>> (http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg02307.html)?
>>> 
>>> Thanks
>>> Sujit
>>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

