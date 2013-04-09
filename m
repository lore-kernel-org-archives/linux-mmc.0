From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v3] mmc: dw_mmc: let device core setup the default pin configuration
Date: Tue, 9 Apr 2013 11:38:27 +0530
Message-ID: <CAJuYYwTAUnjwGsxfHho2jQXvkQfV2Kcvx-QfqCDqq7D7Fu0x7g@mail.gmail.com>
References: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
	<CAD=FV=U7kf_b92w7rDFkZN8Wr4sDTq5_=pMHaP948dT5CZbHsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:33359 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934416Ab3DIGI1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Apr 2013 02:08:27 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so2284896iah.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2013 23:08:27 -0700 (PDT)
In-Reply-To: <CAD=FV=U7kf_b92w7rDFkZN8Wr4sDTq5_=pMHaP948dT5CZbHsg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Patch Tracking <patches@linaro.org>, Olof Johansson <olof@lixom.net>

On 8 April 2013 21:38, Doug Anderson <dianders@google.com> wrote:
> Thomas,
>
> Since I commented on previous versions of this patch, I would have
> loved to have been CCed on this new version.  ;)

Hi Doug,

Sorry for missing out on CC'ing you in the v3 patch. It just slipped my mind.

>
> On Fri, Apr 5, 2013 at 6:53 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> With device core now able to setup the default pin configuration,
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> Changes since v2:
>> - Changed patch subject from "mmc: dwmmc: let..." to "mmc: dw_mmc: let..."
>> - Rebased to Chris's latest mmc-next branch.
>>
>>  drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
>>  drivers/mmc/host/dw_mmc.c        |   12 ++----------
>>  drivers/mmc/host/dw_mmc.h        |    3 ---
>>  3 files changed, 2 insertions(+), 51 deletions(-)
>
> This patch applies fine but fails to compile on linux-next
> "next-20130408".  You lost the race with:
>    f2f942c mmc: dw_mmc: Check return value of regulator_enable
>
> ...that patch adds a "goto err_setup_bus" and you've renamed that
> label.  I guess you get another fun rebase.
>
> NOTE: this patch is even more urgent than it was before.  It looks
> like pincontrol stuff has now landed in linux-next which means that
> Exynos5 devices that need eMMC/SD will no longer boot until this patch
> goes in.

Ok. I have posted the v4 version of this patch taking care of this.
Thanks for pointing this out.

Regards,
Thomas.

>
> -Doug
