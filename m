From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 0/2] share sdhci-pxa among mmp2, pxa910, pxa168 and pxa955
Date: Tue, 21 Dec 2010 22:14:49 -0500
Message-ID: <AANLkTimT7a1T5tC+mM181ouJV=REhOsn4qEDEEcxHJ8=@mail.gmail.com>
References: <AANLkTim_P3z0dQ1JtNMk1AcE3mhHsy_xOMMmD0rkBC0Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:58509 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab0LVDOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2010 22:14:50 -0500
Received: by fxm18 with SMTP id 18so5122829fxm.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2010 19:14:49 -0800 (PST)
In-Reply-To: <AANLkTim_P3z0dQ1JtNMk1AcE3mhHsy_xOMMmD0rkBC0Y@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, niej0001@gmail.com, Philip Rakity <prakity@marvell.com>, Mark Brown <markb@marvell.com>, xywu@marvell.com, njun@marvell.com, Qiming Wu <wuqm@marvell.com>

On Fri, Dec 3, 2010 at 1:26 AM, zhangfei gao <zhangfei.gao@gmail.com> w=
rote:
> These two patches introduce several call backs, in order to share sdh=
ci-pxa.
>
> patch 1: move sdhci_priv and sdhci_ops definition to
> include/linux/mmc/sdhci.h from drivers/mmc/host/sdhci.h
> 1. platfrom could directly overwrite sdhci_ops with soc specific ops,
> this case occurs at different controller share the same driver, while
> different ops they may use, so move sdhci_ops definition to include
> 2. platform code will use sdhci_priv to access host->private
>
> Patch 2: Introduce several call backs.
> pxa955 may require external gpio to detect card insert and remove.
> soc_set_ops is used to overwrite host ops directly from platfrom ops.
>
> example in board.c
> static unsigned int mmc0_get_ro(struct sdhci_host *host)
> {
> =A0 =A0 =A0 =A0return 0;
> }
>
> static void mmc0_generate_init_clocks_mmp2(struct sdhci_host *host, u=
8
> power_mode)
> {
> =A0 =A0 =A0 =A0struct sdhci_pxa *pxa =3D sdhci_priv(host);
> i =A0 =A0 =A0 /* do something */
> }
>
> static void mmc0_set_ops(struct sdhci_pxa *pxa)
> {
> =A0 =A0 =A0 =A0pxa->ops->get_ro =3D mmc0_get_ro;
> =A0 =A0 =A0 =A0pxa->ops->platform_send_init_74_clocks =3D mmp2_send_i=
nit_74_clocks;
> }
>
> static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 =3D {
> =A0 =A0 =A0 =A0.soc_set_ops =A0 =A0=3D mmc0_set_ops,
> =A0 =A0 =A0 =A0.clk_delay_cycles =A0 =A0 =A0 =3D 0xf,
> =A0 =A0 =A0 =A0.soc_set_timing =3D mmp2_init_sdh,
> };
>

Hi, Chris

What's your suggestion about these two patches,  we already use this
interface locally among mmp2, pxa910 and pxa955.
If no problem, can you help merge these two patches, only with these
patch, we can push machine support to arch/arm.

Thanks
