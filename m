From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Make dw_mci_exynos_probe static
Date: Mon, 4 Mar 2013 10:06:19 +0530
Message-ID: <CAK9yfHxwsXHg74_m3qS-ukZuCAnD8Fe9Qy7mH-etHsW7ZFa1GA@mail.gmail.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
	<5121F74E.5050903@samsung.com>
	<001501ce0dc5$f470bab0$dd523010$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:63430 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab3CDEgU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Mar 2013 23:36:20 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so8380635oag.4
        for <linux-mmc@vger.kernel.org>; Sun, 03 Mar 2013 20:36:20 -0800 (PST)
In-Reply-To: <001501ce0dc5$f470bab0$dd523010$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, patches@linaro.org

Hi Chris,

On 18 February 2013 16:21, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Sachin,
>
> You're right.
> 'dw_mci_exynos_probe' is only used here.
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> On Monday, February 18, 2013, Jaehoon Chung wrote:
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> On 02/18/2013 05:53 PM, Sachin Kamat wrote:
>> > Silences the following sparse warning:
>> > drivers/mmc/host/dw_mmc-exynos.c:218:5: warning:
>> > symbol 'dw_mci_exynos_probe' was not declared. Should it be static?
>> >
>> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Can you please review this series?


-- 
With warm regards,
Sachin
