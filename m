From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] ESDHC: Workaround for data crc error on p1010rdb
Date: Wed, 15 Feb 2012 02:00:39 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C023D15@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1329199537-18447-1-git-send-email-r66093@freescale.com>
 <m2vcn9isaj.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:57662 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755803Ab2BOCPu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 21:15:50 -0500
In-Reply-To: <m2vcn9isaj.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

Thanks a lot, Chris.

Thanks
Jerry Huang


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, February 14, 2012 7:11 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Jain Priyanka-
> B32167
> Subject: Re: [PATCH] ESDHC: Workaround for data crc error on p1010rdb
> 
> Hi,
> 
> On Tue, Feb 14 2012, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > SD card read was failing (data crc error)on some cards at maximum
> > possible frequency on P1010(CCB frequency set to 400MHz).
> > Some clock deviations are also observed at this frequency.
> > Hence reduced the mmc clock freq.
> >
> > Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> > Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> 
> Thanks!  Pushed to mmc-next for 3.4.
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


