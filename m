Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794649854;
	b=3dB2aL0cYmnwacmRJyMtClxtExxfbRu+1O2FfbDKvx7GpxZoiO2LOP2l92UKsY1VmTkZ
	 gcmqOuuSh0XANtwlbpPOL1W/L8dXIiR1GaAhjbiYY12tgdWplPaFAc2ADfE5JC658vNOg
	 EGeDw31Sg11UpsovnIymKp/s3F/3pT6T7lX9SbhSkB/2tAI3mFqpThZZG2reFOoC6gt8g
	 MPTWc2EqocVEDQagsWSp+sUv6pS1T+wW2iXlLFujWvpY7+D6KwcSYEK2+Dk+vVVhM0FJc
	 ZGgAqghZGmT42kQ2MVZ0CJynkpFtw0ASpvC8tI5xkoaLybz51hRQX+F852y3Sb5p1rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794649854;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=/og/MwJW0u2IXqQeL20UF4e8Z72CcuByBeXCuDNbtDc=;
	b=0PJ4/+fNinL+ta2DuezfKshVrOxzb5TGi7V6s6QH0SdJsmNloczOE2ZlT04LTwcsKGno
	 ovfpGkmq1Ekj+xjcOq0VgoTjBvB4IENGNl+qpfCrAM2PFf4BOWNKaHTH4iQR9C9ewLUYX
	 OulHSym2gUTQHoGPIYKz22vFacJjMykIvLEohsOFFO1GEOsaeOQu8Eyp1jResa38xiw24
	 QRqqZlt29MidtvhykcUFjPD56eLggOpYlD7nwM7lY71cPShJaLm4UCiJyIPVSGvH5Tlmo
	 6biwogLbu/dOgN+l4FgtHPVNf2XqPq50eEos7p4yCbG8HixAO7+E0uonnczdDAEdXJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b="P/92H3v7";
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF642606A329
	for <linux-mmc@vger.kernel.org>; Sat, 14 Nov 2026 09:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF642606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=P/92H3v7
DKIM2-Signature:  i=1; m=1; t=1794649851;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:G/7eI7Ul3DbZFOe4Z5qw2eXI7jni
   P+OnfPmxXcDWkK9MfshlIZLN2kAcbOCrnePS0+bAnH/pdGylbV0oqza8On/teShgb4IPCxzDjzM
   cYalN+CVSr8fbV8iffXeoGj8P3VtYOd5NrnJ3NwQ2zU//Sol6+MRsDobiE/peprmTw2urbmZGuH
   T7C4VHG6HrgEwqVFYJOqLbhlGUXUMbAzFEnOLxUbeF28I6fWOS+vOep3ZXWQIJpBL+bYbpAKvRH
   EEVo4tmo6NUDcM7R8EVxckJtPwh2kJVVNNyfMLVPSY3vfQPQXHC/zKw1C95n1wBFkqZSR6JN6K5
   eBUJmbFyNGaHXg==;
Message-Instance:  m=1;
 h=sha256:
   bhOUi8ovHiSa0950V5yr/KSU5LgousjsI22Xb2pE8Ig=:
   rhOjPF4xaT4byzoZ8RKZUNIlqMn5D8AxUkjeiMzwIdY=,
  sha512:
   8rdoip1ZWJEkNQe4ve8KuPC+pHJdKer3cTesRuZ5TSZIEyXPhELnFu/9Ii1Yopcv3nLgs0wkYRf99YVBCjND5Q==:
   RGiNmEa1kDE/U537G6wWnOQVE2GYRvELbCoXFV9IipPA1KaK71VQoZE9rt4HvBt9ifjmAFd+wd2N5WtONblznw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794649833; x=1795254633; i=wahrenst@gmx.net;
	bh=/og/MwJW0u2IXqQeL20UF4e8Z72CcuByBeXCuDNbtDc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P/92H3v73ok1fQCSEEAJGSMpACWirjCSl6cMeJ8qxmib6orlEJm/CxClibI1VpGS
	 NkLzeKVHZ+5pafqKj7CukXBJT0jYfzVftLnIzfLhetaWUmORx1AWmnyIUccz0Fr3n
	 OJefRkmMTEzpTKGpJ/qGNDlnkbil96sNkbGpYi1KzfrvE0y0+YKUwt5RReBX0/naE
	 k/eaRlUxzOsrSg3W7DbsbC762r1if624+c5N52mpP0igSlO6NE9FgGk1thbDVPrcF
	 bYR6jNQ31WV8EkVq72/nVE4HuZ2XUCww+1KxxLrt24PI87s/pxM6a0Pj+pMtzoRGD
	 o1jPgsXhJsR8w9R7jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1xJ2md40cR-0053fu; Sat, 14
 Nov 2026 10:50:33 +0100
