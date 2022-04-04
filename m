Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4DC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Apr 2022 12:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbiDDMQX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbiDDMQW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2022 08:16:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A2AE5F
        for <linux-mmc@vger.kernel.org>; Mon,  4 Apr 2022 05:14:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p10so16821666lfa.12
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2022 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSQP6H+w0A6mK1X6YckSkQa+uY4WT+vpP1uv3lYD8xg=;
        b=SpMe7y/b+L2vVcjET6iWPHNNjIQyT80Rc1DetSrH3U4WGxccF9IMMz05dm7oX5MxkQ
         DDV8jpIueBPmP+bfRB5/BjNfW8nt0bXPO/Ut+6FeB3IZwotrKO9T7EQxAJ9QBihGwvbS
         UURVOthZsrve9v9DmaxOBG6by6HT6hb6X0VMxe2LJyMiHIO6s3RBCV00te1mWCGNXKca
         iO0SPVAjdwk0Q71wWVW/PH+RV6agX4Q32p4omO3vcw3ohfjYFBTtxPizM6uPK2nPb7cc
         P5+ONv19uJhDSjCNHDCXSMkIFYL2ItIM6u0t58NREZMcGiQnn4RNIuOkjMWYUS4B0wxZ
         +ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSQP6H+w0A6mK1X6YckSkQa+uY4WT+vpP1uv3lYD8xg=;
        b=VRgFLd274JTe4C6q2Fzr5OYhMSCaadsWRNLd4qm4WK1sRJi3bcBlpQnDre7oNxaxpH
         gY07H/UKwalGE4NpkuuqcZgJNTyBwTUHCjMuIX6X+7k1vCKYPcK23Qq/AJt76TFUb/x0
         orl5C8re5sTwtuOXJqw2PEwuzQwuxbNl5M1k4NAa7dnCU5I40ILvELASegusR/q1PPUb
         9asA7Ofvpb6xqu/K7GDPmcV3dewIpcVw5P0bId804Os4OXLJjZPRT0XvWIx5SMt4rWj4
         JnVd3OlE4FMV+XuH4Zn9Km1Cv0e5RsZ49tTdbHk1MSoJejEBNuHlQeQLGlmCJuhFNptk
         hh3w==
X-Gm-Message-State: AOAM5310NgCPTS0SO/0fKi/XrLzxLQ0WVFmmI9hLUwER+dbBlkwpt7Lz
        6nabTbctyCkw8wvY7bkQWvmth/lwMXGqGWCf1Iu/TA==
X-Google-Smtp-Source: ABdhPJx6/M59e/LceORrAaJwjmYx51VoKqH6hL5/10GGrTKh07Z9uQ8DL6vpFQ0BRbZrKnzsbYMZly7RZDbHaf8xMNM=
X-Received: by 2002:a05:6512:c0c:b0:44a:6865:860a with SMTP id
 z12-20020a0565120c0c00b0044a6865860amr21944403lfu.71.1649074464272; Mon, 04
 Apr 2022 05:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com> <20220321115059.21803-9-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220321115059.21803-9-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 14:13:48 +0200
Message-ID: <CAPDyKFqwgxhRPBabxfUTC+8UVegWrTg3F0nRn3PoToiO2DWtvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] mmc: core: improve API to make clear hw_reset
 from bus_ops is for cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Mar 2022 at 12:51, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> To make it unambiguous that bus_ops->hw_reset() is for cards and not for
> controllers, we a) add 'card' to the function name and b) make the
> function argument mmc_card instead of mmc_host. All users are converted,
> too.

Again b) is sufficient in my opinion. All bus_ops are for cards, while
host_ops are for hosts.

Also, there may be some corner cases where b) can't be done, like the
->remove() bus_ops for example. In that case, we either have to make
more re-structuring of the code of simply live with that there may be
some special cases.

[...]

Kind regards
Uffe
