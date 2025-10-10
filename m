Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9042C159D
	for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090370; cv=none; b=pjsft5lEBdqmOWs/ALnVS0+WkIFx9n6oojy+wiQJIsSiFuGQv3lpwXSjLGQaK/lZf9C6+Qp6twOQQjQ3yUOuv7KpN2ZsaF3jDmpVxoiFjVy6wYh93Bq2niYi1GqUCjnWISepjYQXaQzN5y+Ar9vmGC/IqDxO18Lm8W5hyXUy0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090370; c=relaxed/simple;
	bh=vQWMYvYYYMF9y9WflHX8XkNouS4Wqt/G/yc56cKJNGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJg06eaX8+FFxsZdMVunQcWBqntj2D8OjzCDr3+ERWyAZwlwPPvTQb1o9MIyfDstUFHSuRzQLLF0g/dzs+aSmlAkeG/hw9uC1S+n89Jt7u6CKL8L0a9K2uq6WPTpWgooLvMX3g+HUOOVlN0xdr63AXHzFE06v9BSQ6QWNLpljrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PQNtyzcz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PQNtyzcz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1174738f8f.0
        for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760090366; x=1760695166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DzAn8h5K5sSJjaAHPz0TH/gQotZMWW1j3+EKC49O1s=;
        b=PQNtyzczxlDdhAIyLrO13veTVPsvystYcjbf28Jd90p/+0CZeTHBX2ZA4z1C2qCXK3
         Dq3LiKc9ThOd49Yr/ZST8rsb4IN65QwlKm7HOhIQVyH9HnOtXnDh2KE1ePVza9KxJFXg
         /rafNFYK53bNEtTEUnf5b+AUcunbtsM84tJL7JJ8G7ltI6e8NkNaf7R3DEW0dx9dHJ3d
         ml1QV5E8e1N0EDSX/RWPNvqgSgAmm3qAX+66eNLmbyJ4ARl1b1nPMb0dkoKrQDpoxJrK
         IBkXmMoM+vpv+okBKeBQjaZu2PLvauEr2JLhRrdskbyXWoUSobNt0hFWs6NAdNu10Jbv
         9NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760090366; x=1760695166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DzAn8h5K5sSJjaAHPz0TH/gQotZMWW1j3+EKC49O1s=;
        b=jafrFJewhmNPcXkRiN1mpfBqtCK/zoYXgFPiR6hIFFHKMjTkeb7vibb+dea5k3mpGR
         DvUdiRlqxc/z6SntRLjnf2mZGaLYMP6TpOtieKH0GzXYCticEjLtge5Ql5FK7T15yLWa
         e1siv7PEB/+2U0e5YD3NTUGS9bGSPa8zZu+beDEgAC8/solZ99Iz1gT67/xkNddmKFcI
         87EsZHkEqC2a0zNGO1sjavDBOZ1AsJUAt4rPqVN9xrIXnIA97Tpb2UQ8MdRjcdl5iNVy
         9FtVt7BNvySrxMna3u2xyXIpLbN12nybxLRP+mwr+w7xSiQhe+yEb3DtT0SM6ncyMaa+
         +M+w==
X-Forwarded-Encrypted: i=1; AJvYcCXrMOFvyeYPxa1syQ7MY88biZ5LdALFj8h2QFjIdUbmb2uKqpv2t5AUTu5Itf0qMmsUJw88u7VhGVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+zLAU58WnY1UIar4NgVpsi5ABJqvdAmTIDFTlmkJH47dj6L1
	3DOGe9z08rgLXbOCTUlRgicdQZWHMv9+9EEJTZoCQPAONUd1iql0ryZ6YNNqYRQIpYE=
X-Gm-Gg: ASbGncutcEjyuVYKQMtS9t8HZHHPeXDJB2evXsR3PTbdjGjASmqHyh7I2RQQbM+o2U2
	9GIOvMpZBKPQRcUTe+I1jNfnVUK88rPm/Vw2yATNMIt4BkjtkuuZ0cTz8Vlk1Msp5Lidg2WNOug
	MkKG77B/fdeXJf82kwZjuLGrpT0kA2AlAS6MVSBJM43NYRtljPSm7LRSBDu7jWp8JAnOBPDX29e
	JlsOCr5cAau4kpXd71HxJFFIR0wOR6jUUWqaTS5PDz2TxF3M3FS6XehZKIvkakpsWLod0Q1Nde0
	xy0OSYkngWzCQxhlydHdrkdokHjB/6l2G/4TMqRzpHUI0DZiY+A7Tb6UNiHGKYSMlbjSRVCMKKY
	Qxx+PfBrtE3BvoCFt6S0OW1zKe+L2bJoTF6/Grdonh5N/S0QrtLdJ/skR0xv3YMqpwaCnk9+fKE
	1c2k1RjK8=
