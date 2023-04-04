Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24AFC6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 11:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjDDLkb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjDDLka (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 07:40:30 -0400
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ECBB6
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 04:40:26 -0700 (PDT)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7889422293C
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 13:40:24 +0200 (CEST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 5CC0622293B
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 13:40:24 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail6.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 13:40:24 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Dominik 'Rathann' Mierzejewski <dominik@greysector.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: mmc-utils: ioctl connection timed out with SD cards
Thread-Topic: mmc-utils: ioctl connection timed out with SD cards
Thread-Index: AQHZZlWz7zj1vli6ykWT5I70wuFTRa8aAk7wgADKbgCAADokIA==
Date:   Tue, 4 Apr 2023 11:40:22 +0000
Message-ID: <3e16419fac794968a0107ce44e32bd5d@hyperstone.com>
References: <ZCsSHxDv+158emk5@sakura.greysector.net>
 <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
 <ZCv3OBCE1hB32CDI@sakura.greysector.net>
In-Reply-To: <ZCv3OBCE1hB32CDI@sakura.greysector.net>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27544.007
X-TMASE-Result: 10--17.359800-10.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4qwNPl5dbX19NQO+lFC5/FXB8Ugf1J6jaA0I
        08nED9RPqm51GyKw24VtGBiKDv+3E/VACeiFsAcy3nHtGkYl/VpNLPQl0QAltN0LGV/C459aIYF
        VNSU8WZgEyBq2HTOr570+/nv6ad1Fz4wBVW4Yax2uYt4ytygzqAvxMaV6x4s89kCABefJILzFYx
        BBONJAzXsDbTFoPmjmuWvhWuGAhoIQcafPsw1WnAQ6EfMOwvTmMzbF1gbxlQbzn5zPKmWNBmtwO
        oXDbvJwj+R7JkCQEPNCUypx6Ef5xF0ieHN50/kH7kcgu385s/Vit9m6mgNgspsoi2XrUn/JExkb
        qSDWgw9dY+ZoWiLIm7xAi7jPoeEQftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: ee1e1bc1-7ecf-4d10-ba87-eb2c7aedbd8e-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Looks ok to me but haven't tried it yet, I would be especially looking for e.g. mmc_request_done log, I would expect at least a mmc_command structure shown there there with
Opcode 13 and some resp[0,1,2,3] values. If you see that than I'd say that is good.

-----Original Message-----
From: Dominik 'Rathann' Mierzejewski <dominik@greysector.net> 
Sent: Dienstag, 4. April 2023 12:09
To: linux-mmc@vger.kernel.org
Subject: Re: mmc-utils: ioctl connection timed out with SD cards

On Monday, 03 April 2023 at 22:11, Christian Löhle wrote:
> >Hello,
> >is the mmc tool from mmc-utils supposed to work with SD cards?
> Not really no, but status get is pretty much the one thing that should 
> work, apart from register reads that don't issue anything.

I see. I thought any /dev/mmcblk? device would be supported. The documentation doesn't make this clear. :)

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
There should be a science of discontent. People need hard times and oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

