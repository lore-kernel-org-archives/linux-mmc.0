Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447D1990BB;
	Tue, 13 Aug 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548972; cv=none; b=XQPLBrb02Wfu2j+nY6kIzJhpc30lQhwxigyCpXBe+19FRKWT/paK3f1mldWtrOsviJfElQResYVnbmWlM/H92yaWH4Tlhke2stGrP/RWd9jL0KcP6GltqCj6KKKKQqqxJCHMc+q+sRDB8x6AoJgtGdGSdEU9ahMbBHWvshxdBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548972; c=relaxed/simple;
	bh=exKRsAXvlT58w7WCWjQ3fI+DLF6NQtv9HMGXbUGCLPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoYdZykvedCWVxjhnHLc4nkbOcXcht45aFbLfdxg7/VKkKmhXSkKdf7mPXmYiRAE2xvvEwLfNTWpSLOWo5BSl3VfV5t9dHPax9OVt7isRtmfxiSy39n/iHwXYMGoPDCgsgXhj1ECAwqUM1I0eEtaN/9chJd6iOxZTnHZK6fbv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R7Wx9iBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R7Wx9iBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A809EC4AF0B;
	Tue, 13 Aug 2024 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723548972;
	bh=exKRsAXvlT58w7WCWjQ3fI+DLF6NQtv9HMGXbUGCLPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7Wx9iBaNtez1dPA8HdLWx67OC84J+eQxXOd3kK+bzsK/ehuU8QFIZaJdQ0iS6rBh
	 i5fGbK3d5SHYsFklx+yeVx54gPzdkWMr04mzoLnQIyJ8NHTzLPt1u0WMZCqn9MbxOs
	 Ps6mNlgboAAOe2kd7DuW2q7sDnHx9D73h/L8oWfg=
Date: Tue, 13 Aug 2024 13:36:08 +0200
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
Message-ID: <2024081346-riveting-unwired-d9dc@gregkh>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org>
 <2024081346-dutiful-stalemate-0e07@gregkh>
 <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>

On Tue, Aug 13, 2024 at 01:26:18PM +0200, Jens Wiklander wrote:
> On Tue, Aug 13, 2024 at 11:29 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > > --- /dev/null
> > > +++ b/drivers/misc/rpmb-core.c
> > > @@ -0,0 +1,233 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> >
> > Fine, but:
> >
> > > --- /dev/null
> > > +++ b/include/linux/rpmb.h
> > > @@ -0,0 +1,136 @@
> > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> >
> > Really?
> >
> > Why?  I need lots of documentation and a lawyer sign off for why this is
> > a dual license for a file that is obviously only for internal Linux
> > kernel stuff.
> 
> I'm sorry that was added via one of the patch sets before mine. I'll
> revert to GPL-2.0 only.

Please be sure to get proper legal approval to change the license of
code not written by you :)
