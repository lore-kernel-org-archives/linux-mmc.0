Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D16BECAAA1
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Oct 2022 17:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJ1RBH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Oct 2022 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJ1RAC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2022 13:00:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5233B183B4
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 09:59:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so14303488eje.10
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdBYaH8Vkz/OFpcUliUNXSUHa5224PBWc/8NFz84BpI=;
        b=UYFDgpwh4gQXASm0ajaOXIPSZAnokFKGRz3i8tZtZbSWWnZolu06tgNOMllG7MRETN
         Tm4lTLSVv7CzCYX+BzbeoW4IwwOM8E6/x5qA7mq65SVAL2oHVUeyUul5Xr+eOeqg2f7B
         QsTh2p1iAaL01/r/mfd3lrKoSa0L0Ta20tWgNpIp/Dg5kwRTi+pt+q12GtnLc98XSJsC
         RX8Qrw7tDZ1DirvKxw/yjeXtx7rfncdWpDcvZBYHhMVQGNh8UjOEpiZaUW7i4W37dzhf
         wCtxsU6WA1SP9LV0GcnBarIow754Qsz7AS2uYmTUFRlxLcgKdSvGX13UhPutYURKcwxl
         wHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdBYaH8Vkz/OFpcUliUNXSUHa5224PBWc/8NFz84BpI=;
        b=6xcYXK6Cd0XN8VOxzD3D6yUb9WGp0diQhxH+iUqIfGzHNj9OAGeRgUP9OTIzE2g2PL
         Pa+9lxsyYxHWS82FRc5h0GIGXIDNSrmF0uze097m2X9JDPHXH4ksKk1GxgyoNRAIaJQa
         4wjo1QB93xluh0wzznFnU+wng9DWtuTTA3DpHUXYSZU8ifOJ7iLUSoHIeznOpLBGNRWe
         xP5uR8PDuyCSCwI/UUAlpMMr2go2NgTcBcOiTGW2VBw/LyloJppMavwDj9QNw+NJ37yj
         XzWPvDcg3VkIDCoFHI+Q2ESBWiwsAG3pY6PxibWYAtOns/vi1Kkp7aZ9fBSusVTu++sO
         Gdug==
X-Gm-Message-State: ACrzQf3kedoJTwNakC5ugpTTC2hkpDwQ+J3apHB2rYqYM5lfW8a/VEen
        H6fiaWmAKzxoBzrpKjbw4qD/ZAvsuDrtSPFf
X-Google-Smtp-Source: AMsMyM4b6Makf2XUO4oZ8JASTD+TYGiZ5WlRT4RQswqjcl1lt6qbCvTXNliMY/qz6n9V80ctCVXTPA==
X-Received: by 2002:a17:907:31c7:b0:740:e3e5:c025 with SMTP id xf7-20020a17090731c700b00740e3e5c025mr249555ejb.341.1666976379411;
        Fri, 28 Oct 2022 09:59:39 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id t17-20020a170906065100b0072f112a6ad2sm2387793ejb.97.2022.10.28.09.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:59:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2] regulator: core: Resolve supply name earlier to
 prevent double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <166083617547.142744.6260121456450934801.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 18:59:36 +0200
Cc:     wens@kernel.org, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D80E1210-85D4-4D05-8FB7-843CED790A60@kohlschutter.com>
References: <3B4AE882-0C28-41E3-9466-F8E301567627@kohlschutter.com>
 <YtlqPbbBceBmekcV@sirena.org.uk>
 <E0925148-3F0E-4DD6-9872-96778BFE39DE@kohlschutter.com>
 <166083617547.142744.6260121456450934801.b4-ty@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> On 18. Aug 2022, at 17:22, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, 22 Jul 2022 19:42:27 +0200, Christian Kohlsch=C3=BCtter wrote:
>> Previously, an unresolved regulator supply reference upon calling
>> regulator_register on an always-on or boot-on regulator caused
>> set_machine_constraints to be called twice.
>>=20
>> This in turn may initialize the regulator twice, leading to voltage
>> glitches that are timing-dependent. A simple, unrelated configuration
>> change may be enough to hide this problem, only to be surfaced by
>> chance.
>>=20
>> [...]
>=20
> Applied to
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git =
for-next
>=20
> Thanks!
>=20
> [1/1] regulator: core: Resolve supply name earlier to prevent =
double-init
>    commit: 8a866d527ac0441c0eb14a991fa11358b476b11d
>=20
> All being well this means that it will be integrated into the =
linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>=20
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems =
and
> send followup patches addressing any issues that are reported if =
needed.
>=20
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>=20
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>=20
> Thanks,
> Mark

I've finally managed to publish a blog post about this journey into =
regulator land; I hope you find it worthwhile.
https://kohlschuetter.github.io/blog/posts/2022/10/28/linux-nanopi-r4s/

Thanks to everybody involved for getting this far!
Special thanks go to Robin Murphy for pulling out the oscillator, and =
Mark Brown for helping that these changes get into 6.1.

Best,
Christian

