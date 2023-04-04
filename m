Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC0C6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 17:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjDDRSv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjDDRSr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 13:18:47 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469D4216
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 10:18:23 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 8D76F3A2A2A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 19:18:20 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 717203A0808
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 19:18:20 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 19:18:20 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Dominik 'Rathann' Mierzejewski <dominik@greysector.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: mmc-utils: ioctl connection timed out with SD cards
Thread-Topic: mmc-utils: ioctl connection timed out with SD cards
Thread-Index: AQHZZlWz7zj1vli6ykWT5I70wuFTRa8aAk7wgADKbgCAAJlYEA==
Date:   Tue, 4 Apr 2023 17:18:19 +0000
Message-ID: <19a192bf476c48468429391963679737@hyperstone.com>
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
X-TMASE-Version: DDEI-5.1-9.0.1002-27546.001
X-TMASE-Result: 10--12.357600-10.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4qwNPl5dbX19NNNNLDf7bemCfqmp4B6gPRon
        Dr088qtFfE3qFp1T4KYAjhCLb7ooAM5YYT+DO/SI8eSmTJSmEv3GrCYQ4FUp6i99T+uJIleRORB
        WX+Ofof8SkTIlq5S+sTbVTiFkkh3DApCOjGpq/X+iVU7u7I4INcCY5/Mqi1OiL85Vy+GZ4Fgj+K
        RTBejfq0Q9LOf8yuZh2tsLaxD9OMET1oHLc6clU95x7RpGJf1aYrfZupoDYLKbKItl61J/yRMZG
        6kg1oMPXWPmaFoiyJsgBwKKRHe+r0cFNGIbhJk0nPxOXxhfGnz5Cm1261V+ZlONjpGa4IU77KM9
        Iuks6cI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 86dbf450-560d-4fb8-b0ab-9a37acebb7bb-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Nevermind, I can reproduce the issue on my own Pinebook Pro,
Ill take a look at it tomorrow.

-----Original Message-----
From: Dominik 'Rathann' Mierzejewski <dominik@greysector.net> 
Sent: Tuesday, April 4, 2023 12:09 PM
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

