From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: Make reset-gpios optional to match
 doc
Date: Tue, 19 Jan 2016 18:34:34 -0800
Message-ID: <20160120023433.GG19432@atomide.com>
References: <20160108090726.13066.66125.stgit@localhost>
 <CABxcv=mYRG0rikgtY-fPj_BFhY8hgn_LYjcxEeY14rZD-BHpfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56252 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933377AbcATCeh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jan 2016 21:34:37 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv=mYRG0rikgtY-fPj_BFhY8hgn_LYjcxEeY14rZD-BHpfg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

Hi,

* Javier Martinez Canillas <javier@dowhile0.org> [160108 08:42]:
> On Fri, Jan 8, 2016 at 6:07 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> > The DT binding doc says reset-gpios is an optional property but the code
> > currently bails out if it is omitted.
> >
> > Make the code match the documentation.
...
> Tony already posted a fix for this before [0] but got some feedback so
> is likely to post a v2 soon.

Hmm I think my patch would end up looking pretty much like Martin's
patch after fixing the comments. Based on what I understood, Ulf
wants to keep pwrseq_simple, well, simple as discussed in [0].

It also seems Ulf also wants to leave out the allocation, and does
want to add any deeper knowledge of the state of the GPIOs in
pwrse-simple. Instead, we can do device specific pwrseq for things
like Marvell 8787 and so on.

Ulf may have more comments, but $subject patch fixes the issue
I'm seeing with wl12xx on omap5 devices:

Tested-by: Tony Lindgren <tony@atomide.com>

Probably should be tagged Cc: stable # v4.4 when applied.

Regards,

Tony

> [0]: http://www.spinics.net/lists/linux-mmc/msg34398.html
