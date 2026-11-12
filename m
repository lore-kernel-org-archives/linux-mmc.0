Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464797;
	b=ED4LVLhTbMwP8l+UhHNb9XOe8tSsXVB3QyhJ4DmH9vmImzXpEGCe0/J1hd1TWJBI0ELf
	 Xa3DHBH8Ts08HHO8A1Q//FSYHJ5tCU/NzgtlH01LSTZRaFzzLxGV+2y78sXYDfZkpxbbf
	 NUVTsW49QEpfYnSOGbYz1URauKQZ2yuX9+abnY92dMii5S5r6TBU+oGwbOUP44gI9dZ6P
	 7+GpBKflC9wVxyQR2r9JQ7MZV5YeVNI6aBXhlLKZ4wRvY7q35NVE0VNdOYEPHJ/R6uPzW
	 VfwSjROcUB991frt0AMJNqPbI7xqHquTpKWM2IWlzB7HPHoNa0X6tInZ00l/NFMmVYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464797;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=HQqBrTbEZxsA8ilEZ7vX7+ePIXnnagD5L9RGTt8hUKU=;
	b=GlbrxLeaL7mTnjut/gx/g8i14oVTpl3yPJPhoQ3nJJscn1yVwqo59xXd1lWuO1p/qlCI
	 IRRfff0+3CEnRntAdUGLETCZfyutYiO3kXSEzsmsbKb3QdZVUyq7NxqNrbXhECX608Fis
	 +mR9tmXFL9EJiPLp2GEfgV8BLyKUeYso51CeeQ3hD7LpHWgAONBpHmpuUEWTlMAogVCOX
	 dnF5lxAZj+FcAThG/PeREwG3IBDrY3HsoImdTbJzJTZvzZ9xaKcsKxzFqgkbmUrruQU8r
	 oo8kHihauDFce7d/njQS1NLPgVgZcfWI854PyB+EUXNTRmziDztkW4uA5xDeWYHDrGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UrOqU3G3;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C78606A33D;
	Thu, 12 Nov 2026 06:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C78606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UrOqU3G3
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2AEC10E394;
	Thu, 12 Nov 2026 07:26:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794464784;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HQqBrTbEZxsA8ilEZ7vX7+ePIXnnagD5L9RGTt8hUKU=;
	b=UrOqU3G31RyOiOqFQExBFk/gH/aWva67ebwxY/V4/r0OTjA6A1UFpegkRCSIk+tE0mFD33
	Wtq9qE24rFg0BigDkfjPT5qwA8YrIwZQ3w3riH6OlpJm2nnWA/jN/cHH7CsoiG+Zjv5H8s
	E/36RtsB4sX3SoI6dWvu3cJq9oiVsR3iyJSf5l3MVmnzmE8thu8sBqXr3R3PmsiNsje4+B
	u/2Sg8e5L1PhKDwi2FUzuKeGyk3GJFv1gMY3l1XSVsP4WkfoC2zBLgDqUQQVb1pWSd3hmx
	oklxgLxwfH6TWsiJPNTQWy0acnm0ueUh9EjoilfioFqZJTV4QX2/rNgY2fFCNA==
Message-ID: <c3cbd7ab-e689-4a9b-b311-af43980738d2@nabladev.com>
Date: Thu, 12 Nov 2026 02:22:10 +0100
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
 <51207e63-ec60-4805-bf6a-b10647ee3866@nabladev.com>
 <CAPx+jO89Z0Z241L1jyB_3sUygdEwGicqT-WfHc6ppG8egHUO2w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAPx+jO89Z0Z241L1jyB_3sUygdEwGicqT-WfHc6ppG8egHUO2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/11/26 12:45 PM, Ulf Hansson wrote:

Hello Ulf,

>>>> -       if (ios.power_mode == MMC_POWER_OFF) {
>>>> +       if (ios.power_mode == MMC_POWER_OFF ||
>>>> +           ios.power_mode == MMC_POWER_UP) {
>>>>                   /* Only a reset could power-off sdmmc */
>>>>                   reset_control_assert(host->rst);
>>>>                   udelay(2);
>>>
>>> What exactly will this reset?
>> The controller.
> 
> Okay, I see.
> 
> In that case, this reset also makes us reset preceding updates to any
> other registers, for example the clock register. I would not recommend
> doing that here, but perhaps there is no better option.

Does that pose a problem in the MMC_POWER_OFF/UP state ? I agree this 
would pose a problem in the MMC_POWER_ON state, but here the card is not ON.

> If I may I suggest an alternative solution, perhaps we can manage this
> in the ->runtime_resume() callback instead. If the power_mode ==
> MMC_POWER_OFF, perhaps do this reset there instead? Would that work?
> 
> Anothing thing that caught my eyes was the MCI_STM32_PWR_CYC bit that
> gets written at MMC_POWER_OFF. This bit becomes cached in
> host->pwr_reg, hence it's also rewritten at MMC_POWER_ON. Is that
> intentional?
I _think_ so, this seems to be used to power cycle the card.
