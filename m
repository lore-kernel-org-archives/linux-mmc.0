From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from
 STATE_DATA_ERROR
Date: Fri, 05 Apr 2013 17:18:43 +0900
Message-ID: <515E88E3.5070507@samsung.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
 <5146EAB0.1030705@samsung.com>
 <CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19467 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3DEISf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Apr 2013 04:18:35 -0400
In-reply-to: <CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Bing Zhao <bzhao@marvell.com>, Ashok Nagarajan <asnagarajan@chromium.org>, Paul Stewart <pstew@chromium.org>, Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Doug,

You're right..it's something wrong.
Actually i didn't test with your patch, but your commit message is reasonable.

I will check until next week after test.

Best Regards,
Jaehoon Chung

On 03/27/2013 03:06 AM, Doug Anderson wrote:
> Jaehoon,
> 
> On Mon, Mar 18, 2013 at 3:21 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Doug,
>>
>> Great..i have found the problem like this.
>> I will check your patch..and share the result.
> 
> Did you have any time to check this patch?
> 
> Thanks!
> 
> -Doug
> 

