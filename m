From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 3/3] sdhci-pltfm: add call back set_max_speed
Date: Tue, 28 Sep 2010 10:13:12 -0400
Message-ID: <AANLkTim3o03EAidiMikPgjgwmgWKtNJEAqzP7Nt331ad@mail.gmail.com>
References: <AANLkTimNAnA396gofvckwibOfsGb=11jDRzwHKuLUB4W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47539 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab0I1ONN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:13:13 -0400
Received: by iwn5 with SMTP id 5so6020399iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 07:13:12 -0700 (PDT)
In-Reply-To: <AANLkTimNAnA396gofvckwibOfsGb=11jDRzwHKuLUB4W@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Sun, Sep 26, 2010 at 10:59 PM, zhangfei gao <zhangfei.gao@gmail.com>=
 wrote:
> From c75877463fb72e691e1547184f8e2783e5d1fe27 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 27 Sep 2010 10:39:18 -0400
> Subject: [PATCH 3/3] dhci-pltfm: add call back set_max_speed
>
> =A0 =A0 =A0 =A0set_max_speed should be done after add_host to change =
mmc->f_max,
> which set max_clk in add_host by defalut
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci-pltfm.c | =A0 =A03 +++
> =A0include/linux/sdhci-pltfm.h =A0 =A0| =A0 =A01 +
> =A02 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
> index 5c3c513..f25825b 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -123,6 +123,9 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_add_host;
>
> + =A0 =A0 =A0 if (pdata && pdata->set_max_speed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->set_max_speed(host);
> +
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.=
h
> index 0d20cb4..0d8e8f6 100644
> --- a/include/linux/sdhci-pltfm.h
> +++ b/include/linux/sdhci-pltfm.h
> @@ -30,6 +30,7 @@ struct sdhci_pltfm_data {
> =A0 =A0 =A0 =A0unsigned int quirks;
> =A0 =A0 =A0 =A0int (*init)(struct sdhci_host *host, struct sdhci_pltf=
m_data *pdata,
> void* priv_pdata);
> =A0 =A0 =A0 =A0void (*exit)(struct sdhci_host *host);
> + =A0 =A0 =A0 void (*set_max_speed)(struct sdhci_host *host);
> =A0 =A0 =A0 =A0unsigned int =A0(*get_quirk)(struct sdhci_host *host);
> =A0 =A0 =A0 =A0struct sdhci_host *(*alloc_host)(struct device *dev);
> =A0};
> --
> 1.7.0.4
>

Help review, much thanks
