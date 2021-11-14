Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F3FC433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Nov 2021 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B498E60FE8
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Nov 2021 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhKNUqi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Nov 2021 15:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhKNUqh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Nov 2021 15:46:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F5C061746;
        Sun, 14 Nov 2021 12:43:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y196so12157735wmc.3;
        Sun, 14 Nov 2021 12:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrR3UPlCzUG7xn47afzQ6lXIB1wVcH1LZzlTZ62d7lU=;
        b=PNedUQ/X9lQEwEB/R5eL6v59Ce0d49E8cqW/5dTgVDmZATKuwQwHEK+IrXgF7caE+T
         ymfk/zSfAYKP1ZoEED/90bP2rRk5mUXnGREddTR8TLQ4ycKkAXE8YAzxiC9M0szGXES6
         utWKiXIxcLPy2JSexQkmuzIbIY6Ndds+w5YfbH2L0+dqlYGbGymrsbk1LV1ilLacM7Fj
         3XNBr1IU/FXWfesvLDAD4WXShK3CPmhnD7nDM1933KlA31JdKTz3SUCKBT1Os24g8JWb
         Y/Oo6g4eqvlGtNEycWQ5sMoAkCPUgqGexP53NJGSsXDCiUpIaYJWjCNMgr9jo7VZ8yr+
         xH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrR3UPlCzUG7xn47afzQ6lXIB1wVcH1LZzlTZ62d7lU=;
        b=3q3HYw18AoGkbHxssbuiryoLGeCnn4D3cTKoikPQ8kN7gHQBGuLlm6sRdLEM8Ygupv
         66PgwnRg3GwI+UGMI9y4AdMg21j9TNVyq8Peps6L8al2rjtJ/nGwPrcOwvTxsCo1tF6t
         9kithKgBHkVnFM/jOCRyVqCtTHVX/09+fHtsf6uYY/ZvNBZVEZ2HtNuaMgw/9qN/+70K
         RcWxifXNO/5p64w7zMPkYoSUFfpT/NqKvQGVumybC3LRsfVBgo4LyzBBWr/cw676Yax9
         wOJ8cCRYDW874lt15t2hmYWskadYnk8wV273vIhWD20+LMoxpjXQ/0HNpHxViJm07kQg
         FCtg==
X-Gm-Message-State: AOAM531i0YpCklds6rLe14E/p30C7aiFtTiJHMCptERfyGwdzucJ3pWy
        G0JXKj4j+9QU5weuPxnB3hU=
X-Google-Smtp-Source: ABdhPJwH7L0kGHd7O8e0FNLfFky4paf91nfNiJSEtPSUkWQ6SIaqgI7nR353PGk2zjl9N8MpfuANIw==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr56197441wms.12.1636922621776;
        Sun, 14 Nov 2021 12:43:41 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip (p200300e94719c9aa03f58ab728c81581.dip0.t-ipconnect.de. [2003:e9:4719:c9aa:3f5:8ab7:28c8:1581])
        by smtp.gmail.com with ESMTPSA id m14sm16673630wrp.28.2021.11.14.12.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 12:43:41 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 0/2] Two change for mmc-utils
Date:   Sun, 14 Nov 2021 21:43:29 +0100
Message-Id: <20211114204331.39555-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Hi Uffe,
   Two changes for mmc-utils, please have a take look at it.

Kind regards,
Bean

Bean Huo (2):
  mmc-utils: Use memcpy instead of strncpy
  mmc-utils: Add note for CMDQ_MODE_EN runtime value

 mmc_cmds.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1

