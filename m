Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE672877DA;
	Mon, 12 Jan 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232886; cv=none; b=X2xoJHWTzmHmnjueniu8EDRaCaA7CtfkiVB468J3kziNeQBplNvDi9+OBiR1c9VjklELrhkU2fV+DZ/jMcdIPNvZ5NjsXv3FAR8RCqio8Dp9T2ZF3RQGFG/YeIA86j+EV2SCFf6sdwrMBYmQoXKdFh0MX6fKZSU64hDTRTb82nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232886; c=relaxed/simple;
	bh=o6bLg0ySoZFHDQc+FNwqUrcZpZi5SIhfxu4HKAZ3x7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+YRDi9hZ4K33ntfnFo/zxJJtuRU+ci5rDrSEH7qHWZ38pa1b5tvhFfakq8myJnZzI6xECjtGmW2jpG2OXKUpesFF9K1dhvQUln9d8kFKpnwQmySpxe2Bhsama2lBFSMf/7lFSnsJDSCcFK1NetAbJz91Se5EW0yhMICTl8DSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWusaK50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWusaK50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4705BC19422;
	Mon, 12 Jan 2026 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232886;
	bh=o6bLg0ySoZFHDQc+FNwqUrcZpZi5SIhfxu4HKAZ3x7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWusaK509HA0eIMXPq06mOSRxySQ4nCsiv9htDK34SN6ExfuIvfN1c2LG5UQcRjKE
	 YGHBEbL7iaGIR1Ssl05VuiGyf+/WlYaReCV/Z+z3RX/3hcRAhu+OITBgT5dMI2j150
	 3uPzWuU42Cn12bbM9fmqGhlWdgIn86/RSi8na6s2F3z4d2050vP4HDwTEn5Rcp5Q+M
	 Dh8JOUUuULMpnUEGkCJyb7g5nhHPm491sI/+YSFRK6aXSQUJo1uZtIVuK+BEdsERW7
	 cNizGOxXSIIMzXy06HWwvjW62qWyoVEu6bAqMDvIDyl7GdIm4Qc4OuyAgK0ffEtq+1
	 +rYs/0VMe1sGA==
Date: Mon, 12 Jan 2026 09:48:05 -0600
From: Rob Herring <robh@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Kamal Dasu <kdasu.kdev@gmail.com>, Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: mtd: brcm,brcmnand: Drop
 "brcm,brcmnand" compatible for iProc
Message-ID: <20260112154805.GA271138-robh@kernel.org>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-1-124a53ce6279@kernel.org>
 <CAHi4H7GvSsX=BO2AWy4BB=FfQ8bWx_C3PBh9UQHYOo+G247P_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi4H7GvSsX=BO2AWy4BB=FfQ8bWx_C3PBh9UQHYOo+G247P_g@mail.gmail.com>

On Fri, Jan 09, 2026 at 10:05:04AM -0800, William Zhang wrote:
> Hi Rob,
> 
> On Thu, Jan 8, 2026 at 9:53 AM Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Some users of "brcm,nand-iproc" include "brcm,brcmnand" and some don't.
> > The "brcm,brcmnand" compatible is not useful for iProc systems as
> > there's a separate driver for iProc. So drop it as a fallback.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > index 064e840aeaa1..3105f8e6cbd6 100644
> > --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > @@ -66,7 +66,6 @@ properties:
> >          items:
> >            - const: brcm,nand-iproc
> >            - const: brcm,brcmnand-v6.1
> > -          - const: brcm,brcmnand
> >        - description: BCM63168 SoC-specific NAND controller
> >          items:
> >            - const: brcm,nand-bcm63168
> >
> > --
> > 2.51.0
> >
> 
> Another fix would be adding brcm,brcmnand to the users of
> brcm,nand-iproc to keep consistency with all other brcmnand chips and
> utilize the fallback mechanism in the driver, although I agree it does
> not happen in real life case.
> I don't have any strong opinion either way but a follow-up change is
> needed to remove the fallback from the brcm,nand-iproc dts files if we
> go this route.

The question to ask on a fallback is "is it usable on its own?". IOW, 
would a driver than only understands brcm,brcmnand function in this 
case. Given iproc needs its own driver and specific handling, the answer 
is no here.

Plus, this matches what dts files actually have at least for the arm64 
ones. 

Rob
