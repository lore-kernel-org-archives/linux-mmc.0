Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794651244;
	b=Sy5H0Amn59Ez0D4TjKli8Ac1EbMAX8g+61vWeKaH5wVJ5/TrxegiAyLG0gNSZDArxucT
	 u2veb49JbPR1unFBFVBsJn38Er9Fh7MymBTbP+zD5/Hfbzfc6H8LU5t5POyBqaV1DeMKU
	 muY8myvQaEY8MMeu9ByjBeKAG/ow6Oo1DS6c5KMER965CxtwU/z06vfRt0/iNgj6x0hUL
	 nvBQW6yuRrOTTZWDZOIdsEtSoh1Bljie9juRi+GFmiuyN4RmLA4bLy/fJDkJbQyMK5/+I
	 67uIo/ciiqtYCU9cc9kjCgzLMfgk/N/OxjL5HlSjIL4n9PTJpcyRIOEXIPL4P0jheew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794651244;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SB73NSyM9IDD31uAayyVRUqA94r4RoQKPelrn7GTAjE=;
	b=AfnMwjIAT6QruHuI3u5NsiH73IwTV9lD7bNQBBVmh0UWIY6KH95OqyBN0rfTLIKctXOv
	 9Cv0sK7fNawiuUGGuF2dNcyC3LCCtks5SrUaISziNkG33REdbHw2Ifh1OF5RCQjY7B77A
	 6/93IaIb1VWGlXzZnW/BYvfYxEzn1oJpjQYHW3imIRCHOz5LrJmXxqeSWakAJYRCCbgG/
	 N8xxyitMGr5rpHHnFepqPoK/rlV+uCBhKGSgOaoDVA6leAY4GZuKuif8I8MnLgvqNj69Q
	 B025FeLjvEhL+3VY97V+v3A/J0VAeEFjYm92fuQZLr3r0YM3eBonklNCLVAVwUPssLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=N02D2b3b;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6F606A32D;
	Sat, 14 Nov 2026 10:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A6F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=N02D2b3b
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F056D10E988;
	Sat, 14 Nov 2026 11:13:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794651233;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SB73NSyM9IDD31uAayyVRUqA94r4RoQKPelrn7GTAjE=;
	b=N02D2b3beYxmdyVWuxq2DIFbj4k0uds9ayUfn6iXl2pkTt9f+I5uts4pP0PtRM2Q5pk9qz
	hvDoZeJqQ6afVUn8uqnsHnllNg8UjbA0Z+vxzsAmROQbCK5iofs55grgqYk2Qj183Gq03s
	u3Sq0cVX1eDc/f/nwezT3kBi7NTzeEeP3hHy0KaYXORo/CzfxTXGG1PK+/N5mYjwTs4+71
	mjrBr+UCchPV0oyb4RUBdq0y7sjzKU98HFV1VSPMURxSGCxvSKx+WAPgKafkrOhBtTf81t
	y2GYq6ngM7uR2Hy272blLfddU7HYSGRfy61mQm1kc6BOXlQQpf+kh5hv4z3cvQ==
Message-ID: <73cca072-583d-4601-8953-6f2769c6cb19@nabladev.com>
Date: Sat, 14 Nov 2026 02:00:42 +0100
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
To: Christophe KERELLO <christophe.kerello@foss.st.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>, kernel@dh-electronics.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20261030215427.488298-1-marex@nabladev.com>
 <CAPx+jO8sc8gbxNQTjK2tx+1UPLqwwEof3E9vknHNc4kmbeB7oA@mail.gmail.com>
 <51207e63-ec60-4805-bf6a-b10647ee3866@nabladev.com>
 <CAPx+jO89Z0Z241L1jyB_3sUygdEwGicqT-WfHc6ppG8egHUO2w@mail.gmail.com>
 <c3cbd7ab-e689-4a9b-b311-af43980738d2@nabladev.com>
 <CAPx+jO8=nVBUuOQ==Q66nOnH+VeXur88DetmETe8qmOiS_NCWQ@mail.gmail.com>
 <e996f9ab-6373-4a27-b5ae-591ba33845c5@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <e996f9ab-6373-4a27-b5ae-591ba33845c5@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/13/26 5:53 PM, Christophe KERELLO wrote:
> Hello Ulf,
> 
> On 11/13/26 12:46, Ulf Hansson wrote:
>> On Thu, Nov 12, 2026 at 7:26 AM Marek Vasut <marex@nabladev.com> wrote:
>>> On 11/11/26 12:45 PM, Ulf Hansson wrote:
>>>
>>> Hello Ulf,
>>>
>>>>>>> -       if (ios.power_mode == MMC_POWER_OFF) {
>>>>>>> +       if (ios.power_mode == MMC_POWER_OFF ||
>>>>>>> +           ios.power_mode == MMC_POWER_UP) {
>>>>>>>                    /* Only a reset could power-off sdmmc */
>>>>>>>                    reset_control_assert(host->rst);
>>>>>>>                    udelay(2);
>>>>>> What exactly will this reset?
>>>>> The controller.
>>>> Okay, I see.
>>>>
>>>> In that case, this reset also makes us reset preceding updates to any
>>>> other registers, for example the clock register. I would not recommend
>>>> doing that here, but perhaps there is no better option.
>>> Does that pose a problem in the MMC_POWER_OFF/UP state ? I agree this
>>> would pose a problem in the MMC_POWER_ON state, but here the card is 
>>> not ON.
>> I think it is a problem, yes. If you have a closer look at what
>> happens in mmci_set_ios(), I think you will agree.
>>
>>>> If I may I suggest an alternative solution, perhaps we can manage this
>>>> in the ->runtime_resume() callback instead. If the power_mode ==
>>>> MMC_POWER_OFF, perhaps do this reset there instead? Would that work?
>> Can you try this?
> 
> I have sent a new patch based on your proposal:
> https://lore.kernel.org/linux-mmc/20261113-fix-resume-reset- 
> v1-1-115b3da5764d@foss.st.com/
> 
> It works fine on my side.
> 
> Hi Marek,
> Could you also test it on your board to confirm that it fixes the issue 
> you reported?
This works too, thanks .
