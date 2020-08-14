Return-Path: <SRS0=tY5E=BY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9669DC433E4
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 22:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FE12074D
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 22:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpmo8Z7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHNWPC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNWPB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Aug 2020 18:15:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666BC061385
        for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2020 15:14:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so11485963ejb.0
        for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2020 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=I1P9jSvj8KsgaDMEv65UiEF9Z+hJk+AMaAtGqjiPwHk=;
        b=cpmo8Z7L00clOxaEygKbxnGwKvrxuJvVUvlujmlizi9+0bQBNLRlbFUu7fecqHsIpn
         f3+bVXFK+H8VK1ymJV4wxOKKu2kF55hLWv6RlN5rOcQlaSJAxZ+CkC+R3bhG1aMmrxLi
         GMQjLUGc5oDee3BjY6uYJ5Ofz8E7kHHM2uZ0pOUDrHH0D/OAK0prvli+7kFsEgfT4zMa
         wixUAL0T/iH1UygkhlTk8ewnTmUybC72NlAQlOY+EnoC+xuARx/Mz8JlHUZPH+/vj+ia
         vPF+M1G3bJ7J4nCtD7kLwJ3wIyCUTAi8P+VGqEl3xCVxObsC9OR6Zb7CicL/92e79rT9
         /J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=I1P9jSvj8KsgaDMEv65UiEF9Z+hJk+AMaAtGqjiPwHk=;
        b=qzrlMVrAZIRhl2vqrjn6dHgNUj+lTyOs6MyIqOjE35UUI3I4DhUZf3yfl89jhXlUJq
         5BS+LBSdiAy9FxlwdfNk03aKPYE2B0BN0XDOZE0SzZKXNCOnb0OmbwUR2lzjevN137lV
         X2rZvwkKaSb770HO00C9URIfg4Wss+Ab2tWqRyYzDuU+uw7O09K08PveANpLW6mmvpJF
         vwv729fMqrDCLPIj/cu3tx/ugDZ+amxDgCBTZfufyi6DKMldAJA3JHTFKYli8zihek0T
         8IsKHRvQckmUo3JJUMfRyK17uVZbzhbEeZbfyJGCFpNLPpLIWhEzMsnURmiEFwHLE8sD
         lfUw==
X-Gm-Message-State: AOAM532vTSGvG6/YlU+8Vujm+FyU6YPbYbiuiuQHSwn9MD7ZK0pSQ+E2
        FubttfyOqAO2qt00jPUJlj513s97zlTSqWtGD4M=
X-Received: by 2002:a17:906:3445:: with SMTP id d5mt3766886ejb.348.1597443298656;
 Fri, 14 Aug 2020 15:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200814152201.254010-1-konradybcio@gmail.com>
In-Reply-To: <20200814152201.254010-1-konradybcio@gmail.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Sat, 15 Aug 2020 00:14:22 +0200
Message-ID: <CAMS8qEVHGE9Q9WO5-FfM0yWccjKA=Ayo3204ncYbg5KdVHBCFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] [-next] mmc: host: msm: Add optional full power cycle property.
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As I mentioned in the next email, please ignore this patch. The whole
idea is incorrect and does not solve the problem.

Konrad
