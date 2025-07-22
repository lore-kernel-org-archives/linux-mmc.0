Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D7283FDE
	for <linux-mmc@vger.kernel.org>; Tue, 22 Jul 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212403; cv=none; b=G/7gYsVyhu5Yoame3uQREkHkxYY9NvAwRaO9Zz++xhPg11e11rvgoVQ3sJBiyji0U/c+dgcslU4EODkGA0rhdyThMD/bb12Mnjir2w3qzBC9mnLn7V8SB0iKHApJLKtaljgpcHxCXWB518WP8ABnbO8vDC/c6YTuD7Gkhujjy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212403; c=relaxed/simple;
	bh=r8p8hVZxBnCsNpFZtA5U7in3wSETNlidi4caaOKWZmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsrsR6y422vXYeuCmFcMJ7lkzdVpaDTSLTmEMidAHACojFZaNc00g7AZrUGvmpJT0wzYHuXKiN55DQQr00ftm9XTkLrJ+hKAAJDMRn3qt7v1H8xSU3go2CFzioaKVZLMLMXJ24+lPQO2/dnhmNQb7MGtnDmkRtm/poS+twgc5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LPa92Iwo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LPa92Iwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ehdr
	cvwFtwtG3b1bwdaFy5MfOsGxSF9HKb9WkVVO+s4=; b=LPa92IwoYuCHW59JDOW3
	2m+prX1sp+j+QHc5HL/yMUfiI4pHT5i/gsaCGwyoBAOlzbbmSmOYu6feXeT0/QRC
	VX8QVcW5FNZ/x7utTvnr/jgMj8FmpAYCOnHaCYb8bD1xgXtNesywbw/MgnkO/VKt
	oa5hPrkTyKHMCMaPlpDzXVB10xQAnE1VrmssoxQGnNZ0DBhbIqnc6isrletEEE4A
	WWOY5GLI8gLAjnfbnzG4l6eAw3lr5Ee+ie3E8iti95shIO4Sr5ETOFYMTfwytrmT
	zG5LBsMJZ3NnR1FYaHlgFR0Lr+3StjYwDJMAm1hRFqPwXNNMecZCbU+7Tq9kq8Ff
	Uw==
Received: (qmail 1431599 invoked from network); 22 Jul 2025 21:26:40 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Jul 2025 21:26:40 +0200
X-UD-Smtp-Session: l3s3148p1@sL5Pkok61M4gAwDPXyBWAATEinPyanBm
Date: Tue, 22 Jul 2025 21:26:39 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH RFC/RFT 2/2] mmc: renesas_sdhi: Enable 64-bit polling mode
Message-ID: <aH_l79VIoKFJhZm3@shikoro>
References: <20250630081315.33288-1-biju.das.jz@bp.renesas.com>
 <20250630081315.33288-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630081315.33288-3-biju.das.jz@bp.renesas.com>

On Mon, Jun 30, 2025 at 09:13:11AM +0100, Biju Das wrote:
> Enable 64-bit polling mode for R-Car gen3 and RZ/G2L SoCs.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

