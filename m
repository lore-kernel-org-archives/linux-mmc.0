From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH -next] mmc: omap_hsmmc: pass IRQF_ONESHOT to request_threaded_irq
Date: Thu, 17 May 2012 19:26:38 +0530
Message-ID: <CANfBPZ__JCHs01yt_AwgqjVXebBCxMiqCyThPf4Rr8MB191h5g@mail.gmail.com>
References: <1337221633-26656-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:54012 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760921Ab2EQN5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 May 2012 09:57:03 -0400
Received: by bkty5 with SMTP id y5so1812695bkt.30
        for <linux-mmc@vger.kernel.org>; Thu, 17 May 2012 06:57:00 -0700 (PDT)
In-Reply-To: <1337221633-26656-1-git-send-email-ming.lei@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

On Thu, May 17, 2012 at 7:57 AM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> The flag of IRQF_ONESHOT should be passed to request_threaded_irq,
> otherwise the following failure message should be dumped because
> hardware handler is defined as NULL:
>
> [ =A0 =A03.383483] genirq: Threaded irq requested with handler=3DNULL=
 and
> !ONESHOT for irq 368
> [ =A0 =A03.392730] omap_hsmmc: probe of omap_hsmmc.0 failed with erro=
r -22
>
> The patch fixes one kernel hang bug which is caused by mmc card
> probe failure and root device can't be brought up.
>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
Right thing to do!
Acked-by: Venkatraman S <svenkatr@ti.com>

> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index ebaf62a..9a7a60a 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1981,7 +1981,7 @@ static int __devinit omap_hsmmc_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D request_threaded_irq(mmc_slot(=
host).card_detect_irq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 omap_hsmmc_detect,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESH=
OT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc_hostname(mmc), host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->=
mmc),
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
