Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C2C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 09:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJMJKe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJMJKd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 05:10:33 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D211E45D
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 02:10:31 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id BAB301234DB;
        Thu, 13 Oct 2022 11:10:29 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A555812337F;
        Thu, 13 Oct 2022 11:10:29 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Thu, 13 Oct 2022 11:10:29 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 13 Oct
 2022 11:10:29 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Thu, 13 Oct 2022 11:10:29 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCHv3 0/2] Introduce custom sanitize timeout
Thread-Topic: [PATCHv3 0/2] Introduce custom sanitize timeout
Thread-Index: Adje40rbcPA8pDj9S+KTLhmyQ4oAgQ==
Date:   Thu, 13 Oct 2022 09:10:28 +0000
Message-ID: <980bb045bad7406eabef5598022a732c@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.66]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27198.006
X-TMASE-Result: 10--4.014300-10.000000
X-TMASE-MatchedRID: 9886Ub8IUalINlHl+WuFyrPx3rO+jk2QTSz0JdEAJbQHNq0HeN2LVOS9
        slBM8vbuSJzAi9GgKOa2hc0LErYsCwlEwlpQS2lgjoyKzEmtrEcQhNjZQYyI3Jsoi2XrUn/JExk
        bqSDWgw/9RzpTdIDZ1dAtbEEX0MxBxEHRux+uk8h+ICquNi0WJLwH9L7KNMmic+vu6cyfgf/pxn
        ynSssSAG79TuywZxVPftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: a4fe4bfd-2c02-4d59-a98d-c55637b6ba5b-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sanitize operation has been shown to take longer on some cards.
Refactor switch calls to include a timeout and let the user input
a timeout.

v3: Let kernel handle default switch timeout
v2: Make refactor commit usable on it's own

Christian Loehle (2):
  mmc-utils: Refactor switch to allow custom timeout
  mmc-utils: Allow for custom sanitize timeout

 mmc.c      |  2 +-
 mmc_cmds.c | 68 +++++++++++++++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 32 deletions(-)

-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

