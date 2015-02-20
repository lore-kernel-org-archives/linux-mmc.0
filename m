From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 1/3] mmc: dw_mmc: update clock after host reach a
 stable voltage
Date: Fri, 20 Feb 2015 11:05:26 -0800
Message-ID: <CAD=FV=VgvwRvTZrbpMB8EKNNDzUvcCsQKs_uC_RMuc83swu_yA@mail.gmail.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
	<1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
	<1423894668-8886-2-git-send-email-addy.ke@rock-chips.com>
	<CAGOxZ53ndi_hYDGBGhY-7q8aOrFid1=D=_5KEbUvzTsnybJQ3Q@mail.gmail.com>
	<CAD=FV=V9aK-78GJ_eWkpZZdVT_5Zu8ehxg_o3NtnpD2wyRuh7Q@mail.gmail.com>
	<CAD=FV=VSYQs8p9m_+dmXmkMmxgqzDA6EGZ9Vfy3wsby5k5NitQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VSYQs8p9m_+dmXmkMmxgqzDA6EGZ9Vfy3wsby5k5NitQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>, Addy Ke <addy.ke@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, Andrzej Hajda <a.hajda@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Eddie Cai <cf@rock-chips.com>, lintao <lintao@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Feb 19, 2015 at 5:04 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Feb 19, 2015 at 3:49 PM, Doug Anderson <dianders@chromium.org> wrote:
>> I've got that coded up but I'm still testing it...  If you want to try
>> it too, you can find it at
>> <https://chromium-review.googlesource.com/251341>.
>>
>> Note that without my patch I find that I _really_ need Addy's patch to
>> make sure that the card isn't busy in setup_bus.  With my patch Addy's
>> code catches the card busy less often.  I'm still trying to see if
>> there's a way to totally remove the need for his setup_bus and still
>> trying to grok all the patches flying around...
>
> Ah, this might be the magic needed:
>
> https://chromium-review.googlesource.com/251344
>
>
> I think that together with the previous patch things are happy for me
> without any of Addy's patches, though it's the end of my work day and
> I haven't given this nearly as much testing as I'd like.
>
> I'll continue testing tomorrow and then post both patches together upstream.

OK, posted three patches upstream...

A little hard to follow all the patches flying around (so I'll
probably reply a few different places with the same info), but I
believe that all of Addy's patches (with the exception of the one
intended to fix mmc_test which needs to be spun by him for a bugfix)
can be replaced with:

* mmc: dw_mmc: Don't start commands while busy
  https://patchwork.kernel.org/patch/5858221/

* mmc: dw_mmc: Make sure we only adjust the clock when power is on
  https://patchwork.kernel.org/patch/5858261/

* mmc: dw_mmc: Give a good reset after we give power
  https://patchwork.kernel.org/patch/5858281/


In order to avoid further spreading info out among several patches,
I'd request that you don't respond here but instead respond to my
posted patches.  Thanks!

-Doug
