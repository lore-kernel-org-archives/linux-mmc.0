From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/4] mmc: sh_mobile_sdhi: Add tuning support
Date: Fri, 27 May 2016 13:59:34 +0200
Message-ID: <20160527115933.GD1663@katana>
References: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
 <1464057797-29951-4-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47498 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbcE0L7n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 May 2016 07:59:43 -0400
Content-Disposition: inline
In-Reply-To: <1464057797-29951-4-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 24, 2016 at 11:43:16AM +0900, Simon Horman wrote:
> From: Ai Kyuse <ai.kyuse.uw@renesas.com>

I wonder if you shouldn't take over ownership of this and the previous
patch? You changed quite a lot.

> +static inline u32 sd_scc_read32(struct tmio_mmc_host *host, int addr)
> +{
> +	return readl(host_to_priv(host)->scc_ctl + (addr << host->bus_shift));
> +}

What about passing 'priv' to these functions? Then we can save the
host_to_priv for each access.

> +
> +static inline void sd_scc_write32(struct tmio_mmc_host *host, int addr, u32 val)
> +{
> +	writel(val, host_to_priv(host)->scc_ctl + (addr << host->bus_shift));
> +}

Ditto.

> +
> +static unsigned int sh_mobile_sdhi_init_tuning(struct tmio_mmc_host *host)
> +{
> +	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
> +		return 0;

Will the core call us if MMC_CAP_UHS_SDR104 was not set?


> +
> +	/* set sampling clock selection range */
> +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_DTCNTL,
> +			0x8 << SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT);
> +
> +	/* Initialize SCC */
> +	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, 0x00000000);

..., CTL_STATUS, 0);

?

> +
> +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_DTCNTL,
> +		SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
> +		sd_scc_read32(host, SH_MOBILE_SDHI_SCC_DTCNTL));
> +
> +	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
> +		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));

'CLK_CTL_SCLKEN' instead of 0x100?

> +
> +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_CKSEL,
> +		SH_MOBILE_SDHI_SCC_CKSEL_DTSEL |
> +		sd_scc_read32(host, SH_MOBILE_SDHI_SCC_CKSEL));
> +
> +	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
> +		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +
> +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSCNTL,
> +		~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
> +		sd_scc_read32(host, SH_MOBILE_SDHI_SCC_RVSCNTL));
> +
> +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_DT2FF, host->scc_tappos);
> +
> +	/* Read TAPNUM */
> +	return (sd_scc_read32(host, SH_MOBILE_SDHI_SCC_DTCNTL) >>
> +		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
> +		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
> +}
> +
> +static void sh_mobile_sdhi_prepare_tuning(struct tmio_mmc_host *host,
> +					 unsigned long tap)
> +{
> +	/* Set sampling clock position */
> +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_TAPSET, tap);
> +}
> +
> +#define SH_MOBILE_SDHI_MAX_TAP	3

unused

> +
> +static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host,
> +					bool *tap, int tap_size)
> +{
> +	unsigned long tap_num, i;
> +	int ok_count;
> +
> +	/* Clear SCC_RVSREQ */
> +	sd_scc_write32(host, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
> +
> +	/* Select SCC */
> +	tap_num = (sd_scc_read32(host, SH_MOBILE_SDHI_SCC_DTCNTL) >>
> +		   SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
> +		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
> +
> +	if (tap_num * 2 != tap_size)
> +		return -EINVAL;
> +
> +	/*
> +	 * Select clock where three consecutive bock reads succeeded.
> +	 *
> +	 * There may be multiple occurrences of three successive reads
> +	 * and selecting any of them is correct. Here the first one is
> +	 * selected.
> +	 */
> +	ok_count = 0;
> +	for (i = 0; i < tap_size; i++) {
> +		if (tap[i])
> +			ok_count++;
> +		else
> +			ok_count = 0;

ok_count = tap[i] ? ok_count + 1 : 0;

? Yes, I do like the ternary operator :D

...

> +	if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
> +		/* Reset SCC */
> +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
> +			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));

'CLK_CTL_SCLKEN' instead of 0x100?

> +
> +		sd_scc_write32(host, SH_MOBILE_SDHI_SCC_CKSEL,
> +			~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
> +			sd_scc_read32(host, SH_MOBILE_SDHI_SCC_CKSEL));
> +
> +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
> +			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));

Ditto.

...

> +		if (!hit)
> +			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104 and HS200\n");

HS200 will come later, I think (although the path should be easy now).

Thanks, I think we are quite close. Maybe Ulf does have some high level
comments?


--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSDalAAoJEBQN5MwUoCm25NMP/A+B//WiFUGPa4zIGg6CuZb+
5tguvK5rg/Er+EDWaU4bp2188bGfhNtWgqZWpk0Zlx3tHV6vZPvw5l0T+xbZWxPI
1sOZMnx9G8g2RHqQqD4Qp0ysPAbRUoJzABYXOBLaV0UyPPRYRYnhisBeZrUtWBy0
TIiUW3Mku1MrVj0sQFVOpppgWxdJThRKdftlVRjbgDLJnvaBweE39eH4QM3fojTH
F2ghcduOIRj+u5Ozyb74SSJlB9nWfqX0x4aI0hinKrU4T8WIxk88+uzD20yf90Ah
0i/ZygbsmouuGXebOFqQF/onBl5X0OcqtW2ePC0bK4NB7ws91KFDydxNcBT2ITs8
CtTFXMWKULdW3w1dib2/16Cvq7ginXi5gneds14HeGKI/HBNH/Yje9EuNQOfyZcz
lmUhdegEen9Q8Pt4Mraaw409mdumCxkZOWJDYO1Y8tKhzynYAAxsRje/q422p45d
m8Ug9kRi06YPWndV40I/IGhCW0cn3QQMzUfMosNxL+17YKX5bbWzUmGSJYS3EuXt
gglOwufth6gVLD6wEgqk6A7RqpLAJWI2Mj2dJy0QinWZY1V8f0WxnlMyr+EwDNFi
BDiBJ2xVvWOyPqmIUyR9yrK7pdTAGs3ZaPuOr3lmagcbxoJaqnRn/tpUDY730KRS
QNLSbWlQMOg4YBLiydRo
=FINn
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
