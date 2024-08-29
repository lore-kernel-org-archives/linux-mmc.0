Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1D191F86;
	Thu, 29 Aug 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931647; cv=none; b=WH8UM8/wZDU+1yPp0s15GCOKtfYaAmI6cKHvhllM6/tBJ2KmQOctWMvLYZ+481J1pPtDu5LEHxbUg8t6zVzFW6UQn9IIO7EdcHaw6nlB3mGRwdaxYBHD9HajSIH/1wx05i5LZ9qtOZOyj3YopCrU8qNujIQwXqUJ5+W9nRL9Wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931647; c=relaxed/simple;
	bh=Nt7ZZX0x6F3sy+BZW/fe8OCh3YjOwY0+2wkW9tHqskA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFHivANv1+N7IFNWXsgVCgJZf+AOLZAXQYB6oK1OM1ELfReV6W5gnjygz0pS5FBVCLq3AjF4NtH65aXYCxyHV8zEjCf/kmSmgKiF0XHlXJ7DKZhPUSHUdQcXETF52uU2aw7B9ZYw95JRjwRiiG9xgEE/QjxLul8ExA3nVuhHV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=feW1dFfr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="feW1dFfr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vffnevxmTo7hNckZnJnx5YQo6t8J0qHcb2yiWeO+Uk8=; b=feW1dFfrXYN8IpusNEi38wBDIJ
	YMkD1E977vq8flu4X4fhhQZKsXFHHVh8xbj+MeTQ0RowQQjhEJa+V9g4oRfVtmvjH2ChBrrf+Xqfp
	zL+7IFauUGi7nfDkNXAUABAGsZp1Cc7RktJCOmVtVSDpWAP6RmryJ7+DVaa2zDbWHg2YiAAx/zdWy
	Bg/D1Uvl3vR78wVrypEm7fvoVLioqiBwEqVqmmDKOAirr+kZLZDxjA/8Fr1EIPzYPv7gZegwp8A5h
	dRt5QYzYb4sJuhhLTaeupPwMs1pXG8mof1J11YY1wzkW1kIb0tDVJcU6iMKvwiTtvx8edihTfFewb
	odxHuTkw==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjdW3-0003YD-Nm; Thu, 29 Aug 2024 13:40:39 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v5 2/3] mmc: dw_mmc-rockchip: Add internal phase support
Date: Thu, 29 Aug 2024 13:41:56 +0200
Message-ID: <2355828.22IY78Rhhi@diego>
In-Reply-To:
 <010201919996fdae-8a9f843e-00a8-4131-98bf-a9da4ed04bfd-000000@eu-west-1.amazonses.com>
References:
 <20240828152446.42896-1-detlev.casanova@collabora.com>
 <010201919996fdae-8a9f843e-00a8-4131-98bf-a9da4ed04bfd-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 28. August 2024, 17:24:55 CEST schrieb Detlev Casanova:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Some Rockchip devices put the phase settings into the dw_mmc controller.
> 
> When the feature is present, the ciu-drive and ciu-sample clocks are
> not used and the phase configuration is done directly through the mmc
> controller.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


