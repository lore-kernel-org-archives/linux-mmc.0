From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: add a quirk for the defferent bit of sdio interrupt
Date: Wed, 29 Oct 2014 21:49:48 -0700
Message-ID: <CAD=FV=VgCjhO5n5VPo_8QmMPBg1ZDMR8nvmVHS=Le8bxEFmzeA@mail.gmail.com>
References: <1414635679-12565-1-git-send-email-addy.ke@rock-chips.com>
	<CAD=FV=Uo3gcnGFn=gpZhV1r+qyZxJ_tpAEiSsu06P=csHTScug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Uo3gcnGFn=gpZhV1r+qyZxJ_tpAEiSsu06P=csHTScug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"open list:ARM/Rockchip SoC..." <linux>
List-Id: linux-mmc@vger.kernel.org

Addy,

On Wed, Oct 29, 2014 at 9:41 PM, Doug Anderson <dianders@chromium.org> wrote:
> You can avoid a lot of "if" tests if you just add a new "sdio->id"

Whoops, I mean "slot->sdio_id"
