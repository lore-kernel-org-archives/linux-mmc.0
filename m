From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND PATCH 1/2] mmc: mmci: Fix incorrect handling of HW
	flow control for SDIO
Date: Fri, 12 Oct 2012 12:54:48 +0100
Message-ID: <20121012115448.GH21164@n2100.arm.linux.org.uk>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com> <20121012091322.GC21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51076 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758361Ab2JLLzE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 07:55:04 -0400
Content-Disposition: inline
In-Reply-To: <20121012091322.GC21164@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org

On Fri, Oct 12, 2012 at 10:13:22AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 10, 2012 at 06:03:19PM +0200, Ulf Hansson wrote:
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > For data writes <= 8 bytes, HW flow control was disabled but
> > never re-enabled when the transfer was completed. This meant
> > that a following read request would give buffer overrun errors.
> > 
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Both look fine to me too.  Linus' has already said what needs to happen
> with these two.  Thanks.

Ulf,

I see you've tried three times to get a replacement password for the
patch system today.  If it's not getting through, you need to complain
to your IT department, and get them to complain to Google:

2012-10-12 11:09:21 1TMcBE-0005ED-VS <= apache@arm.linux.org.uk H=n2100.arm.linux.org.uk [2002:4e20:1eda:1:214:fdff:fe10:4f86]:55740 I=[2002:4e20:1eda:1:24c:69ff:fe6e:7578]:25 P=esmtpsa X=TLSv1:AES256-SHA:256 A=cram:n2100.arm.linux.org.uk S=1065 id=E1TMcBD-00061o-HP@n2100.arm.linux.org.uk T="Your new password" for ulf.hansson@stericsson.com
2012-10-12 11:09:24 1TMcBE-0005ED-VS => ulf.hansson@stericsson.com R=verp_dnslookup T=verp_smtp S=1097 H=stericsson.com.s200a1.psmtp.com [207.126.147.10] X=TLSv1:AES256-SHA:256 DN="/C=US/ST=California/L=Mountain View/O=Google Inc/CN=*.psmtp.com" C="250 Thanks"
2012-10-12 11:25:13 1TMcQb-0005EY-8d <= apache@arm.linux.org.uk H=n2100.arm.linux.org.uk [2002:4e20:1eda:1:214:fdff:fe10:4f86]:37918 I=[2002:4e20:1eda:1:24c:69ff:fe6e:7578]:25 P=esmtpsa X=TLSv1:AES256-SHA:256 A=cram:n2100.arm.linux.org.uk S=1065 id=E1TMcQZ-00066s-2O@n2100.arm.linux.org.uk T="Your new password" for ulf.hansson@stericsson.com
2012-10-12 11:25:17 1TMcQb-0005EY-8d => ulf.hansson@stericsson.com R=verp_dnslookup T=verp_smtp S=1097 H=stericsson.com.s200a1.psmtp.com [207.126.147.10] X=TLSv1:AES256-SHA:256 DN="/C=US/ST=California/L=Mountain View/O=Google Inc/CN=*.psmtp.com" C="250 Thanks"
2012-10-12 12:25:56 1TMdNM-0005IG-8u <= apache@arm.linux.org.uk H=n2100.arm.linux.org.uk [2002:4e20:1eda:1:214:fdff:fe10:4f86]:57521 I=[2002:4e20:1eda:1:24c:69ff:fe6e:7578]:25 P=esmtpsa X=TLSv1:AES256-SHA:256 A=cram:n2100.arm.linux.org.uk S=1065 id=E1TMdNK-0006XU-SG@n2100.arm.linux.org.uk T="Your new password" for ulf.hansson@stericsson.com
2012-10-12 12:25:59 1TMdNM-0005IG-8u => ulf.hansson@stericsson.com R=verp_dnslookup T=verp_smtp S=1097 H=stericsson.com.s200a1.psmtp.com [207.126.147.10] X=TLSv1:AES256-SHA:256 DN="/C=US/ST=California/L=Mountain View/O=Google Inc/CN=*.psmtp.com" C="250 Thanks"

You are not the first to encounter this problem.  psmtp.com seems to
put the password reminders into a big black hole, and this is inspite
of them trying to follow every possible RFC concerning auto-generated
mail, and being DKIM signed too.

Unfortunately, what this means is that effectively the spammers have
won the arms race: it is becoming increasingly difficult to get email
through to the intended destination due to all the filtering that
people now impose (not that it ever has been guaranteed.)
