From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH v4 2/3] mmc: core: Factor out the alignment of erase size
Date: Tue, 6 Sep 2016 09:19:18 +0200
Message-ID: <20160906071918.GA27539@rhlx01.hs-esslingen.de>
References: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
 <48c332c9c688796b7ea157046b8feb68a11e60d4.1473130123.git.baolin.wang@linaro.org>
 <20160906043435.GA10158@rhlx01.hs-esslingen.de>
 <CAMz4kuJzqyAEam3RNJga5EERMh6TgXWFoY-uZ8pbm1OZW7uy8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:57002 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbcIFHTV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2016 03:19:21 -0400
Content-Disposition: inline
In-Reply-To: <CAMz4kuJzqyAEam3RNJga5EERMh6TgXWFoY-uZ8pbm1OZW7uy8g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Andreas Mohr <andi@lisas.de>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Tue, Sep 06, 2016 at 02:26:06PM +0800, Baolin Wang wrote:
> On 6 September 2016 at 12:34, Andreas Mohr <andi@lisas.de> wrote:
> >> -     to = from + nr;
> >> -
> >> -     if (to <= from)
> >> -             return -EINVAL;
> >
> > Hmm, this is swallowing -EINVAL behaviour
> > i.e., now possibly violating protocol?
> 
> I didn't see what situation will make variable 'to' is less than
> 'from' since I think variable 'nr' is always larger than 0, right? If
> so, we should remove this useless checking. Thanks.

Hmm, indeed, since all participating variables are unsigned,
the existing calculation should never hit this.
However, one could argue that this is an additional safeguard
against implementation source getting modified in a way
that will suddenly result in this pathologic case becoming true
(where a -EINVAL bailout surely will then pinpoint things
much more visibly for some users,
as opposed to potential data corruption or some such).



I have seen another change

> -	if (nr == 0)
> -		return 0;

where it gets moved out of common path
and into MMC_ERASE_ARG-specific branch
(likely because the subsequent common-path conditional of
    nr > rem
is deemed sufficient).

This seems to be again a change
where a simple yet crucial
device geometry calculation post-condition
(either to > from, or nr > 0)
is then not verified specifically/separately.

Ultimately, I am not sure whether or not
these (post-)conditions should be verified
in their most basic, simple form,
as an extra/separate verification step.

HTH,

Andreas
