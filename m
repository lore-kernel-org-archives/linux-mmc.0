Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2D8C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A634720678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhB60q8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbgDNQPj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390423AbgDNQOe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104EC061A0E
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 131so168709lfh.11
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QnWaA+YV/c9Li2yPT2LBVJasT99G3qkQ/TJy+CeVPw=;
        b=mhB60q8XHmKslX9V/PSmnWFU41gKBr1Uwkl54rU2Nh8oLbk4Me9Zansiaoh4oKKls4
         oYDbWj3VZ5492bw6NgtSYyse7daOzDzfKmSjJ0Ykrikxz2YKTpS1UJQHf3ao92/AOack
         b1ol2JOc6xG2+TQvluwsX4793IpLo4k39L7AKgFDSqyBf3zZUPJKh7jF+QyBa0NCe46U
         Lr5wsf/fFkwvIR4xZAwWjZ0Jyn6w9iLJthjpPsTzRaXsE8o7AEjAKiXLLFRx9+pum3zE
         UspWncBdmJgBTpZHgexGOBdWKaNOGg7jyO01SXDGw6u57XILEDP1jorSiosRdABHr+HS
         J/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QnWaA+YV/c9Li2yPT2LBVJasT99G3qkQ/TJy+CeVPw=;
        b=DR3bCxZYHnPsBgcsazUCZjwdHQDNfBCmuHG8ekBZRZLy2mKbqWILLzOM9qJVi9HxR0
         xl38VDwqLlcVR+Ly3pBeUNVCdZivkKnjR3tZjg3MaPO4uzlvGXfd9mEBbQo+KnDBscZ2
         d1CfcHkNEikayqziCycqlTWBbQ1DcgBPaLFIR9eKy5opUHr4ofNuUKlxMkoUexMzFTua
         d/F4MNGKqQ4JBnerHnqpxcEp5sg7JVRNHDoHuXtVFVo1WEHnOT/fw/NsZgd/IEDZVscX
         X16uUPNzY5LQbgv/n0zd9kb5/BSD4faLRak12+WRDzwv3QuGM4LcBn5kLhL2x7fhqhrM
         hrMQ==
X-Gm-Message-State: AGi0PuYgrDTJ8FKvRwU8vOtjKaLfVZHfswE7SVDUvZju5lfA5BePES/m
        JLbZfh9d3VnvxieMOWr/GM9f+2TUhNg=
X-Google-Smtp-Source: APiQypIPuqtPsAl6LcmL52VbxsBmm8/BLz+8CoOBvDh6Wmj9fQVDtl72gpelIUiST9FPwmaJBPaJ0Q==
X-Received: by 2002:a19:c64b:: with SMTP id w72mr357854lff.82.1586880871411;
        Tue, 14 Apr 2020 09:14:31 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 08/19] mmc: sdricoh_cs: Drop unused defines
Date:   Tue, 14 Apr 2020 18:14:02 +0200
Message-Id: <20200414161413.3036-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdricoh_cs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index a38b8b2a4e5c..1fc4db713ef5 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -57,10 +57,8 @@ static unsigned int switchlocked;
 #define STATUS_BUSY              0x40000000
 
 /* timeouts */
-#define INIT_TIMEOUT      100
 #define CMD_TIMEOUT       100000
 #define TRANSFER_TIMEOUT  100000
-#define BUSY_TIMEOUT      32767
 
 /* list of supported pcmcia devices */
 static const struct pcmcia_device_id pcmcia_ids[] = {
-- 
2.20.1

