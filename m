Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CD191F63;
	Thu, 29 Aug 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931727; cv=none; b=Fh8znQ8wHX+MGPVxfqnV/uqAHoLoFaeryqx7/vd9gfvAluYHvl53G9JtQNDT72YkLG6bpmE4jDFY6SB6kGsg6vI0g+s8OlEeSS+ZyrN7sm+58r4EpBAFL97KUdnizlJoRUrZDFNymXGlisBH02Xdq1YHC+jlnArL9fgoD7oL4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931727; c=relaxed/simple;
	bh=6XOmQDVFjQgc2CKL6kanHnYaPJO2r+OHXS5SQCEPjBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mip9e8/9q2I6RIY/n2JnkiScPAFEGhNJP1NsvmnHotitx3MWLct02U1DCPuuqD/bt9gc0I97vxwmj9VkOI7BgC4r7nkjmVLRb0Pk3M1gyy7OZjxrHFlgp3wXuGOhJiGRTAsDR3Wbo8ldYnRuKdIJ66Mg/hpLzWsOPIw3YsobndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bTJjLA5c; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bTJjLA5c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FJSZahwc40ZHt4JyXqSTTDfaFMrVzETSzLCNlx+UK3g=; b=bTJjLA5ckKx6GUELjopKDUZ56B
	ZGQu5BZgKWmE1yYHFzp64o0YhCoCdzLqrnBGZRMK7uY36Xi4tD7L3lM+SEEP9lPCstTTNOQ3SrAda
	nxxl/4faVYNB458Ru5qDawcLuslkZjqBWtMhRikYeoWqi2eMIh4UZFOuBQqvCCMMK1RsCfd+D/aB/
	QlBfYnmWylCbhlo7P2fSIz8aDFDgk5HbaNpZcAOqtNpjg3ECztszmqqeU/0CkY81SKuhdC+Cmc5RC
	wi3D9FLL8TBcTToPIN2FjARC+H+nvHQUU2hYgCA6qVIMhwOLNrKzqIPZj+lIf6czom5U7rApowgXg
	wzUb3Lbw==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjdXN-0003Yq-3K; Thu, 29 Aug 2024 13:42:01 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v5 0/3] Add dw_mmc support for rk3576
Date: Thu, 29 Aug 2024 13:43:17 +0200
Message-ID: <2596461.otXNkdZ6W1@diego>
In-Reply-To:
 <010201919996ef8a-db8bbe89-3c18-4dc3-bd0c-6498f09d978a-000000@eu-west-1.amazonses.com>
References:
 <010201919996ef8a-db8bbe89-3c18-4dc3-bd0c-6498f09d978a-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 28. August 2024, 17:24:51 CEST schrieb Detlev Casanova:
> The SD card controller on the rk3576 SoC stores the phase settings into
> the dw_mmc controller, so the code has to be adapted to implement that.
> 
> Although the feature can be detected through the USRID register value, the
> decision to use it is based on the compatible.
> 
> The compatible for rk3576 is added in its own group of compatible to mark
> that all devices compatible with rk3576 have internal phase settings and
> don't have the ciu-drive and ciu-sample clocks.
> 
> Changes since v4:
> - Drop commit that ignores phase above 270 degrees
> - Use a bool instead of int for internal_phase field
> - Fix pahse typo

Sending through some Amazon thing broke your message-ids in this series
too.


