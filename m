Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B2C63777
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 06:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6BB20709
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 06:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgLCGoO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:44:14 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:56178 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgLCGoO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Dec 2020 01:44:14 -0500
Received: from [10.28.39.31] (10.28.39.31) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 3 Dec 2020
 14:43:05 +0800
Subject: Consultation on related issues of Linux kernel4.19
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <Jianxin.Pan@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Victor Wan <victor.wan@amlogic.com>
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
 <1ja79b4mje.fsf@starbuckisacylon.baylibre.com>
 <e80cb817-e58a-68ce-a3c6-d82636aaf7d3@amlogic.com>
 <1j8sou4u1g.fsf@starbuckisacylon.baylibre.com>
 <7ec2e682-cfec-395e-cf38-58f050440c40@amlogic.com>
 <1j7e4e4sab.fsf@starbuckisacylon.baylibre.com>
 <dee789ae-6825-3f4c-16e7-227e064562d6@amlogic.com>
 <1j5zjy4fif.fsf@starbuckisacylon.baylibre.com>
 <ec705819-9763-b0d2-9480-949e7ccd1cb9@amlogic.com>
 <1jeeydf27h.fsf@starbuckisacylon.baylibre.com>
From:   Nan Li <nan.li@amlogic.com>
Message-ID: <ea7ce09c-01a8-6a32-ab50-f288a859ab9a@amlogic.com>
Date:   Thu, 3 Dec 2020 14:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1jeeydf27h.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.31]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi，Jerome

     I recently migrated the 4.19 kernel and found that the RCA 
reconfiguration for emMC is available within the mmc_set_relative_addr() 
function within the mmc_ops.c file, but for SD card or SDIO 
configuration, the mmc_send_relative_addr() function within the sd_ops.c 
file is not set.If I want to reset the RCA value of an SD card or SDIO 
device area to satisfy my need to switch between multiple slave devices, 
this function cannot be implemented.I'm wondering if the 
mmc_send_relative_addr () function has no reconfiguration. What is the 
purpose of this design?If I need this function, is there any interface I 
can use?Or can I modify it?
     I am looking forward to your reply. Thank you.


