From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Mon, 04 Apr 2016 12:54:03 +0900
Message-ID: <5701E55B.1080503@samsung.com>
References: <1459322696-29919-1-git-send-email-guodong.xu@linaro.org>
 <1459322696-29919-3-git-send-email-guodong.xu@linaro.org>
 <56FBBB2F.5030308@samsung.com> <1754831.FONmYVUinF@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50391 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbcDDDyG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Apr 2016 23:54:06 -0400
In-reply-to: <1754831.FONmYVUinF@phil>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Guodong Xu <guodong.xu@linaro.org>, shawn.lin@rock-chips.com, "robh+dt@kernel.org" <robh+dt@kernel.org>, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 04/02/2016 03:42 AM, Heiko Stuebner wrote:
> Am Mittwoch, 30. M=E4rz 2016, 20:40:31 schrieb Jaehoon Chung:
>> modified Rob's mail address.
>>
>> On 03/30/2016 04:24 PM, Guodong Xu wrote:
>>> mmc registers may in abnormal state if mmc is used in bootloader,
>>> eg. to support booting from eMMC. So we need reset mmc registers
>>> when kernel boots up, instead of assuming mmc is in clean state.
>>
>> Do you mean mmc(card side) register or dwmmc host controller's regis=
ter on
>> host side?
>>
>> According to dwmmc controller TMR, there are two reset signals. One =
is
>> reset_n, other is rst_n. It seems this patch is relevant to reset_n(=
=46or
>> host). (rst_n is hardware reset for card.)
>>
>> So could you clarify better? Then it's helpful to me for understandi=
ng..
>=20
> I think that actually means a reset of controller IP block logic, out=
side=20
> the control of the dw_mmc block itself.
>=20
> On Rockchip SoCs this gets triggered from the CRU (clock and reset un=
it), so=20
> I guess if I'm reading the manual correctly, should be the reset_n si=
gnal of=20
> the ip block.
>=20
> rst_n on the other hand gets triggered through a dw_mmc register sett=
ing and=20
> is already handled by the dw_mmc driver.

Right, this patch is for reset_n signal. I didn't have seen the SoC tha=
t reset_n is designed.
(Or i didn't realize...)
If Rockchip is used from CRU (clock and reset unit), then i think that =
it makes sense.

Thanks for explanation.=20

Best Regards,
Jaehoon Chung

>=20
>=20
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

