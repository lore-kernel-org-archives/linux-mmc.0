Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965996;
	b=IzSgI7Jz7PsE1TYNG6pY43Nf7X9XSQQdhHHF2CBxMc/vav0GgjVvAnh0+jm/MOJ3myKl
	 3FptFb69+E+u0RFx67mMa4+VSW8vvr8xUMGyaEFUevzMvcuLIuxZ7CtiXsNzVyZWWDNJG
	 RiCgGM4LiiGsgVgeDk6xAZOlp8AfkffY/LtDyKH28dAKPKNFKtbYm7VnRFUBHGLy5u/h/
	 nIDcTrFiqVEZQEdylIGGiWyoec2vUk7iPvOIZfBn4kXvYe00OsmlkrjQKclU547vswg61
	 nSVChu3aI1jV2i99OkhA6LmVDLFn362t+T5jvm/+vX747bKNFIUjJ60jPWv9pbHqm1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965996;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=I/OO/nNJKu96xyQLdYksv6ciskkjcoM0XRhrDbG7jEE=;
	b=O3ftQ73Qp9y1yA2B6N0TvBkuSyIyGWHQRmBX6f6Tua2XJvN9wGq7E7J23mQlCXedTfVK
	 4LEx4Zq9ssJRBOx/ECgEbdxkbwUaYlOU2ifnRoydbXe0YauBisYxVul3F/b+HwNq1KvoU
	 cuDD9SKwV9XYxIKnopPP8I6B4+mNyFNHSYtxE6/DtqJ4CdoR50t4+ECM2E6gnxML4kM1Z
	 QdG/Ggug7oOIZq/sD6GlUroQMlfuo48plmtsadCJwmJu9G9XJ7wvmaGSqWtb0nS38UImU
	 6aZZnNBvcCuZMENaQxm/faMTyEO6DbIYN056JHwkBQ2d9N74MFxxAk11lMac0ozeDkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bqM/pnVy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312FB606A32C;
	Fri,  6 Nov 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqM/pnVy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06BB1F0089F;
	Fri,  6 Nov 2026 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965995;
	bh=I/OO/nNJKu96xyQLdYksv6ciskkjcoM0XRhrDbG7jEE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=bqM/pnVytVbK/olqcwbBvt5em7AsA0fvQCg+IKlErWt5EjRt4X/SfSE6ob5YXuCsg
	 Ukoz1b3NWtwfGMG34KTV9iZxNIUix3IJxm/c53385kgKZIDYq0XJ6XPwJfSP1tR6kT
	 muXEX9uNXCzBPRKj2fnFH8nc1B5KpnlfK4PDInvpfSaBopPeM1wdaO1ZviNGdtpjGB
	 7HmB/DgzYy33ARuYZvYXYKxpJjI9l3YLMUijNNlvSp48UvPx6FIc87hgMPq6FhCrA2
	 /c/I4gKcPJTiGqJNOal1qY2wsRzIwQynVBif0qg6GDHdKE6owvKtLiWeSVQ3yS/nvD
	 ukdbEBhSHpMOg==
Message-ID: <28ab5309-8925-4df8-a366-78ab657ce486@kernel.org>
Date: Fri, 6 Nov 2026 12:52:59 +0100
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
Subject: Re: [PATCH 23/25] usb: dwc2: add support for Metanoia MT2824
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Samuel Holland <samuel.holland@sifive.com>,
 Ben Zong-You Xie <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?B?UmFuZG9scGggU2hlbmctS2FpIExpbijmnpfogZblh7Ep?=
 <randolph@andestech.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-phy@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-23-86087eaf5af4@bootlin.com>
 <20261106-glistening-flounder-from-mars-3ec4af@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261106-glistening-flounder-from-mars-3ec4af@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/11/2026 12:52, Krzysztof Kozlowski wrote:
> On Fri, Nov 06, 2026 at 10:30:20AM +0100, Benoît Monin wrote:
>>  const struct of_device_id dwc2_of_match_table[] = {
>>  	{ .compatible = "brcm,bcm2835-usb", .data = dwc2_set_bcm_params },
>>  	{ .compatible = "hisilicon,hi6220-usb", .data = dwc2_set_his_params },
>> @@ -347,6 +358,8 @@ const struct of_device_id dwc2_of_match_table[] = {
>>  	  .data = dwc2_set_stm32mp15_hsotg_params },
>>  	{ .compatible = "intel,socfpga-agilex-hsotg",
>>  	  .data = dwc2_set_socfpga_agilex_params },
>> +	{ .compatible = "metanoia,mt2824-usb",
> 
> Please organize the patch documenting the compatible (DT bindings)
> before the patch using that compatible.
> See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46
> 

Oh, apologies, patchset is fine, wrongly ordered in mutt.

Best regards,
Krzysztof
