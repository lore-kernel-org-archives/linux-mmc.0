Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CB2C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Oct 2022 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJLTDv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJLTDj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2022 15:03:39 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906D2CC97
        for <linux-mmc@vger.kernel.org>; Wed, 12 Oct 2022 12:03:38 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7620A46377A;
        Wed, 12 Oct 2022 21:03:36 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6383B4636BA;
        Wed, 12 Oct 2022 21:03:36 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Wed, 12 Oct 2022 21:03:36 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 12 Oct
 2022 21:03:35 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 12 Oct 2022 21:03:35 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCHv2 0/2] Introduce custom sanitize timeout
Thread-Topic: [PATCHv2 0/2] Introduce custom sanitize timeout
Thread-Index: AdjebPBvxn8zfevZRzeWVLD6WuLesg==
Date:   Wed, 12 Oct 2022 19:03:35 +0000
Message-ID: <2633a557a76c48e1b5785eba5a29e207@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.2]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27198.002
X-TMASE-Result: 10-1.016700-10.000000
X-TMASE-MatchedRID: 9886Ub8IUalINlHl+WuFyrPx3rO+jk2QTSz0JdEAJbQHNq0HeN2LVOS9
        slBM8vbuAxKfrdkYxYYU/FrOclzESho/F4wweNBuuce7gFxhKa19LQinZ4QefIFD/hZ+jeimnYH
        vJGPl9zkd+FalTlP/BGrz/G/ZSbVq+gtHj7OwNO0PXZPurZ0hS0LJSy9W3b468fzBJgutpzVs8+
        Rbjz5V4xAI+LoLjJdS
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 0ee9e13a-5310-4882-a3f1-76addddb8ea5-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sanitize operation has been shown to take longer on some cards.
Refactor switch calls to include a timeout and let the user input
a timeout.

v2: Make refactor patch usable on its own

Christian Loehle (2):
  mmc-utils: Refactor switch to allow custom timeout
  mmc-utils: Allow for custom sanitize timeout

 mmc.c      |  2 +-
 mmc_cmds.c | 90 +++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 60 insertions(+), 32 deletions(-)

-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

