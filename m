Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C578C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiK1NdU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiK1NdT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 08:33:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA92F42
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 05:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669642399; x=1701178399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=09BOGxgeXlKWNNJvljw399n1+XkbLs2It1OpzBbpCDc=;
  b=ZCWMYlY99pCj7fLMoegM/Gt4m4Df7jBvLwQaqnyZivGruTk5S1O2hzVY
   ngAZiugNKZeEj3ZGs+T4ffujeVDd34jly4S1oty6K2E1EQkAYFHBB8Cgm
   axsuFn4a+fzmDibAo88KteB5myfAZpGKYcQH1qNkQsLnVthgcoXUkmapC
   m/GLnNQ5kR4DTs9SJgk/iqb6J5csQea5M2GFlt0+rbfA0AAopVmKBxU/+
   Aditkvolk6iuC/QJoCglwuwn6xYhLqR6swxmhxmTGbAlRYYK+vy6Bl673
   MUS6fBU3r3DrFGjiapzbznZQObO4ZBkxalMChSkn0slS1je+uB3LD50z+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="401121707"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401121707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676044460"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="676044460"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:12 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH V2 0/4] mmc: sdhci: Fix voltage switch delay
Date:   Mon, 28 Nov 2022 15:32:55 +0200
Message-Id: <20221128133259.38305-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

Here is a fix for the voltage switch delay issue raised here:

  https://lore.kernel.org/linux-mmc/20221117094859.20582-1-quic_sartgarg@quicinc.com/

Plus some subsequent tidy-ups.


Changes in V2:

    mmc: sdhci: Fix voltage switch delay
        Tidy messy if-condition a bit


Adrian Hunter (4):
      mmc: sdhci: Fix voltage switch delay
      mmc: sdhci: Avoid unnecessary re-configuration
      mmc: sdhci: Avoid unnecessary ->set_clock()
      mmc: sdhci: Enable card clock instead of ->set_clock()

 drivers/mmc/host/sdhci.c | 101 ++++++++++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |   2 +
 2 files changed, 71 insertions(+), 32 deletions(-)


Regards
Adrian
