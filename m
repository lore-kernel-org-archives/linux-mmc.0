From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of of_match_ptr()
Date: Wed, 20 Mar 2013 21:01:36 +0530
Message-ID: <CAK9yfHxdNZk2q9y_9AUPFF+4F9-8b1jkYBxp5-vxc-hXWM3=Sg@mail.gmail.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
	<1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
	<002201ce1ff5$874c82b0$95e58810$%jun@samsung.com>
	<CAK9yfHwBsJ-BVPvnV4JBG8cp2vQ6aecGqZJKN-zOSsXkFVoW9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:40621 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3CTPbh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 11:31:37 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so1727909obc.6
        for <linux-mmc@vger.kernel.org>; Wed, 20 Mar 2013 08:31:36 -0700 (PDT)
In-Reply-To: <CAK9yfHwBsJ-BVPvnV4JBG8cp2vQ6aecGqZJKN-zOSsXkFVoW9A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

On 13 March 2013 21:05, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Chris,
>
> On 13 March 2013 19:47, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> On Monday, February 18, 2013, Sachin Kamat wrote:
>>> 'dw_mci_exynos_match' is always compiled in. Hence of_match_ptr
>>> is not required.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
>
> Here are the required Ack's for you to apply the patch :)
>

ping Chris.



-- 
With warm regards,
Sachin
