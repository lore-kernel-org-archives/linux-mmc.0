From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Mon, 28 Dec 2015 13:10:06 +0100
Message-ID: <CAPDyKFqhRVh9XdY=2aMP5sL5kp+RkHV_tsA4=Oj_88e8NN9DCw@mail.gmail.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	<1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
	<1450116253.15946.353.camel@freescale.com>
	<CAPDyKFrKSMC0uo8re3CxjNCUsVnEMau=GTKq=v_3ooNnQxw2Eg@mail.gmail.com>
	<CAPDyKFoYxM4Nv_pHCZbGzuswMCXTLyj6CYgLjYnRguscUs9LrQ@mail.gmail.com>
	<HE1PR04MB0889791AB9F06A5591D4CD5FF8FB0@HE1PR04MB0889.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35166 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbL1MKH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 07:10:07 -0500
Received: by mail-yk0-f181.google.com with SMTP id x67so100114843ykd.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Dec 2015 04:10:06 -0800 (PST)
In-Reply-To: <HE1PR04MB0889791AB9F06A5591D4CD5FF8FB0@HE1PR04MB0889.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Scott Wood <scottwood@freescale.com>, Lu Yangbo-B47093 <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Xie Xiaobo-R63061 <X.Xie@freescale.com>, Leo li <LeoLi@freescale.com>

On 28 December 2015 at 11:26, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Thursday, December 17, 2015 7:31 PM
>> To: Scott Wood
>> Cc: Lu Yangbo-B47093; linux-mmc; Xie Xiaobo-R63061; Leo li
>> Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for
>> MMC_SDHCI_OF_ESDHC
>>
>> [...]
>>
>> >>
>> >> And I think stubs for reading SVR is quite a bad idea.  It'll make
>> >> the driver build but it will silently not be able to apply SVR-based
>> workarounds.
>> >
>> > It doesn't have to be "silent", the driver can return an error (and
>> > print error messages) from its ->probe() method, if the calls to the
>> > GUTS driver fails.
>> >
>> > Anyway, I mentioned this idea only to understand the need for
>> > *optional* GUTS supports. Perhaps there is a cross SOC drivers that
>> > for some platforms depends on GUTS but on others it doesn't.
>> >
>> > Maybe that isn't case then!?
>>
>> Can you please answer this question!?
>>
>> According to the earlier versions of this patchset and from your comments
>> [1], it *do* seems like the GUTS driver may be optional and thus stubs
>> could address this.
>>
>> Kind regards
>> Uffe
>>
>> [1]
>> http://www.spinics.net/lists/linux-mmc/msg34412.html
>
> [Lu Yangbo-B47093] Hi Scott and Uffe,
> In the earlier version, I'd like to use syscon support and only add 'syscon' compatible in the dts whose eSDHC needs to use it to get SVR.
> But I never thought this had caused so much discussion... :(

Sorry, I understand your frustration but that's life sometimes. :-)

To me, the syscon solution is more elegant...

> Could we reach an agreement about the 'optional' or not 'optional'?

...but I am fine with the current approach as well, as long as my
recent comments gets addressed. Let's make it optional.

Address Scott's and my review-comments, get other peoples ack for the
non-mmc parts, then I will happily pick up the patches.

Kind regards
Uffe
