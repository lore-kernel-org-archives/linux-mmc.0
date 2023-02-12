Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A10C636D3
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Feb 2023 22:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBLWiN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Feb 2023 17:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBLWiM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Feb 2023 17:38:12 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1F583D2
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2023 14:38:11 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id v15so8831943oie.9
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2023 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3pF4e+yE1WYMQ/Nq6UrylxVMHOzbrRpD8GFxZ6NraY=;
        b=CKyKXVVWoHCGRqb4JHNeo/JHJbmvJDR6xIqrXhZU5kKzSewBAV7DAKhI1ISJeI4gGJ
         i/YhAsri0JcTFKvopelGLVvVd8GvftuZSjXdizrxlL5TnsliiK73V4pNfWs2lumSI+Hp
         SZ38Mi8WJjLbEBR5n7piGXBL9An20OKpR8oJZbmfDIJ0m5cAiM1tVtLF3FEglUpN06C2
         Lw4WWEd2/X5zwZyGJcd7vbnp/Z6eA2PprDkPws94TZBTUbV6eZ9c9WwmwE3GS0omrXWI
         oXkncjR0F3SSIhVO7LbN4Fu0ASFemDdm8QkX9UF6icQtO6T6QPDhHyozX2FJ/IMn7xWA
         2btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3pF4e+yE1WYMQ/Nq6UrylxVMHOzbrRpD8GFxZ6NraY=;
        b=1yVmC1/XMAyqi4eslC7lFvhwHaqkiGOKpOO4BCYR2R6K1CKKntZdJlk4kJsUJk6CRM
         K0W0SYaMAgmIHg4koFQqxpPrwKE4CeVMbp7AUq6ZWBJockoFcOlK+vpSqktjLRN+NZ7d
         Dhn5Clx0Hlltq4r90Hw/AeFp8yxFs92zuk0PCY9h0x+50YhyV1+1WSsEn6Mv16si2Srq
         OURmXlAkCqcCrvZXmBAagkF1aXdpCNslXeuoxN/Us/RlED4yFVUO5fWTI9f+kpLa2JIf
         fFE/pZA8Y9N4kplYdA587rcqcBUb2KLtF+X+52/THAjsgq/50VzBa7RhIehBwCV48Akk
         tO8g==
X-Gm-Message-State: AO0yUKUBNpkQShq1hRFl6Gg/hljY2TAEqTWcaDR44MG1oRHf9Y+VHPkb
        zv33pkan4rcho+kteCEhXV8=
X-Google-Smtp-Source: AK7set8K2xP2e319H6ENNR2E4+vRrcu/Xi5EcOFsEBG3yR/+06GOwJjxQWj1HpLFS5N/r5+8RfqLmw==
X-Received: by 2002:a05:6808:9bb:b0:37a:2bf0:5026 with SMTP id e27-20020a05680809bb00b0037a2bf05026mr7730019oig.20.1676241490657;
        Sun, 12 Feb 2023 14:38:10 -0800 (PST)
Received: from geday ([2804:7f2:8006:2be1:80e4:f9a7:d80e:f5ea])
        by smtp.gmail.com with ESMTPSA id q187-20020acaf2c4000000b003780e80fad6sm4476952oih.49.2023.02.12.14.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 14:38:10 -0800 (PST)
Date:   Sun, 12 Feb 2023 19:38:05 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] mmc: meson-gx: fix SDIO mode if cap_sdio_irq isn't set
Message-ID: <Y+lqTSqKm4a/qTDN@geday>
References: <9e296859-0363-ecc4-2d99-fd0239efceff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e296859-0363-ecc4-2d99-fd0239efceff@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Feb 12, 2023 at 10:54:25PM +0100, Heiner Kallweit wrote:
> Some SDIO WiFi modules stopped working after SDIO interrupt mode
> was added if cap_sdio_irq isn't set in device tree. This patch was
> confirmed to fix the issue.

Hi Heiner,

with this patch, with cap-sdio-irq set or unset in the DT, it doesn't
matter, I get the following warning on dmesg:

meson-gx-mmc d0070000.mmc: unaligned sg offset 3148, disabling descriptor DMA for transfer

The offset number varies between reboots.

Is that to be expected?
