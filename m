From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Tue, 29 Mar 2016 15:15:25 +0900
Message-ID: <56FA1D7D.1090807@samsung.com>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
 <1457254062-22677-2-git-send-email-guodong.xu@linaro.org>
 <56DC3BAD.8020107@rock-chips.com>
 <CAFGCpxz3GfFeduaz1Dkg0WvRJWs+GHdVu8uY0-wV=RGyRfBE=A@mail.gmail.com>
 <56F9E6E5.9000100@kernel-upstream.org> <56FA192A.9030209@samsung.com>
 <56FA1C1C.4090008@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59273 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcC2GP3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 02:15:29 -0400
In-reply-to: <56FA1C1C.4090008@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Guodong Xu <guodong.xu@linaro.org>
Cc: robh+dt@kernel.org, =?UTF-8?B?UGF3ZcWCIE1vbGw=?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>

On 03/29/2016 03:09 PM, Shawn Lin wrote:
> =E5=9C=A8 2016/3/29 13:56, Jaehoon Chung =E5=86=99=E9=81=93:
>> On 03/29/2016 11:22 AM, Shawn Lin wrote:
>>> =E5=9C=A8 2016/3/25 13:35, Guodong Xu =E5=86=99=E9=81=93:
>>>> Hi, Shawn
>>>>
>>>> Sorry I replied late. I added comments below.
>>>>
>>>> On 6 March 2016 at 22:16, Shawn Lin <shawn.lin@rock-chips.com
>>>> <mailto:shawn.lin@rock-chips.com>> wrote:
>>>>
>>>>      On 2016/3/6 16:47, Guodong Xu wrote:
>>>>
>>>>          mmc registers may in abnormal state if mmc is used in boo=
tloader,
>>>>          eg. to support booting from eMMC. So we need reset mmc re=
gisters
>>>>          when kernel boots up, instead of assuming mmc is in clean=
 state.
>>>>
>>>>          With this patch, user can add a 'resets' property into dw=
_mmc dts
>>>>          node. When driver parse_dt and probe, it calls reset API =
to
>>>>          deassert the 'reset' of dw_mmc host controller. When prob=
e error or
>>>>          remove, it calls reset API to assert it.
>>>>
>>>>          Please also refer to
>>>>          Documentation/devicetree/bindings/reset/reset.txt
>>>>
>>>>          Signed-off-by: Guodong Xu <guodong.xu@linaro.org
>>>>          <mailto:guodong.xu@linaro.org>>
>>>>          Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com
>>>>          <mailto:kong.kongxinwei@hisilicon.com>>
>>>>          Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org
>>>>          <mailto:zhangfei.gao@linaro.org>>
>>>>
>>>>
>>>>      Really should V2 and add the changelog.
>>>>
>>>>
>>>> Yes, will do. next version I sent will be labelled as V3.
>>>>
>>>>
>>>>
>>>>          ---
>>>>             drivers/mmc/host/dw_mmc.c | 22 +++++++++++++++++++++-
>>>>             1 file changed, 21 insertions(+), 1 deletion(-)
>>>>
>>>>          diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host=
/dw_mmc.c
>>>>          index 242f9a0..281ea9c 100644
>>>>          --- a/drivers/mmc/host/dw_mmc.c
>>>>          +++ b/drivers/mmc/host/dw_mmc.c
>>>>          @@ -2878,6 +2878,14 @@ static struct dw_mci_board
>>>>          *dw_mci_parse_dt(struct dw_mci *host)
>>>>                   if (!pdata)
>>>>                           return ERR_PTR(-ENOMEM);
>>>>
>>>>          +       /* find reset controller when exist */
>>>>          +       pdata->rstc =3D devm_reset_control_get_optional(d=
ev, NULL);
>>>>          +       if (IS_ERR(pdata->rstc)) {
>>>>          +               if (PTR_ERR(pdata->rstc) =3D=3D -EPROBE_D=
EFER)
>>>>          +                       return ERR_PTR(-EPROBE_DEFER);
>>>>          +               pdata->rstc =3D NULL;
>>>>
>>>>
>>>>      maybe we can remove "pdata->rstc =3D NULL", and directly
>>>>      use IS_ERR(..) for the following "if (host->pdata->rstc !=3D =
NULL)"
>>>>      statement
>>>>
>>>>
>>>> Yes, will do.
>>>> I see your point, other lines in this file are using IS_ERR(!..), =
I will
>>>> use this style too.
>>>>
>>>>          +       }
>>>>          +
>>>>                   /* find out number of slots supported */
>>>>                   of_property_read_u32(np, "num-slots", &pdata->nu=
m_slots);
>>>>
>>>>          @@ -2949,7 +2957,9 @@ int dw_mci_probe(struct dw_mci *hos=
t)
>>>>
>>>>                   if (!host->pdata) {
>>>>                           host->pdata =3D dw_mci_parse_dt(host);
>>>>          -               if (IS_ERR(host->pdata)) {
>>>>          +               if (PTR_ERR(host->pdata) =3D=3D -EPROBE_D=
EFER)
>>>>          +                       return -EPROBE_DEFER;
>>>>
>>>>
>>>>      please fix the coding style here.
>>>>
>>>>
>>>> Do you mean to add additional {} for this 'if' , like this?
>>>>
>>>>      +               if (PTR_ERR(host->pdata) =3D=3D -EPROBE_DEFER=
) {
>>>>      +                       return -EPROBE_DEFER;
>>>>
>>>>      +                }
>>>>
>>>> I will add {}.
>>>>
>>>>
>>>>
>>>>          +               else if (IS_ERR(host->pdata)) {
>>>>                                   dev_err(host->dev, "platform dat=
a not
>>>>          available\n");
>>>>                                   return -EINVAL;
>>>>                           }
>>>>          @@ -3012,6 +3022,9 @@ int dw_mci_probe(struct dw_mci *hos=
t)
>>>>                           }
>>>>                   }
>>>>
>>>>          +       if (host->pdata->rstc !=3D NULL)
>>>>          +               reset_control_deassert(host->pdata->rstc)=
;
>>>>          +
>>>>
>>>>
>>>>      sorry, I can't follow your intention here. Shouldn't it be so=
mething
>>>>      like "assert mmc -> may need delay -> deassert mmc". As your =
current
>>>>      code, nothing happend right?
>>>>
>>>>
>>>> The chip exits from bootloader with this bit asserted. And when en=
tering
>>>> kernel, we only need to deassert.
>>>>
>>>> In my current code, the driver deassert mmc in _probe(), and asser=
t mmc
>>>> in _remove().
>>>
>>> I catch your point. From the previous discussion, we add it to make=
 sure
>>> dw_mmc in good state after leaving bootloader to kernel. But My rea=
l question is that you can assert it in  bootloader, so you can also
>>> dessert it in bootloaer to make sure dw_mmc work fine when probing
>>> in kernel. In that way, we don't need this patch?
>>
>> Doesn't dw_mci_hw_reset work fine? I think that card should be reset=
 with MMC_CAP_HW_RESET.
>> Could you check this?
>>
>=20
> MMC_CAP_HW_RESET actually reset the mmc card, but Guodong means to
> reset the controller rather than mmc card :)

