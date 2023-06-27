Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C533CEB64D9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Jun 2023 12:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjF0MLl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Jun 2023 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjF0MLj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jun 2023 08:11:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF8F1999;
        Tue, 27 Jun 2023 05:11:30 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b44eddb52dso68402271fa.3;
        Tue, 27 Jun 2023 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687867888; x=1690459888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m+9Bx4TaQDJ3xq08eT0W/lsQ80FM8Zc2O+5nzMh3Mbo=;
        b=JbbZCJ2BqPgX1sSqAcw6+/Q+fKxtIkuZAhlJvOq+Gxb5aa+FlAupckRTe72hlmabLM
         jrIhE54Dc1w5BgRzDEwax4tOJ1jqkP+cqBAbxtV0FWX4cS3QolOeYatPbJxryiBki5pF
         /8TKZxZIfuApMnaXINYQcH4oBq9iZfVJr/N8+CoMBehUwlYGZgoFn0c/6heGXonCzmge
         VwOFQM+E1KcH9xNgP6J/siqrJ41p7/Ta+c9KHmO/i4tJVLvFKw61KKRgdrzyvheaSg6r
         E8i54/QpP5RvzPECuIyfUJUVgNhSVAsD6xG3/GBXDynHlBx9NrV6g2luE/A715uGgsgQ
         ZuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687867888; x=1690459888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+9Bx4TaQDJ3xq08eT0W/lsQ80FM8Zc2O+5nzMh3Mbo=;
        b=SE3qSXVlRK68WoReUY8ElVZx/OzSfR05xef/mKAVBzvCMNC52lIB0YEIQibIN/MLcV
         ei2JgH0VverDsjxg8N1cs38OT5Cyr37BZKQJoiTZO+ibHXBpo6K35qsU2p4zipbU298B
         07bB2qZET2cFrdCqpTLN2GqXZJzmIF0YRfH/mRHOm/WG2r2e2iKecfJ1yV6AZl0gznAT
         ysVC4lj+ZrxcppTYI02u9Numc5WFfNaIil898jRTff45Bj14lYhr0+TAMVXw81SHMJ8I
         Uv5i5BYxxDhY+/Fk3j+r86RtDEIgJXPE/TXO2u+uy95/TfX8Uj2AfVnl8a1GP6cqJoL/
         kxoA==
X-Gm-Message-State: AC+VfDxIZFWBy3wBHMJiww5tD8ovRXHh/PD6Dp0lMLj6HyDQu1UMpSDg
        KB2mFR6Ec0lEoDK2HW5kzvCZaRlFj+oEKO8g+ZPLu/eyiH8=
X-Google-Smtp-Source: ACHHUZ6QmNH58jaElLeCDDDtY0mwdr4Fv3G38Z/Cogx36Jvwe3Kf7I51aE1f0hJAKpZmUMIWq9PFzZYpN+yzUUZxlRs=
X-Received: by 2002:a2e:a0ce:0:b0:2b5:974f:37e with SMTP id
 f14-20020a2ea0ce000000b002b5974f037emr7150286ljm.19.1687867888080; Tue, 27
 Jun 2023 05:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230627120549.2400325-1-saproj@gmail.com>
In-Reply-To: <20230627120549.2400325-1-saproj@gmail.com>
From:   Sergei Antonov <saproj@gmail.com>
Date:   Tue, 27 Jun 2023 15:11:17 +0300
Message-ID: <CABikg9yoY7rQ4gmBi7YACx0e+1xU3bLWVPho7xsre4HkXctf6g@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: read scr register without changing byte order
To:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc:     Jonas Jensen <jonas.jensen@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ulf.hansson@linaro.org
