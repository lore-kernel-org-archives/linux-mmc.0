From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] mmc: dwmmc: let device core setup the default pin configuration
Date: Mon, 25 Mar 2013 09:56:25 -0700
Message-ID: <CAD=FV=Uy1dQMAxgh_ncxfsQVMDp4Da3inLTvgbJFhyhFLjVWrg@mail.gmail.com>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
	<CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Thomas,

On Mon, Mar 11, 2013 at 10:53 AM, Doug Anderson <dianders@google.com> wrote:
> It would be good to address Seungwon Jeon's comments (change prefix to
> dw_mmc and remove setup_bus), but in general this looks good to me,
> so...

Are you planning on doing this?  I noticed that Chris pulled your
sdhci-s3c change in recently but apparently skipped this one since it
had outstanding comments.  Can you address comments and re-send?  This
is blocking pinmux dts stuff from landing (I think) and that blocks a
lot of other things from landing.

The comments are pretty trivial, so I could always fix them and
re-send myself, but it would be better if you could do it...  :)

-Doug