We have talked about FBE scenarios, right? :)
Now, I remembered it.

>=20
>=20
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> More to think, Is it ok to match the behaviour of bootloader stage?
>>> My bootloader doesn't assert the reset pin of dw_mmc, so it seams i=
f
>>> I want to fix you issue on kernel stage, I need a new round of
>>> assert->delay->deassert.
>>>
>>>
>>>>
>>>>
>>>>
>>>>                   setup_timer(&host->cmd11_timer,
>>>>                               dw_mci_cmd11_timer, (unsigned long)h=
ost);
>>>>
>>>>          @@ -3164,6 +3177,9 @@ err_dmaunmap:
>>>>                   if (host->use_dma && host->dma_ops->exit)
>>>>                           host->dma_ops->exit(host);
>>>>
>>>>          +       if (host->pdata->rstc !=3D NULL)
>>>>          +               reset_control_assert(host->pdata->rstc);
>>>>          +
>>>>             err_clk_ciu:
>>>>                   if (!IS_ERR(host->ciu_clk))
>>>>                           clk_disable_unprepare(host->ciu_clk);
>>>>          @@ -3196,11 +3212,15 @@ void dw_mci_remove(struct dw_mci =
*host)
>>>>                   if (host->use_dma && host->dma_ops->exit)
>>>>                           host->dma_ops->exit(host);
>>>>
>>>>          +       if (host->pdata->rstc !=3D NULL)
>>>>          +               reset_control_assert(host->pdata->rstc);
>>>>          +
>>>>                   if (!IS_ERR(host->ciu_clk))
>>>>                           clk_disable_unprepare(host->ciu_clk);
>>>>
>>>>                   if (!IS_ERR(host->biu_clk))
>>>>                           clk_disable_unprepare(host->biu_clk);
>>>>          +
>>>>             }
>>>>
>>>>
>>>>      unnecessary new line here.
>>>>
>>>>
>>>> Will fix.
>>>>
>>>> -Guodong
>>>>
>>>>
>>>>             EXPORT_SYMBOL(dw_mci_remove);
>>>>
>>>>
>>>>
>>>>
>>>>      --
>>>>      Best Regards
>>>>      Shawn Lin
>>>>
>>>>
>>>
>>>
>>>
>>
>>
>>
>>
>=20
>=20

