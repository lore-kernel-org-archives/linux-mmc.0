From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc_rescan: reduce verbosity
Date: Tue, 12 Oct 2010 03:12:36 +0100
Message-ID: <20101012021236.GA8179@void.printf.net>
References: <1286833731-30567-1-git-send-email-eric@eukrea.com> <alpine.LFD.2.00.1010112007250.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46265 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756750Ab0JLCMi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Oct 2010 22:12:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010112007250.2764@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 11, 2010 at 09:50:46PM -0400, Nicolas Pitre wrote:
> On Mon, 11 Oct 2010, Eric B=E9nard wrote:
> > since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
> > includes a pr_info which prints 4 lines each second for hosts confi=
gured
> > with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
> > This patch increase log level to debug (but maybe the right solutio=
n
> > would be to remove this log).
>=20
> Indeed.  Flooding the log with debug messages is not much better.

Other options include:

(a) Turn the message into a DBG().  (CONFIG_MMC_DEBUG=3Dy)
(b) Turn the message into a DBG(), predicated on !MMC_CAP_NEEDS_POLL.
(c) Remove the message.

Any thoughts?  I'll go with (c) unless we agree on a better idea.

Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
