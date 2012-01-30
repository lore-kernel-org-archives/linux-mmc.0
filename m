From: Michael Hunold <hunold@linuxtv.org>
Subject: Re: omap_hsmmc.c and MMC_CAP_SDIO_IRQ
Date: Mon, 30 Jan 2012 12:16:37 +0100
Message-ID: <4F267C15.7070704@linuxtv.org>
References: <4F1EC123.8070103@linuxtv.org> <CAGDS+nnVosHsv4SUcGXCieVQG2cjW=mL7DZ7_W2p+uNhUYfPyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bar.sig21.net ([80.81.252.164]:55891 "EHLO bar.sig21.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab2A3LQi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jan 2012 06:16:38 -0500
In-Reply-To: <CAGDS+nnVosHsv4SUcGXCieVQG2cjW=mL7DZ7_W2p+uNhUYfPyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

Hello Steve,

on 01/27/2012 03:09 PM Steve Sakoman said the following:
> On Tue, Jan 24, 2012 at 6:33 AM, Michael Hunold <hunold@linuxtv.org> wrote:

> Your summary below is a pretty accurate description of the current state.

Ok.

> I've made an attempt at creating a patch for 3.2 that follows David
> Vrabel's original patch series as closely as possible with the new
> structure.
> 
> Unfortunately it doesn't quite work.  I've only been doing this as a
> background task so progress is pretty slow.

I understand, no problem.

> The patch doesn't seem to break support for memory devices (which is
> good since my rootfs is on an mmc device!) and I do see SDIO
> interrupts occurring and being handled in the debug log, so it is a
> good start:

> However the SDIO device does not function properly due to multiple
> timeout errors, so something is still not quite right.

> Let me know if you would like to help with further development of the
> patch and I will send you a copy.  It is rough enough and broken
> enough that it probably isn't yet ready for even an RFC to these
> lists.

Yes, please send them to me. I will give them a try and let you know the
results.

As a side node: actually I'm working double tracked. I plan to use it on
some OMAP-based board like Beagleboard or Pandaboard for a stationary
system, running any kernel that is needed.

But I'd like to use some spare N900s as well, because I can carry them
around easily. But these are running ancient 2.6.28.1 kernels. David
Vrabel mentioned that he originally developed his patches on the N900. I
sent him a mail using his mail address from csr.com, but I have not
received a reply yet.

If you or anybody else has every seen his original patches for the N900
(he did not sent them to any list as far as I know) please let me know
as well.

> Regards,
> Steve

CU
Michael.

