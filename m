From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add compatibility for exynos4412 SoC
Date: Mon, 18 Feb 2013 14:16:03 +0530
Message-ID: <CAK9yfHy2MJNOSB73rzBFbUSUu0Sd-j=7rsre1Pkdz8FmFj7K2g@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHynG-avvyNaiXpDcKmDoDYY+6jg4knL6n6aM87bfq0K_w@mail.gmail.com>
	<CAGOxZ52iXBzv9capeJoe0-_GXEABOmuTOUzSWXX2vV174n7C3g@mail.gmail.com>
	<511DC675.4050004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:48247 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3BRIqG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 03:46:06 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so5333605obb.28
        for <linux-mmc@vger.kernel.org>; Mon, 18 Feb 2013 00:46:04 -0800 (PST)
In-Reply-To: <511DC675.4050004@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>, Dongjin Kim <tobetter@gmail.com>

>>> On 07/02/2013, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>> Added compatibility string for Exynos4412 SoC.
>>>>
> If using same drv_data, i would prefer to use "&exynos_drv_data" instead of &exynos5250_drv_data.
>
> This patch could be separated into two patches. like this "compatibility for exynos4412 SOC" and "rename the drv_data"

Came across this patch from Dongjin Kim [1] who has already attempetd
the above suggestion. Hence dropping my patch.

Dongjin,
Are you still working on this patch [1] as this has not yet been
accepted or merged?

[1] http://lkml.indiana.edu/hypermail/linux/kernel/1301.3/00450.html

-- 
With warm regards,
Sachin