Message-ID: <132b7ffc-c1b7-4adb-ac66-6f40cc512048@gmx.net>
Date: Sat, 14 Nov 2026 10:50:31 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: bcm2835: restore scatterlist after DMA setup failure
To: Artem Novak <artem122novak@gmail.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Hemanth Selam <hemanth.selam@gmail.com>, John Garry <john.garry@linux.dev>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20261114051011.275554-1-artem122novak@gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20261114051011.275554-1-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nrH/vxNRBhZ6a0ipo7FcbE1OmnofzWbaUMQ5yErUsGQM/wmlgB2
 OZy1dXo2tRK8O14aJZ4QmVbYfaA1fMfmOcGuDJ0O29B0cG6T4F8hyp+Ul/YIxyauf9yFWeP
 BrDbTfkMtR2LJy8l8pski7YDXVV39ddAtVbTw99QyqvYc1X4uxJ81CHVsG19m5+EQR8HMFr
 rGm+PRt21soOpL/uIFmKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7RB0z1SjRpo=;5vzJeIRSDRyhu8fielYIyrrl8Ob
 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

Hi Aartem,

Am 14.11.26 um 06:10 schrieb Artem Novak:
> The DMA preparation path shortens the final scatterlist entry
> to reserve space for FIFO drain words.
>
> If DMA mapping or descriptor preparation fails, the request
> falls back to PIO, but the shortened scatterlist entry is left
> unchanged. Restore its original length and clear drain_words
> before returning to the fallback path.
>
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost contro=
ller.")
> Signed-off-by: Artem Novak <artem122novak@gmail.com>
are there real potential negative consequences? I'm asking because there=
=20
is a fixes tag.
> ---
>   drivers/mmc/host/bcm2835.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index efd1903c3ccd..49a975e984df 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -449,6 +449,8 @@ static
>   void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *d=
ata)
>   {
>   	int sg_len, dir_data, dir_slave;
> +	struct scatterlist *trimmed_sg =3D NULL;
> +	unsigned int original_len =3D 0;
>   	struct dma_async_tx_descriptor *desc =3D NULL;
>   	struct dma_chan *dma_chan;
>  =20
> @@ -480,6 +482,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, =
struct mmc_data *data)
>   		for_each_sg(data->sg, sg, data->sg_len, i) {
>   			if (sg_is_last(sg)) {
>   				WARN_ON(sg->length < len);
> +				trimmed_sg =3D sg;
> +				original_len =3D sg->length;
>   				sg->length -=3D len;
>   				host->drain_page =3D sg_page(sg);
>   				host->drain_offset =3D sg->offset + sg->length;
> @@ -495,14 +499,21 @@ void bcm2835_prepare_dma(struct bcm2835_host *host=
, struct mmc_data *data)
>   				     &host->dma_cfg_tx);
>  =20
>   	sg_len =3D dma_map_sg(host->dma_dev, data->sg, data->sg_len, dir_data=
);
> -	if (!sg_len)
> +	if (!sg_len) {
> +		if (trimmed_sg)
> +			trimmed_sg->length =3D original_len;

Maybe I missed something, but why do we need trimmed_sg? Can't we just=20
check original_len instead?

Best regards

> +		host->drain_words =3D 0;
>   		return;
> +	}
>  =20
>   	desc =3D dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_slav=
e,
>   				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  =20
>   	if (!desc) {
>   		dma_unmap_sg(host->dma_dev, data->sg, data->sg_len, dir_data);
> +		if (trimmed_sg)
> +			trimmed_sg->length =3D original_len;
> +		host->drain_words =3D 0;
>   		return;
>   	}
>  =20
