From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from
 STATE_DATA_ERROR
Date: Mon, 08 Apr 2013 14:10:00 +0900
Message-ID: <51625128.7040405@samsung.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
 <5146EAB0.1030705@samsung.com>
 <CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
 <515E88E3.5070507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64705 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab3DHFJs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 01:09:48 -0400
In-reply-to: <515E88E3.5070507@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Bing Zhao <bzhao@marvell.com>, Ashok Nagarajan <asnagarajan@chromium.org>, Paul Stewart <pstew@chromium.org>, Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Looks good to me.

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 04/05/2013 05:18 PM, Jaehoon Chung wrote:
> Hi Doug,
> 
> You're right..it's something wrong.
> Actually i didn't test with your patch, but your commit message is reasonable.
> 
> I will check until next week after test.
> 
> Best Regards,
> Jaehoon Chung
> 
> On 03/27/2013 03:06 AM, Doug Anderson wrote:
>> Jaehoon,
>>
>> On Mon, Mar 18, 2013 at 3:21 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi Doug,
>>>
>>> Great..i have found the problem like this.
>>> I will check your patch..and share the result.
>>
>> Did you have any time to check this patch?
>>
>> Thanks!
>>
>> -Doug
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

