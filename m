Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E016BE01;
	Tue, 13 Aug 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541382; cv=none; b=Tp1yJEanfQ9bbzddCiH/hOniGGjcGmyZloTGnfcuYKGJbwL65j63MC5zjXv97Ob2X813FdyeuP854R/QMjl68X7P0CskavQum+U5WmkWrX37ZnqhcfgcVYTrwIqCiVpwqurZmKSxSfgZFNNdHLX1BVS3mbhuBbHrxZYHWr4DHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541382; c=relaxed/simple;
	bh=T72KJ6tL1f/ZnqwIY+UaMp7HRuV44RO7462cnkCjCzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxOlkPqja242kb/fHF3loM45n01NBro7hD+UR0RWp4jJ/AosEVqQYXzZZreLWIfW2E4O4vrr6Wx6hPLqDxl+K8PfHKMp8w1x4I/8xpBWLEeB9+yMyYGUlqJhKY5m8GH3M1xu84BxKAd5FOKhnKOxkKW64xQ5prlABPCkimuJt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewtUJQB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewtUJQB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC84AC4AF09;
	Tue, 13 Aug 2024 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723541381;
	bh=T72KJ6tL1f/ZnqwIY+UaMp7HRuV44RO7462cnkCjCzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewtUJQB3WFWIZdbL79r8077ab2FHKoWlmjJyWX4upJl4aPRb7PVm5PRAZgNlkmrBt
	 Ng2hLjj465ugfk0yQU0+P3iKb/1x7DEIo1LT9mQCQ2cygi5P+qgPtOZwhYmb7LeE47
	 flxJWRNVtfxnkRqHNBnMwUCVfM/iTNkniVCObNhs=
Date: Tue, 13 Aug 2024 11:29:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Message-ID: <2024081346-dutiful-stalemate-0e07@gregkh>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812133127.865879-2-jens.wiklander@linaro.org>

On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> --- /dev/null
> +++ b/drivers/misc/rpmb-core.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0

Fine, but:

> --- /dev/null
> +++ b/include/linux/rpmb.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */

Really?

Why?  I need lots of documentation and a lawyer sign off for why this is
a dual license for a file that is obviously only for internal Linux
kernel stuff.

thanks,

greg k-h
