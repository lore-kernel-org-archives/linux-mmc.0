From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mmc: moxart: fix probe logic
Date: Mon, 02 Feb 2015 15:58:49 +0100
Message-ID: <4754899.RDUhFfxBSW@wuerfel>
References: <8340872.32GezMfzR1@wuerfel> <1862200.Pj3heKAtuk@wuerfel> <CACmBeS0RGJUzqztQLZtHyTYgCd=jpAoYYk-roH7_VLbfy-+ftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62354 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbBBO64 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 09:58:56 -0500
In-Reply-To: <CACmBeS0RGJUzqztQLZtHyTYgCd=jpAoYYk-roH7_VLbfy-+ftw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jonas Jensen <jonas.jensen@gmail.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Monday 02 February 2015 11:52:44 Jonas Jensen wrote:
> 
> On 29 January 2015 at 23:06, Arnd Bergmann <arnd@arndb.de> wrote:
> > Jonas Jensen wanted to submit a patch for these, but apparently
> > forgot about it. I stumbled over this symptom first:
> 
> Sorry about this, I remember thinking about the changes but only made
> a mental note (which was lost over time). I was sidetracked with other
> changes and work.
> 
> 
> > @@ -586,10 +586,10 @@ static int moxart_probe(struct platform_device *pdev)
> >                 goto out;
> >         }
> >
> > -       clk = of_clk_get(node, 0);
> > -       if (IS_ERR(clk)) {
> > +       host->clk = of_clk_get(node, 0);
> 
> host->clk is a NULL dereference at this point in probe() (log below).
> 
> I moved the single line "host = mmc_priv(mmc);" to happen just before,
> and everything is working normally again.

Thanks a lot for testing, and finding the second embarrassing bug
in my patch!

Can you forward the patch you successfully tested with your
Signed-off-by?

	Arnd
