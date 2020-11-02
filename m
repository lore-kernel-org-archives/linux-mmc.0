Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E61CC00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 21:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A9208A9
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 21:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/xEZruW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKBVTR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBVTR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 16:19:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB199C0617A6
        for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2020 13:19:16 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h22so10862539wmb.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2020 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=rLTI241sVjhiO7RP9cDBlUJjxn2rihkXPkzD1Jd+Bts=;
        b=Q/xEZruWERaO15T1+BgSgQa2GUi3DBA9ROebiitGqeLG3MVv+J/tHmzU6XiX5lItIu
         Q5downlkHfMUn1EsLKoQSPof1DdrktFQl41u9IhfX3eYrjeK5WeKyWguGGNBoVMAlcfR
         aUqU3GBC0/p2o2UY74kO+YlCRuo1hI6Pavmy9ftlnjQ/uiYJprGhsog+SUlJArSX3Fex
         T9Q7ZN+7zrYaolwMcneXywKzSEeMti68XVmwZtn14gc+PTqX7nI2pJr/WP/jTxWd1CcR
         Yv2+tJ5Nh727qAYSaV/BGjz3F9EfzzPwf/O34tK0IcTQ3zK2aa9uXkrHJourBVpfeqWf
         yh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=rLTI241sVjhiO7RP9cDBlUJjxn2rihkXPkzD1Jd+Bts=;
        b=KXpg6w0POeM+enPMdf5zrJrezo9HehlRq2NBua0A3gmvRNRSNo/t3kOU1Fq3DejqCG
         FVNrGIpgHUQVsJjZEszuVqeX3MZGpwKCUqPzPGKrDed5mYa7ZBHPFxLN21kjLE1s3C0O
         vRPhDHUPo6dmlx9b8fOaq31fHHMl15UEDMuXDiMg79hC5s5yScYMuIUxplzUk/PphwoQ
         yEvjsiJalrV9+9oXdaX2zshCpd+PEH2jVWElerLaFQ+KXPvQqdrbH0wKHjcnYHI8TJiw
         a9vGN5h/+NLa09QWPG20sTM6256iRTdfc+FGalY0U67eQDCj8yJ9poGs5sR8ijsHCpNF
         PB2w==
X-Gm-Message-State: AOAM532nggEz8reXIP3pq+OTfRN+/M0FO4G6rD1SDgIJd7Su8z4b42oB
        En8dTVCD6xeycHTu+KCgKSQ=
X-Google-Smtp-Source: ABdhPJzTFxUyZFboCv0wmPw28uElDioJanriCAD082uyFacPBW5Vgf51BXGTkSDYLyuKYLyx4EZPXw==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr100925wmf.122.1604351955474;
        Mon, 02 Nov 2020 13:19:15 -0800 (PST)
Received: from localhost ([170.253.46.69])
        by smtp.gmail.com with ESMTPSA id b7sm22873824wrp.16.2020.11.02.13.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:19:14 -0800 (PST)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <treding@nvidia.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [regression, bisected] no MMC on rk3399-gru-kevin with 5.10-rc1
Date:   Mon, 02 Nov 2020 22:19:12 +0100
MIME-Version: 1.0
Message-ID: <f7ed6286-05c0-465a-add4-d3bb458432ed@gmail.com>
In-Reply-To: <CAD=FV=U1arH7-VRL_Xevvu_=1A9XKjqf4rZ4JqOM0ZUtWP716w@mail.gmail.com>
References: <59a5676c-cbf7-4a8e-ace1-f079e09d21a8@gmail.com>
 <CAPDyKFocOzHfaZyGPJbUDMiTrV1DoEUjdu7TMN5B1wPjBiBS2Q@mail.gmail.com>
 <CAD=FV=U1arH7-VRL_Xevvu_=1A9XKjqf4rZ4JqOM0ZUtWP716w@mail.gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe, Doug,

On Monday, November 2, 2020 4:38:38 PM CET, Doug Anderson wrote:
> Hi,
>
> On Mon, Nov 2, 2020 at 7:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>=20
>> On Fri, 30 Oct 2020 at 23:04, Vicente Bergas <vicencb@gmail.com> wrote:
>>>=20
>>> Hi,
>>> commit 21b2cec61c04bd175f0860d9411a472d5a0e7ba1
>>> mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4
>>> broke booting rk3399-gru-kevin.
>>>=20
>>> The kernel waits forever for the root device to appear on MMC.
>>=20
>> Waiting forever sounds weird to me.

The behaviour is expected because of the "rootwait" kernel parameter.

>>> Removing the line containing PROBE_PREFER_ASYNCHRONOUS in
>>> drivers/mmc/host/dw_mmc-rockchip.c fixes the issue.
>>=20
>> I am guessing when we enable async probe, we reveal some other
>> existing error. Or, perhaps the rootfs mount point become wrong?
>>=20
>> Would it be possible to share a boot log (before/after) with some
>> driver probe debugging enabled?
>
> Are you sure you haven't just got your MMC block IDs shuffled now?
> Perhaps a careful application of the newly-supported MMC aliases would
> help fix things?  When we landed, Ulf pointed to:
>
> [1]
> https://patchwork.kernel.org/patch/11747669/
> https://patchwork.kernel.org/patch/11747671/
>
> The async probe can cause shuffling of block IDs which were previously
> quite stable though never guaranteed (everyone always yelled loudly
> "use UUIDs").

I've got UUIDs everywhere (fstab and on other machines without root on MMC)
except in the "root" kernel parameter in rk3399-gru-kevin and, as you say,
the device path changed causing the issue.

So, false alarm, this is not a bug.
Still, those MMC aliases providing reliable device naming are really
welcome.

Regards,
  Vicente.

> I will also note that I just put v5.10-rc1 on a rk3399-gru-kevin and
> confirmed that it booted up OK.
>
> -Doug

