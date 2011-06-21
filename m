From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and post_req
Date: Tue, 21 Jun 2011 11:11:50 +0530
Message-ID: <BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org> <1308518257-9783-3-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47767 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1FUFmK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 01:42:10 -0400
Received: by yxi11 with SMTP id 11so2378513yxi.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 22:42:10 -0700 (PDT)
In-Reply-To: <1308518257-9783-3-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

<snip>

> +
> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_requ=
est *mrq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool is_=
first_req)

I don't see the usage of "is_first_req" below.
Is it required?

> +{
> + =A0 =A0 =A0 struct omap_hsmmc_host *host =3D mmc_priv(mmc);
> +
> + =A0 =A0 =A0 if (mrq->data->host_cookie) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->data->host_cookie =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (host->use_dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_hsmmc_pre_dma_transfer(host, m=
rq->data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &host->next_data))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->data->host_cookie =
=3D 0;
> +}
> +
> =A0/*

Regards,
Kishore
