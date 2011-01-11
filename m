From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: Re:[lnxrevli] [REVIEW 2/2] ENGR0000137838 SDHCI Some eMMC cards
 can't workwell in our BSP
Date: Tue, 11 Jan 2011 02:17:08 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE9004756C@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1294711368-446-1-git-send-email-r65037@freescale.com>
 <1.10.2011-mgd.freescale.com-30-6343028328831767454500-3831@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:44664
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753800Ab1AKCRT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jan 2011 21:17:19 -0500
In-Reply-To: <1.10.2011-mgd.freescale.com-30-6343028328831767454500-3831@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Zhang Lily-R58066 <R58066@freescale.com>, "root@udp161639uds.ap.freescale.net" <root@udp161639uds.ap.freescale.net>, ReviewList Linux-LNXREVLI <LNXREVLI@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Chris:
I keep all the info of the original patch into my local patch.
The script the pull-tool used by us send out the emails to all the sign-off email address,
When I used this tool to push the local patch into our mainline.
Sorry to bring any inconvenience to you.

Best Regards
Richard Zhu

Best Regards
Richard Zhu


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, January 11, 2011 10:08 AM
> To: Zhu Richard-R65037
> Cc: Zhang Lily-R58066; root@udp161639uds.ap.freescale.net; ReviewList
> Linux-LNXREVLI; linux-mmc@vger.kernel.org
> Subject: Re:[lnxrevli] [REVIEW 2/2] ENGR0000137838 SDHCI Some eMMC cards
> can't workwell in our BSP
>
> Hi,
>
> On Tue, Jan 11, 2011 at 10:02:48AM +0800, Richard Zhu wrote:
> > Pick up the patch from the community.
> >
> > fc8a0985c2846292312556cba10b8a4182f55967
> > From: Hanumath Prasad <hanumath.prasad@stericsson.com>
> > Date: Tue, 10 Aug 2010 18:01:45 -0700
> > Subject: [REVIEW 2/2] mmc: only set blockaddressed for > 2GiB cards
> >
> > A non-zero value of SEC_COUNT does not indicate that the card is
> > sector addressed. According to the MMC specification, cards with a
> > densitygreater than 2GiB are sector addressed.
>
> What's the point of sending this mail to linux-mmc@?
>
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


