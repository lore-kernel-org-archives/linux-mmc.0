From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v4 03/12] omap_hsmmc: add support for pre_req and post_req
Date: Thu, 16 Jun 2011 18:44:47 +0530
Message-ID: <BANLkTikP8pveKPPG+_h6_hBenh91vAi4mQ@mail.gmail.com>
References: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
	<1306360653-6196-4-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50445 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751892Ab1FPNOt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2011 09:14:49 -0400
In-Reply-To: <1306360653-6196-4-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linaro-dev <linaro-dev@lists.linaro.org>, David Vrabel <david.vrabel@csr.com>

On Thu, May 26, 2011 at 3:27 AM, Per Forlin <per.forlin@linaro.org> wro=
te:
> pre_req() runs dma_map_sg(), post_req() runs dma_unmap_sg.
> If not calling pre_req() before omap_hsmmc_request()
> dma_map_sg will be issued before starting the transfer.
> It is optional to use pre_req(). If issuing pre_req()
> post_req() must be to be called as well.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 87 +++++++++++++++++++++++++++=
++++++++++++--
> =A01 files changed, 83 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index ad3731a..2116c09 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -141,6 +141,11 @@
> =A0#define OMAP_HSMMC_WRITE(base, reg, val) \
> =A0 =A0 =A0 =A0__raw_writel((val), (base) + OMAP_HSMMC_##reg)
>
> +struct omap_hsmmc_next {
> + =A0 =A0 =A0 unsigned int =A0 =A0dma_len;
> + =A0 =A0 =A0 s32 =A0 =A0 =A0 =A0 =A0 =A0 cookie;
> +};
> +
> =A0struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0struct =A0device =A0 =A0 =A0 =A0 =A0*dev;
> =A0 =A0 =A0 =A0struct =A0mmc_host =A0 =A0 =A0 =A0*mmc;
> @@ -184,6 +189,7 @@ struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs_block=
ed;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_reg;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_in_pro=
gress;
> + =A0 =A0 =A0 struct omap_hsmmc_next =A0next_data;
>
> =A0 =A0 =A0 =A0struct =A0omap_mmc_platform_data =A0*pdata;
> =A0};
> @@ -1344,8 +1350,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_s=
tatus, void *cb_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_dir(host, data));
> + =A0 =A0 =A0 if (!data->host_cookie)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->=
sg, data->sg_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_g=
et_dma_dir(host, data));
>
> =A0 =A0 =A0 =A0req_in_progress =3D host->req_in_progress;
> =A0 =A0 =A0 =A0dma_ch =3D host->dma_ch;
> @@ -1363,6 +1370,45 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_=
status, void *cb_data)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mmc_data *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct omap_hsmmc_next *next)
> +{

As you are passing &host->next_data into next, next will always be a
valid pointer. So..

> + =A0 =A0 =A0 int dma_len;
> +
> + =A0 =A0 =A0 if (!next && data->host_cookie &&
> + =A0 =A0 =A0 =A0 =A0 data->host_cookie !=3D host->next_data.cookie) =
{

!next will always return false and hence the rest of the check will
never be executed.
Perhaps s/&&/||/g ?


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "[%s] invalid cooki=
e: data->host_cookie %d"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" host->next_data.cookie=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, data->host_coo=
kie, host->next_data.cookie);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Check if next job is already prepared */
> + =A0 =A0 =A0 if (next ||
> + =A0 =A0 =A0 =A0 =A0 (!next && data->host_cookie !=3D host->next_dat=
a.cookie)) {

Cookie matching will never be checked..

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_len =3D dma_map_sg(mmc_dev(host->mm=
c), data->sg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0data->sg_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0omap_hsmmc_get_dma_dir(host, data));
> +
> + =A0 =A0 =A0 } else {

and this will never be executed as well?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_len =3D host->next_data.dma_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->next_data.dma_len =3D 0;
> + =A0 =A0 =A0 }
> +
> +
> + =A0 =A0 =A0 if (dma_len =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (next) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next->dma_len =3D dma_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D ++next->cookie < =
0 ? 1 : next->cookie;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_len =3D dma_len;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
