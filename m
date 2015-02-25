From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 1/3] mmc: dw_mmc: update clock after host reach a
 stable voltage
Date: Wed, 25 Feb 2015 13:05:13 -0800
Message-ID: <CAD=FV=WxjQXQpRDNj8pOrcQdAgiQKrJSM1Upf=npjNEpbBLcPg@mail.gmail.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
	<1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
	<1423894668-8886-2-git-send-email-addy.ke@rock-chips.com>
	<CAGOxZ53ndi_hYDGBGhY-7q8aOrFid1=D=_5KEbUvzTsnybJQ3Q@mail.gmail.com>
	<CAD=FV=V9aK-78GJ_eWkpZZdVT_5Zu8ehxg_o3NtnpD2wyRuh7Q@mail.gmail.com>
	<CAGOxZ53vcz96mFbb9ez3GAjZBqEQqiss_TmU1y7EQeRGTVLQdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGOxZ53vcz96mFbb9ez3GAjZBqEQqiss_TmU1y7EQeRGTVLQdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Addy Ke <addy.ke@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, Andrzej Hajda <a.hajda@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Eddie Cai <cf@rock-chips.com>, lintao <lintao@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Alim,

On Tue, Feb 24, 2015 at 11:52 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>> This looks a HACK to me.
>>> If stabilizing host voltage regulator is the problem, can you try out
>>> below patch, and see if this resolve your issue?
>>
>> Actually, IMHO Alim's patch is more of a hack than Addy's.  There's
>> already a 10ms delay between "power up" and "power on" in the MMC core
>> in mmc_power_up() state.  That delay is commented as:
>>
> Well, my suggestion (adding 5ms in switch_volatge) was based on DW_MMC
> databook (V2.41a) section "7.4.1.2 Voltage switch Normal Scenario"
> step #7 which says:" After the 5ms timer expires, the host voltage
> regulator is stable".

So all of that should be handled by the core.  Just reading the DW_MMC
databook can be confusing because they don't differentiate between
what's in the SDMMC spec and what's DW_MMC specific.

Check out mmc_set_signal_voltage(), specifically:

* During a signal voltage level switch, the clock must be gated
* for 5 ms according to the SD spec

-Doug
