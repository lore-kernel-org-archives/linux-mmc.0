From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
Date: Tue, 21 Jan 2014 13:39:20 -0600
Message-ID: <CAGo_u6qHFmgb9s9Taw2NAuBgjLY5tDW5XHbfik7PHcTArW7szg@mail.gmail.com>
References: <1390260542-22213-1-git-send-email-nm@ti.com>
	<20140120233941.GG6516@saruman.home>
	<52DEB078.5030005@ti.com>
	<20140121180549.GS30451@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:48119 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbaAUTjV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 14:39:21 -0500
In-Reply-To: <20140121180549.GS30451@saruman.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: dt list <devicetree@vger.kernel.org>, Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 21, 2014 at 12:05 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Jan 21, 2014 at 11:38:00AM -0600, Nishanth Menon wrote:
>> On 01/20/2014 05:39 PM, Felipe Balbi wrote:
>> > On Mon, Jan 20, 2014 at 05:29:02PM -0600, Nishanth Menon wrote:
>> >> When device is booted using devicetree, platforms impacted by
>> >> Erratum 2.1.1.128 is not detected easily in the mmc driver. This erratum
>> >> indicates that the module cannot do multi-block transfers.
>> >>
>> >> Handle this by providing a boolean flag to indicate to driver that it is
>> >> working on a hardware with mentioned limitation.
>> >
>> > sure there's no way of reading the revision register to figure this one
>> > out without having to add a new DT attribute ?
>> >
>> I did a quick patch to read the Module revision register:
>> http://slexy.org/view/s21TKvlWlR
>>
>> sdp2430: Revision: 1.2, Spec: 0.0, normal interrupt
>>
>> OMAP3430-ldp: (ES2.1): Revision: 2.6, Spec: 0.0, normal interrupt
>> SDP3430:(ES3.0) Revision: 2.6, Spec: 0.0, normal interrupt
>> AM3517-evm: (ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
>> AM3517-crane:(ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
>>
>> AM37x-evm: (ES1.2) Revision: 2.6, Spec: 0.0, normal interrupt
>> OMAP3630-beag-xm (ES1.2): Revision: 2.6, Spec: 0.0, normal interrupt
>>
>> am335x-evm:(ES1.0): Revision: 3.1, Spec: 0.1, normal interrupt
>> am335x-sk: (ES2.1): Revision: 3.1, Spec: 0.1, normal interrupt
>> am335x-beaglebone-black:(ES2.0): Revision: 3.1, Spec: 0.1, normal
>> interrupt
>>
>> sdp4430.txt: (ES2.2): Revision: 3.1, Spec: 0.1, normal interrupt
>>
>> OMAP4460-panda-es (ES1.1): Revision: 3.1, Spec: 0.1, normal interrupt
>>
>> OMAP5uevm:(ES2.0): Revision: 3.3, Spec: 0.2, normal interrupt
>> dra7-evm (es1.1): Revision: 3.3, Spec: 0.2, normal interrupt
>>
>>
>> OMAP3430-ldp seems to be the only one impacted with module revision
>> 2.6 -> so using revision information is not really helpful here. Hence
>> the usage of a flag in dt attribute to indicate hardware impacted by
>> erratum.
>
> alright, that's too bad. Seems like revision in this module isn't very
> useful :-(

Can I take that as an acked-by?

Regards,
Nishanth Menon
