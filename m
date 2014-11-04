From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
Date: Tue, 04 Nov 2014 11:15:54 +0900
Message-ID: <545836DA.90905@samsung.com>
References: <1414666240-16782-1-git-send-email-addy.ke@rock-chips.com>
 <1414977633-3196-1-git-send-email-addy.ke@rock-chips.com>
 <5457440E.3070002@samsung.com> <3540679.aQ4QUeBEJd@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43822 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaKDCP5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Nov 2014 21:15:57 -0500
In-reply-to: <3540679.aQ4QUeBEJd@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Addy Ke <addy.ke@rock-chips.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, huangtao@rock-chips.com, devicetree@vger.kernel.org, hl@rock-chips.com, linux-doc@vger.kernel.org, yzq@rock-chips.com, zyw@rock-chips.com, zhangqing@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, lintao@rock-chips.com, linux-rockchip@lists.infradead.org, xjq@rock-chips.com, zhenfu.fang@rock-chips.com, chenfen@rock-chips.com, cf@rock-chips.com, hj@rock-chips.com, linux-arm-kernel@lists.infradead.org, zyf@rock-chips.com

Dear Heiko.

On 11/03/2014 07:23 PM, Heiko St=FCbner wrote:
> Hi Jaehoon,
>=20
> Am Montag, 3. November 2014, 17:59:58 schrieb Jaehoon Chung:
>> Hi, Addy.
>>
>> On 11/03/2014 10:20 AM, Addy Ke wrote:
>>> The bit of sdio interrupt is 16 in designware implementation,
>>> but it is 24 on Rockchip SoCs.This patch add sdio_id0 for the
>>> number of slot0 in the SDIO interrupt registers.
>>>
>>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>>> ---
>>> Changes in v2:
>>> - rebase on http://git.linaro.org/git/people/ulf.hansson/mmc.git, n=
ext
>>> branch Changes in v3:
>>> - Remove dts for sdio_id0, just replace this with 8, suggested by D=
oug
>>> - Change to support all Rockchip Socs, suggested by Heiko
>>>
>>>  drivers/mmc/host/dw_mmc-rockchip.c | 10 ++++++++++
>>>  drivers/mmc/host/dw_mmc.c          | 12 +++++++-----
>>>  drivers/mmc/host/dw_mmc.h          |  2 ++
>>>  include/linux/mmc/dw_mmc.h         |  3 +++
>>>  4 files changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
>>> b/drivers/mmc/host/dw_mmc-rockchip.c index bbb4ec3..b997c8f 100644
>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>>> @@ -68,14 +68,24 @@ static void dw_mci_rk3288_set_ios(struct dw_mci=
 *host,
>>> struct mmc_ios *ios)>=20
>>>  	}
>>> =20
>>>  }
>>>
>>> +static int dw_mci_rockchip_parse_dt(struct dw_mci *host)
>>> +{
>>> +	/* It is slot 8 on Rockchip SoCs */
>>> +	host->sdio_id0 =3D 8;
>>> +
>>> +	return 0;
>>> +}
>>
>> Well, function is "__parse_dt__", but this function don't parse anyt=
hing.
>> If All rockchip soc is supported, i think that it can be located to =
other
>> place.
>=20
> do you have a suggestion for a location?
>=20
> The only alternative I can see right now would be using the init-hook=
 in=20
> dw_mci_drv_data or adding a new field to it holding the slot-offset.
> [with using the init-hook being my personal preference of the two]

init-hook can be used, then, in future, it can also included other spec=
ific code for rock-chip.

Best Regards,
Jaehoon Chung
>=20
>=20
> Heiko
>=20

