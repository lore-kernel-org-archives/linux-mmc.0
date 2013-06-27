From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from
 STATE_DATA_ERROR
Date: Thu, 27 Jun 2013 12:36:18 +0900
Message-ID: <51CBB332.2050903@samsung.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
 <5146EAB0.1030705@samsung.com>
 <CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
 <515E88E3.5070507@samsung.com>
 <003401ce3453$19d1e8c0$4d75ba40$%jun@samsung.com>
 <CAD=FV=V+ZZ0MUtuWKUOgR9NPyAquUjFC6KtHvAP-4iHXAYpjqA@mail.gmail.com>
 <001601ce35b9$652c5870$2f850950$%jun@samsung.com>
 <CAD=FV=XKeRjpH1+ytjMfLuGGqQ5VVub22n=V+UpV=jBCD4LLHw@mail.gmail.com>
 <001801ce6c20$6ba39900$42eacb00$%jun@samsung.com>
 <477F20668A386D41ADCC57781B1F70430EA2AA2513@SC-VEXCH1.marvell.com>
 <CAD=FV=Xz-Cp86u=w8m91AEMJgH-o6cLkz6_udVw_3bm7Tm0OiA@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F70430EA2AA251A@SC-VEXCH1.marvell.com>
 <CAD=FV=V6S7FsK+=+7EHDV74=Mw_iWecO2ZxVpVcd=p7ugW-sHA@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F70430EA2BD5ECB@SC-VEXCH1.marvell.com>
 <001001ce720f$f96980c0$ec3c8240$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49007 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3F0DgO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jun 2013 23:36:14 -0400
In-reply-to: <001001ce720f$f96980c0$ec3c8240$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Bing Zhao' <bzhao@marvell.com>, 'Doug Anderson' <dianders@chromium.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@gmail.com>, 'Ashok Nagarajan' <asnagarajan@chromium.org>, 'Paul Stewart' <pstew@chromium.org>, 'Olof Johansson' <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Seungwon,

I didn't get the same result..In my case, it's working fine.
But as Bing's result, i will check more and share the result.

Best Regards,
Jaehoon Chung

On 06/26/2013 10:53 AM, Seungwon Jeon wrote:
> Hi Jaehoon,
> Do you have the same result?
> Could you share the result?
> 
> Thanks,
> Seungwon Jeon
> On Tuesday, June 25 2013, Bing Zhao wrote:
>>> I think the proposal on the table is to take Seungwon's patches
>>> instead of mine.  Assuming they solve your problems, I'm OK with that.
>>>  I think he was requesting testing the first of his two patches alone
>>> and then both of his two patches together.
>>
>> Test #1: Swungwon's patch #1 alone [1]
>> Test #2: Swungwon's patch #2 alone [1]
>> Test #3: Swungwon's patch #1 and #2 [1]
>> Test #4: Doug's original patch [2]
>>
>> Test #1 and #3: it doesn't work; system reboots due to kernel hung_task
>> Test #2 and #4: it works; instead of hung_task driver gets CRC error (which is expected)
>>
>> Thanks,
>> Bing
>>
>> [1] https://lkml.org/lkml/2013/4/8/316
>> [2] https://lkml.org/lkml/2013/3/15/583
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

