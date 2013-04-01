From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] mmc: dwmmc: let device core setup the default pin configuration
Date: Mon, 1 Apr 2013 11:42:31 -0700
Message-ID: <CAD=FV=Vxh9+qpAmoLuALCOZJCLTfga0WdCf=P+heOmbkDY=Aww@mail.gmail.com>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
	<CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
	<CAD=FV=Uy1dQMAxgh_ncxfsQVMDp4Da3inLTvgbJFhyhFLjVWrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:46123 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758094Ab3DASmd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Apr 2013 14:42:33 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so2360485lab.21
        for <linux-mmc@vger.kernel.org>; Mon, 01 Apr 2013 11:42:32 -0700 (PDT)
In-Reply-To: <CAD=FV=Uy1dQMAxgh_ncxfsQVMDp4Da3inLTvgbJFhyhFLjVWrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>, Olof Johansson <olofj@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, patches@linaro.org

Thomas,

On Mon, Mar 25, 2013 at 9:56 AM, Doug Anderson <dianders@google.com> wrote:
> Are you planning on doing this?  I noticed that Chris pulled your
> sdhci-s3c change in recently but apparently skipped this one since it
> had outstanding comments.  Can you address comments and re-send?  This
> is blocking pinmux dts stuff from landing (I think) and that blocks a
> lot of other things from landing.
>
> The comments are pretty trivial, so I could always fix them and
> re-send myself, but it would be better if you could do it...  :)

I didn't hear anything last week and it's getting pretty late in the
process.  I'll post something tomorrow if I don't hear from you...

-Doug
