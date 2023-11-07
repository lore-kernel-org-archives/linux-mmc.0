Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB939C0018C
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Nov 2023 12:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjKGMPy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Nov 2023 07:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjKGMPI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Nov 2023 07:15:08 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE5448E
        for <linux-mmc@vger.kernel.org>; Tue,  7 Nov 2023 04:11:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so5820036276.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Nov 2023 04:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699359085; x=1699963885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBsaoWhr2znf8wvyVHsUac05BAGwf4F6oqcvXZtUp/8=;
        b=iXMkBoQoLgWKkzBZiOv+sDzqltnXDA88Ik0w9dbJytsRyMYtCb0LG2wDl94RFq/lVJ
         AmXh3VGPX17KdiZuCsbS5NAp6CH8XeRfEowFcbuIan1DkNJpQK3HI1eRlPwZRDT4AZC/
         orlK4K34LFGBC5Q6GgQzdbQBi2cfbAtTAbwVSjQKSWPJWPZXtB09YTahdZ/4CDJFI/jL
         Dy/OBTD+Nw007JpCtsK5+Z3Jb9QQNT4/rrUIyxo8TKqx6R/RB15IaH520MYQ9Z0GEDgh
         AfhU4j+Yca9KansunGFkshE9e5T6FtrTickKD+1lUoPlH05uV9ujA5bgU9ZsKxWbCF7N
         N/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699359085; x=1699963885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBsaoWhr2znf8wvyVHsUac05BAGwf4F6oqcvXZtUp/8=;
        b=LzBMRL0jlfgA9Nl6vWnxtUlQyv1SKDPAaVaB8Mf1CEsFhPtxV8C5YLwam8kKUM0zsV
         XgzvGlsPtUAwqKVIF8o2FDLOyQ6VWDrU25SMy5UC7XoCJJzMm2J8dvs/Bcn+LjQZkYHf
         +4+Y8Lf85x3I1IbT4Jh46p1Jfq5i+rdkd/ohZp4L8DhqL287GQEdam9ZQgVpvRCnRvtY
         7gFgED4/UUnL6exNOkR94jQHuPwxyhTWLagK7cehVOgJZW/4ZESURDjvU4zC+PrNIYfq
         QXa5XEnUz3ApPmxck7LZt32yg3MAbFFO6bAmZx86zSwR7J8+t2zBarlanQtP4aiGdChH
         u6hQ==
X-Gm-Message-State: AOJu0YxYQAwIWXqLLnICSE6lNCYQ8/G+T7woU43uDohNzGgpbiHyD53A
        4C2jvXOVzxb2Q5cDfJthhMPvSJg/i2VwlCAZ9wtUKg==
X-Google-Smtp-Source: AGHT+IHDMrKkSc1YppgWblP5EWz8Z1JpAjj1O5XSYjWz9AyzWl+KPwEz68afvy4+rSnZBmueG6VR2NfhaMpio9halj0=
X-Received: by 2002:a25:1955:0:b0:d85:abce:3f43 with SMTP id
 82-20020a251955000000b00d85abce3f43mr26728461ybz.38.1699359085155; Tue, 07
 Nov 2023 04:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20231107095741.8832-1-victorshihgli@gmail.com>
In-Reply-To: <20231107095741.8832-1-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Nov 2023 13:10:48 +0100
Message-ID: <CAPDyKFrr91qxxdYLiC4jeL+igYmJXpcfqvV1svWW-o7y4d9Kqw@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay
 timer timeout of AER
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        SeanHY.Chen.tu@genesyslogic.com.tw, kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Nov 2023 at 10:57, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =======
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages that will
> often appear in the system log when the system accesses the GL975x
> PCI config. Therefore, the replay timer timeout must be masked.
>
> Patch structure
> ===============
> patch#1: for GL9750
> patch#2: for GL9755
>
> Changes in v3 (November. 7, 2023)
> * Split patch in two patches. One patch for GL9750 and another for GL9755.
> * Add fixes tag to corresponding patches.
>
> Victor Shih (2):
>   mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
>   mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
>
>  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Applied for fixes and by adding stable tags, thanks!

Kind regards
Uffe
