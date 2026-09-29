Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B350E5AA;
	Tue, 29 Sep 2026 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683806; cv=none; b=hEgd749UHhcJAkBVagpqEEplcvObgDn0jDa/Ddn7r3bmH/ORF23KlC0B5BvFVy+8L0gvc2tem3fgQqdNW3qdPRDrAuP3xZfxokEUFQT5AWpLsRXMtUB5GH0S+cHbAJsM/3gIk5wDoq2N8KePJiqkVdNm3sl9Hl2UIeSaxPtHtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683806; c=relaxed/simple;
	bh=0TQIG6b0QhiYyhhVsn09ZaXE0tRmvWDczzbfnRItPCs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iYH6/Lc8nmgvf/dFl5/YsQXRM71QXh8ZP6Exwm5OSzufUiKLjBG3GKMA+JpahV6nyEqmA+ffoKO8VdAY3uujf297UAv7V91w1JJX572vKNFwJ52fQX/tK+IeYwvwRb2+gH0wdANp35GRlevuv2tgiPam02HkSZ0cPrmfnkEp+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Message-ID: <d3b99da7-bc64-4df8-94ab-25080474ee35@mainlining.org>
Date: Tue, 29 Sep 2026 15:09:27 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Subject: Re: [PATCH v3 16/19] thermal: qcom: tsens: Add support for MSM8952
 tsens
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
 <4de27200-3598-47b7-b0af-8f7acd037618@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4de27200-3598-47b7-b0af-8f7acd037618@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

On Tue, 29 Sep 2026 09:11:28 +0200, Daniel Lezcano wrote:
> On 9/21/26 20:19, Muzaffer Kadir via B4 Relay wrote:
>> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>
>> Add MSM8952 support for tsens.
>>
>> Downstream does a lot of advanced things with calculations.
>> But seems like using tsens-v1 directly works too.
> 
> Can you elaborate a bit the changelog please ?
> 
> Thanks
> 

MSM8952 has 11 sensors
and 3200 default slope (according to downstream)

For tests, this is the table for readings:
tsens sensor 0  1  2  3  4  5  6  7  8  9  10
TWRP         32 31 29 28 28 31 30 30 30 32 30
this patch   31 29 31 29 29 31 30 31 31 30 30

Both are read from same device, one after the other,
First upstream then TWRP.
2 degree difference seems reasonable in my idea,
as there is a reboot process happens in between reads and
downstream has more power saving features than this port.

I don't know any way to independently measure temperature.

I reused offsets and slope from downstream.

My commit message wasn't good, I will expand the
commit message by v4.

Best regards,
Muzaffer Kadir
