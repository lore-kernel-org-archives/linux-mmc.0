Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795351166;
	b=PTNW5CkIQPi2OCJuph7v3NlBgpgSqW1x5XE1dWQD5FkuYhmrBPX6pwNQZrrbNjxi3d3v
	 YCcqH6zYLMaTAg4wYvfuybtaTW/DQhr8nMgAQea3PYDZJGJ4qetxtlX3LrfrH0GB7RWL5
	 +lutrtXMf8bKMuyVitWpR0LTlywno75XKlPL8rbao3YcaOZ7HYuTWw/pvdEzoFDD50XOr
	 x+xc8lAwKNDE2oB6J1+fZVgpwS5WaxWDHktaLIdCBuHwe4CacXACT39HmDcBTniwUN4BQ
	 ksfUpDPPvYuTS0FKlJR8zrnoGH5dAb6SKzBilWvTV8uwHrpQYPpn5EiDvsH85u/jgaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351166;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=pimJ7WtGXn8iWughbWdCqANZvoIzX3xugoC2CsGLUrM=;
	b=NMcw/0/35mI1IiTfIYOVT9VbtAKSlCvvSKNP9e4zPGgovmXGyfb6ELYTLhTPiutLhYyO
	 KUDEOIOQrJabp8Y+rJXBwGgvhXp6GrafJtcFQrB5SRYGg3eidG3+XYssfhVoHR27i43Nf
	 JlKrOIlTJnhrRKb593LSohObMdC+IMfvnqpgiL3aNKDWeHS7OFHV+KHgxlDsppcGMQmXM
	 EHoD4FVlVtWthCUHVDHEIAZ4bNgAkx9ijHPCkS91DSfGuD04ZUW159QQNZrwRjlp6pKtM
	 TIz+5xqoYrBc3vCaXutsUog/Bc+yaMZbjUs86vBJhT7nQKVmFyw7Umw4hqjt8VcOi1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=GEs7fxe7;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A5606A320
	for <linux-mmc@vger.kernel.org>; Sun, 22 Nov 2026 12:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09A5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=GEs7fxe7
DKIM2-Signature:  i=1; m=1; t=1795351163;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:OOCNVMFHogtaVun7YG1s+1+gu5fL
   A6Wd+41gA7CoYG9xRvW5wPZRE5YgsdN5BR5ni1Ra6li/Hnb8YM5DetVy7LY4vCcAAOsjQVs9TQ+
   Cn1B+eeN4RnWtjk6sTv5VTsJJ0oPm22nX5i/gu2Obp/zATjIE2LbPz2Gi1XiLMLgl3DNUXL/JGc
   kSFen1nRJkwmNH4ClY60lFEFTOPh83CbrncWmp8NK+PWYBKDpdn8+Wk+O1IgsCvTOzqStjHlTzl
   c1K5pGyDyHzRxE5phtWO+47PTpC+FTt3zYkjq1jHBLn1L5J0AKJ4EPHSKiB7oA7eDn7czKVRG2Q
   SX4Ve6gxfSbtMw==;
Message-Instance:  m=1;
 h=sha256:
   iQN6qWc4XpR/eD5QVvfx18FKsUUvv5M5F2Ole8+uADY=:
   pimJ7WtGXn8iWughbWdCqANZvoIzX3xugoC2CsGLUrM=,
  sha512:
   3lIXV/GYsgWKMletybdb+3REEtqRuEp3V1JX3811+Q4jI2r9xUX23XVx7n+rA8zmoQOzSLyKGp4VV7u/fYUzmw==:
   JC+qttD3peBBjnDkLHnJ4Y7e54rHtlSFiTy274z9/wbkPqMIXn6etmtphVLKrlcJRXojN9JkUp2VxxB0ZuTdbw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1795351143; x=1795955943; i=wahrenst@gmx.net;
	bh=pimJ7WtGXn8iWughbWdCqANZvoIzX3xugoC2CsGLUrM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GEs7fxe7jfJ6+V+yGQKBccCcGFYGy+Edi1oayZMHyZPy43mldKpWkgmahFUliYZu
	 Rf5pt/nruseGjI02anrAVk6P3BxPUXubLgFrCYLpqig26GdMoAkIMpTS/ASaAGFVH
	 +gykldEU/UnBVf3eYZ4+1Zol08hugId4i2q4yHuxzEkQ1aEaq8XTWVc8tZOnalYf8
	 Qj9g+DrrU1fEpyKim+OND6H35u4lLawN4ZPhsXrUfvY4F2VCBWsH7YIu5ITheBwgf
	 GT02JdNRtEJDqS48VYRmbgeU1r5ksPywcooKPs5X38Oc0s+5V0leSUpXcWU/jtTuU
	 48zUBBTFE/nZPx3Yrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1xUYc91cMU-00HOuo; Sun, 22
 Nov 2026 13:39:03 +0100
Message-ID: <8ea10aa4-71fd-4894-b80f-e94a41f7e4f3@gmx.net>
Date: Sun, 22 Nov 2026 13:39:01 +0100
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
Subject: Re: [PATCH v2] mmc: bcm2835: restore scatterlist after DMA setup
 failure
To: Artem Novak <artem122novak@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 hemanth.selam@gmail.com, john.garry@linux.dev, kraxel@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, rjui@broadcom.com,
 sbranden@broadcom.com, ulfh@kernel.org
References: <fcfc5d38-2755-445c-8444-bd4c5b9c524f@gmx.net>
 <20261122075814.162099-1-artem122novak@gmail.com>
Content-Language: en-US
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
In-Reply-To: <20261122075814.162099-1-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IMSofjOf9Ev+R0ycMhjyJYvry4IZX3KxItWF+DHejgWaWnN3a7D
 bA352OgB6OyyevNS/DZpInRY78oCoKelcwgea7WOwQAyRwy6SA3YskoJWTLa9SOq9VF4ETs
 /sPF1QgmLNTqqSB/zleNhmiN0QY1lh2eMeKHrQHbwK46jmYwl2uws8hnjPkEhqhhAButwGR
 6tOIKiAtEtp13QKo/PrSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+pOcrzR6cLA=;l/91TL/JuXNUekl45+WieVxeIHs
 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

Am 22.11.26 um 08:58 schrieb Artem Novak:
> The DMA preparation path shortens the final scatterlist entry
> to reserve space for FIFO drain words.
>
> If DMA mapping or descriptor preparation fails, the request
> falls back to PIO, but the shortened scatterlist entry is left
> unchanged. As a result, the PIO transfer may omit part of the
> data, potentially causing corrupted or incomplete I/O.
>
> Restore the entry's original length and clear drain_words
> before returning to the fallback path.
>
> This issue was found while investigating a kernel panic on
> my Raspberry Pi server.
>
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
> Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
