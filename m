From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: How to print CMD18 read data
Date: Wed, 01 Feb 2017 17:08:37 +0900
Message-ID: <e0fcedc7-58f4-7ee3-e182-db684c8748d6@samsung.com>
References: <CGME20170201072351epcas2p4b40fc91e204153ce57d510622ab021cc@epcas2p4.samsung.com>
 <CAMGZvfKXGwmrOSD-z_4F5aM5S7TPENmPkLKQ3ArQxJ+rEruhtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43726 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdBAIIp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 03:08:45 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKO00QF1RYEZYC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Feb 2017 17:08:38 +0900 (KST)
In-reply-to: <CAMGZvfKXGwmrOSD-z_4F5aM5S7TPENmPkLKQ3ArQxJ+rEruhtg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: amit mahadik <amitmaddy@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On 02/01/2017 04:23 PM, amit mahadik wrote:
> Hello,
>          I want to interface MMC card via SPI bus. However, I am
> getting CRC errors for CMD18. I tried reading partition table using
> CMD17 but still get errors.
> The same SDMMC card gets detected using SD interface. I want to
> compare the data of CMD18/CMD17 of SD and SPI modes. Please let me
> know how can I print the read data of the said commands in the block
> layer?

In my experience, CRC error was timing issue..(clock, driver-strength, etc..)
You can check those things.

Best Regards,
Jaehoon Chung

> 
> I tried using the following code but it didn't help
> 
> sg_copy_to_buffer(brq->data.sg, brq->data.sg_len, buf, 4096); and printed buf.
> 
> Regards,
> Amit.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

