From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: let device core setup the default pin configuration
Date: Mon, 8 Apr 2013 09:08:30 -0700
Message-ID: <CAD=FV=U7kf_b92w7rDFkZN8Wr4sDTq5_=pMHaP948dT5CZbHsg@mail.gmail.com>
References: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, patches@linaro.org, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

Thomas,

Since I commented on previous versions of this patch, I would have
loved to have been CCed on this new version.  ;)

On Fri, Apr 5, 2013 at 6:53 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> Changes since v2:
> - Changed patch subject from "mmc: dwmmc: let..." to "mmc: dw_mmc: let..."
> - Rebased to Chris's latest mmc-next branch.
>
>  drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
>  drivers/mmc/host/dw_mmc.c        |   12 ++----------
>  drivers/mmc/host/dw_mmc.h        |    3 ---
>  3 files changed, 2 insertions(+), 51 deletions(-)

This patch applies fine but fails to compile on linux-next
"next-20130408".  You lost the race with:
   f2f942c mmc: dw_mmc: Check return value of regulator_enable

...that patch adds a "goto err_setup_bus" and you've renamed that
label.  I guess you get another fun rebase.

NOTE: this patch is even more urgent than it was before.  It looks
like pincontrol stuff has now landed in linux-next which means that
Exynos5 devices that need eMMC/SD will no longer boot until this patch
goes in.

-Doug
