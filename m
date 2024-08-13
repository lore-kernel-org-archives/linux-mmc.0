Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADA199E9B;
	Tue, 13 Aug 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552870; cv=none; b=fNYXmaXpH+47ozawCDspw806wvG5LYQnZi15f6W0e9ixAJ/YBxotv8d+pWpbdLt4+2ilN8oItJEUQmK5siYJ2Q4dHppHyFmrKWca/dBQC2sbc+LN0LEN5IzmevU7oFh19FIPOqraLsWHJi5/EcrAqlJu5cn9dBO31KuuBpOHMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552870; c=relaxed/simple;
	bh=Lzb34/CvVVyhI01Dl5f0d3ecyQv2GsEPN7HgFMl3tZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQXu/4i+W3GOIRn+0Y0x+ioCmW+99/yYn9goaOQpOhI22gM+puoqzuysIPnsGpiYI7uSZ0e/wbck1DHlMQ7B4JtZz33CveIQMktGdlsTXrxMaPeDmGprTFhalyIYcu2FFx+99h/0XjYthI8qdGO2GnHUceHzHxxanum53hB4aJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z0nsa5+M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z0nsa5+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C8CC4AF0E;
	Tue, 13 Aug 2024 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723552869;
	bh=Lzb34/CvVVyhI01Dl5f0d3ecyQv2GsEPN7HgFMl3tZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z0nsa5+MgU3tVLGNJuqSqbqjp23XTEfc4pSzF+V7xOrGDrhAMQA+UxUUwE9Fz7KtE
	 uehD0Z7n6z7JrCNOUxig1FLGafJpzkh9A95/ESi39rTRqtVkhEZmJ12h0JQ16pivgV
	 ezyOcqozcNcRM1ijhmoxVd4cdlLklFSmZfrInANU=
Date: Tue, 13 Aug 2024 14:41:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
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
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Message-ID: <2024081315-cofounder-stem-8b3d@gregkh>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org>
 <2024081346-dutiful-stalemate-0e07@gregkh>
 <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
 <2024081346-riveting-unwired-d9dc@gregkh>
 <PH7PR11MB7605F50AC47D18361D933CE1E5862@PH7PR11MB7605.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB7605F50AC47D18361D933CE1E5862@PH7PR11MB7605.namprd11.prod.outlook.com>

On Tue, Aug 13, 2024 at 12:04:03PM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Aug 13, 2024 at 01:26:18PM +0200, Jens Wiklander wrote:
> > > On Tue, Aug 13, 2024 at 11:29 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > > > > --- /dev/null
> > > > > +++ b/drivers/misc/rpmb-core.c
> > > > > @@ -0,0 +1,233 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > >
> > > > Fine, but:
> > > >
> > > > > --- /dev/null
> > > > > +++ b/include/linux/rpmb.h
> > > > > @@ -0,0 +1,136 @@
> > > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> > > >
> > > > Really?
> > > >
> > > > Why?  I need lots of documentation and a lawyer sign off for why
> > > > this is a dual license for a file that is obviously only for
> > > > internal Linux kernel stuff.
> 
> This was legal approved.

This internal Linux kernel header file for an internal-only Linux kernel
api?  Wonderful, please get the Intel lawyer who agreed with that to
sign off on the commit next time around explaining why it needs to be
this way.

thanks,

greg k-h
