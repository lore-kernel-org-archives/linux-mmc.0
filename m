From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] mmc: dwmmc: let device core setup the default pin configuration
Date: Mon, 11 Mar 2013 10:53:19 -0700
Message-ID: <CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:52688 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3CKRxV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Mar 2013 13:53:21 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so4164628lab.5
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 10:53:19 -0700 (PDT)
In-Reply-To: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, patches@linaro.org

Thomas,

On Wed, Mar 6, 2013 at 4:04 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
>  1 files changed, 0 insertions(+), 38 deletions(-)

It would be good to address Seungwon Jeon's comments (change prefix to
dw_mmc and remove setup_bus), but in general this looks good to me,
so...

With <https://patchwork.kernel.org/patch/2225151/> on exynos5250-snow
(ARM Chromebook):

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>


-Doug
