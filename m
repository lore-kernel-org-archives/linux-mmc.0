Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4100DC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jun 2022 09:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiF0JQM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jun 2022 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiF0JQL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2022 05:16:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC2614E
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 02:16:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pk21so17813231ejb.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kJ1jAwa/+7BjPtt5g76BTIKEOFlfeh80CJPRRsz6gBY=;
        b=QVRkpvoeUqPXDpIa2rU1njf8g+wNu1owM3abURlIHRb1HaswOUzKXD0aZAYaYQQxNx
         jdzAWkC0xvcwT7Dc0NzDZeRrJx4y/5x2QvSBhDnej/DZFMRa05sst3bYwNHkFApDIt9H
         IxX3MLfjwgZxn6ej8j644dMoVHx24Q+U1NNz5Vzgsh1CLWoBoHZriZKbQVvMjH/GtYHv
         xOvU9Yu+CJ2KOOHmhXu3nbdrc1nG0AOa541v5g8aak1o1KbH7CagOoWMGvDu6W/zhhy2
         mel7Nu+NJl8MD/GjAncYHbAIJf4uqHyLuj5U84jj9hERQ8SQunLqfSZa2pukWtGvqw52
         Igeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJ1jAwa/+7BjPtt5g76BTIKEOFlfeh80CJPRRsz6gBY=;
        b=wLW3BDTDcv94oAS3LQJg8o9bVJPbsJcoewegLXiSMRY120/OAEPBrdjw7OC8Dw2X5L
         ALu/NJAeGuD1hf5P1kC8S6BeQZ0YLdXFa4WXrlLqfA8OqIFAsR1PP9YmoCjIOvxm6thT
         IAtg45XwnvvN7oz4HmuiFLaE+jz7yhyeNf+HjgMvqb8n7jQ7NJ8P+bxUPZGloK6A7yf4
         tVIVGtXX/S5BEu2lPlMXub9Cb/sm0Z/nLR3VV6rRK+9VK+AyJHD3vg0rpQDdMSTuM1dd
         fz6bsUl1dMtHN/s0kW/+fcGlbd2Cbf4a7gbZFjuM2KsH0ikVL7Dx89ybUNna1XSWxxw0
         EfpQ==
X-Gm-Message-State: AJIora9bAscF+qglnz/B80psPGhqrd56ciYR6bqKitePGiuwGyegPSfz
        O+nB3WfA5ok+7U+uugLfgkUFFA==
X-Google-Smtp-Source: AGRyM1sFJYD09SrNHrTBsRr5F+dNB4PCjRgumEjuEC8DVluJhWZ7budht3O44iDxJgZyA1gHbR9xqw==
X-Received: by 2002:a17:906:752:b0:726:a6c2:b242 with SMTP id z18-20020a170906075200b00726a6c2b242mr3854178ejb.33.1656321367816;
        Mon, 27 Jun 2022 02:16:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        jh80.chung@samsung.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Subject: Re: (subset) [PATCH 2/5] ARM: dts: s3c24xx: align SDHCI node name with dtschema
Date:   Mon, 27 Jun 2022 11:15:43 +0200
Message-Id: <165632135506.81841.714380645007134856.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220626120342.38851-3-krzysztof.kozlowski@linaro.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org> <20220626120342.38851-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 26 Jun 2022 14:03:39 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects "mmc".
> 
> 

Applied, thanks!

[2/5] ARM: dts: s3c24xx: align SDHCI node name with dtschema
      https://git.kernel.org/krzk/linux/c/1923e58045471c7226eeab34762e2f821c2c31b7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
