From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
	ux500v2 variant
Date: Wed, 28 Nov 2012 17:12:21 +0000
Message-ID: <20121128171221.GF19440@n2100.arm.linux.org.uk>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com> <20121121153811.GN3290@n2100.arm.linux.org.uk> <CAFEEs1kzJUgsvnzgWwU4i7o1jkE=8iTq5+NJ_t1jdiHEm7b-RQ@mail.gmail.com> <20121121165048.GO3290@n2100.arm.linux.org.uk> <CAFEEs1nb+UD+8_jsKvGKhyFqGDogN5wsmV30PnELqahTMDyRVA@mail.gmail.com> <20121122173708.GJ5764@n2100.arm.linux.org.uk> <50B34270.7070403@stericsson.com> <20121126102712.GC19440@n2100.arm.linux.org.uk> <50B349D3.2050806@stericsson.com> <CAFEEs1nZboGyAfpYQ2hUvp366FiS0=8u5zL6Vr1RfXac_Ls_dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51987 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab2K1RMb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Nov 2012 12:12:31 -0500
Content-Disposition: inline
In-Reply-To: <CAFEEs1nZboGyAfpYQ2hUvp366FiS0=8u5zL6Vr1RfXac_Ls_dw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Nov 28, 2012 at 05:55:13PM +0100, Per Forlin wrote:
> I have tried to work out an if-statement to check this properly. Here
> is my conclusion,
> This only works if sg len is 1 (in the SDIO case)
> 
> if (WRITE)
>   align = sg->offset & 3
> else if (READ)
>   align = 0
> 
> if (sg->offset & 3 && (PAGE_SIZE - (sg->offset + align) < host->size))
>    error; /* cannot be handled by mmci driver */

This looks wrong.  For starters, why in the write case do you _add_ the
byte offset in the word to sg->offset ?  So, if we're offset by one byte,
it becomes two bytes.  Makes no sense.

Secondly, (PAGE_SIZE - whatever) < host->size will be mostly always true.
What that means is the check is effectively just "sg->offset & 3".

Ah, maybe that's what you're trying to do - obfuscate the code in the hope
that I won't analyse it so you can get your check past me and then remove
all the obfuscation later... but maybe I'm just paranoid. :)

> Is this if-statement align with your view of the alignment issue ?

I've no idea why you're making it soo complicated.

Let's review.  It copes fine with aligned buffers.  It copes fine with
misaligned buffers that don't cross a page boundary.  It also copes
fine with transfers that end with a non-word sized number of bytes
(which we don't need a check for).

So:

	/* We can't cope with a misaligned transfer which crosses a page */
	if (sg->offset & 3 && (sg->offset + sg->len > PAGE_SIZE ||
			       data->sg_len > 1))
		bad;

See what I've done there?  I've taken the English and converted it directly
to code.  And the comment also matches the code.

And this way we continue to allow buffers that the string-IO operations
can cope with just fine, but avoid the issue of a word crossing a page
boundary.
