From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC] mmc: tmio: Fix timeout value for command request
Date: Mon, 15 Jun 2015 18:34:31 +0200
Message-ID: <20150615163431.GA1583@katana>
References: <1434302606-31040-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55501 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451AbbFOQef (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Jun 2015 12:34:35 -0400
Content-Disposition: inline
In-Reply-To: <1434302606-31040-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> @@ -230,7 +230,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>  	 */
>  	if (IS_ERR_OR_NULL(mrq)
>  	    || time_is_after_jiffies(host->last_req_ts +
> -		msecs_to_jiffies(2000))) {
> +		msecs_to_jiffies(5000))) {
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		return;
>  	}
> @@ -818,7 +818,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	ret = tmio_mmc_start_command(host, mrq->cmd);
>  	if (!ret) {
>  		schedule_delayed_work(&host->delayed_reset_work,
> -				      msecs_to_jiffies(2000));
> +				      msecs_to_jiffies(5000));

What about using a define here since the same kind of magic value is
used in two different places?

Kind regards,

   Wolfram


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVfv6XAAoJEBQN5MwUoCm2AgUP/R7katf+BayySPc8UnWPUxZi
sEe3u+oXixVfKlZDmQUUKraIoe/3PPYyhE+6CQZ+0pvxrRHtQ9HezQni3G28swmG
ctsqWC0vObQ/z7nEuSsbX9Ya8NET311l77mAjmSOWCBk+A3sUetU9PLWFZ3RUeXm
aFcnxEEgLMuswcrQMgUfGDTX6O8MtqyPIoql814QLaNMVuG+CCoVteY3420Qfr05
ExBzNoVaX2WG+ZvFPWeTuroisA8XigJL2TqeUNgCSqyHMWAE1Kmnvk7+9grVRCR1
ExarukiOfnZUkYj7lDHx4/BmTosTr72ZT8RzrqOycHBElhfJuI5+40IKKQHMv4dj
aQQXJgikD5V9SQkh8K+EacDKaqBvEApt+wiObaUQJsBlvH7ABqUY5UQq9soDYzj3
Fs9MXnryywukBF/iGaCteEAhvu8vBtT1Kcor16DGKqZTQO0fwCE4qGIcRqH86Cd4
MTVijCw0hKZh+T+rGkVjEVSGriQ90YkoabGcU35dc4NOdzIHi9vIUNW7E/5fI9xS
aO/g9yQcFvBfYEg6+L/LRRocyT8L63j/6bU0WgjU4TwRsSkAIFx68X4sgZUwPaln
SIRpYSryosN6IZpiV7vQ5MXavDifdJ+VZ6GQhwWdodtlA82dlAZU7zDOCtHGJtXG
oogn4lzL1FFvT9RaXQPk
=ButM
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
