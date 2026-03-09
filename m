Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944335C1AA;
	Mon,  9 Mar 2026 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059097; cv=none; b=umhqwLLgig2ZXxY0r13NmhoTujVidz5MEZX9/YtLnWT/YiECRxWslx7ipu9b0sypYvkEZA4FENctauVa9GljsrbuiceyEYs1qz5coHRFIyNWbsjbBEE/G25yuIRijIRcc7vrlRUjbChSrnbC573oy28qr98IeW5+Py6JywZfzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059097; c=relaxed/simple;
	bh=mjH3zrVPmhOB++yQLp5VghDz9hAicCZSwf6bBs9sepI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGyNm33msvvj//YdPBqQo034owqsB/ULwX2GPwWEJgppYI9YskdtVEkGS29wF+QrKbumD/NYLZFtT94aYXcW8E3UjlRXigWKyDAE5o70EeYkVFOhu3B2MFRg006aRk3upW8Vw/zQ+mG1SXDflF83aC7TBGcrPS/+/FHxBM7NMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DL5r+Ncw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DL5r+Ncw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930C7C4CEF7;
	Mon,  9 Mar 2026 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773059096;
	bh=mjH3zrVPmhOB++yQLp5VghDz9hAicCZSwf6bBs9sepI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DL5r+NcwUWHlXcnA1M9g+8Hqqt4KtIS1JNJhSf/S0aTz1nvwCKNPij4sBPL9hIZRT
	 QpY0xNMcw0mKf7v8o+eTgLNRAS23kWOXrMreKWwmCvhAlke7brdGCkxgXTszoahTpW
	 AoioJ5ZH9wGxzFgG/ONMIfy2uiOyZMpOZTTpL+sI=
Date: Mon, 9 Mar 2026 13:24:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH] mmc: moxart: fix potential use-after-free on remove path.
Message-ID: <2026030953-overrate-saddlebag-9cef@gregkh>
References: <2026022351-badness-custody-28ad@gregkh>
 <CAPDyKFp=9qL2XROcTXDsv106FdoFwzziFU6YpBCB85aQ5ZFZRA@mail.gmail.com>
 <2026030816-womb-recollect-bdb4@gregkh>
 <CAPDyKFptyTf6HJbUf0eRXiutP=hLTjoxmRQb2ut1w4Z7RbvkSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFptyTf6HJbUf0eRXiutP=hLTjoxmRQb2ut1w4Z7RbvkSQ@mail.gmail.com>

On Mon, Mar 09, 2026 at 12:42:53PM +0100, Ulf Hansson wrote:
> On Sun, 8 Mar 2026 at 19:03, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 04, 2026 at 05:25:25PM +0100, Ulf Hansson wrote:
> > > On Mon, 23 Feb 2026 at 14:48, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
> > > > on remove path"), we should wait until after we are finished writing to
> > > > the mmc host device before removing it, otherwise it could have been
> > > > already freed.
> > >
> > > mmc_remove_host() doesn't actually free the host, but it reverses what
> > > mmc_add_host() did during probe.
> > >
> > > Since the moxart driver uses devm_mmc_alloc_host() the last reference
> > > to the host will be dropped after ->remove() completes, leading to
> > > mmc_free_host() to be called for it.
> >
> > Then how did commit bd2db32e7c3e ("moxart: fix potential use-after-free
> > on remove path") do anything?  It really wasn't needed either?  And so
> > the CVE related to it should be rejected?
> 
> No, commit bd2db32e7c3e is perfectly okay and solves the intended problem.
> 
> Before the moxart driver was converted to use devm_mmc_alloc_host() in
> commit 973aa22b9f1a, it used mmc_alloc_host() during probe.

Ah, that makes more sense, thanks, I was confused.

> Calling mmc_free_host() is needed in these cases, but it should
> typically be the final thing a ->remove() callback does, in order to
> clean up correctly and prevent use-after-free bugs.

I moved the call to be the "final thing" in these patches, so they are
ok?

thanks,

greg k-h
