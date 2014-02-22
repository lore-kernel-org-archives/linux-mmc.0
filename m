From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq handler
Date: Sat, 22 Feb 2014 18:27:06 +0000
Message-ID: <8638jbvw91.fsf@void.printf.net>
References: <20140218175703.GJ21483@n2100.arm.linux.org.uk>
	<CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
	<20140219094322.GR21483@n2100.arm.linux.org.uk>
	<CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
	<20140219095212.GT21483@n2100.arm.linux.org.uk>
	<CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com>
	<20140219105011.GU21483@n2100.arm.linux.org.uk>
	<CAKohpokBf_fJhiUJ53c+=6v+GMcjaDKd7+fwib99=sLMdkjQQQ@mail.gmail.com>
	<20140220105903.GY21483@n2100.arm.linux.org.uk>
	<CAKohpo=FTk9SGCMJGBdOUheUg71WsG7qaeE9rwQRqd5dP4O8FQ@mail.gmail.com>
	<20140221103710.GB21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54437 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbaBVS1S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Feb 2014 13:27:18 -0500
In-Reply-To: <20140221103710.GB21483@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 21 Feb 2014 10:37:10 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org

Hi,

On Fri, Feb 21 2014, Russell King - ARM Linux wrote:
> On Thu, Feb 20, 2014 at 04:48:58PM +0530, Viresh Kumar wrote:
>> Nothing wrong in that, only right.. Do you want me to float a patch for
>> this or you can get that done along with your series?
>
> I'll send a follow-up mini-series of five patches for it.  It shouldn't
> depend all that much on the bigger series - and I think the first two
> patches could well do with going into -rc.

Thanks.  Since testing resources might be scarce, and it looks like
Viresh is in favor of the series, any objections to putting these in
mmc-next straight away rather than waiting for test results to come in?

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
