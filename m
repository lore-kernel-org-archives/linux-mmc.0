Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E717C10F27
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 09:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2326421655
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 09:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUisK/9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgCKJDq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:03:46 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34844 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCKJDq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 05:03:46 -0400
Received: by mail-vk1-f196.google.com with SMTP id a1so315311vko.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8FJLsb20BkCkHy7ypB9BQW1lsR3buzKph+H1mgd2hE=;
        b=aUisK/9fujwcFoaGs0nNbIqDzGkMBxHanR5iIQsH9UWjYd4Xkn3wIr+MKf4laooZR6
         H3oWBtU6YvzEHlqRq/1Nb6ENwrb1Ip0jOTREhvhzVJXhIK7rHGS8n0ckR/Bxe2qd90Mk
         SYobP8hqd0qCdRDap/9WZJSsAGE7WcieYvUN/5+ktXInFzyKOrL7ojc0SZ5Sku816Qe+
         y6eehEdyAv8xEKqA5obJLUmvk6EcdsZ6D6lZKfXOcOrI9pU38B5Na0bmSSa3ZVQPeICK
         8NrBAPB1lBd1M/LdX9X0nKmUFcn9Hr4RlsJxO0vs0EEnBLK9rgiHCnJ03PSOLWh0qVv9
         nJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8FJLsb20BkCkHy7ypB9BQW1lsR3buzKph+H1mgd2hE=;
        b=pHeJs71TjcPbFKYYG+u4zrrNv9G6HSUGLxXPMXb0XYaFl5SKtWqSvJ1ltxIiiXmg93
         TLQuK9gGxh0UWMCcP3b/mvTXo+5xkz0PlJAIa1s7yU2H4v9JAj79mNM+yhEk5RwuWyec
         PHtV6KOf69ru+WJj3loBIhORpycPhhPnIUHH2TXgVfjZw/5JsW7/wDtK9L0CLxw7719v
         thjhQEXzZibd4MkMnPQmvKxwaPPuisTnkMZ19Voj1CXY5BjT3w4X4Y3UgQZTNFJHuqDN
         PVh9FCOdOjEG8Qcofkq4Oc4coUooHBkdM5Llf6Q7IiaennqU22Ismcgu2n34/MLPj/FS
         U51A==
X-Gm-Message-State: ANhLgQ056avxVizxhKoTO/NueJqvNSmm4CVR2vaAtzjLCOIFbHxefEUg
        VyDg177efLLr2Gjik1VrXHS9fDK3Gl4fuFV/ZE6VIt2a
X-Google-Smtp-Source: ADFU+vtVswukaJho5oeOUQzCN0XjMtdQuixehNimCXbxAsZUki4moko4Q90SVHeBVtJ5frEw+QUxwoWAqoVapcOHesM=
X-Received: by 2002:ac5:c4fc:: with SMTP id b28mr1299629vkl.101.1583917425109;
 Wed, 11 Mar 2020 02:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200310153340.5593-1-ulf.hansson@linaro.org>
In-Reply-To: <20200310153340.5593-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 10:03:09 +0100
Message-ID: <CAPDyKFq_Lxhs1T4V2G-au9YZHe_CVz-XWapXeECADS4K3yWyuA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: Fix busy detection timeouts for some SDHCI variant
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Mar 2020 at 16:33, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The mmc core may decide (for CMD6 and erase/trim/discard operations) to convert
> from using an R1B response into using an R1 response, in cases when the needed
> busy timeout exceeds the host's maximum supported HW max_busy_timeout. The core
> does this to prevent the host from doing HW busy detection and instead rely on
> polling, as to cope with the needed busy timeout.
>
> However, it has turned out that some SDHCI variants (tegra, omap), really
> requires R1B for all commands that have this response associated with them. This
> became especially obvious when commit 24ed3bd01d6a ("mmc: core: Specify timeouts
> for BKOPS and CACHE_FLUSH for eMMC") (and a few other commits on top) got
> introduced in v5.6-rc1, as several people reported errors (thanks!). More
> precisely, the mentioned commit triggered the existing problems described above
> in the SDHCI variant drivers, when an eMMC cache flush command (CMD6) was
> issued.
>
> This series fixes these problems, but the changes are also targeted for stable
> releases as the problems have existed since a long time back.
>
> Please help out in testing this!

FYI, this is now applied on my fixes branch.

[...]

Kind regards
Uffe
