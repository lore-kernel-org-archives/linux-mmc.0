Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC38C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Dec 2022 15:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiLMP0T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiLMP0R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2022 10:26:17 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C42DC6
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2022 07:26:15 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7A4173A29E7
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2022 16:26:13 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 5ECDA3A078E
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2022 16:26:13 +0100 (CET)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2022 16:26:13 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLAAADypIAAxzoEAAAK4ktA=
Date:   Tue, 13 Dec 2022 15:26:12 +0000
Message-ID: <256e7a78852041ffbea965e3e3a71863@hyperstone.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
 <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
 <DM6PR04MB6575C12FBBD33AD36B8290D6FCE39@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575C12FBBD33AD36B8290D6FCE39@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27322.000
X-TMASE-Result: 10--8.500800-10.000000
X-TMASE-MatchedRID: F3kdXSFZYkfUL3YCMmnG4pTQgFTHgkhZC/ExpXrHizxaCbh+r2jQs2dv
        IBM8UuLSiOOJL7UsrrssWi4sXciGhcCiHTNtFGyJqdwbW9Wx9tD/lIIryslypzpnHdhQ1BMbGSE
        KEg7q+Dx6KCIBFzd6H2aZdF3A++/3bw6bxgWmSFwv09a+vBP41kxUJyPnqTyGxuXV3UE49jiNpx
        yS486SbuPy996aobFy8PAec6ZZAC751PG1p8jrTSnWPZZ0/GQXkYC3rjkUXRLRguFbDyQ6QY1/b
        5Pr4RYOUoDKDRI6O5l8sQbV/4bjS0QfOO3rxcnQ/e+uN180e5cxXH/dlhvLv/4DDXoaCqk75oaD
        8GK3n22godYFWegkc7THG/IS3+B1v6perBgQquMe4SzTjxRVojqu3dM+YhFR3bBYhNTI0/zLKOx
        8Px7v0uCvRZnq77Kllsm6RP1UKocYB2fOueQzjxM0JxSxHjFJseWplitmp0j6C0ePs7A07RRAJC
        2k3BZ6nz5JOy8lvajnqvaeza1QCyX/qtViMqeDqwYwmUuy2qY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 1c361056-b368-4fd0-aa8e-f3bd2eb8b906-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> > For SD a CMD13 after CMD38 is required, too.
>> > I guess I can add that.
>> 
>> Just realized that sending CMD13 is not sufficient as the kernel will 
>> poll because of R1B and clear the error flag.
>> Anyway I have this kernel patch for a write flag bit that aggregates 
>> errors during polling until card is in TRAN again.
>> I will send it then, since I don't think there is a good way of 
>> solving this for SD in mmc-utils, please consider this patch on its own.
> Leaving SD aside for now - I Still wasn't able to get an expert opinion - holiday season etc. 
> While waiting however, looking in Table 70 - Device Status field/command - cross reference, I can see that :
> - ERASE_RESET - is not reported for any of cmd35, cmd36, and cmd38
> - ERASE_PARAM - is 'X' for cmd35 only
> - ERASE_SEQ_ ERROR - is 'R' for cmd35 and cmd36
>
> So potentially only ERASE_SEQ_ ERROR may reside in those commands responses.
> But mmc-utils uses multi-ioctl for that, so there couldn't be any mis-ordering?
> Which error bits you see in which command responses?
> 
> Thanks,
> Avri

Hey Avri,
Thanks for having a look at this.
Yeah I have indeed only seen ERASE_SEQ_ERROR, but added the rest because it doesn't hurt.
Why would you say ERASE_PARAM shouldn't be checked? Or are you arguing it should only be checked at CMD38 (i.e. the X of CMD35)?
(In which case I agree, just didn't want more than one error mask)
Seeing a ERASE_PARAM would definitely make the erase not happen (that's all mmc-utils should really care about).
ERASE_RESET may be removed for sure, could be checked when a SD ioctl erase fix like I described is in the kernel.
Then an ideal mmc-utils erase operation checks that no relevant R1 bits are set at CMD38 RSP and all CMD13 until card leaves PRG and stops signalling busy.


For an erase call like this:
mmc-utils erase legacy 0 0xFFFFFFFF /dev/mmcblk2

the MMC trace (according to spec and most cards I tried, this is one of them) looks like this:
Format: timestamp,type,CMDOPCODE,
for type 1 (CMD) and type 2 (Resp48) then the next field is arg/response in hex.
I guess rest is more or less self-explanatory / not relevant.

325533.758261654,1,13,00010000
325533.758282029,2,13,00000900, READY_FOR_DATA, TRANS_STATE
325534.549850485,1,08,00000000
325534.549874693,2,08,00000900, READY_FOR_DATA, TRANS_STATE
325534.550132818,4,08,0,512
325534.550132818,5,08,00000000000000000000000... REDACTED FOR SIZE
325534.550693693,1,35,00000000
325534.550710026,2,35,00000900, READY_FOR_DATA, TRANS_STATE
325534.550761651,1,36,ffffffff
325534.550774485,2,36,80000900, ADDRESS_OUT_OF_RANGE, READY_FOR_DATA, TRANS_STATE
325534.552136276,1,38,00000000
325534.552164568,2,38,10000900, ERASE_SEQ_ERROR, READY_FOR_DATA, TRANS_STATE
325534.552227568,1,13,00010000
325534.552241276,2,13,00000900, READY_FOR_DATA, TRANS_STATE

Hope that helps.

Regards,
Christian

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

