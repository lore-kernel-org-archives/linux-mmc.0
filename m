From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH RESEND] sdhci: add MMC_CAP_8_BIT_DATA in the Host
	capabilities
Date: Mon, 20 Sep 2010 08:51:50 +0200
Message-ID: <4C970486.4010204@st.com>
References: <20100917221907.GB19979@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:54272 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752864Ab0ITGw4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Sep 2010 02:52:56 -0400
In-Reply-To: <20100917221907.GB19979@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks Chris to have resent the patch again.

I'm going to resend it just today ;-).

I'm using 8BIT_DATA mode on my HC without any problems and with good
performances.

Regards
Peppe

On 09/18/2010 12:19 AM, Chris Ball wrote:
> From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Date: Tue, 31 Aug 2010 05:43:45 +0200
> Subject: [PATCH (sh-2.6.32.y)] sdhci: add MMC_CAP_8_BIT_DATA in the Host 
> capabilities
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
> drivers/mmc/host/sdhci.c | 2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 955cad9..1c49326 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1799,7 +1799,7 @@ int sdhci_add_host(struct sdhci_host *host)
> mmc->caps = MMC_CAP_SDIO_IRQ;
> 
> if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> - mmc->caps |= MMC_CAP_4_BIT_DATA;
> + mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> 
> if (caps & SDHCI_CAN_DO_HISPD)
> mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> --
> Chris Ball <cjb@laptop.org> <http://printf.net/>
> One Laptop Per Child
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJMlwSGAAoJEAm9vY9TshdvbJAH+wZXUrPEOIGr/4i/uAGKW+jN
6yYukjyyCHerXLmI9vmmV8NekDU/DOi5jMHlUaFHkCUZcSVFfK+68xfOuH4Sz2Cu
7L3wTPXrQabIeM6cV31DOu15wLpgmTZhXECBxlZOAjMnnE2UyzszMbep4v5ZMZM4
Tj8lbCkdnINjBZc/lNUUwgIdOGvoIdxt5KIMy0k84BZY01ggsurTzMwtnXQEK6J4
YkOT4Ut57TIR/9ZxEzii/QbJjVNvm4hrZOwbooTu8cYcy2di66dJ7TwrOa5rKcev
z5QkmH7UZqVja7WAhgK1f9TlBSMiTmhRnJeOoQvELpq8lHV0tOajIBsK7EmJiwI=
=W0a6
-----END PGP SIGNATURE-----
