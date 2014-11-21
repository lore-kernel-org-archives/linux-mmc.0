From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for vqmmc
Date: Fri, 21 Nov 2014 09:42:08 -0800
Message-ID: <CAD=FV=Ve1TY4+8quq1=18A1YOFvOWuFGrBmHLwMCwdWBSqzxOw@mail.gmail.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
	<1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>
	<CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
	<CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>
	<5464152E.7040209@rock-chips.com>
	<CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: addy ke <addy.ke@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, open list:A
List-Id: linux-mmc@vger.kernel.org

Ulf,

On Fri, Nov 21, 2014 at 4:06 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>> Sure
>> If the first card is sd2.0 since startup, dw_mci_switch_voltage will not be called,
>
> That can't be right. mmc_power_up() should trigger
> dw_mci_switch_voltage() to be invoked.

Hmmm, I think you're right.  Addy: can you double check if it's only
the 2nd card for you?  I was thinking that if a regulator is currently
3.3V and you request 2.7 - 3.3V the regulator framework will treat
that as a noop.  ...but that definitely doesn't appear to be the case.
When I boot up the first time even with no SD card plugged in, I see
this at bootup:

[    3.042234] vccio_sd: 1800 <--> 3300 mV at 3300 mV

...showing that it started at 3.3V.  Then I see:

$ grep "" /sys/class/regulator/regulator.16/{name,microvolts}
/sys/class/regulator/regulator.16/name:vccio_sd
/sys/class/regulator/regulator.16/microvolts:2700000

...so it is certainly getting changed even with no card plugged in.


BTW: I don't actually have one of these failing cards--all of mine
work.  Addy, do you know the make and model of the card you have that
fails?


-Doug
