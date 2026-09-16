Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663345560A;
	Wed, 16 Sep 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544615; cv=none; b=s1ocyH5LU+ZB3nJUKVxv5P+LyE9ORmWv1MBX1IBGFK2m8HwDbMDw0/1JlccKgdHnnz2fNptnR4jszc84AlG3qb3sPumhPzblx1Oyq81cOPmEtc/nwl0pImjdrnqXx2AFcIhuwPXXEPdoXeQRoRnOEiFONdq9PNmX3GPcWRpKhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544615; c=relaxed/simple;
	bh=BWssDij2mg73tyJvk7B58oEzHxtCMXIMbA+cyUEtM6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy7Js6EmoJUDnrGoDusa319OolewVOXyUrXrGW/1AM22X3jPUjEx45MXukO5uHeKm50LcWYtWFoKuEijmzEA8qB4rfwgjd2oRpjVeKdtVC1mJJo8H0I7yVgoxHsNmEiI6Xv9xARqDwutQ0k3qYcJwUbs+FjfuNVhPEPNhcAiyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCciOZAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCciOZAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A5C1F000FF;
	Wed, 16 Sep 2026 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789544601;
	bh=3zF1Fk8kVa6SnNWXD08w1cAi4q0nr4MhHg6c2ELeNLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bCciOZAA4NTSB3mm2Su+F9gONsKf+yqyR0mg3ly9Y/JZbps3gg59Nf9ZO3PI5mGi5
	 q1MOiS8x3CQ9SW/PN6ue8zNyZ3oVYje1631Lh/Sgnfc8ERgUEkFz66oe1NINQLq+1R
	 Y1/CUd0aM2c/8cUHKe1fI2+7AdQoQxZG4QRO0XiK5XFAozTZ6yeJSLnDPzBdltFzzr
	 D3eMw6LxMD9RfSkSNHkNsh9td6+ewIUoXDCzSwHo9keVK29h/PSMrRMxu3TmUmYtnj
	 RNJITCCqWG719sSwv1hbVmZ1qXVjukV5oejRYBarWAbVB34jUi8MrOkNQPB99LHEij
	 JrdonCRvrQVRQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x6kIZ-00000005vbW-1KzK;
	Wed, 16 Sep 2026 09:43:19 +0200
Date: Wed, 16 Sep 2026 09:43:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static
 functions
Message-ID: <aqpIl5NWCFiuKy9b@hovoldconsulting.com>
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 03:20:46PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> As there are no longer any users of these functions, let's make them
> internal to the mmc core. 

Why would you want to do that? The devres helpers should just be simple
wrappers around these and sometimes devres just isn't a good fit.

Especially with the work cancellations present in mmc_free_host() (which
I have pointed out elsewhere should not be there), a driver may need to
free the host before tearing down other non-devres managed resources
during unbind.

This may even be needed for greybus which currently destroys the
connection before freeing the host.

I suggest you just keep the non-devres interface around (after updating
the prototype).

> While at it, let's also flip the order of the
> in-parameters to mmc_alloc_host() to be consistent with devm_alloc_host().

Johan
