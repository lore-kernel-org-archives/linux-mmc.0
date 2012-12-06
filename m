From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-s3c: Fix compilation warning
Date: Thu, 06 Dec 2012 13:13:57 +0900
Message-ID: <50C01B85.5060502@samsung.com>
References: <1354620787-20575-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39530 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab2LFEOU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Dec 2012 23:14:20 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MEL002GSD3U62L0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Dec 2012 13:14:18 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MEL005NKD3TKCX0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Dec 2012 13:14:18 +0900 (KST)
In-reply-to: <1354620787-20575-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, ben-linux@fluff.org, patches@linaro.org

It looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 12/04/2012 08:33 PM, Sachin Kamat wrote:
> 'sc' is used only when CONFIG_PM_RUNTIME is defined. Hence define it
> conditionally.
>=20
> Silences the following warning:
> drivers/mmc/host/sdhci-s3c.c: In function =E2=80=98sdhci_s3c_notify_c=
hange=E2=80=99:
> drivers/mmc/host/sdhci-s3c.c:378:20: warning: unused variable =E2=80=98=
sc=E2=80=99 [-Wunused-variable]
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 7ea3aea..82a8de1 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -375,7 +375,9 @@ static struct sdhci_ops sdhci_s3c_ops =3D {
>  static void sdhci_s3c_notify_change(struct platform_device *dev, int=
 state)
>  {
>  	struct sdhci_host *host =3D platform_get_drvdata(dev);
> +#ifdef CONFIG_PM_RUNTIME
>  	struct sdhci_s3c *sc =3D sdhci_priv(host);
> +#endif
>  	unsigned long flags;
> =20
>  	if (host) {
>=20

