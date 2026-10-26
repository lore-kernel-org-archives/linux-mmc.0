Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004165;
	b=Xgsu+fMMcnFCsS2Vor6qrAMi3VlrGy3zxxu9mUMhjv8toW7gQ6Z/A4naZjaskNOCmC/f
	 INAcvAq1hUpl2WcmNpvUD4+uPB0091LXJnXdyHgRtka6CWeK8tdJuoQIETGC4CPytGaq2
	 AYm65TKNai1gTnjiTnSo/N/pMtkd3EHa1qoc5V//b1GvddDOPlVQ8h1GCc3fPv+aDEjuJ
	 QzjmsOH1K5/srVwj3B2y/qLjadWmTe8Xbuo7gmEx62ehIUe6JvJkdBtK4fZZphqBJm3qk
	 h2TwLYd3Rzb/t2PShEc9VIT8dfhKBONVlsmY2hxIPx4h3tSbIdbVflRPfpERk3JfB4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004165;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=E1nL2/Vfk4pnrbVLCTirKX2aylDFGWUjxOEqPVE/VhU=;
	b=nR++INgiTcJLWNd+6oc4d28jHRmKBqwrqqsRoK7LntIhJTPfEbldUXf6nCoA3FlNOhDT
	 uE+SbDP7dsijCTT4jOaR69yIFFaV1ckp3zcClI1BOCdZFB0wiVQoHT6jf5xivC6/HSOvb
	 je0LXIrjtQmWPiQ0DVUuXXn7u9OZ8joC9zyx/vbDsa98N0LgWqOmTdpp4BDpjwKmqztKf
	 hScAA3kv957nPf7C2hDYuNXhZMicv4Kn1x/IJ+gc3MF7J8qbaiFpSkK0rdOzfNMLdEykr
	 dXUcuMAvMQseLwr9LycPklSDzzvL2aUtTbCy96yV5b4RHpeuuNCnKrqPZzefatFPHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C249606A31A;
	Mon, 26 Oct 2026 08:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C249606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <48976ce134e26877200e8e1ef8d3f5c66f4fdcf6.camel@crapouillou.net>
Subject: Re: [PATCH] mmc: jz4740: Remove the host before resetting the
 controller
From: Paul Cercueil <paul@crapouillou.net>
To: Olivier Louvignes <olivier@mgcrea.io>, Ulf Hansson <ulfh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Matt Fleming
 <matt@console-pimps.org>, 	linux-mmc@vger.kernel.org,
 linux-mips@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 09:42:32 +0100
In-Reply-To: <20261026083323.12301-1-olivier@mgcrea.io>
References: <20261026083323.12301-1-olivier@mgcrea.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Olivier,

Le lundi 26 octobre 2026 =C3=A0 09:33 +0100, Olivier Louvignes a =C3=A9crit=
=C2=A0:
> jz4740_mmc_remove() masks every interrupt and resets the controller
> before mmc_remove_host(), which removes the card and lets the card's
> driver send its last commands. Those commands then run on a controller
> that was just reset, and can wait out the driver's 5 s request timeout.
>=20
> With an SDIO card that cost 5 s on every unbind: on a HiBy R1 (Ingenic
> X1600, a BCM43430A1 driven by brcmfmac), the CMD52 that
> sdio_release_irq() sends from brcmfmac's remove waited 5.1 s. The
> command had finished (END_CMD_RES set in MSC_STAT), but MSC_IMASK read
> 0xffffffff although the request had unmasked END_CMD_RES. MSC_STAT can
> still show IS_RESETTING after jz4740_mmc_reset() returns, so the reset
> most likely completed after that write and undid it.
>=20
> Remove the host first, then quiesce the controller, as other host
> drivers do. On the R1, unbinding the Wi-Fi's MSC now takes 0.65 s.
>=20
> Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.=
")
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

If you have a Fixes: tag, you need to Cc the stable@vger.kernel.org list.

Cheers,
-Paul

> ---
> =C2=A0drivers/mmc/host/jz4740_mmc.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.=
c
> index 6a3c26b7c82d..923cf1450de5 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1151,12 +1151,13 @@ static void jz4740_mmc_remove(struct platform_dev=
ice
> *pdev)
> =C2=A0{
> =C2=A0	struct jz4740_mmc_host *host =3D platform_get_drvdata(pdev);
> =C2=A0
> +	/* The card's driver may still send commands as it goes */
> +	mmc_remove_host(host->mmc);
> +
> =C2=A0	timer_delete_sync(&host->timeout_timer);
> =C2=A0	jz4740_mmc_set_irq_enabled(host, 0xff, false);
> =C2=A0	jz4740_mmc_reset(host);
> =C2=A0
> -	mmc_remove_host(host->mmc);
> -
> =C2=A0	free_irq(host->irq, host);
> =C2=A0
> =C2=A0	if (host->use_dma)
>=20
> base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
