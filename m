From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] regulator: add missing prototype for regulator_is_supported_voltage
Date: Wed, 21 Nov 2012 17:22:02 +0800
Message-ID: <CAMPhdO8uuNmdiaejcypOH77rsU2ZR+dov73KXyAsbAfW0tKmcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53873 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2KUJWY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 04:22:24 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so2525861lbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 21 Nov 2012 01:22:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Philip Rakity <prakity@gmail.com>, Philip Rakity <prakity@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Mark,

Looks to be a simple omission there. Patch is from Philip Rakity, I
just did review and by-passing here.

>From d015139ac621e10d5d9c0d3e427e9517b08fe772 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@nvidia.com>
Date: Tue, 20 Nov 2012 18:07:41 +0100
Subject: [PATCH] regulator: add missing prototype for
regulator_is_supported_voltage

avoids needs for CONFIG_REGULATOR in sdhci.c

Signed-off-by: Philip Rakity <prakity@nvidia.com>
Reviewed-by: Eric Miao <eric.y.miao@gmail.com>
---
 include/linux/regulator/consumer.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/regulator/consumer.h
b/include/linux/regulator/consumer.h
index c43cd35..4e3ec91 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -358,6 +358,10 @@ static inline void regulator_set_drvdata(struct
regulator *regulator,
 {
 }

+static inline int regulator_count_voltages(struct regulator *regulator)
+{
+ return 0;
+}
 #endif

 static inline int regulator_set_voltage_tol(struct regulator *regulator,
--
1.7.0.4
