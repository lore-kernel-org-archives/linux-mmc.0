Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D7ECAAA3
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Aug 2022 21:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbiHYVfj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbiHYVfi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 17:35:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D59CC0B52
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 14:35:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id og21so4470483ejc.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=ayYJXfoaVqamX/0fPfe8WakX1FqMZovXKfWsEclLPw4=;
        b=fCyhqjQWnUSgXCng/Uyl3oZeG4HO2vdl5ri2Vb4UQA6XgraFpxMsOFIK8iAUXMSt+z
         ILAdWcD0y4dkItdcMRAWTIkdokMI8VjAbmV2MEFAMsvKC4ktSum52WiAj4WMBo6MOmqI
         rFf7nwvrrRnfLkuCdy2G/KWXPrMQmUxiQfmDkVyyFCvAyDAGgVDd1RXdNtFPiD6f4kDa
         zLHsAPRknak8oL7SYZXSsw0eNNnKhZ6UYQvMpRW+uZoO11TfPNiOVQ3PWwnkGMojQbXR
         4Q9MiFBNscD/HsAMyC/aeHG/It/XnUJ0Xy5sOpb5FfRyMTMG6mUxE70EMIFW2JGnXtvC
         IVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=ayYJXfoaVqamX/0fPfe8WakX1FqMZovXKfWsEclLPw4=;
        b=xllGpOKAzWIT2jVfVa3EO06GKd/ttjuu9hN0WisprDMWqS6a8/cfWH0/aqUNZ7LpAP
         MkTeTU8d04eO8BIf9OoNlI6BksMIqrGmys1aIFXCLiWqoOgt6W+eKcIMFEjJPmmbAdB/
         GDGRwOgQ9KxAreqPvSj57AyRY//fqFlut+ATqdTACopNbrz9u9Cwi2B8WZmHzZBu46fH
         NYKq72e2VI0W06iJbHjOMu+s5lmueXrFxPL6oortkXjG7q7cmqZTCh94yRvEyS2na2cy
         NS09uvFZ1oExb/MO9/SlLG2fyzKmHgXyceZz1mJlYi7NXZg5eE4So8D/5R2wtg51cvzL
         5suA==
X-Gm-Message-State: ACgBeo2QPY30LTRMWZNI5oZzVsBxowVA1wTV+AuatkXgf1lpgSIFp1+9
        PoSAnHy1un7+Z18rHE45VRENTw==
X-Google-Smtp-Source: AA6agR6UAR8iU1I7U5Rgd1PQDG/Z095iGYhSbVz5sTV9dkyzLv3MYY0z2ai6OTON1jzMRLstM6xLrg==
X-Received: by 2002:a17:907:97d5:b0:733:1ce:9572 with SMTP id js21-20020a17090797d500b0073301ce9572mr3786919ejc.220.1661463329888;
        Thu, 25 Aug 2022 14:35:29 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id g25-20020aa7c599000000b0044795d36f12sm289657edq.55.2022.08.25.14.35.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:35:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <20220825212842.7176-1-christian@kohlschutter.com>
Date:   Thu, 25 Aug 2022 23:35:27 +0200
Cc:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>, wens@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <395E54FA-15D2-48C7-A076-20E9B9398C22@kohlschutter.com>
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com>
To:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This needed some further rearrangement. Please validate v5 of the patch.

Any branch that has the v4 patch should revert that change and freshly =
re-apply the v5 patch.
I hope this simplifies merging into mainline.

Verified by
1. rebooting numerous times (no mmc errors, partitions on mmc SD card =
are properly detected, no hangs upon reboot, i.e., the change appears to =
work)
2. "cat /sys/kernel/debug/regulator/regulator_summary" now correctly =
shows regulators, regulator-dummy use count is 1
3. ensuring that no entries for "(null)-SUPPLY' were found in dmesg or =
/sys

Thanks,
Christian

