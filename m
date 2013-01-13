From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] mmc: mvsdio: Replace IS_ERR_OR_NULL() with IS_ERR()
Date: Sun, 13 Jan 2013 22:42:59 +0100
Message-ID: <20130113214259.GE17242@lunn.ch>
References: <20130111004323.GA12257@schnuecks.de>
 <1357889273-11553-1-git-send-email-andrew@lunn.ch>
 <20130113204348.GR13433@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:35523 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913Ab3AMVnI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Jan 2013 16:43:08 -0500
Content-Disposition: inline
In-Reply-To: <20130113204348.GR13433@titan.lakedaemon.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, gmbnomis@gmail.com, linux-mmc@vger.kernel.org, cjb@laptop.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Sun, Jan 13, 2013 at 03:43:48PM -0500, Jason Cooper wrote:
> On Fri, Jan 11, 2013 at 08:27:52AM +0100, Andrew Lunn wrote:
> > A NULL is a valid clk cookie, so we should not be tested with
> > IS_ERR_OR_NULL(). Replace it with IS_ERR().
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> > This patch depends on Thomas Petazzoni DT patches for mvsdio, which changed
> > the order of resource allocation etc.
> 
> grrr, I'm seeing fixes depending on features :(  Any way to avoid that?
> 
> In light of Russell's comments, shall I wait for a v3?  All of Thomas'
> mvsdio work is now waiting on this.  I'd like to get that in as early as
> possible.

Well, im guessing doing the fixes first will require changes to Thomas
features. 

Did you try putting Russells patch in first? How bad are the
conflicts?

	Andrew
