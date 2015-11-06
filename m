From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH 0/4] mmc: mmc: Improve reliability of HS200/HS400 selection
Date: Fri, 6 Nov 2015 22:02:53 +0530
Message-ID: <CAGOxZ53XOdRJz6eXAjKLh_YMGvRovYXbBUYkbbmNw+cuHkSx6w@mail.gmail.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35287 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbbKFQdd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 11:33:33 -0500
Received: by igpw7 with SMTP id w7so41016226igp.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2015 08:33:33 -0800 (PST)
In-Reply-To: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

Hello Adrian

On Wed, Oct 28, 2015 at 5:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some patches that improve the reliability of selecting
> eMMC HS200 or HS400 mode.
>
> Generally the improvement is to match the host controller timing
> setting with the card mode before sending commands.
>
>
> Adrian Hunter (4):
>       mmc: mmc: Improve reliability of mmc_select_hs200()
>       mmc: mmc: Fix HS setting in mmc_select_hs400()
>       mmc: mmc: Move mmc_switch_status()
>       mmc: mmc: Improve reliability of mmc_select_hs400()
>
>  drivers/mmc/core/mmc.c | 93 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 24 deletions(-)
>
Have tested this series on dw_mmc host controller on exynos5800-peach board.
HS400 and HS200 still works with these patches. Have not done a stress
testing, but looks like across cold/warm reboot and across
suspend/resume cycles, eMMC card still works in hs200/hs400 mode.
Feel free to add:
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>


>
> Regards
> Adrian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
