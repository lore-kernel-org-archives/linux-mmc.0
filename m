Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15261B67F;
	Thu, 29 May 2025 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748506136; cv=none; b=JnYL0jmd0f4AUAi7VkAl2lZ/lv1noyPdbByuPTqCWmiljbLKgZzxT9UPehn6BfvbCUnwrnNrk2pwWvQNzxw63ficvQSZfeWKovWSsoD3Y2WG2fIHa1xJaaLOWB6CWWMJJe6bejlWXQrCz12yyGlRW+aNk5nrS8nnNqXuB4ga3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748506136; c=relaxed/simple;
	bh=X6J2EZGtcDFFf1QChLOELilViAGYllQkhXFuw2otxaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qQT8qb6QmOI/xEhkWhSBYnjwhA/RDnEPeYZoayc8o78TmTilN7bvoCvpWfiTA+kDlZH7HiRLvewcKFJCD/y5Wt1LagrdePs0cqMEaRKZfdXAH9/PjISUN4bMC0win+hV45Jf2U0dPQGSIN/4qzeWbz3Pu1BMDx1nmgo24KyE1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=oaTwYbCg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="oaTwYbCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1748506132; x=1749110932; i=wahrenst@gmx.net;
	bh=5UdOdgiI5zxoMEjvek8mnmCqj8OoSdpXbP1HCHQdtxo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oaTwYbCgkcGhpT4VUXzhhal2aGmlUD3F8gkQaVyopbdKkXsd7O3HPPZ0KFDJpVAv
	 Dbfv2DY/29UcVOUX+6Pub4firuPyFx6TEtC/3ml8ziPyrDydoZoiKiH0BXDEL1E+I
	 IunUSOZw+bsLxSAAus/B98G8M0h01Iht7V2O+R2Oo8NCKb3UBPZXon2jkclAstMrw
	 /psFUd4tYPeR0rXUV14KECBT49SuUdVkdMZeWJSwsd3+SwzMt8CCUaOvk/qM+Qc6g
	 sDiCb9sDMoCsNahVbRHvx5DgpG6X44AKaPSPN6IN3tIqf3H1a3wJOycQRvmEduFhG
	 aAY7wlF4VB35f/ZURw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1utcI03T4x-00fQ8P; Thu, 29
 May 2025 10:08:51 +0200
Message-ID: <892d352c-8639-4837-a7b6-6706ec35ac7b@gmx.net>
Date: Thu, 29 May 2025 10:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: mmc: mxs-mmc: change ref to
 mmc-controller-common.yaml from mmc-controller.yaml
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
References: <20250528222433.727633-1-Frank.Li@nxp.com>
Content-Language: en-US
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250528222433.727633-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EjTI9J4dGsDiQy9sInFfttZwWAJ1r5kykoL7b9hCsFgH5NbL1LX
 7OX+iqRNF3k69KTIV2tiLqXjUAwfPA1eV6+DkRF7dPyJNdhgLzGLEUvkNUj16xgjQP6DfUs
 NusR/Hbyinp21BwcaRyGFVIg/TVelnH7R31Nd0TB+ICOqn9bd8RGgp9sH0JIkOlEJsFJnrd
 5mYDbSEb5LiIZU0X3LCdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RvCdwBGOh/U=;MuzvyMicLeznzIzkbQWlBD99GgU
 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

Hi Frank,

thanks for the patch.

Am 29.05.25 um 00:24 schrieb Frank Li:
> Change ref to mmc-controller-common.yaml from mmc-controller.yaml becaus=
e
> imx23/imx28 use dual mode controller (spi and mmc). So default dts node
> name use spi instead of mmc. The legancy reason, it use difference
legacy reason ?
> compatible string to distringuish work mode (spi / mmc).
>
> Fix below CHECK_DTB warnings:
> arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dtb: spi@80010000 (fsl,imx23-m=
mc): $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
>
> Additional add clocks property.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml b/Docume=
ntation/devicetree/bindings/mmc/mxs-mmc.yaml
> index 32e512a68ed61..ca40ca92f858d 100644
> --- a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> @@ -17,7 +17,7 @@ description: |
>     and the properties used by the mxsmmc driver.
>  =20
>   allOf:
> -  - $ref: mmc-controller.yaml
> +  - $ref: mmc-controller-common.yaml#
>  =20
>   properties:
>     compatible:
> @@ -31,6 +31,9 @@ properties:
>     interrupts:
>       maxItems: 1
>  =20
> +  clocks:
> +    maxItems: 1
> +
The patch looks good, but shouldn't "clocks" be a required property ?
>     dmas:
>       maxItems: 1
>  =20

