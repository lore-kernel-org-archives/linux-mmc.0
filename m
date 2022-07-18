Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFAC43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 21:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiGRVEs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRVEr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 17:04:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C826597
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 14:04:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e15so17036550edj.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=lgYxQ6VDW00cU97BocyveA5Xw2LA05J8ZBbZjuEjBbs=;
        b=ysRZ20nSv1AY8vsUIYaB1KCb7Q30mE3E6K7n7d95wId/RdkNd+qdCO7zLW56+1lhQx
         FMAM3HJmvHH/obQ6GgmbKtJC5GXi2HgDaNV6K344sLUkdnRiGUnYNHG8msV+0ACStmvf
         p8Il0CHFw8LAeE8GpBIH6v9wj8AdFvCoamt3z45quczVKBP0WAzHocSWT5duzbo33hoP
         Xj+nasYNkfyWb2VkRfgNNq5R0v9Y4cUzdKTVhK4HCIhxA1y0eNXu6RRzhwNHhzbEpsVB
         +QevqZ4FAxbXohECqUjQJWRr/f+73oGlYrgrVKbUFRRNGFl6aBOzivd7IZmAufOh1GMx
         o6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=lgYxQ6VDW00cU97BocyveA5Xw2LA05J8ZBbZjuEjBbs=;
        b=Uqnmcey9vTrQQ0kZHdnHtcgX7uMlmyfS/d5yVH3rEsscAWk4jOrQsbYmxwQMDDpzkl
         EQAIEsz1dvOaO+G2wLzjDfxSqOeUzyXv71bAjbwsMW0CXEICiomkRggMgCMRtFj9fAZ4
         OuNquSMZ3hZsMzijF5s0jhVqu32NdqwhUSSVkz7h+JE8s7Y5GibAEem3vtC5I/uEFAp7
         lcKI369RYqNprw9y8nAbuzHrlZU6Pg2KArdKPfncvGevXU0D8m9DMKKmo9CQbJhkQXv8
         UsKTnxKkQHPtjp0dNayePyQZyEe+LvEzPSe9KRlXbOz9vObvImxizUj/UyeszZbTRSHd
         iaqw==
X-Gm-Message-State: AJIora/SZjpfVnNU6QJhygSzitP+KcQT4nhvoiC+NmPRD7jDVit+UvD3
        bTeguo1KwCcq0ABLo9iqHAIldQ==
X-Google-Smtp-Source: AGRyM1uMAGPcbJs10DHZgwCacO7JwWJg0/uGhTxHr3qyP+y4XQdgLemNimWtsQu4TGNXOnTXmYe6Bg==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr40569237eda.134.1658178284768;
        Mon, 18 Jul 2022 14:04:44 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id sa42-20020a1709076d2a00b007081282cbd8sm5885440ejc.76.2022.07.18.14.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 14:04:44 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v6] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
Date:   Mon, 18 Jul 2022 23:04:43 +0200
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
 <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
 <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
 <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
 <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
 <17a4c6f6-d79c-a7b2-860f-e5944b778f9f@arm.com>
 <9405b97a-6758-ad4e-ccff-eed072096539@arm.com>
 <BF7CC548-88C9-4889-8A41-8E99C31EF81C@kohlschutter.com>
 <daf3b61c-d886-98eb-0443-de233d742041@arm.com>
 <CDF716FC-F6CF-44A9-84D9-B48C46E6AC2C@kohlschutter.com>
 <3912A668-9F73-40FD-8993-5060F632238A@kohlschutter.com>
 <7E830C9F-BB5D-4EFC-B3F4-1C580E9326A3@kohlschutter.com>
 <E5A1A1E7-449F-4161-87B9-7A6CA0CAA42C@kohlschutter.com>
 <C153DF3B-C5F7-42E5-8A86-D9193578C96A@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
In-Reply-To: <C153DF3B-C5F7-42E5-8A86-D9193578C96A@kohlschutter.com>
Message-Id: <38DFE34C-E4A5-4DBB-AC57-5D92D703B877@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 18.07.2022 um 14:05 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
>> Am 18.07.2022 um 14:04 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>>=20
>> mmc/SD-card initialization may fail on NanoPi R4S with
>> "mmc1: problem reading SD Status register" /
>> "mmc1: error -110 whilst initialising SD card"
>> either on cold boot or after a reboot.
> ...
> Walking back on my claim in the commit message that no further patches =
are needed for the u-boot integration to work.
> Other than that, the actual patch is unchanged.

I can no longer verify that the v6 patch actually increases use_count to =
2.

At this point, I don't have a purely device tree-based fix that works =
reliably, therefore necessitating the code changes in regulator/core.c.
If anyone of you knows a way to reliably increase vcc3v0_sd's use_count =
("cat /sys/kernel/debug/regulator/vcc3v0_sd/use_count") to at least 2, =
then we can remove the regulator-always-on statement.

