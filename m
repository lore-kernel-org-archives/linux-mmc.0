Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA01C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501BF206D3
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JydyafUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLQCwk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:52:40 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:46181 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbfLQCwk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551160; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=IWOe5PsNdgKGqLtW5omXyBv5zFlS7VV8mc290wNfifs=; b=JydyafUKVGOI7XfG8gpRgJTcR4yjFHYlDrJmTsCe2z8XenihnpoffHg5/Fbx5c87Him2MRwf
 PQStzyN2kPw+X6krwaX40qpU1PZ4KDw8+u3gJwriKaBFeUzXv520EvSTvkANGmIMDUJqYdjb
 Wdlb5yX8QwJ732k/OuqnNAvi2fg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842f7.7f65a87180d8-smtp-out-n02;
 Tue, 17 Dec 2019 02:52:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 206D3C433A2; Tue, 17 Dec 2019 02:52:39 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1CE0C43383;
        Tue, 17 Dec 2019 02:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1CE0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 3/9] mmc: host: Add device_prepare pm for mmc_host
Date:   Mon, 16 Dec 2019 18:50:36 -0800
Message-Id: <7dede0ae6c0574ea38cc71b166f3ca0b05856931.1576540907.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

mmc_host is a virtual device and it doesn't have any pm ops and so during
pm registration of device, no_pm_callback gets set as true. The
mmc_host device is not runtime enabled as it is a virtual device and
mmc_host is the parent device of mmc_card. As the mmc_host is runtime
disabled, mmc_card can runtime suspend/resume without depending on
state of mmc_host during normal operations. During system suspend, the
direct_complete flag of mmc_host device gets set as it has no pm_ops.
When mmc_card successfully suspends, it clears the direct_complete flag
of its parent (mmc_host).

But in certain cases during dpm_suspend, an async error can occur after
suspend work for mmc_card is scheduled and before it gets executed. In
that case, mmc_card suspend work will not clear the direct_complete flag
of mmc_host. When mmc_host suspend comes after that of mmc_card,
it too will skip all actions.

But by this time, the mmc_host device has been added to device_suspended
list. So during resume, mmc_host resume will do dpm resume of mmc_host.
In dpm_resume, all devices which has direct_complete flag set will be
runtime_enabled. This is because, in dpm_suspend, any device with
direct_complete flag will be runtime_disabled. Thus, mmc_host which has
direct_complete flag set, will get runtime enabled during dpm_resume.
This is a problem in pm framework with direct_complete flag
(runtime enabling a device in resume when it was not runtime disabled
in suspend path).

Now that mmc_host device is runtime enabled, to runtime resume the
mmc_card, the pm framework will try to runtime resume the mmc_host
device as well and will fail. This prevents mmc_card from runtime
resuming after a runtime_suspend.

Fix this by adding a dummy suspend_prepare() fn for mmc_host. This
prevents the direct_complete flag of mmc_host device from getting set.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/host.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 105b7a7..242657b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -40,9 +40,28 @@ static void mmc_host_classdev_release(struct device *dev)
 	kfree(host);
 }
 
+static int mmc_host_prepare(struct device *dev)
+{
+	/*
+	 * Since mmc_host is a virtual device, we don't have to do anything.
+	 * If we return a positive value, the pm framework will consider that
+	 * the runtime suspend and system suspend of this device is same and
+	 * will set direct_complete flag as true. We don't want this as the
+	 * mmc_host always has positive disable_depth and setting the flag
+	 * will not speed up the suspend process.
+	 * So return 0.
+	 */
+	return 0;
+}
+
+static const struct dev_pm_ops mmc_pm_ops = {
+	.prepare = mmc_host_prepare,
+};
+
 static struct class mmc_host_class = {
 	.name		= "mmc_host",
 	.dev_release	= mmc_host_classdev_release,
+	.pm		= &mmc_pm_ops,
 };
 
 int mmc_register_host_class(void)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
