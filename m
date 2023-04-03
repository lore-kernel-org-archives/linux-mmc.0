Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28282C761AF
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Apr 2023 20:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDCULz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjDCULy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 16:11:54 -0400
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1DFE5D
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 13:11:51 -0700 (PDT)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 598D422293C
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 22:11:45 +0200 (CEST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 4517A22292D
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 22:11:45 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail6.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 22:11:45 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Dominik 'Rathann' Mierzejewski <dominik@greysector.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: mmc-utils: ioctl connection timed out with SD cards
Thread-Topic: mmc-utils: ioctl connection timed out with SD cards
Thread-Index: AQHZZlWz7zj1vli6ykWT5I70wuFTRa8aAk7w
Date:   Mon, 3 Apr 2023 20:11:43 +0000
Message-ID: <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
References: <ZCsSHxDv+158emk5@sakura.greysector.net>
In-Reply-To: <ZCsSHxDv+158emk5@sakura.greysector.net>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27544.002
X-TMASE-Result: 10--15.524400-10.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4qwNPl5dbX19C/ExpXrHizz2QIAF58kgvMVj
        EEE40kDNewNtMWg+aOYIO4Hm6Rbign1PaVvCiNKv4MlM9EFnmr+Uq+GQ/zyJdLgbJOZ434BsGck
        C9b/sBkOaThZNi5MBhEeDPyqIAshAPOqr6B64RICU6d4lyugDFCkDYTG6KmZanhD4vcFcha6TMD
        ir0Fhb8ol1YaOpGaiC0Spjpa7rs86ucAjj7wkhNp4CIKY/Hg3Ai26KQAtSmcZ4UhBPLRlvhqu6x
        VHLhqfxIAcCikR3vq/6Xtm9NlelS/P+LZ1eKjw+uIaL/vxL0A/CG96WQ0kWtdvgSmcJB29n
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: d1f94c1d-8d3d-4db5-b35c-a36ec7eb5162-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>Hello,
>is the mmc tool from mmc-utils supposed to work with SD cards?
Not really no, but status get is pretty much the one thing that should work, apart from register reads that don't issue anything.
I'm using RK3399 on SD too and it works okay for me, will try updating tomorrow.
Could you show the debug prints to see the mmc command / responses?
Ideally for anything in mmc/core

>I tried mmc status get /dev/mmcblkN with three different SD cards on two different machines (Pinebook Pro and a Sony laptop) and I get the same error on both:
># mmc status get /dev/mmcblk0
>ioctl: Connection timed out
>Could not read response to SEND_STATUS from /dev/mmcblk0
>
>dmesg on the Sony machine shows:
>[ 1291.196547] mmc0: new SD card at address aaaa [ 1291.196834] mmcblk0: mmc0:aaaa SD01G 969 MiB [ 1291.200263]  mmcblk0: p1 p2 p3 [ 1306.273160] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: __mmc_blk_ioctl_cmd: cmd error -110 [ 1306.276978]  mmcblk0: p1 p2 p3
>
>I'm able to get status of the internal eMMC device on Pinebook Pro with no errors. extcsd read works fine, too.
>
>I'm running Fedora 38 with kernel 6.2.9 on both machines if that helps.
>
>Regards,
>Dominik
>-- 
>Fedora   https://getfedora.org  |  RPM Fusion  http://rpmfusion.org
>There should be a science of discontent. People need hard times and oppression to develop psychic muscles.
>        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
>
>

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