X-Google-Smtp-Source: AGHT+IGBYsfMh75Hh5zxiwruYu23yH7nClDJDGYy+ble0hfKIDqxAPcoM9f6zkelCUi0z7d0tu8mqg==
X-Received: by 2002:a05:6000:1a8f:b0:3ec:db8b:cbf1 with SMTP id ffacd0b85a97d-42666ac7279mr7036053f8f.24.1760090365997;
        Fri, 10 Oct 2025 02:59:25 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e10e8sm3345992f8f.39.2025.10.10.02.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:59:25 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:59:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <aliep4j5jmbdixu5cmqztoxwp3jv4r4hi63qpvhughepsepzb3@qh3mwgryf5ny>
References: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
 <20251009152744.9734-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54dwufa2azbfzfm6"
Content-Disposition: inline
In-Reply-To: <20251009152744.9734-1-rakuram.e96@gmail.com>


--54dwufa2azbfzfm6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
MIME-Version: 1.0

Hello Rakuram,

On Thu, Oct 09, 2025 at 08:57:38PM +0530, Rakuram Eswaran wrote:
> Your suggestion makes perfect sense =E2=80=94 since host is devm-managed,=
=20
> explicitly assigning its members to NULL has no effect.=20
> I=E2=80=99ll remove those two redundant lines in v2 as you suggested.
>=20
> I had one small clarification regarding the remaining host->dma_chan_tx =
=3D NULL;
> in the TX DMA error path. Since that branch uses goto out,=20
> the cleanup section below may call dma_release_channel() on both RX=20
> and TX pointers. Setting TX to NULL there seems like a defensive step=20
> to avoid accidentally passing an ERR_PTR() to dma_release_channel()=20
> =E2=80=94 is that understanding correct?

Ah right, so either keep host->dma_chan_tx =3D NULL or improve the error
handling like:

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..e5068cc55fb2 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -715,7 +715,7 @@ static int pxamci_probe(struct platform_device *pdev)
 		dev_err(dev, "unable to request tx dma channel\n");
 		ret =3D PTR_ERR(host->dma_chan_tx);
 		host->dma_chan_tx =3D NULL;
-		goto out;
+		goto out_dma_tx;
 	}
=20
 	if (host->pdata) {
@@ -765,10 +765,11 @@ static int pxamci_probe(struct platform_device *pdev)
 	return 0;
=20
 out:
-	if (host->dma_chan_rx)
-		dma_release_channel(host->dma_chan_rx);
 	if (host->dma_chan_tx)
 		dma_release_channel(host->dma_chan_tx);
+out_dma_tx:
+	if (host->dma_chan_rx)
+		dma_release_channel(host->dma_chan_rx);
 	return ret;
 }
=20
> Also, I noticed that in the build configuration downloaded from the LKP r=
eport=20
> link (CONFIG_DMA_ENGINE isn=E2=80=99t defined), the kernel uses the stub =
inline=20
> version of dma_release_channel() from include/linux/dmaengine.h,=20
> which becomes a no-op.=20
>=20
> From what I understand, when the DMA engine framework isn=E2=80=99t enabl=
ed,=20
> these APIs compile as no-ops through their inline stubs.=20
> Please correct me if I=E2=80=99m misunderstanding how this works.
>=20
> Please let me know if this reasoning aligns with what you had in mind.

Sounds right.

Best regards
Uwe

--54dwufa2azbfzfm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjo2PkACgkQj4D7WH0S
/k5wUwf7BFg4e6GvALl61mEKV9IwUSBj6wGkRqj3UTzRfeqjt2/9cfLxrg9YrQXq
ZjjEQ4EDNpqeaVtzJmG6Cdv/sz49fAat8Cu3LUlg7iQjecA2Bp2ZT05wgAWD+lb9
/sc5wevdk7Lkwj835EAQsGZja31qEDsvIsuVL936pPYuLOAeH/KjlRD5mVp9rVGz
pQAfBsKe9tyeIDZPjmKyR8xrAvqqri3Z39LL+GJWtTUmQEy7z+Ibwcegu2HI5pea
0qHZAYpkqzFSiDrMF4n66sSyaF5ddDa+HwPHInzM4W5IKPWTtu3vNybWF4rvbpjU
mxedmYUlwln6CAHXIa6iHKqC8OYi4g==
=3GaF
-----END PGP SIGNATURE-----

--54dwufa2azbfzfm6--
