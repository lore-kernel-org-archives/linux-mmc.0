From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] How working MMC_BUS_WIDTH_TEST??
Date: Thu, 30 Jun 2011 11:12:45 +0900
Message-ID: <4E0BDB9D.3030809@samsung.com>
References: <4E09B2E3.20903@samsung.com>
 <A143AB12-AF84-4CD9-BA9C-97651D0ED29C@marvell.com>
 <4E0AAD3C.5040201@samsung.com>
 <AF5E05CF-CE23-49BA-8638-0FF385D0A874@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:37247 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757887Ab1F3CMq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 22:12:46 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LNK00ISGZG30130@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 30 Jun 2011 11:12:45 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LNK008J1ZH9RC@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 30 Jun 2011 11:12:45 +0900 (KST)
In-reply-to: <AF5E05CF-CE23-49BA-8638-0FF385D0A874@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Philip..

If i didn't set MMC_CAP_BUS_WIDTH_TEST,
entered mmc_compare_ext_csds(). right?

i understand that mmc_compare_ext_csds() compared with previously ext_csd.
But in source code, always previously ext_csd is NULL.

I didn't find where assigned ext_csd..

I think that need to assign ext_csd..

If my point is right, i will send the patch..

Thanks
Jaehoon Chung

Philip Rakity wrote:
> On Jun 28, 2011, at 9:42 PM, Jaehoon Chung wrote:
> 
>> Philip Rakity wrote:
>>> On Jun 28, 2011, at 3:54 AM, Jaehoon Chung wrote:
>>>
>>>> Hi..
>>>>
>>>> I found the MMC_CAP_BUS_WIDTH_TEST...
>>>> In mailing, I read the related patches..
>>>> but i didn't fully understand...
>>>>
>>>> /*
>>>> * If controller can't handle bus width test,
>>>> * compare ext_csd previously read in 1 bit mode
>>>> * against ext_csd at new bus width
>>>> */
>>>> if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
>>>> 	err = mmc_compare_ext_csds(card,
>>>> 		ext_csd,
>>>> 		bus_width);
>>>> else
>>>> 	err = mmc_bus_test(card, bus_width);
>>>> if (!err)
>>>> 	break;
>>>>
>>>> And i tested suspend/resume..it's failed..
>>>> If i didn't set MMC_CAP_BUS_WIDTH_TEST, always return -EINVAL..
>>>> (using SDHCI controller, card is eMMC4.41)
>>>>
>>>> Didn't compare ext_csd's value..
>>>>
>>>> So i want to know how use MMC_CAP_BUS_WIDTH_TEST..
>>> I am using eMMC and code works fine so  maybe there is issue in no ext_csd.  You will need to
>>> add debug code to the compare_ext_csd and see what is not right and we can adjust the code.
>>> I am surprised that resume fails -- code will default to 1 bit data and it is NOT possible for this to
>>> be wrong.  At the moment -- clueless to explain with more information.
>>>
>>> TheCMD14/ CMD19 is in JEDEC spec for bus width testing.  Sends a pattern to the card and
>>> based on the returned values detects the bus width.  Some controllers do NOT support this command.
>>> The just do not work.  You need to figure this out by enabling the quirk.  No other way to know.
>> When card is probing, i think that need to test bus-width.
>> If card is non-removable, unnecessary bus_width test during resuming.
> 
> agree not necessary but does not explain error.
> 
> 
>> Because already know that support n-bit bus-width..how about this?
>>
>>> regards,
>>>
>>> Philip
>>>
>>>> Thanks,
>>>> Jaehoon Chung
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

