Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5F13AD11;
	Mon,  5 Aug 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855693; cv=none; b=eT9LhlD8ZslM6eUb/r9K/h/I8ebUR1/WKI4BOhLh7FwYqyrs47pg1xIzyIeIuAQl/zIFXOAmi7ZDjNNNVl7htF3XkHg6VbbLm1HSD47TqcvEzdcgkOi4QpSDDvR4XFqdi2wPrK12O2JncVtzg+NSmWw5JMPy5Y8WReUbCb1HsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855693; c=relaxed/simple;
	bh=562EsOMsTxNo/513EjVttaLWSasgWOtYFHwi01GnFiQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyzrsijaPlx3p2CrzBwwfzOmWb/1BXV4tD335fKmxDttOz0+tpKTQxHzO1OX3eXcqit+MK+kFkKNoQncV25Ka0pTdziPHKtNMFC29wLr7Wl0alPti5FotFFL9RLQKt99mMq1f0ChRsS0fCbJ1ybZFGaLiKfO4u5FOE63U7772SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewMw5G2h; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewMw5G2h"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso13213507a12.1;
        Mon, 05 Aug 2024 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722855690; x=1723460490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w92A5DSLMtWgFu3PG5e7V2aasOF9qr2/85zMzlFL76I=;
        b=ewMw5G2hfb5N7gcErad1/HzRLHk+6Jr6aVl4ox2PAuBYkrSNcj5Xw8CaVPJAWIhhzS
         AK0uN4uKvJsCYiXvwtvab24PO7AOgBV9zLpRWopIcpFYQJegG9VSV6f5oye9NRQdpU+y
         /SzB+P3i0QwWbDNv9wLdhC533iw74mH0QC1HR813zaAsGyXcQio2NuK0yUZUsCaUOHtY
         1PZL3OrbkVG+4KIvKdlB3IpVS8l0Okmug/s9DTElemjXQhO0+FHy16BKO7Iwf+BSASml
         5aHMmpJiOtoJ9PKLJ2FULhrw73Qs3t4Ovj0DNW6c8gPWWW6etgrfFSRi81lgiAFFdp05
         x02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855690; x=1723460490;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w92A5DSLMtWgFu3PG5e7V2aasOF9qr2/85zMzlFL76I=;
        b=NkthOx9SKwsIlAguOLXOTJt/QLwE1GclegdzbdiDiVG5a3ji169Bju3aSAwcuU5I52
         ngW3aldodTEBjCh/lgG9r0GKnKnFJQTrraQ11v9aDUEduB0WIKVM72odF/j8n9CFdybg
         Uwp98SWyHBAojwyHT/gLiiNLL8TA67kSQ97nNiQT3uII3d4z7NL6NFu/08/3k6A1KIyo
         +Db49CiOsG7ePQ5mRvww49Ck7QoyLtgQZHezxtqJjrjk2/FFf8ygCjIm7mKLDAxRvohJ
         y5cBAfyA+JzWXJ8PlsYe2dB7z7GR7L8LaXAqBKZH47G7xXv1VgntEWRxBdM5XnoE9Kol
         H3sg==
X-Forwarded-Encrypted: i=1; AJvYcCXjqkZSUhz6U4feZnDpwtOdXTBnnk0CtGqnxb/oKT19ngsb1CchETAwpo+wf4hBIgdIjKauPA+5hz44DVODZg34an9qxvUoWQY2HpkL/HLLEr6UuvJx2cTNKkP7jWAEuT0nJ3ii57MIwsNJEQyCXDFYnyIoVv2gZ4CrTV8nLJ72CnyHiQ==
X-Gm-Message-State: AOJu0YxTKKHRTvFn4VybY1aevTHaydfPxoOQ3MhmpLOOWuxSp15mz4o4
	J7TLaQdSEtisVtPS5MErbDjw9LGNcImFYgfqLajk35WYo5aUaAhv
X-Google-Smtp-Source: AGHT+IG3bgoM32LacSe8Aeid35LCdMXycqCOoZj2eJ0y9sS0Tr1FkiYG5HntASlHWcu+NtMPW2GNSg==
X-Received: by 2002:aa7:c50e:0:b0:57d:456:e838 with SMTP id 4fb4d7f45d1cf-5b7f57f6c52mr8123532a12.31.1722855689903;
        Mon, 05 Aug 2024 04:01:29 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-255-112-66.business.telecomitalia.it. [95.255.112.66])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f34sm4805088a12.56.2024.08.05.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:01:29 -0700 (PDT)
Message-ID: <66b0b109.050a0220.93681.d015@mx.google.com>
X-Google-Original-Message-ID: <ZrA-9btkfLnpPip-@Ansuel-XPS.>
Date: Mon, 5 Aug 2024 04:54:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
References: <20240804174414.18171-7-ansuelsmth@gmail.com>
 <202408050612.Ya1m6REu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408050612.Ya1m6REu-lkp@intel.com>

On Mon, Aug 05, 2024 at 06:52:04AM +0800, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linus/master v6.11-rc1 next-20240802]
> [cannot apply to mtd/mtd/next mtd/mtd/fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240805-014740
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20240804174414.18171-7-ansuelsmth%40gmail.com
> patch subject: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
> config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408050612.Ya1m6REu-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mtd/parsers/ofpart_airoha.c: In function 'airoha_partitions_post_parse':
>    drivers/mtd/parsers/ofpart_airoha.c:33:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
>       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
>          |                ^~~~~~~
> >> drivers/mtd/parsers/ofpart_airoha.c:33:14: error: assignment to 'struct property *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
>          |              ^
> 
> 
> vim +33 drivers/mtd/parsers/ofpart_airoha.c
> 
>     10	
>     11	int airoha_partitions_post_parse(struct mtd_info *mtd,
>     12					 struct mtd_partition *parts,
>     13					 int nr_parts)
>     14	{
>     15		struct mtd_partition *part;
>     16		int len, a_cells, s_cells;
>     17		struct device_node *pp;
>     18		struct property *prop;
>     19		const __be32 *reg;
>     20		__be32 *new_reg;
>     21	
>     22		part = &parts[nr_parts - 1];
>     23		pp = part->of_node;
>     24	
>     25		/* Skip if ART partition have a valid offset instead of a dynamic one */
>     26		if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
>     27			return 0;
>     28	
>     29		/* ART partition is set at the end of flash - size */
>     30		part->offset = mtd->size - part->size;
>     31	
>     32		/* Update the offset with the new calculate value in DT */
>   > 33		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Mhhh somehow I can't repro this with instructions?
-- 
	Ansuel
