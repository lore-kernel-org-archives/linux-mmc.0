Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE595C6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 09:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjDDJ31 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDDJ30 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 05:29:26 -0400
Received: from arashi.greysector.net (arashi.greysector.net [51.68.141.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3B1BD6
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 02:29:24 -0700 (PDT)
Received: from sakura.greysector.net (unknown [192.193.243.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by arashi.greysector.net (Postfix) with ESMTPSA id D00731466
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 11:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arashi.greysector.net D00731466
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greysector.net;
        s=default; t=1680600562;
        bh=jGlPi4L8K/jXL5+5n5r7PIPhysDPiXu3V0283Z9bmqE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=XbhbY62Q9Gab0HZnVovxWyq89OwqmSvea6qm/wyzBBE4GZ0i4/jbg30FvlVVPa7rz
         ahoKo83R1ilyLE11wnAFogunmN5WZo5rnEwR53PEw5pLIN5uTjFzSVtOC8fLecwV8r
         kLq737FYd+6gyVAz+LyGA52KTi0Bw+F86zCGDJCE=
Date:   Tue, 4 Apr 2023 11:29:21 +0200
From:   Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: mmc-utils: ioctl connection timed out with SD cards
Message-ID: <ZCvt8WDcpsAXW5/q@sakura.greysector.net>
References: <ZCsSHxDv+158emk5@sakura.greysector.net>
 <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
 <48e2f9c1a3664fa59977a56579edde97@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48e2f9c1a3664fa59977a56579edde97@hyperstone.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello, Christian.

On Tuesday, 04 April 2023 at 08:14, Christian Löhle wrote:
> > is the mmc tool from mmc-utils supposed to work with SD cards?
> > I tried mmc status get /dev/mmcblkN with three different SD cards on
> > two different machines (Pinebook Pro and a Sony laptop) and I get
> > the same error on both:
> > # mmc status get /dev/mmcblk0
> > ioctl: Connection timed out
> > Could not read response to SEND_STATUS from /dev/mmcblk0
> 
> Could you try something like
> sudo dd if=/dev/mmcblk0 of=/dev/null count=1 iflag=direct; sudo mmc status get /dev/mmcblk0
> just to rule out anything in the autosuspend direction?

I did, same error:
$ sudo dd if=/dev/mmcblk0 of=/dev/null count=1 iflag=direct; sudo mmc status get /dev/mmcblk0
1+0 records in
1+0 records out
512 bytes copied, 0.000832209 s, 615 kB/s
ioctl: Connection timed out
Could not read response to SEND_STATUS from /dev/mmcblk0

And there's a corresponding
[ 3540.312203] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: __mmc_blk_ioctl_cmd: cmd error -110
in dmesg.

This is on a third machine, a Dell laptop (though the SD card reader is
driven by the same rtsx_pci_sdmmc driver as in the Sony case).

Regards,
Dominik
-- 
Fedora   https://getfedora.org  |  RPM Fusion  http://rpmfusion.org
There should be a science of discontent. People need hard times and
oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
