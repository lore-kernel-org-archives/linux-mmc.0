Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F8EC43334
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jul 2022 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiGVRme (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jul 2022 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiGVRmd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2022 13:42:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1E8F530
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jul 2022 10:42:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w12so6652129edd.13
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jul 2022 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N7EQU9MlWTC84hNYcDq54sTO0o6CB2OpePDIIDMkHEg=;
        b=RAgnXjbIvsoZwcpLh1CBW7DY1j7VdtKawfUE7mkVKf8TvOF6WczItap8eV38eHJwve
         /rR/mvvGPU+AmyXghjrJZOhHbdNnJvGEzChy2/xUc9kj0D00uvn90rTH2EDe3+ZVNQHs
         Lp+a2/I7Nv3SkNCfzoDi5MjZ1P5aXJQwMUUEqkhZhpocdLvUqLriTDpK6CkE4/GJ+KBP
         +zFd326waGpgEr6Ls+zrKh0ssSYcLD54Ihv4CCpdX8InVL8A5Su7/ov9k5TyD2sED2DF
         Ndj8CELTQI/WrNCkQR0fqvcFUjOBysSNpsAgo3Jx/jWT3YAiOXGzX6EjuhDbWuAHJpFr
         j3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N7EQU9MlWTC84hNYcDq54sTO0o6CB2OpePDIIDMkHEg=;
        b=nPUfsk5tW6zA+JHniPnHX7iCarNudtHGbt4BWCO2IWP8VDYBro2COQc44dBFu1DCGJ
         5teMDgif+eLztdwh9fKhRrlAnwFpOUwJPVtkIrpqO14R4XId3XrXmx+gUzyBDonyUeTt
         Gwv6p/6l2lLNd4W3by5yLvngR1GYZQwNjNx3S7qMbI8czbvv670d+K/b7KbmL4IwEk+T
         FQ1Kyt+dzsPO8Gl78pCf2byjwdbkMNF8O7MD7IPC5g6LWSanzUCyuoCCUHEZi6D5yn1N
         udlGS69pT1+y+XnbcbTapADfNERyx6rr+z18LZZh9QxeTLs/b1BD7H5eoDggBiodVQqO
         uOYg==
X-Gm-Message-State: AJIora+vPnFzaTpUoB07YJf1yrx2UGd17tSwXJtUcXtQZ+Hl/frbN59A
        xzdh87eleUpIBxaWYpP2+Onk1w==
X-Google-Smtp-Source: AGRyM1sBIoB4ad1rdzYX4b4fs9ym/ManTz8+yH9dZ/S0izmo3QreB58en0TuKY9jROlaw5a3t3tvPQ==
X-Received: by 2002:a05:6402:495:b0:43a:a211:4c86 with SMTP id k21-20020a056402049500b0043aa2114c86mr996718edv.294.1658511749469;
        Fri, 22 Jul 2022 10:42:29 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id p9-20020a056402074900b00431962fe5d4sm2861755edy.77.2022.07.22.10.42.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:42:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH v2] regulator: core: Resolve supply name earlier to prevent
 double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <YtlqPbbBceBmekcV@sirena.org.uk>
Date:   Fri, 22 Jul 2022 19:42:27 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0925148-3F0E-4DD6-9872-96778BFE39DE@kohlschutter.com>
References: <3B4AE882-0C28-41E3-9466-F8E301567627@kohlschutter.com>
 <YtlqPbbBceBmekcV@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
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


