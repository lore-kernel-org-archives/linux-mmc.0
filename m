From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: How to print CMD18 read data
Date: Wed, 01 Feb 2017 20:43:06 +0900
Message-ID: <0f96cf1e-cd58-c02c-5746-11d52fe9bb7e@samsung.com>
References: <CGME20170201072351epcas2p4b40fc91e204153ce57d510622ab021cc@epcas2p4.samsung.com>
 <CAMGZvfKXGwmrOSD-z_4F5aM5S7TPENmPkLKQ3ArQxJ+rEruhtg@mail.gmail.com>
 <e0fcedc7-58f4-7ee3-e182-db684c8748d6@samsung.com>
 <CAMGZvfJsuHFkRJVdp9npeUMP53vsCh4G4=Py1pZphZkaowsT9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57803 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdBALnT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 06:43:19 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKP00AR81W47O80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Feb 2017 20:43:16 +0900 (KST)
In-reply-to: <CAMGZvfJsuHFkRJVdp9npeUMP53vsCh4G4=Py1pZphZkaowsT9A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: amit mahadik <amitmaddy@gmail.com>, linux-mmc@vger.kernel.org

On 02/01/2017 05:48 PM, amit mahadik wrote:
> Hi Jaehoon,
>                    Thanks for replying promptly. adding more debug
> prints I see that CMD9(CSD) CMD51(SSR) values in case of SD and SPI
> mode are the same. Only command that troubles is CMD18. My clock
> setting is 25Mhz and the card is working at 3.3V.

I don't have a knowledge about SPI mode..it might have the difference initial sequence.
How about checking "use_spi_crc"?..Someone might have much knowledge for SPI mode. :)

Best Regards,
Jaehoon Chung

> 
> Regards,
> Amit.
> 
> On Wed, Feb 1, 2017 at 1:38 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi,
>>
>> On 02/01/2017 04:23 PM, amit mahadik wrote:
>>> Hello,
>>>          I want to interface MMC card via SPI bus. However, I am
>>> getting CRC errors for CMD18. I tried reading partition table using
>>> CMD17 but still get errors.
>>> The same SDMMC card gets detected using SD interface. I want to
>>> compare the data of CMD18/CMD17 of SD and SPI modes. Please let me
>>> know how can I print the read data of the said commands in the block
>>> layer?
>>
>> In my experience, CRC error was timing issue..(clock, driver-strength, etc..)
>> You can check those things.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> I tried using the following code but it didn't help
>>>
>>> sg_copy_to_buffer(brq->data.sg, brq->data.sg_len, buf, 4096); and printed buf.
>>>
>>> Regards,
>>> Amit.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
> 
> 

