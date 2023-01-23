Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD306C54EAA
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Jan 2023 19:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjAWTl2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Jan 2023 14:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjAWTlZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2023 14:41:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BC30EB4
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 11:41:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q5so7205548wrv.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/RsMe/pvsRxXGnKgG44ap9RIqwrmY5BGtfT8sB3Eh4=;
        b=OMnyhIAFcuf8nT4iXKlhGZ1df39+dR+qfI3xswY1zqPdP6REFLZ1jGmagTJf0E/qZg
         fSW8p77CNMLw+pmKKkZy2rMGx8V6D5sDerkC7rLtD6BL+JogehS+v3JKKYoyI3rwglN5
         2PpB28eDnu5Esw+nb/k+NfdGU6f0H5WhAn+f2eaVsl5C4qGAxLnL5LfSwVOLT8QSXgeY
         v44j/NvtBsgcIIWOcZ7luzLDwmgckOU01IckCg6HSLZgpli3Dtg1CV9XJDSQLmeHR7gO
         fwN0z4WMjlYZ7L75MkD6TbA8Kqvuv3LgKMrDwTKQpJHLy48xMDMk0oau5V9Ic0FeBvNK
         pCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/RsMe/pvsRxXGnKgG44ap9RIqwrmY5BGtfT8sB3Eh4=;
        b=3BG/wGaLDtEdg7mQajc6rDie14VzifJ+5BFZEsoL92EprkMgfyyXBamEs5hmdvbg7l
         voOvH/iZ9FdsDduZocFMtg36qZbhh23rNnCdaguafb2nlUmUT721TRJ4GXn8vludnI1Y
         jx6U1qJANYo/YXTXRQghf7C/peFk7zsJfBhIgtDgw5Yj8FiJty7UzjuxZUdbg6DnzqhP
         04CfUmaBFh0RaKknXCxv6llsyXIr/t9mLQhCPkRyhjN9AIcjwPDuRGK0DYl3DxiE2uI7
         WfmAw3yEqlrGDI5cAKTPWs+Qa3lGq/eybbNuGAVAYttulQJnEEx6MdT3n32loDvihVuE
         STmA==
X-Gm-Message-State: AFqh2koSDgfz5prkOtivXzw4iz9GblrDyEdi048VKX2q89viGvWm+4fx
        NVRKyhROu5rrKH2pkbTyWVSY1Cs133tVknfa
X-Google-Smtp-Source: AMrXdXtxGOM+IE7OMAYhEmDiWqfKeOMQpDAVWOJWd/wcOgQQY/5Q9ZqrysmmRjNZV7CdShF+92RTyQ==
X-Received: by 2002:adf:dcd2:0:b0:2bb:ebc4:2f5c with SMTP id x18-20020adfdcd2000000b002bbebc42f5cmr31696184wrm.43.1674502882043;
        Mon, 23 Jan 2023 11:41:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n3-20020adff083000000b002714b3d2348sm172556wro.25.2023.01.23.11.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:41:21 -0800 (PST)
Message-ID: <62eb3874-b9e1-7c7c-3147-a9cd9b65ae0a@linaro.org>
Date:   Mon, 23 Jan 2023 20:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 5/5] drivers: mmc: sdhci-cadence: Add debug option for
 sdhci-cadence driver.
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-6-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123192735.21136-6-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/01/2023 20:27, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Use Kernel config CONFIG_MMC_DEBUG to support dumping PHY and host
> controller register configuration for debug.
> 

Commit title/subject does not end with full stop.

Best regards,
Krzysztof

