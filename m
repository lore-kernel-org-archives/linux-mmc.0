From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH resend 0/3] sdhci-pltfm: Few additions and enhancements
Date: Tue, 16 Mar 2010 21:34:00 +0300
Message-ID: <20100316183400.GA24191@oksana.dev.rtsoft.ru>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48204 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754431Ab0CPSeE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Mar 2010 14:34:04 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Vrabel <david.vrabel@csr.com>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>, Pierre Ossman <pierre@ossman.eu>, Ben Dooks <ben@simtec.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 19, 2010 at 11:11:00PM +0300, Anton Vorontsov wrote:
> On Fri, Feb 19, 2010 at 07:55:30PM +0000, David Vrabel wrote:
> > Anton Vorontsov wrote:
> > > Some hosts (e.g. as found in CNS3xxx SOCs) report wrong value in
> > > CLOCK_BASE capability field, and currently there is no way to
> > > force the SDHCI core to use the platform-provided base clock value.
> > 
> > I don't think this needs a new quirk. Change the sdhci driver to check
> > if the platform provides a value before reading the standard register.
> 
> Well, Pierre once said that by default we should conform to the
> SDHCI spec, and any diviations from the spec should be handled by
> the quirks:
> 
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-02/msg03385.html
> 
> Spec clearly states that base clock == 0 is the case when we should
> fall back to the platform-provided clocks.

No further comments, resending the patches...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
