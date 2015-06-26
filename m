From: David Jander <david@protonic.nl>
Subject: Re: [RFC PATCH] mmc: core: Optimize case for exactly one
 erase-group budget TRIM
Date: Fri, 26 Jun 2015 08:56:42 +0200
Message-ID: <20150626085642.5cdad2e3@archvile>
References: <1433320469-29453-1-git-send-email-david@protonic.nl>
	<CAPDyKFocxYD+q_CQQ4Kz6ZZ88P+DwWcwfrEGEJJEEgkFT5r+MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:14693 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbbFZG4o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 02:56:44 -0400
In-Reply-To: <CAPDyKFocxYD+q_CQQ4Kz6ZZ88P+DwWcwfrEGEJJEEgkFT5r+MA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Sascha Hauer <s.hauer@pengutronix.de>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Dear Ulf,

On Thu, 4 Jun 2015 10:31:59 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 3 June 2015 at 10:34, David Jander <david@protonic.nl> wrote:
> > In the (not so unlikely) case that the mmc controller timeout budget is
> > enough for exactly one erase-group, the simplification of allowing one
> > sector has an enormous performance penalty. We optimize this special case
> > by introducing a flag that prohibits erase-group boundary crossing, so
> > that we can allow trimming more than one sector at a time.
> >
> > Signed-off-by: David Jander <david@protonic.nl>
> 
> Hi David,
> 
> Thanks for working on this!

I have since sent an updated patch that includes more comment. It would be
great if you could find the time to review it. I hope the comments are clear
enough.

Best regards,

-- 
David Jander
Protonic Holland.
