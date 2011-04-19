From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] mmc: sdhci: Fix SDHCI_QUIRK_TIMEOUT_USES_SDCLK
Date: Tue, 19 Apr 2011 12:53:29 -0500
Message-ID: <BANLkTimQKLoNAZjv2QFXsuOkQqJAyRF=TA@mail.gmail.com>
References: <1303235057-4745-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:41920 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab1DSRxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 13:53:32 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3JHpaLN024031
	for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 13:51:37 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3JHC1ml001619
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 13:51:36 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so6744830wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 10:53:30 -0700 (PDT)
In-Reply-To: <1303235057-4745-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Ball <cjb@laptop.org>, patches@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org

On Tue, Apr 19, 2011 at 12:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Commit 373e6a (mmc: sdhci: R1B command handling + MMC_CAP_ERASE) move=
d the
> handling of SDHCI_QUIRK_TIMEOUT_USES_SDCLK from sdhci_calc_timeout() =
to
> sdhci_add_host(). This causes division by zero errors on at least the=
 S3C
> SDHCI controller as the quirk implementation needs host->clock set to=
 work
> but host->clock has not been set when sdhci_add_host() is called.
>
> Fix this by backing out that portion of the change, the clock may var=
y at
> runtime anyway. It does occur to me that we may want to move the quir=
k to
> where we set the clock but this seems more invasive and I'm concerned
> about undesirable side effects.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A07 ++++---
> =A01 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f79dead..da57bdb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -616,6 +616,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host *h=
ost, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0target_timeout =3D data->timeout_ns / =
1000 +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->timeout_clks / h=
ost->clock;
>
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D host->clock / 100=
0;
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Figure out needed cycles.
> =A0 =A0 =A0 =A0 * We do this in steps in order to fit inside a 32 bit=
 int.
> @@ -626,6 +629,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *h=
ost, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 * =A0 =A0 =3D>
> =A0 =A0 =A0 =A0 * =A0 =A0 (1) / (2) > 2^6
> =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 BUG_ON(!host->timeout_clk);
> =A0 =A0 =A0 =A0count =3D 0;
> =A0 =A0 =A0 =A0current_timeout =3D (1 << 13) * 1000 / host->timeout_c=
lk;
> =A0 =A0 =A0 =A0while (current_timeout < target_timeout) {
> @@ -1894,9 +1898,6 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (caps & SDHCI_TIMEOUT_CLK_UNIT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->timeout_clk *=3D 1000;
>
> - =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D host->clock / 100=
0;
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Set host parameters.
> =A0 =A0 =A0 =A0 */
> --
> 1.7.4.1
>
>

Sorry about that. I thought I had the right idea.

I'll try to be more careful.

A
