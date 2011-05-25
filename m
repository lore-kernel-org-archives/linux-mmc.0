From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: SDHCI Auto-CMD23 fixes.
Date: Wed, 25 May 2011 01:47:40 -0500
Message-ID: <BANLkTikD4D4W0xTi=wbP0Qx3D8oZi2pzoA@mail.gmail.com>
References: <m3aaeby3xr.fsf@pullcord.laptop.org>
	<1306307623-8610-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:37295 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1EYGrn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 02:47:43 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4P6jIqS015259
	for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 02:45:18 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4P6iXjr014674
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 02:45:17 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so7903866wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2011 23:47:40 -0700 (PDT)
In-Reply-To: <1306307623-8610-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>

Chris,

On Wed, May 25, 2011 at 2:13 AM, Andrei Warkentin <andreiw@motorola.com=
> wrote:
> Fixes bugs in Auto-CMD23 feature enable decision. Auto-CMD23
> shoud be enabled if host is >=3D v3, and SDMA is not in use.
>
> USE_ADMA | USE_SDMA | Auto-CMD23
> ---------+----------+-----------
> =A0 =A00 =A0 =A0| =A0 =A00 =A0 =A0 | =A0 =A0 1
> ---------+----------+-----------
> =A0 =A00 =A0 =A0| =A0 =A01 =A0 =A0 | =A0 =A0 0
> ---------+----------+-----------
> =A0 =A01 =A0 =A0| =A0 =A00 =A0 =A0 | =A0 =A0 1
> ---------+----------+-----------
> =A0 =A01 =A0 =A0| =A0 =A01 =A0 =A0 | =A0 =A0 1
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fbb1842..a4e64b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2498,9 +2498,9 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_AUTO_CMD12;
>
> =A0 =A0 =A0 =A0/* Auto-CMD23 stuff only works in ADMA or PIO. */
> - =A0 =A0 =A0 if ((host->version =3D=3D SDHCI_SPEC_300) &&
> + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_300) &&
> =A0 =A0 =A0 =A0 =A0 =A0((host->flags & SDHCI_USE_ADMA) ||
> - =A0 =A0 =A0 =A0 =A0 =A0!(host->flags & SDHCI_REQ_USE_DMA))) {
> + =A0 =A0 =A0 =A0 =A0 =A0!(host->flags & SDHCI_USE_SDMA))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_AUTO_CMD23;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "%s: Auto-CMD23 avail=
able\n", mmc_hostname(mmc));
> =A0 =A0 =A0 =A0} else
> --
> 1.7.0.4
>
>

The reason the older logic didn't work correctly is because
SDHCI_REQ_USE_DMA is not set in sdhci_add_host, but set in
sdhci_prepare_data. That means if you didn't have USE_ADMA, but had
USE_SDMA, it would still enable AUTO_CMD23, since the
SDHCI_REQ_USE_DMA bit would always be 0. I would be very grateful if
you can try it out on your XO. I unfortunately can't test this out
right now.

A
