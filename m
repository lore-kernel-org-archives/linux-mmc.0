Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0F19004F;
	Wed, 10 Jul 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617591; cv=none; b=G4ONQGJOZw5qKPbUt1KDHPB8UUiI3K1wwbEYL1iDwSuCqP9zu7zLT5vpIUyxZJHScuOmfJTaahXK71n8aq3IJ34FUxUSu/ImmYlNSWxVuP56I4RhkHwLnwM4W8fVoo57n7zcl/ZezVKE9o8+w/NeQaEgPoMGyvUGQz1o1hsvV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617591; c=relaxed/simple;
	bh=O90TUUQx+d7jTk9J2Q8dS1mhFLB0RMxcOegUeSAxLyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+KK4XX4j3bWQBn8iu+hnXhpYZ8gYt8/Q07KdD+afJDQjg2PTu7z9Jk+gdCaQ4BvNS+OU+8bbx5KVTPa6Pqp7qIwvLETLP6w38a//gchwaVkh6LNhdbbn6wTZs6l3kleHZuZkyNaz2fns769NLXZ+BbowTgjpI6w3zb0HvXaF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZ1dxzjy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZ1dxzjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720617590; x=1752153590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O90TUUQx+d7jTk9J2Q8dS1mhFLB0RMxcOegUeSAxLyg=;
  b=bZ1dxzjy+PhLIgl+4VjUxN5Iw5W9BCteIduk5xFnOBt1npc5H394Lzpm
   fOoQqu+yydNiVQmEiG5MKbgsRGC5GbpCPmbZnLoHZ3JTF0p8tyVeChojL
   G9MJHlWEgnKbOD9w2rtUpo2St21ZesPd/bxY1OFENShR8xnt4kyXbInQt
   kDoHCA/4U+DAZr9gmogW0oT2mfcB+cE7YO2jODeA9VkjXSWdF1CtE5w7l
   BOeideu29J8JFssxconmrNO3uzovGfW82puYpfMQ+IA+o6DVb6Bq3Mh6r
   rmaBM733lNXdOgfxC2i1Vtt+MDxxNkCsmMFliFZPSwksq+FHmvGV3s/+I
   Q==;
X-CSE-ConnectionGUID: 1zilA0/0QXWPK/43J3HG5A==
X-CSE-MsgGUID: 4zU5Nj5ASHKYSBh71BfqCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35471948"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35471948"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:19:49 -0700
X-CSE-ConnectionGUID: 4pkrzRjdRvGn4yNDTdpFag==
X-CSE-MsgGUID: wdHDs67BR0+uToyXBuDIgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="52605856"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:19:45 -0700
Message-ID: <70473b16-4636-4121-a534-f5095cf51cd9@intel.com>
Date: Wed, 10 Jul 2024 16:19:40 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: add 's32@nxp.com' as relevant mailing
 list for 'sdhci-esdhc-imx' driver
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-4-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240708121018.246476-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/07/24 15:10, Ciprian Costea wrote:
> Since NXP S32G2 and S32G3 SoCs share the SDHCI controller with
> I.MX platforms it would be valuable to add 's32@nxp.com' as a
> relevant mailing list in this area.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a39c237edb95..26b1ec2ba094 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20098,6 +20098,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
>  M:	Haibo Chen <haibo.chen@nxp.com>
>  L:	imx@lists.linux.dev
>  L:	linux-mmc@vger.kernel.org
> +L:	s32@nxp.com
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-esdhc-imx.c
>  

Assuming Haibo has no objections:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
