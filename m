Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88786C33CB7
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 09:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB86D20684
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 09:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="I3QUfjzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATJRj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:17:39 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:33813 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATJRj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 04:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579511854;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=qSUjC69zK2oDdbl4JMNMSrLxeZA2bP7y3B61tKmaYIY=;
        b=I3QUfjznxzzsyZe4E1BjVftMMCv6WiKn7GzuMWk62s8EVBWIfHLODMktFzSxlXcAbk
        jvj/V7Yg2monHUe8aY7rU+fZu5tER8qBOaYY2HG+Di0yUJrbl2LIiIwo7ihW2LXFL+Tm
        6b4b2w5OqNO2XgrSaVivKt1ezVaMkuoksvbahaAZIHx+6Ag/tjgwlHd+PKyyn1dkFz1m
        Z5qfcr0Bo5g2G4RybeEuU769aQkKkyHxI5xCj9p6LL5TwChY25+pnYejG0QetTy8KCZc
        Ms6Om1SZgdqY6nsreNxaKpyM4U8TKsOSorlDW9mw0IIH+xnF+aggcvJgMinPZadB1SpV
        rGfQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySd+h5FvloCR9QVidlQfU="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.37]
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id c05c1aw0K9HVw9R
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 20 Jan 2020 10:17:31 +0100 (CET)
Subject: [FSL P5020 P5040 PPC] Onboard SD card doesn't work anymore after the
 'mmc-v5.4-2' updates
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        "contact@a-eon.com" <contact@a-eon.com>,
        Julian Margetson <runaway@candw.ms>
References: <20200108093903.57620-1-hdegoede@redhat.com>
 <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com>
 <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com>
 <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com>
 <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de>
 <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <fda179eb-df5f-ba87-aaf0-524fffca745b@xenosoft.de>
Date:   Mon, 20 Jan 2020 10:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 16.01.20 um 16:46 schrieb Ulf Hansson:
> On Thu, 16 Jan 2020 at 12:18, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> Hi All,
>>
>> We still need the attached patch for our onboard SD card interface
>> [1,2]. Could you please add this patch to the tree?
> No, because according to previous discussion that isn't the correct
> solution and more importantly it will break other archs (if I recall
> correctly).
>
> Looks like someone from the ppc community needs to pick up the ball.
I am not sure if the ppc community have to fix this issue because your 
updates (mmc-v5.4-2) are responsible for this issue. If nobody wants to 
fix this issue then we will lost the onboard SD card support in the 
future. PLEASE check the 'mmc-v5.4-2' updates again.
>
>> Thanks,
>> Christian
>>
>> [1] https://www.spinics.net/lists/linux-mmc/msg56211.html
> I think this discussion even suggested some viable solutions, so it
> just be a matter of sending a patch :-)
>
>> [2]
>> http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4349&start=20#p49012
>>
> Kind regards
> Uffe

