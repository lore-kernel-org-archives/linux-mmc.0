Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0271C6FD18
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Apr 2023 12:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjDYMln (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Apr 2023 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjDYMlm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Apr 2023 08:41:42 -0400
Received: from arashi.greysector.net (arashi.greysector.net [51.68.141.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B1F5FDD
        for <linux-mmc@vger.kernel.org>; Tue, 25 Apr 2023 05:41:39 -0700 (PDT)
Received: from sakura.greysector.net (unknown [212.180.189.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by arashi.greysector.net (Postfix) with ESMTPSA id 717EF3E97;
        Tue, 25 Apr 2023 14:41:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arashi.greysector.net 717EF3E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greysector.net;
        s=default; t=1682426497;
        bh=3I0A/D/r1iQy2k6hzFloP/tFXYv4LchkNk4jiF+un78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DC4GmOFwVF4tqA6+VS5jAZ6/J18O1xMx/BkcDoQKKDmOdw7oNTLj+aOvfG//4xcN6
         LY0CYltcwW9hO/KxcYbUJitkLV4+EehL2M+SSrfZQrKf77xfNuSheniM0NtN87TM4D
         QDb43e+LD2aqaDvqfH3Y37o2mxxUohLmO3fabKkg=
Date:   Tue, 25 Apr 2023 14:41:36 +0200
From:   Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: mmc-utils: ioctl connection timed out with SD cards
Message-ID: <ZEfKgCK5TzjhKJOh@sakura.greysector.net>
References: <ZCsSHxDv+158emk5@sakura.greysector.net>
 <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
 <ZCv3OBCE1hB32CDI@sakura.greysector.net>
 <0dc45f7ba447445e946d8f71e63f3f3e@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dc45f7ba447445e946d8f71e63f3f3e@hyperstone.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, Christian.

On Tuesday, 04 April 2023 at 19:32, Christian Löhle wrote:
> The problem is the harcoded 0x0001 as RCA, sdcards have whatever the
> vendor thinks is right.
> I can send a fix for that tomorrow, but generally mmc-utils isn't much
> useful for SD cards, most mmc-utils features are eMMC-only features
> anyway.
> Softreset works as expected, for byte-addressed we can use grouped wp.
> I was thinking about adding TMP_WRITE_PROTECT for both, maybe unlock, too.
> And also adapt erase.
> Apart from that do you have any features that you can think of?

Not really. I'm not familiar with SD card internals or MMC internals,
for that matter. I think you've already done more than I expected after
my rather naive e-mail, so thank you very much. If mmc-utils can be
fixed to give meaningful error messages when someone tries to use them
on SD cards after being confused by the device naming of the kernel like
myself then I'm happy with that.

> SD just doesn't have that many features that are used outside of
> normal IO operation.

I see. Thanks for the insight.

Best regards,
Dominik
-- 
Fedora   https://getfedora.org  |  RPM Fusion  http://rpmfusion.org
There should be a science of discontent. People need hard times and
oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
