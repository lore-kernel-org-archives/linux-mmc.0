Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84D47D924;
	Tue,  5 May 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979136; cv=none; b=pMa0BxBg9kNRqbaakCJJXii31XfC4VKJesP7EaDyIYHkQ0coF8zV4ovwBDFa2sN5LRiOGEvTGowBIHC9Po5WwaeWnX0+l7Pu9MKqgbOv+C6CfsdaxaHnR9prlcmU6lrxCdYl+0se+iudpe3HfOu2mBQyTsY8625oPHeYbLfThMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979136; c=relaxed/simple;
	bh=DvKtsfIISoVDBYaYachHe0imFPvk68k0TR1DsgJ2kmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWcKGejubzskLIe4oImBr7kDZkdF2b3Z8FBaLElbq9O7hpfFa8BPRISYVzS4qw42OI+T9PfxtEFGUQYPWGm+5E3a2q3eslqjtvYttqe/6Ba7PIo6fKVxBv62qxsymCN8Nr5pbxGpgzxY3x+R9cov2bpnG813pcjANIj9iM0asjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+IJ+p6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+IJ+p6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D525CC2BCB9;
	Tue,  5 May 2026 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777979136;
	bh=DvKtsfIISoVDBYaYachHe0imFPvk68k0TR1DsgJ2kmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+IJ+p6WP0nFDiaaSYezOWU0KrWKfvpgs5gBylPOR6bfqaQIRfxYrAk8eGg6vEp1e
	 buu20sZSM3PYsenVe4K3c+yzxDz4sNif4ASr8W9TxHk7vZpPzPT2uD4uSpbQEf6u1K
	 8XnWfZR6vhbFpH0mkFGogFJS8qKC12kKWHnLllQ0=
Date: Tue, 5 May 2026 13:05:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Alex Dubov <oakad@yahoo.com>, Maxim Levitsky <maximlevitsky@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memstick: Constify the driver id_table
Message-ID: <2026050515-scorch-audible-3d2e@gregkh>
References: <20260505103927.234104-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505103927.234104-2-krzysztof.kozlowski@oss.qualcomm.com>

On Tue, May 05, 2026 at 12:39:28PM +0200, Krzysztof Kozlowski wrote:
> Just like all other driver structures, the id_table should never be
> modified by core subsystem parts.  Constify this member and actual data
> structures for increased code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> This should probably go via memstick tree with mmc ack. Or other way
> around.
> ---
>  drivers/memstick/host/tifm_ms.c | 2 +-
>  drivers/misc/tifm_core.c        | 4 ++--

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

