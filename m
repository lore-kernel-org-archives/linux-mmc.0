From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 0/3] about data busy
Date: Mon, 16 Feb 2015 12:09:43 +0100
Message-ID: <CABxcv=mHAJLviM1ACJKW3cH2JgtuCVp6-54bORaWY=dw4hP-oA@mail.gmail.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
	<1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
	<CABxcv==G_sKsvWHX6rJP7EUv8jE=01k-JeGGXgiwiCN53pxdmQ@mail.gmail.com>
	<54E184B6.90808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:43847 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513AbbBPLJo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Feb 2015 06:09:44 -0500
Received: by mail-wi0-f171.google.com with SMTP id hi2so25187407wib.4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2015 03:09:43 -0800 (PST)
In-Reply-To: <54E184B6.90808@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Addy Ke <addy.ke@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, Alim Akhtar <alim.akhtar@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org

Hello Jaehoon,

On Mon, Feb 16, 2015 at 6:48 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/15/2015 08:41 PM, Javier Martinez Canillas wrote:
>> I modified [1] your patch #2 to do what Alim suggested and only with
>> that patch on top of linux-next I have neither the the "Timeout
>> sending command" error nor the uSD not getting detected errors. Linux
>> mounts the rootfs from the uSD and the wifi SDIO device is enumerated
>> and listed in /sys/bus/sdio/devices/
>
> it needs to check when clock value only update.
> As Javier and Alim are mentioned, if check whether card is busy or not in setup_bus(),
> should be processed unnecessary checking.
> (According to TRM, before disabling clock, check whether card is busy or not.)
> if my thinking is right, chekcing is located more exactly before mci_writel(host, CLKENA, 0).
>
> And i recommend if CLK_GATE is enabled, clkgate_delay sets to the bigger value than 3.
> I'm not sure Javier's issue is same thing..I will check more this.
>

Thanks for checking, do you have access to a Peach Pit or Pi
Chromebook to reproduce the issue I reported? Please let me know if
you need any help from me.

> Best Regards,
> Jaehoon Chung
>

Best regards,
Javier
