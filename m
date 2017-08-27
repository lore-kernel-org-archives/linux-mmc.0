From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Date: Sun, 27 Aug 2017 21:10:02 +0800
Message-ID: <CAGb2v647hP6Ytm+bqNiuA+eMUU5WQrF36mFpVaagLgKZbuQrWQ@mail.gmail.com>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com> <884514a2d304315f54dc81b8b42aea74@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <884514a2d304315f54dc81b8b42aea74@aosc.io>
Sender: linux-clk-owner@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, Aug 27, 2017 at 9:01 PM,  <icenowy@aosc.io> wrote:
> 在 2017-08-25 17:49，Maxime Ripard 写道：
>>
>> The reset hook was left implemented. Provide a dumb implementation so that
>> client drivers can depend on it.
>
>
> I think some clients should also convert to use this.
>
> For example:
>
> - The TCON driver in sun4i-drm. (It now uses reset_control_status, but
>   this is also not implemented in CCU.)

I have patches for both sides of this.

> - The EPHY in dwmac-sun8i driver. (It uses explicit assert then deassert)
>
> P.S. maybe the status hook should also be implemented?

Yes.

ChenYu
