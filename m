Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370475;
	b=M10foFyFPhOqNV+nNdKpkfIwHzfIosdSsVCXmTxDMrok5sHOTx20AVUw8E1ykTQMTVUd
	 MCJGI69anPfIv2xb+y//UPSeOAiucytdC/EAis9yE1ACuFdokX2QTvLO+qLhhGGhDJRzZ
	 exi9yL9zECELH8AVCHFCEtgFilZbMjhN2ZniY8VgM5Hud5qa9ZYjF0r+p+nAtfnV5VDJM
	 y7CUG4CbwTTGTHU9smg1tG0XPh0NMeTLcACYjoYbYjxGkNT+LRkfUpsE3idhSYWqiyHcw
	 65XCI0468LxuUJCpuIVIb1GOBqqoaHQqlmTwOj8xnz4vnTLyya3kHn0VBCAkOlJZr9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370475;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=3fOO/5TS5MC3uku0IcFyxhEk9H8U26fc9bugwI8TDqQ=;
	b=rOOEhrY9YwwB762UvfhK69g1d3W0jZkJUkSDV4RhNoY4NzKIERRpgxwkJ5O/vRi1qFMO
	 Z72AJExQ3MkvcBL06U40V92IVIbQhY0qZPwamiYKNJPk2dXK6CZu9+7/sgmAkU8VMcNTr
	 yaAYVYGZLb6GjeBWJB1F6dZPU0eYhU+G9jW5Ca9vNK4CJg/6RtLjFkkUOZWyH78ENke3Z
	 maVF4KXAFkvtkv4LrOyCQApE2TJcCUx6FMkxpAqH4YF0OmJf2QxLexVeuztXyfaVprU6g
	 jVU67f83B+BhQmt+V+WbQy+KwT4u6pKPFJ98VKEDev+KpH43AVeeLJ4rdE/SoM3vNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b="JxPsOZ/v";
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774C606A321;
	Wed, 11 Nov 2026 04:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D774C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=JxPsOZ/v
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0BE9410DD7E;
	Wed, 11 Nov 2026 05:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794370469;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3fOO/5TS5MC3uku0IcFyxhEk9H8U26fc9bugwI8TDqQ=;
	b=JxPsOZ/vQsc9ChQPwqoKSIBD5HFyAEFCENBUwOk0ggInk+3gfzcC9vvOaMPE6YGYgeaNi8
	qAzCD82Y2LHRuWypQRfr4IoYSxM3zI908pBCG2iTvbwaL8nxnzjWaXmh/QZ1q3eQnm1JAM
	kPMbtrxwzVAc0kA8MJInhvoD0tKuKsbxKKbBae1Icb2vDUrCDwOP7U9eYlNEYqEpK3ZSUL
	PoUw+ypedIEBIMBR/hpjGnhfKSyvy6BaC2usJRXmbYwI3lzdYJH6dVIMtoYFkpH9s5mtvh
	vJ7OU2mhN+HjUKz/BGgMwcY8TXaSrMkc+61x8+ap2s7qzbmckUjahVvIXoTcDg==
Message-ID: <51207e63-ec60-4805-bf6a-b10647ee3866@nabladev.com>
Date: Wed, 11 Nov 2026 03:27:24 +0100
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
Subject: Re: [PATCH] mmc: mmci: stm32: handle mmc power up
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org,
 Christophe Kerello <christophe.kerello@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
 kernel@dh-electronics.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261030215427.488298-1-marex@nabladev.com>
 <CAPx+jO8sc8gbxNQTjK2tx+1UPLqwwEof3E9vknHNc4kmbeB7oA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAPx+jO8sc8gbxNQTjK2tx+1UPLqwwEof3E9vknHNc4kmbeB7oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/10/26 2:32 PM, Ulf Hansson wrote:
> On Fri, Oct 30, 2026 at 10:54 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> From: Christophe Kerello <christophe.kerello@foss.st.com>
>>
>> Manage MMC POWER UP state like MMC POWER OFF state. In case of low
>> power use cases, it will avoid random initialization timeout. This
>> fixes a failure to switch DDR52 eMMC to 8 bit mode due to -EILSEQ
>> returned from mmc_get_ext_csd() in mmc_compare_ext_csds() called
>> from mmc_select_bus_width() after Standby1 suspend/resume cycle.
>>
>> Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> ---
>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Cc: Christophe Kerello <christophe.kerello@foss.st.com>
>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Cc: Ulf Hansson <ulfh@kernel.org>
>> Cc: kernel@dh-electronics.com
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mmc@vger.kernel.org
>> Cc: linux-stm32@st-md-mailman.stormreply.com
>> ---
>> Marek: Update commit message
>> ---
>>   drivers/mmc/host/mmci_stm32_sdmmc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> index 9dc51859c2e51..659a5040729e9 100644
>> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> @@ -368,7 +368,8 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
>>          if (dlyb && dlyb->ops->set_input_ck)
>>                  dlyb->ops->set_input_ck(dlyb);
>>
>> -       if (ios.power_mode == MMC_POWER_OFF) {
>> +       if (ios.power_mode == MMC_POWER_OFF ||
>> +           ios.power_mode == MMC_POWER_UP) {
>>                  /* Only a reset could power-off sdmmc */
>>                  reset_control_assert(host->rst);
>>                  udelay(2);
> 
> What exactly will this reset?
The controller.
