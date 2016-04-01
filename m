From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Fri, 01 Apr 2016 20:42 +0200
Message-ID: <1754831.FONmYVUinF@phil>
References: <1459322696-29919-1-git-send-email-guodong.xu@linaro.org> <1459322696-29919-3-git-send-email-guodong.xu@linaro.org> <56FBBB2F.5030308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FBBB2F.5030308@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Guodong Xu <guodong.xu@linaro.org>, shawn.lin@rock-chips.com, "robh+dt@kernel.org" <robh+dt@kernel.org>, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Am Mittwoch, 30. M=E4rz 2016, 20:40:31 schrieb Jaehoon Chung:
> modified Rob's mail address.
>=20
> On 03/30/2016 04:24 PM, Guodong Xu wrote:
> > mmc registers may in abnormal state if mmc is used in bootloader,
> > eg. to support booting from eMMC. So we need reset mmc registers
> > when kernel boots up, instead of assuming mmc is in clean state.
>=20
> Do you mean mmc(card side) register or dwmmc host controller's regist=
er on
> host side?
>=20
> According to dwmmc controller TMR, there are two reset signals. One i=
s
> reset_n, other is rst_n. It seems this patch is relevant to reset_n(F=
or
> host). (rst_n is hardware reset for card.)
>=20
> So could you clarify better? Then it's helpful to me for understandin=
g..

I think that actually means a reset of controller IP block logic, outsi=
de=20
the control of the dw_mmc block itself.

On Rockchip SoCs this gets triggered from the CRU (clock and reset unit=
), so=20
I guess if I'm reading the manual correctly, should be the reset_n sign=
al of=20
the ip block.

rst_n on the other hand gets triggered through a dw_mmc register settin=
g and=20
is already handled by the dw_mmc driver.


Heiko
