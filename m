Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C8FC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Dec 2022 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiLLOJW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiLLOJB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2022 09:09:01 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0A6246
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 06:08:45 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 450BD3A29D5
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 15:08:44 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 37F703A29CF
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 15:08:44 +0100 (CET)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 15:08:44 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLAAADypIA==
Date:   Mon, 12 Dec 2022 14:08:43 +0000
Message-ID: <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
In-Reply-To: <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27320.000
X-TMASE-Result: 10--1.624900-10.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4pTQgFTHgkhZC/ExpXrHizxaCbh+r2jQs2dv
        IBM8UuLSiOOJL7UsrrssWi4sXciGhcCiHTNtFGyJqdwbW9Wx9tD/lIIryslypzpnHdhQ1BMbGSE
        KEg7q+Dx6KCIBFzd6H2aZdF3A++/3r78SC5iivxwTNCcUsR4xSdqvwrryJwXFk9d3W80cjoETEC
        0P9PvYRt0H8LFZNFG7bkV4e2xSge7z3orQRYuufIC+yV2Aa8yrLUNtqSgjdOAtryXokgebL8WFc
        yN1Agmm
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f4e39143-eca0-4f99-a745-25c13d2b39f1-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> For SD a CMD13 after CMD38 is required, too.
> I guess I can add that.

Just realized that sending CMD13 is not sufficient as the kernel will poll because of R1B and clear the error flag.
Anyway I have this kernel patch for a write flag bit that aggregates errors during polling until card is in TRAN again.
I will send it then, since I don't think there is a good way of solving this for SD in mmc-utils, please consider this patch on its own.

Regards,
Christian

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

