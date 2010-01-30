From: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH v3] port ricoh_mmc to pci quirk
Date: Fri, 29 Jan 2010 18:18:57 -0800
Message-ID: <20100129181857.1f23f013@fido2.homeip.net>
References: <20091125085324.1ef9ae1f@fido2.homeip.net>
	<20091125113501.1f4d42b9.akpm@linux-foundation.org>
	<1259192401.15916.48.camel@maxim-laptop>
	<20091125173019.74d0ddb9@fido2.homeip.net>
	<1259279520.3991.5.camel@maxim-laptop>
	<1259279584.3991.6.camel@maxim-laptop>
	<20091126235551.2db699e3@fido2.homeip.net>
	<1262964284.12577.27.camel@maxim-laptop>
	<20100108074001.5df6c997@fido2.homeip.net>
	<20100112154350.8fa96829.akpm@linux-foundation.org>
	<20100113064657.GB10955@pengutronix.de>
	<1264772255.4620.3.camel@maxim-laptop>
	<20100129080639.3b484a59@fido2.homeip.net>
	<1264803033.7095.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from usul.overt.org ([204.11.33.43]:34454 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435Ab0A3CTM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jan 2010 21:19:12 -0500
In-Reply-To: <1264803033.7095.4.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

On Sat, 30 Jan 2010 00:10:33 +0200
Maxim Levitsky <maximlevitsky@gmail.com> wrote:

> Well, I have nothing against this, but, even Linus himself stated that
> he dislikes broken printk lines.
> 
> I also noticed that some DECLARE_FIXUP in this file are longer that
> 80, and since breaking this doesn't add any value, I thought that is
> ok. Remember that main purpose of 80 char limit is to make code
> simpler.
> 
> However, I don't really care if you insist.

I don't want to be obnoxious either - if no one else is concerned about
the lines, I won't kick up a fuss.

And thanks for sticking with this patch - I want to see it in soon too;
I'd like to sort out the new PCI-e Ricoh parts which are going to need
a new magic sequence.

--phil
