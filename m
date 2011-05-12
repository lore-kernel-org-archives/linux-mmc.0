From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Re-Re-Resubmission
Date: Thu, 12 May 2011 18:26:46 -0400
Message-ID: <m3zkmrv9ll.fsf@pullcord.laptop.org>
References: <1303231971.1622.33.camel@apple-mac>
	<1305117866.1722.14.camel@apple-mac>
	<1305120723.1722.61.camel@apple-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60891 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab1ELWYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 18:24:30 -0400
In-Reply-To: <1305120723.1722.61.camel@apple-mac> (Tony Olech's message of
	"Wed, 11 May 2011 14:32:03 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Wed, May 11 2011, Tony Olech wrote:
> With reference to Arnd's summation of issues with the
> previous version of the patch which can be found at
> "http://ns3.spinics.net/lists/linux-mmc/msg06693.html"
> I have made nearly all of the changes requested.
>
> I have not removed of the __packed keyword from those
> structures that map onto the adapter=E2=80=99s hardware, the
> reason for Arnd's request, as I understand it, is that
> there is a compiler issue with other architectures
> that result in slightly slower code. Since those
> structures exist for translation to/from the adapter
> the efficiency of inserting or extracting data can
> not possibly be an issue. I do not see how having
> the structures marked with the __packed keyword is
> anything but good programming practice since if
> clearly distinguishes those structures from ordinary
> working structures.
>
> There are 2 "if then else if .." decision branches
> that I cannot replace with a single "switch case .."
> statement because there is not a single unique
> expression those value is tested against constant
> values.
>
> I have not chopped the void function "send_command"
> into 2 as Arnd requested, as the function, in spite
> of being 291 lines long is logically very simple
> and any split would be wholly arbitrary and in my
> view just make it more opaque.

Since the remaining objections are minor style issues, I think it makes
sense to merge this to mmc-next now and deal with further improvements
as patches on top of this one (which could get rebased into the origina=
l
patch later, or not).  Would any reviewers like to provide their
Reviewed-by before I do so?

Thanks!

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
