Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B89C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Dec 2022 18:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLOSOh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Dec 2022 13:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLOSOe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2022 13:14:34 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B813B9CD
        for <linux-mmc@vger.kernel.org>; Thu, 15 Dec 2022 10:14:29 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 0EBE83A29F3
        for <linux-mmc@vger.kernel.org>; Thu, 15 Dec 2022 19:14:28 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id EA4B03A29F0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Dec 2022 19:14:27 +0100 (CET)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Thu, 15 Dec 2022 19:14:27 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLAAADypIAAxzoEAAAK4ktAAIxua4ABHzIXA
Date:   Thu, 15 Dec 2022 18:14:26 +0000
Message-ID: <d6e549498c6a420da4e703ce27a81774@hyperstone.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
 <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
 <DM6PR04MB6575C12FBBD33AD36B8290D6FCE39@DM6PR04MB6575.namprd04.prod.outlook.com>
 <256e7a78852041ffbea965e3e3a71863@hyperstone.com>
 <DM6PR04MB6575450E246DBB0880A818ECFCE09@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575450E246DBB0880A818ECFCE09@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27326.002
X-TMASE-Result: 10--8.596600-10.000000
X-TMASE-MatchedRID: a3sLnpBpvfTUL3YCMmnG4pTQgFTHgkhZC/ExpXrHizzRguFbDyQ6QY1/
        b5Pr4RYOxEALcQoDuOilRe5NgCgJIesZ3fR4G18mTbFVCYPBTqaUq+GQ/zyJdOjUkIrT0o6LA5G
        IEFfBenq+kQFb9aK4lCvq+2mQnrLwUb9lEuZnMyTRCUFHAmq1I1/d6ediod7YvBi1vSDtjC2yuh
        piqaRnamMe7coeR41MRW64xoGuxIplJTodqNqEzirLqyE6Ur/jQAKUX1R86jRXPwnnY5XL5NSHn
        JDq2yhMZjVd8EsCu6x4UXBz39+tPlL+KwgRcYO/L7p//vLv4bNPnKxAOPp4WeXPgbQLgxs4K7hh
        c0PCRKmL42rzNh0DNEVLVHt/d4qUlwt7DABrvp+09h+AUneRj0sHsGwIjCmwmOTQRu2CG1eONWI
        sOr2UIE4RFDkLYc/aPMamxhwjTc6NQ8VRQhwTJxfqkKQlk1I5fS0Ip2eEHny4wTpaFKqo4dRnEQ
        CUU+jzjoczmuoPCq2u1v9yFqcHnVtjPI9nnMmWEU7GbQHgt9raZDvJnhq+n+Ppv7pz2L2b
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: ea150a27-d21f-472e-9028-4c51f769d3ed-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hey Avri,

>> Yeah I have indeed only seen ERASE_SEQ_ERROR, but added the rest 
>> because it doesn't hurt.
> ERASE_SEQ_ERROR - It is set when e.g. CMD36 is given before CMD35 e.g. the following CMDs are issued CMD36 -> CMD35 -> CMD38 In the response of CMD36, ERASE_SEQ_ERROR error bit will be reported.
> This can't be happening for mmc-utils because it send the correct sequence using multi-ioctl - Which assure it can't be interrupted by any other command.
> The trace that you attached looks like a fw bug to me.

I disagree, requoting the eMMC spec I quoted originally, considering an OOR erase address:
'If the host provides an out of range address as an argument to CMD35 or CMD36, the Device will reject the command, respond with the ADDRESS_OUT_OF_RANGE bit set and reset the whole erase sequence."
So CMD38 must trigger ERASE_SEQ_ERROR for OOR on MMC and it is a (HW) bug if it doesn't.

>
>> Why would you say ERASE_PARAM shouldn't be checked? Or are you arguing 
>> it should only be checked at CMD38 (i.e. the X of CMD35)?
> ERASE_PARAM - It is set when wrong address is given for first erase group in CMD35, And is reported in the response of CMD36.
> This is actually the only error bit we should look for.
>
>> (In which case I agree, just didn't want more than one error mask) 
>> Seeing a ERASE_PARAM would definitely make the erase not happen 
>> (that's all mmc-utils should really care about).
>> ERASE_RESET may be removed for sure, could be checked when a SD ioctl 
>> erase fix like I described is in the kernel.
> ERASE_RESET is set when any other commands apart from CMD35/36/38/13 is sent during the erase sequence.
> This as aforesaid, can't be happening for mmc-utils.

I disagree here, too.
Just because we are not sending it doesn't mean the card does not see it.
The card may sample a CMD start bit at some time during the sequence, will not answer because of ILLEGAL / CRC mismatch.
The sequence is reset anyway (out of sequence command received). This is not unthinkable on neither SD nor MMC bus.
ERASE_SEQ_ERROR at CMD38 will catch that, too, though.

>
>> Then an ideal mmc-utils erase operation checks that no relevant R1 
>> bits are set at CMD38 RSP and all CMD13 until card leaves PRG and 
>> stops signalling busy.
> Are you suggesting that we should include cmd13 as the 4th command in the erase sequence?
> I am not sure we need it.

I am.
At any point there is some operation making changes to the flash, be it writes or erases, the busy will be asserted (assuming cache off).
When busy is deasserted host needs to check why this was the case.
Consider a flash voltage drop, card may signal e.g. the general error bits, but behavior depends on the card of course.
If issuing a secure erase, I would like to know if busy of CMD38 was deasserted because of successful completion or some other error and erase was in fact not fully executed.
mmc-utils cannot fix this on its own, so for now let's restrict this patch to OOR erases and so on for MMC-only.

> To conclude, IMO only ERASE_PARAM should be checked in the response of CMD36.
I think ERASE_PARAM should be checked for CMD36, ERASE_SEQ_ERROR for CMD38, I'm fine with removing ERASE_RESET check for the patch, it is caught at CMD38 ERASE_SEQ_ERROR anyway.
What do you say?

Regards,
Christian

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

