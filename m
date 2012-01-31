From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-s3c: support the broken voltage.
Date: Tue, 31 Jan 2012 16:02:20 +0530
Message-ID: <CAGxe1ZGDA8ja=rmo+9fbqarDPzUq9g8706tnqRr0dLJN9a1HnA@mail.gmail.com>
References: <4F27907B.10103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64440 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab2AaKcU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 05:32:20 -0500
Received: by vbjk17 with SMTP id k17so16700vbj.19
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2012 02:32:20 -0800 (PST)
In-Reply-To: <4F27907B.10103@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, m.szyprowski@samsung.com

On 31 January 2012 12:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Samsung-SoC need to add the MMC_CAP2_BROKEN_VOLTAGE.
>
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/sdhci-s3c.c | =A0 =A07 +++----
> =A01 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index d065e37..e7e2b6b 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -521,9 +521,12 @@ static int __devinit sdhci_s3c_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0if (pdata->cd_type =3D=3D S3C_SDHCI_CD_PERMANENT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps =3D MMC_CAP_NONREMOVAB=
LE;
>
> + =A0 =A0 =A0 /* It supports additional host capabilities if needed *=
/
> =A0 =A0 =A0 =A0if (pdata->host_caps)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D pdata->host_caps;
>
> + =A0 =A0 =A0 host->mmc->caps2 =3D MMC_CAP2_BROKEN_VOLTAGE;

Dont you think this should be set in the machine specific platform
data structure. If done in the machine specific file
only   if (pdata->host_caps2)
              host->mmc->caps2 |=3D pdata->host_caps2
would be more generic to pull all the caps2 fields

> +
> =A0 =A0 =A0 =A0if (pdata->pm_caps)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->pm_caps |=3D pdata->pm_caps=
;
>
> @@ -543,10 +546,6 @@ static int __devinit sdhci_s3c_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_s3c_ops.get_max_clock =3D sdhci_=
cmu_get_max_clock;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* It supports additional host capabilities if needed *=
/
> - =A0 =A0 =A0 if (pdata->host_caps)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->host_caps;
> -
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "sdhci_add_host() failed\=
n");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
