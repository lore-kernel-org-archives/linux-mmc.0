Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E938F97;
	Mon,  4 Nov 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702311; cv=none; b=NkNHK3qxkutTpqjf60qaCvDi5FZsX7mBJPfTo5KFHfVZAEk9DWpvtrfW33kk22OGm63tnRjaFdUPjvdoqPQdQKMInBoyudmF/bYla9oCdKEFKumXNNcEBRSjXF6axTLz1hm/pJqxHbcDBb781mTFnQ6wKOr9AO+GIskbBLG89d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702311; c=relaxed/simple;
	bh=w5IzZhNS0pyq3dZVWuxnPxZjGqxLGha5AZ2HRi5kLkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnsNBBaOXrfnl4CVvD8ekiqUfdllaM3XkjVjs42+/g7/Gs+IhQA7/fF3R14VpgngZJPNoeWdpaAS9hPsJ+JmimYvGQylyIRGLNt3HXq1bVoWF+4AxYHDUdOJ7HsMNPWbTwqnu9i9P1idw/+baHVTsEoj02JeKV/Uz0FV23fiksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTaamrWS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTaamrWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730702309; x=1762238309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w5IzZhNS0pyq3dZVWuxnPxZjGqxLGha5AZ2HRi5kLkE=;
  b=OTaamrWSJbqHLI7TPRMbRmth9uYMaJqm14xfNVKZfKR18SmZENsESSX1
   arUH5nH/DEnfY1svaUINJZwhEFN0+JTAYDQRNdLfSV1MLBw7m94VB/2+k
   TjPtgoTjMRIBLcZCsUD0Ia0l2i87nzm7HiuF4YOUTMg/qG8sH515fpcKm
   N2VP+O2iIwAtbtmqG28QfXAVGpaRU/AgEEUbS3DaQRqbS9Zp9KBJxIuJY
   +eIjmnYuTsCLKZU1nfQifHNvSRjGUxyyGxs3VE+mmbn/kzP8K1ZEiJy3O
   ifKMJO96ASnenxj/JgEylYTM7pUTrFpITHyJ695iT2TxLXbWlxS9R2xbA
   g==;
X-CSE-ConnectionGUID: Lm5ESs1uRje2v3vUil3Pbw==
X-CSE-MsgGUID: Nmy7KQwYQwSUUrrncwj4Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29801130"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29801130"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:38:24 -0800
X-CSE-ConnectionGUID: 3u7azeIwSYCzt9aSZon4Rw==
X-CSE-MsgGUID: XYoWjP+nSS+br4byYIhU6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114348431"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:38:19 -0800
Message-ID: <8383c639-66ce-4252-b3e8-734cb6688b44@intel.com>
Date: Mon, 4 Nov 2024 08:38:14 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mmc: host: sdhci-esdhc-imx: implement emmc
 hardware reset
To: Josua Mayer <josua@solid-run.com>, Haibo Chen <haibo.chen@nxp.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, Yazan Shhady
 <yazan.shhady@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>,
 imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 13:42, Josua Mayer wrote:
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v3:
> - reused existing control register definition from sdhci-esdhc.h
>   (Reported-by: Bough Chen <haibo.chen@nxp.com>)
> - placed both control register mask definitions next to each other
> - fixed timeout write register name
> - Link to v2: https://lore.kernel.org/r/20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com
> 
> Changes in v2:
> - replaced udelay with usleep_range
>   (Reported-by: Adrian Hunter <adrian.hunter@intel.com>)
> - added comments for delay values
>   (Reported-by: Peng Fan <peng.fan@nxp.com>)
> - delay values based on JEDEC Standard No. 84-B51, 6.15.10 H/W Reset Operation,
>   on page 159
>   (Thanks to Bough Chen <haibo.chen@nxp.com>)
> - added a second patch demonstrating a cosmetic issue revealed by first
>   patch - it bothered me during development but is not important
> - Link to v1: https://lore.kernel.org/r/20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com
> 
> ---
> Josua Mayer (2):
>       mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
>       mmc: host: sdhci-esdhc-imx: update esdhc sysctl dtocv bitmask

For both:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


