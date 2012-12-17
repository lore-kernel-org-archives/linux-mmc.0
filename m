From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [QUESTION] mmc: mmci: Howto merge patches
Date: Mon, 17 Dec 2012 15:46:02 +0000
Message-ID: <20121217154602.GT14363@n2100.arm.linux.org.uk>
References: <CAPDyKFpXyVCzFWkyL3+92Zb9hoyKaEV4hpaUYO9O5o71nNmk8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32931 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab2LQPqL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 10:46:11 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpXyVCzFWkyL3+92Zb9hoyKaEV4hpaUYO9O5o71nNmk8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

On Mon, Dec 17, 2012 at 04:29:51PM +0100, Ulf Hansson wrote:
> Hi Russell and Chris,
> 
> I would like to propose a change of how we handle mmci patches to be
> merged. Instead of going through Russell's arm tree, I would like
> Chris to handle the merge through his mmc tree.
> 
> The reason is simply that patches can have dependencies to the
> protocol layer and in seems a bit unnecessary to wait for another
> merge window to occur to handle these patches.

You're going to have to wait another merge window _anyway_ because no
kernel developer should be stuffing their tree full of patches during
any merge window that have not already been in linux-next well _before_
the merge window.

So like it or not, this merge window already closed to new submissions
maybe two weeks ago.

> Moreover, if most of the mmci patches goes through Chris mmc tree, I
> believe we would minimize the number of possible conflicts. Russell
> will then only need to NACK patches to prevent them from being merged.
> 
> Do you think this could be and acceptable setup for both of you?

The reason that you want to do this is because you're realising that it's
taking a long time for you to get your patches into mainline.  The reason
that I'm being slow with your patches is that you haven't built up the
trust on my side that I can simply say "yes that's fine, I trust your
patches."

That alone is good enough reason for me to say no way to this.
