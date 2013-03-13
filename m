From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of of_match_ptr()
Date: Wed, 13 Mar 2013 21:05:23 +0530
Message-ID: <CAK9yfHwBsJ-BVPvnV4JBG8cp2vQ6aecGqZJKN-zOSsXkFVoW9A@mail.gmail.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
	<1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
	<002201ce1ff5$874c82b0$95e58810$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43384 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab3CMPfY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 11:35:24 -0400
Received: by mail-ob0-f180.google.com with SMTP id ef5so1129129obb.39
        for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2013 08:35:23 -0700 (PDT)
In-Reply-To: <002201ce1ff5$874c82b0$95e58810$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, jh80.chung@samsung.com, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>

Hi Chris,

On 13 March 2013 19:47, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Monday, February 18, 2013, Sachin Kamat wrote:
>> 'dw_mci_exynos_match' is always compiled in. Hence of_match_ptr
>> is not required.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>


Here are the required Ack's for you to apply the patch :)


-- 
With warm regards,
Sachin
