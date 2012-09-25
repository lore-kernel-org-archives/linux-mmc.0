From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Tue, 25 Sep 2012 15:33:19 +0800
Message-ID: <20120925073317.GI27291@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58998 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab2IYHdI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 03:33:08 -0400
Received: by pbbrr4 with SMTP id rr4so8602935pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 00:33:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120925072714.GY1322@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Tue, Sep 25, 2012 at 09:27:15AM +0200, Sascha Hauer wrote:
> > >  Optional properties:
> > >  - fsl,cd-controller : Indicate to use controller internal card detection
> > >  - fsl,wp-controller : Indicate to use controller internal write protection
> > > +- bus-width : Maximum supported bus width. Defaults to 4 if omitted
> > >
> > This is a common mmc property documented in bindings/mmc/mmc.txt.
> > Instead of duplicating the documentation, we should try to make our
> > implementation conform to the common definition of the property.
> 
> It is conform to the common definition, so all I have to do is drop the
> line duplicating the docs. That's easy ;)
> 
Maybe not.  The common binding defines it as a required property while
the patch implements it as an optional one.

Shawn
