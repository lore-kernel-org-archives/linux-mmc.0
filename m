From: Leo Li <pku.leo@gmail.com>
Subject: Re: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific driver
Date: Tue, 3 May 2016 15:05:33 -0500
Message-ID: <CADRPPNQaLVHp_HnEcHvZE7ebcmhYKf4K8CeWHErRk-0Xv8cU3A@mail.gmail.com>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
	<1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
	<1461367352.32510.218.camel@buserror.net>
	<HE1PR04MB088907CD90586FC83D058003F8630@HE1PR04MB0889.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34279 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbcECUFf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2016 16:05:35 -0400
In-Reply-To: <HE1PR04MB088907CD90586FC83D058003F8630@HE1PR04MB0889.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Scott Wood <oss@buserror.net>, Yang-Leo Li <leoyang.li@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Zhao Qiang <qiang.zhao@freescale.com>, Russell King <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Scott Wood <scott.wood@nxp.com>, Claudiu Manoil <claudiu.manoil@freescale.com>, Kumar Gala <galak@codeaurora.org>

On Mon, Apr 25, 2016 at 10:12 PM, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> Hi Scott and Leo,
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Scott Wood
>> Sent: Saturday, April 23, 2016 7:23 AM
>> To: Yangbo Lu; linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Cc: ulf.hansson@linaro.org; Zhao Qiang; Russell King; Bhupesh Sharma;
>> Scott Wood; Claudiu Manoil; Kumar Gala; Yang-Leo Li; Xiaobo Xie; Michael
>> Ellerman
>> Subject: Re: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific
>> driver
>>
>> On Fri, 2016-04-22 at 14:27 +0800, Yangbo Lu wrote:
>> > Add maintainer entry for Freescale SoC specific driver including the
>> > QE library and the GUTS driver. Also add entry for GUTS driver and add
>> > maintainer for QE library.
>> >
>> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
>> > ---
>> > Changes for v8:
>> >     - Added this patch
>> > ---
>> >  MAINTAINERS | 16 +++++++++++++++-
>> >  1 file changed, 15 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS index 1d5b4be..d20aeb6 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -4622,13 +4622,27 @@ F:  drivers/net/ethernet/freescale/fec_ptp.c
>> >  F: drivers/net/ethernet/freescale/fec.h
>> >  F: Documentation/devicetree/bindings/net/fsl-fec.txt
>> >
>> > +FREESCALE SOC SPECIFIC DRIVER
>>
>> FREESCALE SOC DRIVERS
>
> [Lu Yangbo-B47093] Ok, will change it to 'FREESCALE SOC DRIVERS'.
>
>>
>> > +M: Scott Wood <oss@buserror.net>
>>
>> Please CC me at this address, not the NXP address that you sent this to...
>
> [Lu Yangbo-B47093] Sorry for mistaking your email. Will send the one you said.
>
>>
>> > +L: linuxppc-dev@lists.ozlabs.org
>> > +S: Maintained
>> > +F: drivers/soc/fsl/
>> > +F: include/linux/fsl/
>>
>> This directory will contain drivers that work on PPC and ARM... I'm not
>> sure what to put here in terms of mailing lists (we could put both, but
>> people probably shouldn't spam both lists if only one arch is relevant to
>> the patch), and whom to make pull requests to.
>
> [Lu Yangbo-B47093] But sooner or later we need to do this for files in fsl/ ...
> :)
>
> Hi Leo, do you have any idea?

I think it would be ok to put both linuxppc and linux-arm mailing
lists here.  Driver doesn't fall into any of the functional based
sub-systems would very likely be platform stuff.  And if patch author
has the knowledge that a patch only impacts one arch, he can remove
the other list to reduce the spam.

>
>
>>
>> > +FREESCALE GUTS DRIVER
>> > +M: Yangbo Lu <yangbo.lu@nxp.com>
>> > +L: linuxppc-dev@lists.ozlabs.org
>> > +S: Maintained
>> > +F: drivers/soc/fsl/guts.c
>>
>> What about the header?
>>
>> Does guts really need a separate maintainer from drivers/soc/fsl?
>
> [Lu Yangbo-B47093] I was hesitating to add the maintainer...
> And I was not so familiar with it. Let me leave it to the fsl/ directory and remove this...
>
>>
>> -Scott
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev



-- 
- Leo
