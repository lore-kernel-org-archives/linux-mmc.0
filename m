From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add compatibility for exynos4412 SoC
Date: Mon, 18 Feb 2013 14:39:06 +0530
Message-ID: <CAK9yfHxNfB9+3BuWKFiQX-57iWH5N4siVHFnpd2J7Tx-GTqSBQ@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHynG-avvyNaiXpDcKmDoDYY+6jg4knL6n6aM87bfq0K_w@mail.gmail.com>
	<CAGOxZ52iXBzv9capeJoe0-_GXEABOmuTOUzSWXX2vV174n7C3g@mail.gmail.com>
	<511DC675.4050004@samsung.com>
	<CAK9yfHy2MJNOSB73rzBFbUSUu0Sd-j=7rsre1Pkdz8FmFj7K2g@mail.gmail.com>
	<CADoNuNfnU4THePNN7iuZprsL7NdP-iXQc9bzf==fXHAixqLABg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33517 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3BRJJH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 04:09:07 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so5358341obq.21
        for <linux-mmc@vger.kernel.org>; Mon, 18 Feb 2013 01:09:06 -0800 (PST)
In-Reply-To: <CADoNuNfnU4THePNN7iuZprsL7NdP-iXQc9bzf==fXHAixqLABg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dongjin Kim <tobetter@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>

Hi Dongjin,


On 18 February 2013 14:34, Dongjin Kim <tobetter@gmail.com> wrote:
> Hello Sachin,
>
> I have one more patch which use '&exynos_drv_data' for its drv_data,
> but not submitted yet.
> I will send it soon anyway, anything else do you like to point out on
> the patch? :)

Please verify if the capabilities of Exynos 4412 and 5 are same? Other
comments are already provided by Jaehoon and Alim.

-- 
With warm regards,
Sachin
