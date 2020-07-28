Return-Path: <SRS0=a44q=BH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49357C433E4
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jul 2020 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2935A20775
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jul 2020 14:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BI2EYqoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgG1OM3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:12:29 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19148 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgG1OM3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jul 2020 10:12:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2032200000>; Tue, 28 Jul 2020 07:11:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jul 2020 07:12:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Jul 2020 07:12:28 -0700
Received: from [10.26.73.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul
 2020 14:12:24 +0000
Subject: Re: [PATCH] mmc: tegra: Add Runtime PM callbacks
To:     Aniruddha Rao <anrao@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1595854036-15434-1-git-send-email-anrao@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b0c41edb-e9cc-2c36-be21-e52e80577c97@nvidia.com>
Date:   Tue, 28 Jul 2020 15:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595854036-15434-1-git-send-email-anrao@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595945504; bh=rs5ibOGKWRXVbpf5yHwMO8j6h6oLiVC4DnfaYH2lj3M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BI2EYqoeiBRC5T6zDk9D/ZZ1BSRrdXjUUv1ouhze/xHbpj6/G3zWAbs8BXpP7XxeK
         ya2do+R9pBTs3Z57uZijm79hKDEOqhj7lymHdwq5KCkHaldT6jYYQ/DO3DYZfU2NCv
         6j/8egzzCQRrrJwZlLG80tt5Qpx8dLfKGA4wCe86TZeEJA3SQyOfJ4y8bx/BUengsi
         ybtr24ceE8njZFcqBR1M1u1VKQydJIKR6O28R3Mfu8aK4UrpX6RboOOSqLR59Q1CN6
         TtHeYYoR6rgLRC/6TbQnTXOOWgkMH8W1N7WaeXtGY9EBO1BeE3VTcwUofxINuSHDcg
         Q5gj1qO+zAezw==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 27/07/2020 13:47, Aniruddha Rao wrote:
> Add runtime suspend/resume callbacks to save power
> when the bus is not in use.
> In runtime suspend
> - Turn off the SDMMC host CAR clock.
> - Turn off the trimmer/DLL circuit(BG) power supply(VREG).
> - Turn off the SDMMC host internal clocks.
> 
> Re-enable all the disabled clocks/regulators in runtime resume.
> 
> Signed-off-by: Aniruddha Rao <anrao@nvidia.com>


This patch is causing a boot regression on Tegra20 Ventana. Other boards
appear to be booting fine, but this is breaking something for Tegra20.
The bootlogs don't appear to show any particular crash, but I see a hang
when initialising the sdhci controllers.

Cheers
Jon

-- 
nvpublic
