Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3A45DF42;
	Wed, 16 Sep 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544397; cv=none; b=OZkKQ+KbiX6zlEgGmfARm4taMFBMVF7UIs74G6eQgS1FuKMJihLu35tUBv547b/OqONWuRXf3tW+688d0LjBrhXKr2xGna9A7aV/De1MWlff1JOh52vWHWjbKbiSh0KPzJxD+llGZK2TsWeX2XtTgIlWAYkZod2uaye81r618Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544397; c=relaxed/simple;
	bh=lxu9Ou0bZy932xJS7yPyNLopQ5ChUdeYBAlUXA8Z9O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9+z7sPmbIcY4yCM+4tgMpnRKPtt8QEsQTPqn7gL1lEp1JDmMiR6dJdLUhaur4EXWzXHJokMxcF8SM7ltBoVoELigP6GS/RZxVUX4BsmaompC1JfMjA8DCYUEsXTnuBC04YmzdUIlh9RuD6zpYPzSYGmPY8+VgMPMSq5/gxaejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJWJh5xh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJWJh5xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F041F000FF;
	Wed, 16 Sep 2026 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789544374;
	bh=u+XkQxt2u0WvRGPFfPUiOTOwsR11da5RzJPTX5eroTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oJWJh5xhSLLQz27/6XHNQ66B2I8GYLl4B0zT3QWbEs440kNXKYObiJh+bW4mf8hi3
	 PSap+9LOC99YFGRrvfYx/SZkSAHMu/UmBXXBhm9OAIwxpWRdJfvQr7A6eCUM9YdkTP
	 BKApEqjvynbTJKWMR3ZP4430EzDicEt3SvckM19U=
Date: Wed, 16 Sep 2026 08:37:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: sdio: Convert to
 devm_mmc_alloc_host()
Message-ID: <2026091633-viscous-cinnamon-7688@gregkh>
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-2-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915132052.273212-2-ulf.hansson@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 03:20:45PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> Simplify the code by converting from mmc_alloc_host() to the resource
> managed devm_mmc_alloc_host().
> 
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> ---
>  drivers/staging/greybus/sdio.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
