Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CC20408A
	for <linux-mmc@vger.kernel.org>; Thu,  6 Mar 2025 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301622; cv=none; b=qZ5HEs3TImm93Bq4y4CGBGBTrNaYulFbPoBD4CoV0TeSTbzzbIFk+2aCO4TlGdhn/OdW/umbvXOXt8chG5XBRx95U0dpACfNpSliWzn/1Nu7h4QER7JwOGpPXPhHZVvSAQniCXSRmW3+wpNVn74J9BxG+JNsxONCDfduTmmC3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301622; c=relaxed/simple;
	bh=qa2UV/Sy+MaIwgCS6wwLKc3HutozQpnXULdpZhWQNpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnG4aVMkxE1rT2kTH9dItfvvF3MFkCuXjyjenHQhR20vp9hzivClbUc43LqhxABvL8UuGfxbvrL/PIjkADdp/srFWb34Ur3Uo/gpJTFr+DJ5p4sAB+/azwm+3X3Bs1k/VK1TfJaZ79j+gnz7BxyFBsOTfGFRomQwODNQS1vpT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ErCZu1Wu; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ErCZu1Wu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741301615;
 bh=BL399FFBDZ59QPzqtz+58fHUwMJC7+0wO+ycM6zcMQI=;
 b=ErCZu1Wur3KYtsYTbMoANCBQEsyqV5nl252s3xRL3RnsWHNkEmZgRCVNyMh82c2iR1N7ue4Cs
 /o8X36AiDODQhKUUN6eOrhB5V/Mnt87JAu9oj7Ob69Aja5CHJR+FCpW+8znJLjWHFIAp2YtB4sj
 +h035nU5zDJlkxedOd+nXQwf4V/YW9RUY3kEbpJYDQm6OkYD2/7yIcW00JdZ69YwIW3QVcVxgIf
 KujiIWDKwdtcDEUOkG8WQ7Ywgren1yXaHNRMQXx5kMKf126DLElWmsSjOXibrbR/tVJvMhyCkD1
 jBepPUMb/uCQNcZCE5zQpfUnomh6TZxtfUkimmw3JDnw==
X-Forward-Email-ID: 67ca276cc1763851c065c79e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <24a8691f-9faf-4657-b819-183fec3d1a15@kwiboo.se>
Date: Thu, 6 Mar 2025 23:53:27 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible
 string for RK3528
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Yao Zi <ziyao@disroot.org>, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250305214108.1327208-1-jonas@kwiboo.se>
 <20250305214108.1327208-2-jonas@kwiboo.se>
 <20250306-frisky-spiffy-bullmastiff-ad9e49@krzk-bin>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250306-frisky-spiffy-bullmastiff-ad9e49@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2025-03-06 10:36, Krzysztof Kozlowski wrote:
> On Wed, Mar 05, 2025 at 09:41:02PM +0000, Jonas Karlman wrote:
>> The SDHCI controller in Rockchip RK3528 is similar to the one included
>> in RK3588.
>>
>> Add compatible string for the SDHCI controller in RK3528.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
> 
> No power domains here? Post complete support, so this won't have to be
> changed in near future.

To my knowledge this should be complete support. However, there are some
rx/tx tap num and strobe delay num configuration that needs to be tuned
to fully support the faster HS400/HS400ES transfer modes.

For that we could need something like the PHY output/input tap delays
described in mmc/sdhci-am654.yaml. Still unclear to me if the different
delayed used by vendor driver is SoC specific and can live in driver or
if they instead are reference board specific and could be part of the
device tree.

Regards,
Jonas

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

