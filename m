From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Tue, 25 Sep 2012 02:05:46 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C193731@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1348223135-6435-1-git-send-email-r66093@freescale.com>
 <m3y5k3e4tq.fsf@pullcord.laptop.org>
 <6A474F70-46DB-43ED-92C0-5D111AA64D48@kernel.crashing.org>
 <110EED8CC96DFC488B7E717A2027A27C191E05@039-SN1MPN1-004.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C191EAD@039-SN1MPN1-004.039d.mgd.msft.net>
 <EAF14FF4-2EFA-4A3E-BE72-3319FABBA1F5@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:26842
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751677Ab2IYCFw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Sep 2012 22:05:52 -0400
In-Reply-To: <EAF14FF4-2EFA-4A3E-BE72-3319FABBA1F5@kernel.crashing.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

> >>>> Hi,
> >>>>
> >>>> On Fri, Sep 21 2012, r66093@freescale.com wrote:
> >>>>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> >>>>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> >>>>> @@ -143,6 +143,35 @@ static void esdhc_of_resume(struct sdhci_host
> >>>>> *host) } #endif
> >>>>>
> >>>>> +static const u32 non_cmd23_processor_table[] = {
> >>>>> +	/* P1020 Dual/Single core */
> >>>>> +	0x80EC00, 0x80E400, 0x80ED00, 0x80E500,
> >>>>> +	/* P1021 Dual/Single core */
> >>>>> +	0x80EC01, 0x80E401, 0x80ED01, 0x80E501,
> >>>>> +	/* P1022 Dual/Single core */
> >>>>> +	0x80EE00, 0x80E600, 0x80EF00, 0x80E700,
> >>>>> +	/* P1024 Dual/Single core */
> >>>>> +	0x80EC02, 0x80E402, 0x80ED02, 0x80E502,
> >>>>> +	/* P1025 Dual/Single core */
> >>>>> +	0x80EC03, 0x80E403, 0x80ED03, 0x80E503,
> >>>>> +	/* P4080 and P4040 */
> >>>>> +	0x820000, 0x820800, 0x820100, 0x820900
> >>>>
> >>>> I don't see how this method improves on either of the previous two
> >>>> we've discussed.  If anything, Kumar's suggested method seems
> >>>> better than this
> >>>> one:  it detected the MMC IP revision, which I'd expect to be more
> >>>> reliable than building a list of which SoCs contain that IP.
> >>>>
> >>>> Why is this better than using DT or detecting the MMC revision?
> >>>>
> >>>> Thanks,
> >>>
> >>> I feel like I missed this patch, but I'd rather we go with the
> >>> version I sent since the # of IP versions we have is 3 or 4, instead
> >>> of the 30 or
> >>> 40 SoCs we have.
> >>>
> >> MPC8536 and P4080 have the same IP version (VVN1.0), but MPC8536
> >> support CMD23, P4080 can't, how to handle these two silicones?
> >> For the future silicones, no one can make sure all silicones support
> >> CMD23.
> >> don't say almost 0%, which just is the assumption, otherwise, why
> >> p4080 can't support it and mpc8536 can?
> > MPC837x has the same VVN1.0 as the MPC8536 and p4080, which supports
> CMD23, too.
> 
> So I checked on actual boards and got:
> 
> MPC8536 - 00000001
> MPC837x - 00000001
> P4080   - 00001201
> 
> So I don't think you are correct about them reporting the same version
> number. (I think the manual for P4080 may be incorrect).
> 
> Here's the other SoCs that I verified:
> 
> 8536 = 00000001
> 
> 2020 = 00000101
> 8569 = 00000101
> 
> 4080 = 00001201
> 1021 = 00001201
> 1022 = 00001201
> 
> 5040 = 00001301
> 2041 = 00001301
> 5020 = 00001301
> 1010 = 00001301
> 9131 = 00001301
> 
Thank, I double check the version on p4080, it is 0x00001201.
Then, I will send the patch to check the IP version.
BTW:
It is 0x00000001 in p4040 RM, I think the RM should be checked carefully before releasing to customer.


