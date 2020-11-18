Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168FC56202
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 03:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0266724695
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 03:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cudvYm/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKRDgJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 22:36:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54968 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgKRDgJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 22:36:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E3431017FE;
        Tue, 17 Nov 2020 22:36:07 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=y8l+KF7f0+0ASWZxoZ5hLgdJA
        3c=; b=cudvYm/NffJyMpC2TRIag9B3JCaiGrev0nan8ozTbRKtEiZc7mETNY3it
        Sa/kpP5SZJ/7JnDvbJmoztS8ZFrDlbdTi+19qPUI0Bbyw83CxiUhsaNtSgzFwTj7
        nZbpl0J+oprJ83ixN+e3yYPo6+9Y/kTteYVgtlGDty3ODPYwkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:from:subject
        :message-id:date:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=rEd5gqV1E13+IjWxLy+
        Q0BeAVsMwcdWyareWsnoQWGc/JNtUnIEzIipHkmCrMLlPk3yxp4cO9x0eZlhKbo7
        SRfdWIcARCClDraDorTP6xN2YJ6UlO5ZkjZe/MYS9eNnvh5IRIJ2YR3keeT6SnUO
        nZ57RSiPN/XEeSp12yDDU0Qs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4770D1017FD;
        Tue, 17 Nov 2020 22:36:07 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.0.8] (unknown [76.183.130.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A228E1017FA;
        Tue, 17 Nov 2020 22:36:04 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
To:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux MMC <linux-mmc@vger.kernel.org>
From:   Daniel Santos <daniel.santos@pobox.com>
Subject: Write in-place w/o erase? (f2fs on microSD)
Message-ID: <c407136e-6d71-1347-511b-b3d76ad0ab32@pobox.com>
Date:   Tue, 17 Nov 2020 21:35:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 2FEEB8BE-294F-11EB-A66A-E43E2BB96649-06139138!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

I'm designing an embedded program that has to log messages on a microSD
card -- so I presume a simple FTL.=C2=A0 I'm wondering if I can initializ=
e an
erase erase_size portion of a file with 0xff and then make multiple
writes that only clear bits, and get in-place writes (w/o an erase)
instead of using out-of-place writes on a new block each time.=C2=A0 In t=
his
way, I could just write the message size for each message (always less
than 255) and interpret an 0xff as "end of list".

I've looked through the mmc sources a bit and I'm not even sure if this
would be a function of f2fs, the mmc layer or the FTL.

Is this possibly what F2FS_IOC_SET_PIN_FILE is for?

I do realize that if I make writes that require erases that I'll likely
break wear leveling, so I'll want to make sure I'm never triggering erase=
s.

Thanks!
Daniel
