Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F6C33C9E
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 11:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B8924688
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gWsMxHUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgA1Lzf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:55:35 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52975 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1Lzf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Jan 2020 06:55:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 486Q6V2LqGz9sNF;
        Tue, 28 Jan 2020 22:55:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1580212533;
        bh=MpHFi4OUxb+RLUqPq8i8z8tgCvvnh/pa/tf3O7Ge6fY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gWsMxHURlpx686fwXAh2vgtJx0pDdvohiEbSIvcFTMAFxaTlWftoU7X5IU/2WfOjh
         fgXGo1rrIX2MzDep+Mpk6x3HLBPQCJ0BgeJCYzin4REnYbcfyj/Pdr+uCL98uBhU8j
         wAualP1ppZKytFTZRTm9MZyJSj/7Q/Z6Bw6TZ5/9/p+7Bg2uCczAEPG66JJNLnkIWc
         2DZ9oTSn/NssPGBdJxjZZv6sEdsRCKCsEfcpiRut1T1pJlR5pMtMxceISVVVBQlObW
         87pEpga1UpvrXmT7biQDx23pc/QZSyZCXOnMIsQKkTxrOMoRfUI3Elb0BVBdKAdMA6
         5mXHBgv68fWGg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Julian Margetson <runaway@candw.ms>,
        "contact\@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [FSL P5020 P5040 PPC] Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
In-Reply-To: <de35b0fc-9e24-2989-58f6-ade0585db1a0@xenosoft.de>
References: <20200108093903.57620-1-hdegoede@redhat.com> <20200108093903.57620-2-hdegoede@redhat.com> <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com> <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com> <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com> <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com> <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com> <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de> <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com> <8736c5hyhr.fsf@mpe.ellerman.id.au> <de35b0fc-9e24-2989-58f6-ade0585db1a0@xenosoft.de>
Date:   Tue, 28 Jan 2020 22:55:29 +1100
Message-ID: <87d0b3hk26.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Christian Zigotzky <chzigotzky@xenosoft.de> writes:
> On 24 January 2020 at 12:42 pm, Michael Ellerman wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>> On Thu, 16 Jan 2020 at 12:18, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> Hi All,
>>>>
>>>> We still need the attached patch for our onboard SD card interface
>>>> [1,2]. Could you please add this patch to the tree?
>>> No, because according to previous discussion that isn't the correct
>>> solution and more importantly it will break other archs (if I recall
>>> correctly).
>>>
>>> Looks like someone from the ppc community needs to pick up the ball.
>> That's a pretty small community these days :) :/
>>
>> Christian can you test this please? I think I got the polarity of all
>> the tests right, but it's Friday night so maybe I'm wrong :)
>>
>> cheers
> Michael,
>
> Thanks a lot for the new patch! I compiled the RC7 of kernel 5.5 with 
> your patch again yesterday and the kernel works without any problems 
> with our onboard SD cards. [1]

Thanks for testing.

cheers
