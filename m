Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF3BC54FCF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8E920857
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 06:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fUkN6fe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDTGU6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:20:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52847 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgDTGU6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 02:20:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587363657; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TVKNHQnb5r6KRYTza9DhApjLU9yzE6QtVadiD8mE444=; b=fUkN6fe2zTAtUlnMlTaVEgBbk6MMhMJ2/xkT6ZN0VWzYkLUsXS9S0RRG+VIvJsx0nNxOWx9X
 5PgGArl8J4dnzuEW7e+44yypgMKt+XmjnWbPQBAidEYwymm14U9qPFe3/xoPkHGuenE6PSOY
 aX9vHQkbSXunUsdz87xOpCoYOdM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9d3f39.7fea453a9148-smtp-out-n03;
 Mon, 20 Apr 2020 06:20:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5E07C433BA; Mon, 20 Apr 2020 06:20:40 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95814C433D2;
        Mon, 20 Apr 2020 06:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95814C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 0/3] Minor fixes to sdhci-msm 
Date:   Mon, 20 Apr 2020 11:50:22 +0530
Message-Id: <1587363626-20413-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable a couple of CAPS that qcom sd host controller supports.
Set a quirk for enabling support for auto cmd12.
And enable adma length mismatch error interrupt.

--
V1: https://lore.kernel.org/linux-arm-msm/1586706808-27337-1-git-send-email-vbadigan@codeaurora.org
Changes since V1:
	Squashed two caps related patches and appiled stable tag.
	
Veerabhadrarao Badiganti (3):
  mmc: sdhci-msm: Enable host capabilities pertains to R1b response
  mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
  mmc: sdhci-msm: Enable ADMA length mismatch error interrupt

 drivers/mmc/host/sdhci-msm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
