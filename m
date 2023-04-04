Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E7C6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 06:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDDGP5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 02:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjDDGP4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 02:15:56 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC212706
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 23:15:25 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 35F0C3A2A27
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 08:14:59 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 1B65C3A2A26
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 08:14:59 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 08:14:59 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Dominik 'Rathann' Mierzejewski" <dominik@greysector.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: mmc-utils: ioctl connection timed out with SD cards
Thread-Topic: mmc-utils: ioctl connection timed out with SD cards
Thread-Index: AQHZZlWz7zj1vli6ykWT5I70wuFTRa8aAk7wgAAE+8A=
Date:   Tue, 4 Apr 2023 06:14:58 +0000
Message-ID: <48e2f9c1a3664fa59977a56579edde97@hyperstone.com>
References: <ZCsSHxDv+158emk5@sakura.greysector.net>
 <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
In-Reply-To: <597389cd8b21409aa7015d08aa4a804d@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27544.005
X-TMASE-Result: 10--3.489000-10.000000
X-TMASE-MatchedRID: zdfKSpJbRLjUL3YCMmnG4qwNPl5dbX19C/ExpXrHizz2QIAF58kgvDlw
        dnKldJgiQGHSxV69+z4hYpbM1LnTqDP8If+x5Qsr8Jb881FGn9k6rt3TPmIRUbs3Yh2IOCYzINk
        limv2Cx7i8zVgXoAltiUyiw9VWZhy7tpwfSrcmEDZs3HUcS/scCq2rl3dzGQ1tyaKchQkyE46Na
        KGEaHlJr1mHvs6RJpwamnjuWS96CZn/GdXQ5MCshiOZqrgsX/DfeCp/3SmasQjNUAd/OwM0Klgf
        jTYumxmzp/LQfDQ6KCzlYRKiVQWjj6MB1z6PV0adDfg+UkG0p78YVDpCo5I8Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: NULL-NULL-7-0-1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> Hello,
> is the mmc tool from mmc-utils supposed to work with SD cards?
> I tried mmc status get /dev/mmcblkN with three different SD cards on two different machines (Pinebook Pro and a Sony laptop) and I get the same error on both:
> # mmc status get /dev/mmcblk0
> ioctl: Connection timed out
> Could not read response to SEND_STATUS from /dev/mmcblk0

Could you try something like
sudo dd if=/dev/mmcblk0 of=/dev/null count=1 iflag=direct; sudo mmc status get /dev/mmcblk0
just to rule out anything in the autosuspend direction?

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

