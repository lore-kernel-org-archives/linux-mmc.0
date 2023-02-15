Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE16C636D4
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 13:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjBONQA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 08:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBONP7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 08:15:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5982411B
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 05:15:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id bw10so2757216pfb.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676466958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHsKyyxem5T1jmrbt9Xb2WeJb42KIIHV4Nsq+EMoz7Q=;
        b=HlspxRXIkOOH+2uKHi8+FzU2tdPaEvVnljyO8TPu+4+RRGAxxoey+EHrrkLFTFJp1x
         FkCE5VYBQJz7ZdjyBNqy1ZzkNhzA9dT4Gz8RHFoXGFAs9H95+qJffo6Qw1NrfFoRhiAE
         MiWSB4V3G77yqy0BBHPUPvwKDsWmKNzA8vTZ4MXVYwwC4AR1z1XT9IBEqYvWETubirYw
         flj22CWt2mKqoLfoHtYQ7/eaxHm8W74cu/gZsSZYJR1umUcZ5NT2m9mr8L34Cdu6AyfA
         Dz8j/RpLCfSfLut8+94Z0bO4CPvyhJGcPW4dXYLG0xCSHZY50bVb9Iq8Dc+3HZVb4VA3
         VxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676466958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHsKyyxem5T1jmrbt9Xb2WeJb42KIIHV4Nsq+EMoz7Q=;
        b=fSvZQ31rRUOE1H67/YjcwLhYigqytHFmot4l9oPnr0zVWDS72XmVgB0GS6OIMmqoSr
         qd5hAljYzb2g4vhtE8rSEpRLDQ43CPmzNlAcewHfNAcH5+Jfc9OP6dslq3b3q0aRflNd
         Hv3Ou7rLaJYVEvfT7BaPq0OFBaJpUrWUTH86iMMRUzxOzuTUI0g6cWIbk63zGMPES7Al
         cHISoNptfxVOei0JSuI2eT1QJRrAL2vC8yZBa/YDsKOO16NTuHzyDkak//vtcMjswN0A
         TgLIZ+eQ6mEEsqGUUTKS1OXrdNf4fyud1R+oOLJmWsAgRiuS7/9IlFmweY+KxGlU+o/l
         wSjQ==
X-Gm-Message-State: AO0yUKVI8LXccvg58P6QGeNwo6m3LbrEMH+cJPLEtw1BmpNIXMplMnc9
        bVqQjDr7C2CJ1sXcrGJnkC6OFG3VOrd+kl9DrhaeZjws7iFYfg==
X-Google-Smtp-Source: AK7set+x/Zu0eSOU3pI/JAWcjwQtY2FR0D4bgm2gbOabcYxyLqGlIy3o2HuTzzzkIDLu2rFb2gsv8MzAvq6tc/jBNDU=
X-Received: by 2002:aa7:95a9:0:b0:5a8:ba5b:575 with SMTP id
 a9-20020aa795a9000000b005a8ba5b0575mr318689pfk.40.1676466958003; Wed, 15 Feb
 2023 05:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20230214195702.ungo5roxliq7pjas@pali>
In-Reply-To: <20230214195702.ungo5roxliq7pjas@pali>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Feb 2023 14:15:21 +0100
Message-ID: <CAPDyKFptvcm=Co1JVKAtB6dqzbxvoRzAbn=b76iwgZxgdMSjmg@mail.gmail.com>
Subject: Re: Announce: sdioutils (lssdio & sdioids)
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Feb 2023 at 20:57, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello! I would like to inform about new (or rather old) sdioutils
> project, which is on github: https://github.com/sdioutils/
>
> It aimed to be collection of SDIO programs for Linux systems.
>
> Currently it contains two things which can be useful for both users and
> developers:
>
> * lssdio - https://github.com/sdioutils/lssdio - tool which prints all
>   connected and registered SDIO devices in similar format than lspci or
>   lsusb, including tree and verbose formats (Linux v5.10+ required for
>   printing all information)
>
> * sdioids - https://github.com/sdioutils/sdioids - database file
>   sdio.ids of known SDIO devices, in format inspired by pci.ids and
>   which is already used by lssdio
>
> This new sdioids contains updated and imported database file from the
> old udev project (which seems to not be updated anymore).
>
> If you look into the repository, both parts are more than year old and
> I did not announced it before because more people promised to test or
> improve database... but nothing happened, only promises. So I decided to
> announce it now at least in this state. I think that it can be useful
> even in the current state.
>
> So if you want to improve it or add new SDIO cards into database, feel
> free to open a pull request on project page. I think that having some
> central point of sdio.ids database can be useful also for other
> projects.

Thanks for sharing the news, it looks like a useful tool to me!

One thing I wonder though, is why you didn't consider extending
"mmc-utils" with these new cool things instead? In particular, we have
"lsmmc" in there for MMC and SD cards - and since these have a lot in
common with the SDIO cards, I believe it would make sense to extend it
(in some way or the other).

Note that, if you are willing to help with maintenance of mmc-utils
around this, what would certainly be appreciated too. :-)

Kind regards
Uffe
