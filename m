From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] dw-mmc controller fixes
Date: Fri, 20 Jan 2017 09:38:13 +0100
Message-ID: <CAPDyKFpDB7_taAw=DoR8GicK19433O82Ho3Vb6xFoUNK7eZ0fg@mail.gmail.com>
References: <CGME20170120082622epcas5p2e3db3b067b3a1cce2e30f074175cb469@epcas5p2.samsung.com>
 <4082c88e-de72-9e18-7b9a-c37551bda610@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37155 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdATIiQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 03:38:16 -0500
Received: by mail-wm0-f54.google.com with SMTP id c206so32618802wme.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2017 00:38:15 -0800 (PST)
In-Reply-To: <4082c88e-de72-9e18-7b9a-c37551bda610@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 20 January 2017 at 09:26, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull this patch on your fixes branch?
>
> The following changes since commit ee6ff743e3a4b697e8286054667d7e4e1b56510d:
>
>   mmc: core: Restore parts of the polling policy when switch to HS/HS DDR (2017-01-16 16:17:42 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git fixes
>
> for you to fetch changes up to c9ea1acefff02aeb080b427d79cedeb446b28317:
>
>   mmc: dw_mmc: force setup bus if active slots exist (2017-01-20 17:17:43 +0900)
>
> ----------------------------------------------------------------
> Ziyuan Xu (1):
>       mmc: dw_mmc: force setup bus if active slots exist
>
>  drivers/mmc/host/dw_mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Thanks Jaehoon, pulled into fixes!

Kind regards
Uffe
