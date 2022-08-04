Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE515C19F2B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Aug 2022 10:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiHDKog (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Aug 2022 06:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiHDKoe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Aug 2022 06:44:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15022AC54
        for <linux-mmc@vger.kernel.org>; Thu,  4 Aug 2022 03:44:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so13380462edd.13
        for <linux-mmc@vger.kernel.org>; Thu, 04 Aug 2022 03:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N7EQU9MlWTC84hNYcDq54sTO0o6CB2OpePDIIDMkHEg=;
        b=e0iyDEWH8R0ix9gFWmNDk9YNInINTAfTGWPNXlGZ8OMK+TPX9jji6h0kvB6L+BpDdY
         RipD+0jXzrAyZ+OkRzyYzvJYfdDPS8GfQ4Xz36S+hcy0arEIC6qFnPyRvyAxjJbwbw9Y
         BkJhymEuvYgaXbydzpH67xbEm7Winn6br50iX4+zdoRvCpzc+HkMGOvgG1kLnvOxPMHi
         dJxj+q8sX5Pe7PyQtSycORO1LwgYX+4RhNhyU/2MQzjdkRt+ZvnC5SIQaHEf6ugxMOdp
         h9dM7HEcF5nu3pivSWyRw++MMLqeCxd+igKMaZ110OpZAoHmFrNoKwsIyT4QPYrhzSa7
         UMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N7EQU9MlWTC84hNYcDq54sTO0o6CB2OpePDIIDMkHEg=;
        b=N7PCESou+GpWDsD6EqYdg9JuEAf7L0R0LdvQ/mtRJMpMsjjU5R1vXUtxdnnthcrulh
         2CpQ83C0gvP4gshlC7PqDNlQpokcUwkbT0rnYhhBFTH0mABPeczQw4tyhzcn+sacrMax
         tllnB2YPABw5jKY8AWYJeZ6SsYcqQZo1QSkcZOte1/WdEz5TqIfwdfaadZu0kL7Ya6MF
         UU5+aeWpWOH7tzCtcbBCBZLlf1EveZG2FGQwkQnEpt9E47mpZXaKULTQNDW9F62EUrVk
         UBycT62JurChdaBRbSszIX5mdHfRBIQ4tUia76oua9arFSLCu8dwh+4SbnTcigkHYTpj
         8AyA==
X-Gm-Message-State: ACgBeo3jQ0IlndWNiS7sCyD8rSN27Lb8jWWNGXA8ViOVsspTnyoP/ir5
        +lMnpeOV9QhXyijqTsYKj3ueEg==
X-Google-Smtp-Source: AA6agR4I7dWQve6sjghtE3KmTh1uLv4ZCrvLNX0EISZW4vrScpvPY/nB4JDA11L9k5O50hG6G0+Mvg==
X-Received: by 2002:a05:6402:32a8:b0:43e:5490:295f with SMTP id f40-20020a05640232a800b0043e5490295fmr1365826eda.193.1659609871260;
        Thu, 04 Aug 2022 03:44:31 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b0072b2378027csm220357ejt.26.2022.08.04.03.44.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 03:44:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: [PATCH v3] regulator: core: Resolve supply name earlier to prevent
 double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CAEwRq=qe+Frwpe=Zr4n_8A6vjOJnV3noegdnHSN7NTazkKejBA@mail.gmail.com>
Date:   Thu, 4 Aug 2022 12:44:29 +0200
Cc:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Robin Murphy <robin.murphy@arm.com>, wens@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EC5FFA28-21D3-4FBB-B188-7DB1C9E1AA9E@kohlschutter.com>
References: <CAEwRq=qe+Frwpe=Zr4n_8A6vjOJnV3noegdnHSN7NTazkKejBA@mail.gmail.com>
To:     Vincent Legoll <vincent.legoll@gmail.com>,
        Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Previously, an unresolved regulator supply reference upon calling
regulator_register on an always-on or boot-on regulator caused
set_machine_constraints to be called twice.

This in turn may initialize the regulator twice, leading to voltage
glitches that are timing-dependent. A simple, unrelated configuration
change may be enough to hide this problem, only to be surfaced by
chance.

One such example is the SD-Card voltage regulator in a NanoPI R4S that
would not initialize reliably unless the registration flow was just
complex enough to allow the regulator to properly reset between calls.

Fix this by re-arranging regulator_register, trying resolve the
regulator's supply early enough that set_machine_constraints does not
need to be called twice.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 51 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 398c8d6afd4..5c2b97ea633 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5492,7 +5492,38 @@ regulator_register(const struct regulator_desc =
*regulator_desc,
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
 	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
=20
-	/* preform any regulator specific init */
+	/* set regulator constraints */
+	if (init_data)
+		rdev->constraints =3D kmemdup(&init_data->constraints,
+					    sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+	else
+		rdev->constraints =3D =
kzalloc(sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+	if (!rdev->constraints) {
+		ret =3D -ENOMEM;
+		goto clean;
+	}
+
+	if (init_data && init_data->supply_regulator)
+		rdev->supply_name =3D init_data->supply_regulator;
+	else if (regulator_desc->supply_name)
+		rdev->supply_name =3D regulator_desc->supply_name;
+
+	if ((rdev->supply_name && !rdev->supply) && rdev->constraints
+		&& (rdev->constraints->always_on || =
rdev->constraints->boot_on)) {
+		/* Try to resolve the name of the supplying regulator =
here first
+		 * so we prevent double-initializing the regulator, =
which may
+		 * cause timing-specific voltage brownouts/glitches that =
are
+		 * hard to debug.
+		 */
+		ret =3D regulator_resolve_supply(rdev);
+		if (ret)
+			rdev_dbg(rdev, "unable to resolve supply early: =
%pe\n",
+					 ERR_PTR(ret));
+	}
+
+	/* perform any regulator specific init */
 	if (init_data && init_data->regulator_init) {
 		ret =3D init_data->regulator_init(rdev->reg_data);
 		if (ret < 0)
@@ -5518,24 +5549,6 @@ regulator_register(const struct regulator_desc =
*regulator_desc,
 		    (unsigned long) atomic_inc_return(&regulator_no));
 	dev_set_drvdata(&rdev->dev, rdev);
=20
-	/* set regulator constraints */
-	if (init_data)
-		rdev->constraints =3D kmemdup(&init_data->constraints,
-					    sizeof(*rdev->constraints),
-					    GFP_KERNEL);
-	else
-		rdev->constraints =3D =
kzalloc(sizeof(*rdev->constraints),
-					    GFP_KERNEL);
-	if (!rdev->constraints) {
-		ret =3D -ENOMEM;
-		goto wash;
-	}
-
-	if (init_data && init_data->supply_regulator)
-		rdev->supply_name =3D init_data->supply_regulator;
-	else if (regulator_desc->supply_name)
-		rdev->supply_name =3D regulator_desc->supply_name;
-
 	ret =3D set_machine_constraints(rdev);
 	if (ret =3D=3D -EPROBE_DEFER) {
 		/* Regulator might be in bypass mode and so needs its =
supply
--=20
2.36.2



