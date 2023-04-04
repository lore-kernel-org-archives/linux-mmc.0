Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069B7C761A6
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 10:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjDDKJF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjDDKJE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 06:09:04 -0400
Received: from arashi.greysector.net (arashi.greysector.net [51.68.141.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA9272C
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 03:09:00 -0700 (PDT)
Received: from sakura.greysector.net (unknown [192.193.243.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by arashi.greysector.net (Postfix) with ESMTPSA id 71D69C15
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 12:08:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arashi.greysector.net 71D69C15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greysector.net;
        s=default; t=1680602938;
        bh=rD0HzhIpAl2IeJQ9i6LNgMFDiMkaghxz+iDYdxDLlSI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=RBVLUanyL5j8yESvW42vUTgNUblGyaqtWgTzg1LdPCnejwlwgkVfRv8ntukTr6R6j
         f6MBhPGzHQ4cMHVlacsfJb6vcrJPz1dvxSgXNHsbyF1NAic8kte2H1ldsMn7wztw3a
         aBOQmcc8dqGIs2oLRCpJdDmc4NIhWG2g6yHreXSU=
Date:   Tue, 4 Apr 2023 12:08:56 +0200
From:   Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: mmc-utils: ioctl connection timed out with SD cards
Message-ID: <ZCv3OBCE1hB32CDI@sakura.greysector.net>
References: <ZCsSHxDv+158emk5@sakura.greysector.net>
 <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Monday, 03 April 2023 at 22:11, Christian Löhle wrote:
> >Hello,
> >is the mmc tool from mmc-utils supposed to work with SD cards?
> Not really no, but status get is pretty much the one thing that should
> work, apart from register reads that don't issue anything.

I see. I thought any /dev/mmcblk? device would be supported. The
documentation doesn't make this clear. :)

> I'm using RK3399 on SD too and it works okay for me, will try updating
> tomorrow.
> Could you show the debug prints to see the mmc command / responses?
> Ideally for anything in mmc/core

Will something like:

# alias ddcmd='echo $* > /proc/dynamic_debug/control'
# ddcmd 'module mmc_core +p'
# ddcmd 'module rtsx_pci_sdmmc +p'
# mmc status get /dev/mmcblk0
# dmesg | grep -E 'mmc_core|rtsx_pci_sdmmc'

suffice?

Regards,
Dominik
-- 
Fedora   https://getfedora.org  |  RPM Fusion  http://rpmfusion.org
There should be a science of discontent. People need hard times and
oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
