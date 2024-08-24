Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5FF156C63;
	Sat, 24 Aug 2024 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476709; cv=none; b=ukyH6r/hqtF0Le0DoFVqbWQa5uK2a7xkXxgRYCMzmsL7Uy+EM7FFOqN4SSbZTKQIZE5usFlBdFbZJ/59otSVxr8xsCa8xOUW150rs3aTrF9UW23T/A6xnVrxXajHqx6Ljqs9+rbA/TAgk5zmc36XITYLIjd5rnX6GFq3ny/2eaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476709; c=relaxed/simple;
	bh=g4EMx2RE+RHxp7QbzUJInN+TXL/ZyIDsFo+GFa8RueE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9NCBJPPjkGwgkuo+iU/9tPqLogMnxjbGcP3k71QN1xg8xhakcgYYDpuaISeVxh+lPrfk9B8uQXAg596xOErV3Far5ha5h93ekSfrJWj3g3v9TGjHylQrOsL9TXG2zkg5ELplc+xpwolCVaUnj8iLm2uBOf83brNDBwFw8eHLNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tEzT3y3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tEzT3y3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF64C4AF11;
	Sat, 24 Aug 2024 05:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476709;
	bh=g4EMx2RE+RHxp7QbzUJInN+TXL/ZyIDsFo+GFa8RueE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEzT3y3rA5pcNXrPB9WaU4GC2axnnSNaaM19k4xOqVkH4hoBDgR74xjEuVTfTzQO+
	 3xi+dshn+YiINI+PYVhAZpl0A5vqgD9eB++ep+PCkRKAx0jOmYm/B4RA1UMFxkUNOM
	 FUFYXTfLwglgzwxdwiwXjUMeWoXJSi+k/6Y4p4SQ=
Date: Sat, 24 Aug 2024 11:13:29 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: Re: [PATCH v9 0/4] Replay Protected Memory Block (RPMB) subsystem
Message-ID: <2024082414-doily-camisole-b5c7@gregkh>
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
 <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com>

On Wed, Aug 21, 2024 at 11:23:03PM +0200, Ulf Hansson wrote:
> On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi,
> >
> > This patch set is getting ready to be queued for the next merge window. The
> > issues reported by Mikka in the v7 patch set has been resolved, the issues
> > turned out to be outside of the v7 patch set relating to configuration in
> > the secure world. I'm planning a pull request to arm-soc, but before that
> > I'd rather have acks or at least an OK for:
> > - "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Greg
> > - "mmc: block: register RPMB partition with the RPMB subsystem" by Ulf
> >
> > Arnd, please let me know if anything else is missing.
> 
> Greg, Jens,
> 
> To help out with the merging strategy, I don't mind queuing this whole
> series via my mmc tree. It would also be nice to let it cook in
> linux-next for while, via my next branch.
> 
>  From my point of view this looks good to me now, but please let me
> know if you prefer a different route or if you have any further
> comments.

No objection from me, please take it through your tree, makes it simpler
for me :)

greg k-h
