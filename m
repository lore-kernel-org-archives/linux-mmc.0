Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EF4A0C
	for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777219172; cv=none; b=KTqV32I4Iqb3lYYFOOB1iOZfHazU7eMCMOM04K2p1ELAoi/nkOOai/k5bhFozvUCwWq/jznP7Rlkun+0Z9aoh/4cQ9Hqsie+/5QLxvK5SMRI97E4tJnuDmeBsV2ev1unA5cAcQJV+quOUNNSqc0QVbIfSXGRvvAiMB8eYUbDTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777219172; c=relaxed/simple;
	bh=UMk17XFATjMPG5dAZfvWBkop20VNCYFQphs6l6VpWHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU13K6jAqSazdC3fsF3uoUQSCAOLXHGcF66fuU8IG8OtU1mqczO+XlGDvd97qaPSPEUvhpXfHUoJkq9Hw7UEc1+SPkpMqErF0EFRKY1j4/J/50WUgX+ajlyk5z5VAU1OLVXA9GZMKfKfTorhd0JvP1Bu//0YYRIYcch4I0YXP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAgc9+dS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAgc9+dS"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8eea23d01f7so519567285a.0
        for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2026 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777219170; x=1777823970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fo7d9J/wg1DQiQ3bpGIsE9EbQmrecHjxaY6UQYi40as=;
        b=VAgc9+dS+g1JhOgn+tSdBUFaEVMqTmzzE9ysAH4AXwVheuD+LiFDNEuX/lfBFKYqbf
         6bYfNT7LhbDPuELhqOz0B37Yvc+ricedsvPP/xlztDTCtteS7t6imA9TqWw0cKaKmJ46
         N6DM5l5SI2lcjIwd6XroFWboRtz7O6UGfxQ/dWqHLSX/Q8GWm8cFpdBaL4Mz5CXzMmAB
         hVGAksBMijbEm8Ud1mdK0s/+y3q6I4TB588wQ0DsR1zkpzNfoG3/eMFdDxRgdopmyySO
         KZdla7W8byMYz6K8lb3CyK2GqFZaKRvUh90zoFOHkG803fcg+9jlHgw+Aa0Ct2h1JxTS
         29Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777219170; x=1777823970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fo7d9J/wg1DQiQ3bpGIsE9EbQmrecHjxaY6UQYi40as=;
        b=auEL6k0zpd9qqud8K/0JcMisgRriDWEesOpv8KP28BSXY4OXVF7GHUSbVwGlsohND7
         8+c0uwEbgkwaZur2S5gtu0JG92Tw9u+qLPAl7bfX1+FFdib8rd7UM+hy/KomvGZTm/IN
         XWqMfzATTY3S+TaBAydCnnXIqT7SgB9SZ2PFTebya5cD7AKRfRm79BYFEyDzu6iYZEXr
         O7Gqsj2qxo3587FCCI+V0IwCoRyl8K6sUUq69AnuwbvZuuXkwcoqYf2TrEKtoqqbA45D
         sup4JwTyXHoeic6wLqI3oMWEbi6jaYrd8x6rIpYe+O70IEPaphKlUb/QqjMCk35fvT4W
         hImg==
X-Forwarded-Encrypted: i=1; AFNElJ/tgGg9AZOS7rspgvLDaniP4JXKJFuLO7xRrPXUXTaOGQ4AUWPbIfDe+tUjMSQrOJ29iu+FBfl5j0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytef0mkHWs9m7PrRMiJnAIoV/CW6ZWVbLC1897rbRKZZqFdjWK
	t2AV+dgJHrR5F/QJOKLXoANkCt2weaaJV5nN45lLXVA/Du3nFaT3rfoM
X-Gm-Gg: AeBDievXxNV9NFxVKY1Lz8747GrOJSuldSFN2HqoBhNHyn74nIVtks/AHNYvCbj8Exy
	mEDT1+MouqzGpPkFvvJ1JaT5pHm1u5gYEiRn7IPlPI/W1js+7NR3mYNWf+3NRZqvE/3V6NlT54W
	O559SUnt4BlVquowKsYFB1zKeyOqDOfnHcsf8zLKW+eacwYOFUZvSL7wgiiUnnGY1x71w8rKkMZ
	Fs0HIwl6ns9OIxXi/PZFCObsvIe7GgDxexu2nPU/haUE62pc7YuWh+oAjUje5m9IXR7Wniaxwnw
	FdSTJ6pQpC/rnzrllJ4ZyduVr7XNM7XsXX/jxt77xYVrCzOMuZMgnDapj6l/6zATVQfci/bCsVM
	2fh/Mjj8u5R6Q1t/pAQuo5GSo4UihhZmj8VN+HvnA+rTr6vEFDOnrhl3DN6leGqxy2FrnRzKQIR
	JMqye/AHb9Djsu7815Z1vezZaq15NT09AyWF+BY0OC1izTctHdSZiQbmzsMOeRRkjlZhnhrvSgQ
	ZDgq8OXJKbn
X-Received: by 2002:a05:620a:4614:b0:8cd:8ee1:2eec with SMTP id af79cd13be357-8e78bce8d37mr5701845685a.0.1777219170249;
        Sun, 26 Apr 2026 08:59:30 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-17-68-229.pitbpa.fios.verizon.net. [108.17.68.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb795sm2404340585a.25.2026.04.26.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 08:59:29 -0700 (PDT)
Date: Sun, 26 Apr 2026 11:59:27 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@ozlabs.org>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: litex_mmc: Set mandatory idle clocks before
 CMD0
Message-ID: <ae42XyRH0Hsh6ByB@errol.ini.cmu.edu>
References: <20260426112016.1370929-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426112016.1370929-1-inochiama@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Sun, Apr 26, 2026 at 07:20:13PM +0800, Inochi Amaoto wrote:
> The litex_mmc driver assumes the card is already probed in the BIOS
> and skip the phy initialization. This will cause the command fail
> like the following when the old card is unplugged and then insert
> a new card:
> 
> [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> 
> Add required clock settings and initialization for the CMD 0, so it can
> probe the new card.
> 
> Changed from v2:
> - https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
> 1. Remove the added function forward reference and add a new patch
>    for moving litex_mmc_setclk() function
> 
> Change from v1:
> - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> 1. use fsleep to replace udelay
> 
> Inochi Amaoto (2):
>   mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
>   mmc: litex_mmc: Set mandatory idle clocks before CMD0

For the whole series:

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel
