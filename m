Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4637AC33CB3
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9E824688
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MjTccmss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgA1JHR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:07:17 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbgA1JHC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 04:07:02 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S93bVg014413;
        Tue, 28 Jan 2020 10:06:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=2rv368pE4g4zz6kp57DPDD0CXhY4gWUUealEUKO5UXo=;
 b=MjTccmsswg7XdUI+bIb23dLtsJ/i1ae3KT+vW+spslVJmeQADEbcVu0S9lO6LJEkbF/0
 IxTMr5kh5sihtLS+gTRP8SiQcJfwwO1wKb3bQh2MWLbPjtU8OtMl3uyFur6kqKanv+4i
 qOzImuTRnu7h43EyjsBvWzLx1+3EhBJ/XXf6ce3+UNQU4VjHdT/+3pRdFqHPx7/rLlUi
 1FOU074lKe3ShOGyGkGuP1ISdYEd1jbsRLWUiHHLmpNuCxKBr+GwKPzcCfnfyhK5gUpi
 szx3TeDZkfmOU4SJpFhEfj33aX718Kd2NvtBlBnHrE5mQqBglmbxntFXNduwDnE8YZXV BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpaw4t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:06:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95F3D10004B;
        Tue, 28 Jan 2020 10:06:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 84D7B212A38;
        Tue, 28 Jan 2020 10:06:43 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan 2020 10:06:43
 +0100
From:   Ludovic Barre <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 4/9] mmc: mmci: add private pointer for variant
Date:   Tue, 28 Jan 2020 10:06:31 +0100
Message-ID: <20200128090636.13689-5-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128090636.13689-1-ludovic.barre@st.com>
References: <20200128090636.13689-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In variant init function, some references may be allocated for
variant specific usage. Add a private void* to mmci_host struct
allows at variant functions to access on this references by
mmci_host structure.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 55acc0971a44..ddcdfb827996 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -410,6 +410,7 @@ struct mmci_host {
 	struct mmc_host_ops	*mmc_ops;
 	struct mmci_host_ops	*ops;
 	struct variant_data	*variant;
+	void			*variant_priv;
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*pins_opendrain;
 
-- 
2.17.1

