Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5068426D29;
	Mon, 29 Jun 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746610; cv=none; b=Rb2SQCgiYof/5eTbg9Yr/5EVaGHZgghVAdpgUQKJYmSUrpVzLK/KdcE2md4IUoa1zdkLtMBsBT+/nA4fl1RT6XJHy1wFc6iTZfjnnX1LT1AV7lukw6ob3QBel5Wh3oRl7xi2ifYnfxx3UTPtkSEY632lIJyxLjhPnxMKEwmyTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746610; c=relaxed/simple;
	bh=ikG8LyC1XcdBJf6tJzF7Bt/BQgmZRgtL19n+WxN3KCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEfA8WcMa/z8z/haPaMwFMUHbtSy0y1BWIvWmhF/boI/G2upFHIC7oNI9ttta+3OAPj5DbGk48FGeTR57S4l2H1eDZl+gACVxFFw91Qgja2bQ+vBBu+XIx9e5wnA7ucH95GCsHiHZjaV/avOj4V+IBwCwjmjHGPsC7DtZKv9ULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MttTyO8L; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MttTyO8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782746608; x=1814282608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikG8LyC1XcdBJf6tJzF7Bt/BQgmZRgtL19n+WxN3KCI=;
  b=MttTyO8L1ct2KvTGJaLRWCVwN4SGxjOmgbnzswLlWgeVBPQztTpu7zLz
   wsrnu0grXvnBch0n7/+Cl3tMFTvh7teNu57Kor2zEq2CCYhQ7XC04xx0k
   vHSJmGfmQUXLv8Z1OaqA+i3ATFtt0fC62JhMwpvPxzKzdLySvjIWWiQ5l
   dPyrrI1d27HLaE4EPVg9xSk3VpRnuCLvdNH3IZeX3b5RvXqOiUA2jphGn
   At4GQ1cJyqlQgzGB3K6rBFOMJWwyY5cZxVBdvVnnqEI4PfJ6YB752Rsl9
   utHl3TVPTXwyX9wRbZTmK+P2n+TGc58ppdron3g+Mxc36nAmsfrGGzgpe
   g==;
X-CSE-ConnectionGUID: 1a3yruufQASLYQzulWkzEw==
X-CSE-MsgGUID: 6EZfrAeSS0eCEnvQw11iUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94023536"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94023536"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:23:26 -0700
X-CSE-ConnectionGUID: 7N2MW441QaazjVGcO5Si8w==
X-CSE-MsgGUID: QtCGyfNORrCYVEX/UtpPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="245635032"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:23:22 -0700
Date: Mon, 29 Jun 2026 18:23:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
Message-ID: <akKN59lv55CXS3HU@ashevche-desk.local>
References: <20260629135917.1308621-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 03:56:29PM +0200, Arnd Bergmann wrote:

> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
> 
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.

Oh, that's nice!

...

> +/**
> + * gpiod_name() - get a name to print for a gpio descriptor
> + * @desc: gpio or NULL pointer to query
> + *
> + * Returns:
> + * The desc->name field or a dummy string for unknown GPIOs.
> + */
> +const char *gpiod_name(const struct gpio_desc *desc)
> +{
> +	return desc ? desc->name : "(no gpio)";

Can we get into here with wrong (error pointer descriptor)? Shouldn't you call
one of validate_desc() / VALIDATE_DESC()?

Also not sure if "(no gpio)" is a good choice. "not requested"? "not provided"?

> +}

...

> +static inline const char *gpiod_name(const struct gpio_desc *desc)
> +{
> +	WARN_ON(desc);
> +	return "(no gpio)";

Hmm... This will be a second copy with a slight potential of going apart from
the other case. Perhaps a #define? (Yes, yes, I understand that there are pros
and cons, in particular readability with define is questionable.)

> +}

-- 
With Best Regards,
Andy Shevchenko


