Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CC4C433E6
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658E622DFB
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 13:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392684AbhAZNle (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 08:41:34 -0500
Received: from pop32.abv.bg ([194.153.145.222]:34416 "EHLO pop32.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403906AbhAZNkp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Jan 2021 08:40:45 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2021 08:40:44 EST
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop32.abv.bg (Postfix) with ESMTP id 6D17D200F7
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 15:29:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1611667744; bh=eoOyn5w5MbvNhHnzb+uFMtogZEah9Q42+famfziX028=;
        h=To:From:Subject:Date:From;
        b=wnlH4uUnYxYcIIS1O6LA00vgcL2OemXkJTM7roj+bRtmttHTAHqJ+jAHmzxeK9nGc
         nB60EYTxU42914m5l3ixF+Zvwg55b04+D4nWnkT0Rnl4a+56sMFRVy6A4botGzY68E
         vuVa4wbL6W0JfZJbJbi8LxFvfhC61i/BvA51NSw8=
X-HELO: [192.168.1.115]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=buboleck@abv.bg
Received: from 46-249-79-198.net1.bg (HELO [192.168.1.115]) (46.249.79.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted); Tue, 26 Jan 2021 15:29:04 +0200
To:     linux-mmc@vger.kernel.org
From:   Dimitar Kosev <buboleck@abv.bg>
Subject: Realtek USB Card Reader Driver issues
Message-ID: <1c123f6f-705b-8e47-1a01-dc6a61e6d416@abv.bg>
Date:   Tue, 26 Jan 2021 15:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

It seems there is some issue with the rtsx_usb module. I'm using Gentoo 
with kernel 5.7.9 at the moment as the card reader driver does not work 
with 5.9 and 5.10 kernels, I don't know if the issue is there with 5.8 
kernels as it was causing issues with my vga, my card reader info below:

Bus 002 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 
Card Reader Controller

The module detect the reader but does not detect the sd cards inserted, 
the same cards work with 5.7 so I assume something was broken i the driver.

Kind regards,

