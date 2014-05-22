From: Peter Griffin <peter.griffin@linaro.org>
Subject: Add SDHCI support for STMicroelectronics SoCs
Date: Thu, 22 May 2014 16:18:14 +0100
Message-ID: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:57844 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbaEVPSc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:18:32 -0400
Received: by mail-wi0-f177.google.com with SMTP id f8so4507398wiw.4
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 08:18:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, kernel@stlinux.com, lee.jones@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

This series adds a SDHCI platform driver for ST SoCs, along with
the additional device tree bindings and configuration to enable
the controller to work properly.

Initially it supports the stih416 and stih415 SoCs, and has
been tested on a stih416-b2020 board.

regards,

Peter.

