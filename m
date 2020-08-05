Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41802C433E1
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173C222B42
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T+RhXndV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHEUQU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:16:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33610 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgHEQS5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 12:18:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 075DGWpe104587;
        Wed, 5 Aug 2020 08:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596633392;
        bh=jv05QMyNRK6yayjZc1mP1MO1HJsGqxdVtsib46m4psw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T+RhXndV1BPGC6RiOs7bIZtzzRI4KezTc5sDYRlBrjptGzd2t5N7YZbKtslASCm69
         b/5xu9BxUpwVFMXXDLrGZthhOepTcxE1+BIVleZU4bl43OY6PtQJNTighBMU0OqK2P
         ZpdLH+gUqiy+MGAwAKqtJYQPm2GE/UllwhRVIMSk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 075DGWwE068176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Aug 2020 08:16:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 5 Aug
 2020 08:16:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 5 Aug 2020 08:16:32 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075DGTr0043569;
        Wed, 5 Aug 2020 08:16:30 -0500
Subject: Re: [PATCH] mmc: sdhci_am654: Add workaround for card detect debounce
 timer
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20200729234130.25056-1-faiz_abbas@ti.com>
 <2d692a90-0e58-ae69-9b5b-c9eb3ffe21ec@intel.com>
 <75b188ef-2755-b833-4756-79f0f171f8bd@ti.com>
 <c5b166c9-f9ba-e01e-b759-57ac93d99832@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <3f7e85c7-b0ba-e6a8-8d9f-091413614773@ti.com>
Date:   Wed, 5 Aug 2020 18:46:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5b166c9-f9ba-e01e-b759-57ac93d99832@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


