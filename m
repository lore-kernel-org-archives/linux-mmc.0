From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Tue, 29 Mar 2016 10:22:29 +0800
Message-ID: <56F9E6E5.9000100@kernel-upstream.org>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
 <1457254062-22677-2-git-send-email-guodong.xu@linaro.org>
 <56DC3BAD.8020107@rock-chips.com>
 <CAFGCpxz3GfFeduaz1Dkg0WvRJWs+GHdVu8uY0-wV=RGyRfBE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mr213138.mail.yeah.net ([223.252.213.138]:52322 "EHLO
	mr213138.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcC2CXA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2016 22:23:00 -0400
In-Reply-To: <CAFGCpxz3GfFeduaz1Dkg0WvRJWs+GHdVu8uY0-wV=RGyRfBE=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: robh+dt@kernel.org, =?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, Kumar Gala <galak@codeaurora.org>, jh80.chung@samsung.com, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>

=E5=9C=A8 2016/3/25 13:35, Guodong Xu =E5=86=99=E9=81=93:
> Hi, Shawn
>
> Sorry I replied late. I added comments below.
>
> On 6 March 2016 at 22:16, Shawn Lin <shawn.lin@rock-chips.com
> <mailto:shawn.lin@rock-chips.com>> wrote:
>
>     On 2016/3/6 16:47, Guodong Xu wrote:
>
>         mmc registers may in abnormal state if mmc is used in bootloa=
der,
>         eg. to support booting from eMMC. So we need reset mmc regist=
ers
>         when kernel boots up, instead of assuming mmc is in clean sta=
te.
>
>         With this patch, user can add a 'resets' property into dw_mmc=
 dts
>         node. When driver parse_dt and probe, it calls reset API to
>         deassert the 'reset' of dw_mmc host controller. When probe er=
ror or
>         remove, it calls reset API to assert it.
>
>         Please also refer to
>         Documentation/devicetree/bindings/reset/reset.txt
>
>         Signed-off-by: Guodong Xu <guodong.xu@linaro.org
>         <mailto:guodong.xu@linaro.org>>
>         Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com
>         <mailto:kong.kongxinwei@hisilicon.com>>
>         Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org
>         <mailto:zhangfei.gao@linaro.org>>
>
>
>     Really should V2 and add the changelog.
>
>
> Yes, will do. next version I sent will be labelled as V3.
>
>
>
>         ---
>            drivers/mmc/host/dw_mmc.c | 22 +++++++++++++++++++++-
>            1 file changed, 21 insertions(+), 1 deletion(-)
>
>         diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_=
mmc.c
>         index 242f9a0..281ea9c 100644
>         --- a/drivers/mmc/host/dw_mmc.c
>         +++ b/drivers/mmc/host/dw_mmc.c
>         @@ -2878,6 +2878,14 @@ static struct dw_mci_board
>         *dw_mci_parse_dt(struct dw_mci *host)
>                  if (!pdata)
>                          return ERR_PTR(-ENOMEM);
>
>         +       /* find reset controller when exist */
>         +       pdata->rstc =3D devm_reset_control_get_optional(dev, =
NULL);
>         +       if (IS_ERR(pdata->rstc)) {
>         +               if (PTR_ERR(pdata->rstc) =3D=3D -EPROBE_DEFER=
)
>         +                       return ERR_PTR(-EPROBE_DEFER);
>         +               pdata->rstc =3D NULL;
>
>
>     maybe we can remove "pdata->rstc =3D NULL", and directly
>     use IS_ERR(..) for the following "if (host->pdata->rstc !=3D NULL=
)"
>     statement
>
>
> Yes, will do.
> I see your point, other lines in this file are using IS_ERR(!..), I w=
ill
> use this style too.
>
>         +       }
>         +
>                  /* find out number of slots supported */
>                  of_property_read_u32(np, "num-slots", &pdata->num_sl=
ots);
>
>         @@ -2949,7 +2957,9 @@ int dw_mci_probe(struct dw_mci *host)
>
>                  if (!host->pdata) {
>                          host->pdata =3D dw_mci_parse_dt(host);
>         -               if (IS_ERR(host->pdata)) {
>         +               if (PTR_ERR(host->pdata) =3D=3D -EPROBE_DEFER=
)
>         +                       return -EPROBE_DEFER;
>
>
>     please fix the coding style here.
>
>
> Do you mean to add additional {} for this 'if' , like this?
>
>     +               if (PTR_ERR(host->pdata) =3D=3D -EPROBE_DEFER) {
>     +                       return -EPROBE_DEFER;
>
>     +                }
>
> I will add {}.
>
>
>
>         +               else if (IS_ERR(host->pdata)) {
>                                  dev_err(host->dev, "platform data no=
t
>         available\n");
>                                  return -EINVAL;
>                          }
>         @@ -3012,6 +3022,9 @@ int dw_mci_probe(struct dw_mci *host)
>                          }
>                  }
>
>         +       if (host->pdata->rstc !=3D NULL)
>         +               reset_control_deassert(host->pdata->rstc);
>         +
>
>
>     sorry, I can't follow your intention here. Shouldn't it be someth=
ing
>     like "assert mmc -> may need delay -> deassert mmc". As your curr=
ent
>     code, nothing happend right?
>
>
> The chip exits from bootloader with this bit asserted. And when enter=
ing
> kernel, we only need to deassert.
>
> In my current code, the driver deassert mmc in _probe(), and assert m=
mc
> in _remove().

I catch your point. From the previous discussion, we add it to make sur=
e
dw_mmc in good state after leaving bootloader to kernel. But My real=20
question is that you can assert it in  bootloader, so you can also
dessert it in bootloaer to make sure dw_mmc work fine when probing
in kernel. In that way, we don't need this patch?

More to think, Is it ok to match the behaviour of bootloader stage?
My bootloader doesn't assert the reset pin of dw_mmc, so it seams if
I want to fix you issue on kernel stage, I need a new round of
assert->delay->deassert.


>
>
>
>                  setup_timer(&host->cmd11_timer,
>                              dw_mci_cmd11_timer, (unsigned long)host)=
;
>
>         @@ -3164,6 +3177,9 @@ err_dmaunmap:
>                  if (host->use_dma && host->dma_ops->exit)
>                          host->dma_ops->exit(host);
>
>         +       if (host->pdata->rstc !=3D NULL)
>         +               reset_control_assert(host->pdata->rstc);
>         +
>            err_clk_ciu:
>                  if (!IS_ERR(host->ciu_clk))
>                          clk_disable_unprepare(host->ciu_clk);
>         @@ -3196,11 +3212,15 @@ void dw_mci_remove(struct dw_mci *hos=
t)
>                  if (host->use_dma && host->dma_ops->exit)
>                          host->dma_ops->exit(host);
>
>         +       if (host->pdata->rstc !=3D NULL)
>         +               reset_control_assert(host->pdata->rstc);
>         +
>                  if (!IS_ERR(host->ciu_clk))
>                          clk_disable_unprepare(host->ciu_clk);
>
>                  if (!IS_ERR(host->biu_clk))
>                          clk_disable_unprepare(host->biu_clk);
>         +
>            }
>
>
>     unnecessary new line here.
>
>
> Will fix.
>
> -Guodong
>
>
>            EXPORT_SYMBOL(dw_mci_remove);
>
>
>
>
>     --
>     Best Regards
>     Shawn Lin
>
>

