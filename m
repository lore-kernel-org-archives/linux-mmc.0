From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] mmc: dwmmc: let device core setup the default pin configuration
Date: Tue, 2 Apr 2013 08:37:35 -0700
Message-ID: <CAD=FV=Xck5XW3LPmvkMfP=dfmnDH+kG4VYkRetW+SJ-bAz7SqQ@mail.gmail.com>
References: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Thomas,

On Mon, Apr 1, 2013 at 11:09 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>

You missed Seungwon's other feedback.  Please change the title from
"mmc: dwmmc: let device core setup the default pin configuration" to
"mmc: dw_mmc: let device core setup the default pin configuration".
He requested that the tag have the underscore in it for consistency.

If you're resending, it also seems like it might be nice to rebase this atop:

0f6e73d mmc: dw_mmc: Add MSHC compatible for Exynos4412

...just to avoid the simple merge conflict when applying?

Otherwise everything here looks great...

-Doug
