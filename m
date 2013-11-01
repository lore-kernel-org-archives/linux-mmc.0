From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Fri, 01 Nov 2013 17:21:00 +0900
Message-ID: <001b01ced6db$4c31d840$e49588c0$%jun@samsung.com>
References: <1382339639-16764-3-git-send-email-zhangfei.gao@linaro.org>
 <1382533396-6584-1-git-send-email-zhangfei.gao@linaro.org>
 <001401ced6cb$04e2a330$0ea7e990$%jun@samsung.com>
 <CAMj5BkgHE6FwBv6hUi8Mth1Ox40ed2sot4p9LQBxOToN=Fu7Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:24301 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab3KAIVD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Nov 2013 04:21:03 -0400
In-reply-to: <CAMj5BkgHE6FwBv6hUi8Mth1Ox40ed2sot4p9LQBxOToN=Fu7Qg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'zhangfei gao' <zhangfei.gao@gmail.com>
Cc: 'Zhangfei Gao' <zhangfei.gao@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, 'linux-arm-kernel' <linux-arm-kernel@lists.infradead.org>

On Fri, November 01, 2013, zhangfei gao wrote:
> Dear Seungwon
> 
> Thanks for giving suggestion.
> 
> On Thu, Oct 31, 2013 at 11:24 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Hi Zhangfei,
> 
> >> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >> +{
> >> +     struct dw_mci_k3_priv_data *priv = host->priv;
> >> +
> >> +     if (priv->type == DW_MCI_TYPE_HI4511)
> > There are several checking controller type.
> > But now DW_MCI_TYPE_HI4511 is just introduced alone.
> > It seems like unnecessary.
> 
> Yes, currently only K3V2 is added, and k3v3 code will be added soon.
> Do you think type is more suitable to add later?
Yes, it would be better.

> 
> >> +static int dw_mci_k3_parse_dt(struct dw_mci *host)
> >> +{
> >> +     struct dw_mci_k3_priv_data *priv = host->priv;
> >> +     struct device_node *np = host->dev->of_node;
> >> +     u32 data[3];
> >> +     int ret;
> >> +
> >> +     if (priv->type == DW_MCI_TYPE_HI4511) {
> > Didn't you see Kernel panic here?
> > host->priv is not allocated yet, it's a invalid pointer dereference.
> > dw_mci_k3_parse_dt() is called prior to dw_mci_k3_priv_init().
> > You can check dw_mci_probe() sequence.
> 
> It is no problem here
> dw_mci_pltfm_register -> drv_data->init(host) -> dw_mci_probe -> dw_mci_parse_dt
I guess your base is not latest.
Can you check cjb's tree?

> 
> >
> >> +             ret = of_property_read_u32_array(np,
> >> +                             "clken-reg", data, 2);
> >> +             if (!ret) {
> >> +                     priv->clken_reg = data[0];
> >> +                     priv->clken_bit = data[1];
> >> +             }
> >> +
> >> +             ret = of_property_read_u32_array(np,
> >> +                             "drv-sel-reg", data, 3);
> >> +             if (!ret) {
> >> +                     priv->drv_reg = data[0];
> >> +                     priv->drv_off = data[1];
> >> +                     priv->drv_bits = data[2];
> >> +             }
> >> +
> >> +             ret = of_property_read_u32_array(np,
> >> +                             "sam-sel-reg", data, 3);
> >> +             if (!ret) {
> >> +                     priv->sam_reg = data[0];
> >> +                     priv->sam_off = data[1];
> >> +                     priv->sam_bits = data[2];
> >> +             }
> >> +
> >> +             ret = of_property_read_u32_array(np,
> >> +                             "div-reg", data, 3);
> >> +             if (!ret) {
> >> +                     priv->div_reg = data[0];
> >> +                     priv->div_off = data[1];
> >> +                     priv->div_bits = data[2];
> >> +             }
> > Should these register information be got from dt?
> > It could be define in source code instead.
> 
> There are many register from pctrl node instead of mmc controller.
> If set in code, we may read id and then switch id, set register, start
> bit, bits number,
> which is no rules for different controller, using defiine is not helpful.
> for example:
>  switch (idx) {
>         case 0:
>                 clken_reg = 0x1F8;
>                 clken_bit = 0;
>                 drv_sel_reg = 0x1F8;
>                 drv_sel_bit = 4;
>                 sam_sel_reg = 0x1F8;
>                 sam_sel_bit = 8;
>                 div_reg = 0x1F8;
>                 div_bit = 1;
>                 break;
>         case 1:
>                 clken_reg = 0x1F8;
>                 clken_bit = 12;
>                 drv_sel_reg = 0x1F8;
>                 drv_sel_bit = 16;
>                 sam_sel_reg = 0x1F8;
>                 sam_sel_bit = 20;
>                 div_reg = 0x1F8;
>                 div_bit = 13;
>                 break;
>         case 2:
>                 clken_reg = 0x1F8;
>                 clken_bit = 24;
>                 drv_sel_reg = 0x1F8;
>                 drv_sel_bit = 28;
>                 sam_sel_reg = 0x1FC;
>                 sam_sel_bit = 0;
>                 div_reg = 0x1F8;
>                 div_bit = 25;
>                 break;
> 
> So define register offset, start bit and bits number in dts make it simplier.
> Is this acceptable?
It's up to you. I think there will be better ways.
For example, some table for variable register can be used for each controller type.
Additionally, if you intend to use dt, error handling is needed.
dw_mci_k3_parse_dt always returns success although of_property_read_u32_array is failed.

Thanks,
Seungwon Jeon

