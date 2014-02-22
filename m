From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded
	irq handler
Date: Sat, 22 Feb 2014 19:05:36 +0000
Message-ID: <20140222190536.GI21483@n2100.arm.linux.org.uk>
References: <20140219094322.GR21483@n2100.arm.linux.org.uk> <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com> <20140219095212.GT21483@n2100.arm.linux.org.uk> <CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com> <20140219105011.GU21483@n2100.arm.linux.org.uk> <CAKohpokBf_fJhiUJ53c+=6v+GMcjaDKd7+fwib99=sLMdkjQQQ@mail.gmail.com> <20140220105903.GY21483@n2100.arm.linux.org.uk> <CAKohpo=FTk9SGCMJGBdOUheUg71WsG7qaeE9rwQRqd5dP4O8FQ@mail.gmail.com> <20140221103710.GB21483@n2100.arm.linux.org.uk> <8638jbvw91.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46927 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751834AbaBVTFt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2014 14:05:49 -0500
Content-Disposition: inline
In-Reply-To: <8638jbvw91.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org

On Sat, Feb 22, 2014 at 06:27:06PM +0000, Chris Ball wrote:
> Hi,
> 
> On Fri, Feb 21 2014, Russell King - ARM Linux wrote:
> > On Thu, Feb 20, 2014 at 04:48:58PM +0530, Viresh Kumar wrote:
> >> Nothing wrong in that, only right.. Do you want me to float a patch for
> >> this or you can get that done along with your series?
> >
> > I'll send a follow-up mini-series of five patches for it.  It shouldn't
> > depend all that much on the bigger series - and I think the first two
> > patches could well do with going into -rc.
> 
> Thanks.  Since testing resources might be scarce, and it looks like
> Viresh is in favor of the series, any objections to putting these in
> mmc-next straight away rather than waiting for test results to come in?

The series needs to be re-ordered to avoid patch 7 breaking sdhci-spear.
I'll send out a new series appropriately ordered.  I'm continuing to do
more to this driver as time permits.

One thing which I've toyed with is passing a "changes" field in struct
mmc_ios, so that host drivers can know what's changed and avoid resetting
the power, clocks, etc on every set_ios call.  Another thing I've toyed
with is the idea of splitting set_ios up into several sub-calls which
the core only calls with the various changes.

One of my reasonings for the second idea is that with the variability
in hosts, particularly with how they deal with the application of power,
it would be a good idea to allow hosts which do the "turn power on,
send 74 clocks" automonously avoid having to deal with the power_up
transition.

It also means that hosts aren't having to work out if the timings have
changed, or the clocks, or anything else.

What are your thoughts on that?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
