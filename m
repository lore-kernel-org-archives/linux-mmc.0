Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6935C2EA;
	Sun, 12 Apr 2026 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775968165; cv=none; b=t0ZsvaHQsH0r5qeGIl1hpy/9RjpIMl+Vt4pJXqcJ++F/oz9Zn1gl8I8gYGYCKB+iP86DiMZNM0c4Sytytf1/ssvTVTidQ20pGfvZlDUtjI2WTJgC1YJCw0yi1kQ3fi0UbnfezyHzYu3SE53WN1jM18bDS7UyII8cnFxmu/8QYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775968165; c=relaxed/simple;
	bh=mMj8xJVXlOsR/4sGO+dUgAd/881AhDLmkyFvhyKAm2w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UPz6/cUbv2EDP/aLetX83pruI1wEOdPD1AfhFd2CKR2Ny2TWwhsPTro18pWUc/wMeV6IHKdwLbk070cHhjD2FyMlmqXaIGkFefnU5inwjvDKYeWSHonftRtD7+P5+Wh9DTBxS7mJXgKKNuHDCzsEcRw7Mk+rt2N40Tr0H8tqtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Myw/eE2E; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Myw/eE2E"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BD4F825F30;
	Sun, 12 Apr 2026 06:29:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aX68PLeuX5Sz; Sun, 12 Apr 2026 06:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775968160; bh=mMj8xJVXlOsR/4sGO+dUgAd/881AhDLmkyFvhyKAm2w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=Myw/eE2EjhmmSrDx/TAnW1g/LHDUHzhnIDjy6lxojsnnBLAye7iSRv9fNCKNAhfxr
	 mzLJ+KwAqxgvS+fJmSaOmyaRbQC4XXbgpFCak7jZ8gt2m5fMqGtKK3mwNhztGkz2QD
	 ZUgHc1s2KZr7WUGYWhkgLeEmwYmvPHD9bRxp6dEvCJpYTcURWgRO7ntUI0KL27PH6Y
	 8+HYOC6ukTEd2BbJmnWNHQH2iRFaLFfJK9mfdbefUulQNs6HjywkLDLnRHHuj8dTlK
	 O+4S+X3/uM8Vk/Y9CuAdFOEwd1Y8jz0VpJTOIuPFocSUnAxHK9Y0nH9NYBQmk7742F
	 E4VRt2htJ77tA==
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Apr 2026 09:59:10 +0530
Message-Id: <DHQW60ZTLODV.3C6OG2KUNVSBR@disroot.org>
Cc: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: dw-mshc-common: add option for
 configuring DMA threshold
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>, "Ulf Hansson" <ulfh@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Shawn Lin" <shawn.lin@rock-chips.com>
References: <20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org>
 <20260412-dwmmc-dma-thr-v1-1-75a2f658eee3@disroot.org>
 <6d692d1f-ab67-463a-9135-520a36977d5d@kernel.org>
In-Reply-To: <6d692d1f-ab67-463a-9135-520a36977d5d@kernel.org>

On 2026-04-11 22:27 +02:00, Krzysztof Kozlowski wrote:
> On 11/04/2026 21:43, Kaustabh Chakraborty wrote:
>> Some controllers, such as certain Exynos SDIO ones, are unable to
>> perform DMA transfers of small amount of bytes properly. Add a property
>> to configure the DMA transfer threshold.
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml          | 8 +=
+++++++
>>  1 file changed, 8 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-comm=
on.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yam=
l
>> index 6f11b2adf1036..1693277957a91 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>> @@ -57,6 +57,14 @@ properties:
>>        force fifo watermark setting accordingly.
>>      $ref: /schemas/types.yaml#/definitions/flag
>> =20
>> +  dma-threshold-bytes:
>> +    description:
>> +      DMA transfer takes place only if the transfer size is equal to or=
 greater
>> +      than the number of bytes defined by the threshold value. Some con=
trollers are
>> +      unable to perform the DMA transfer properly with small amounts of=
 data.
>
> Looks like controller specific, thus should be deducible from the
> compatible.

"samsung,dma-threshold-bytes"? So you also suggest I move it to the
Samsung's schema? Okay.

>
> Best regards,
> Krzysztof

