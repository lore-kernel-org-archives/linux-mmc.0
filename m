From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] mmc: tmio: bus_shift become tmio_mmc_data member
Date: Tue, 7 Jan 2014 14:40:28 +0100
Message-ID: <201401071440.28355.arnd@arndb.de>
References: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com> <87fvqr8ogb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60111 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaAGNkf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jan 2014 08:40:35 -0500
In-Reply-To: <87fvqr8ogb.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

On Wednesday 20 November 2013, Kuninori Morimoto wrote:
>         const struct mfd_cell *cell = mfd_get_cell(pdev);
>         struct tmio_mmc_data *pdata;
>         struct tmio_mmc_host *host;
> +       struct resource *res;
>         int ret = -EINVAL, irq;
>  
>         if (pdev->num_resources != 2)
> @@ -84,6 +85,13 @@ static int tmio_mmc_probe(struct platform_device *pdev)
>                         goto out;
>         }
>  
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
> +       /* SD control register space size is 0x200, 0x400 for bus_shift=1 */
> +       pdata->bus_shift = resource_size(res_ctl) >> 10;
> +
>         ret = tmio_mmc_host_probe(&host, pdev, pdata);
>         if (ret)
>                 goto cell_disable;

Unfortunately, this has introduced a build error, since you use
an incorrect variable name (res_ctl vs. res) in the last line that
was added.

Please add a fix on top.

	Arnd
