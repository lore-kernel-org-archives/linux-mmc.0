Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD8AC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 17:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbiFGRKN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbiFGRKM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 13:10:12 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316A90CEC
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 10:10:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p13so32196475ybm.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P/gAWYTYcE9jrOxJP6iVGHeZQzn3G/Awl1C3CYU0ggw=;
        b=VXII/SB83wb/H7vaEllfp+qolXwA53Jspz/m3zQC+mAcIKQGnMclloaomhvdrQ8owB
         vHO+Uly527y09F5DuLehOkJ0mwZ30gZgyk4g+U2wxwHl0Y4mgV7S9RqtLgSETdNyx6OK
         8wsp+Y0MkbwvJsfsXmdr6DrYRUD/m0pnxwbu4ivj1VDOAf7zsCj+Ktal0VQ7rxQPrYRu
         evoywSOsVTSGWCD45fXiF7PxxA2UqM85zCTd9mNp4mxBdN1I/K+pmrs8z9//RXW9UQ6Z
         9+tq5ACnviSi88l2ctFEs/bsJAV9hXkEtq0QnXCfz7aME/5cbdjMuehnAIQURMtCzTDA
         gtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P/gAWYTYcE9jrOxJP6iVGHeZQzn3G/Awl1C3CYU0ggw=;
        b=I6dqHNOLf1IQYsRVkvzN4hti0vxEVw07Lfnp+p2T+XNuJ/cbAz12FnIJFo30+h0SN6
         mG80JmpimnhB12pu8eYwCxvwpLzf1LIpOcVRQBbW4MHvRiqktl3un9m6fq183HuMB+VC
         D9K7lM7QxezK5YE87p0CuCB/MJqlib+yR4cOcQhPPTzg6Cdk5RZeYaAF/u8SsRyCXucJ
         QyPWyjUncXBrqVZs3AtTAHPkycLA/b4wSZUqM8JNmsqAzKftTwQ5JV+Ggw+YJu2VWaIN
         qI8xQ+my4GJReBtr52V9w6KuPmlRm8l/0wtWZAs5S6t/GmHY2137WgplwQawQFFYXVwD
         Knyg==
X-Gm-Message-State: AOAM5314DOlzNdKvMycrgSMYSJcrYN8s+UbD3AZVnVvyrau7Aj5jP1gy
        7DXsSMMZ8Fn5Q9X2uFb8XMTrIJFqiiNbq4zI4It4dwS5+CxIGg==
X-Google-Smtp-Source: ABdhPJxpq/x/7JkNme4htfnqYHKUS7ec2XhW2i49YnLrj8HJECrnh2rhb90mOqlSloG8c/1l1755jAZFUZHfIMAjA2o=
X-Received: by 2002:a25:22d7:0:b0:663:c13a:893a with SMTP id
 i206-20020a2522d7000000b00663c13a893amr7638158ybi.98.1654621809618; Tue, 07
 Jun 2022 10:10:09 -0700 (PDT)
MIME-Version: 1.0
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Wed, 8 Jun 2022 01:09:54 +0800
Message-ID: <CAMSo37WW9veYH6=tHqUR2pa_7YX1UuzHqLBHit60P2QyzQmCEw@mail.gmail.com>
Subject: Please help cherry pick four mmc related changes into the 4.14 stable kernel
To:     stable@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Benjamin Copeland <benjamin.copeland@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Alistair Delva <adelva@google.com>,
        Steve Muckle <smuckle@google.com>,
        Todd Kjos <tkjos@google.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, All

With the 4.14.281 version[1], there were three mmc related changes merged,
but that causes one boot failure with the X15 Android builds, a problem
similar to one reported before here[2].
After being confirmed with Ulf Hansson, and verified with the X15 Android build,
it needs to have the following four commits cherry-picked to the 4.14
branch as well.

    4f32b45c9a2c mmc: core: Allow host controllers to require R1B for CMD6
    5fc615c1e3eb mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
    d091259b8d7a mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
    23161bed631a mmc: sdhci-omap: Fix busy detection by enabling
MMC_CAP_NEED_RSP_BUSY

The above four commits are from the 4.19 branch, as they are a little
easier to be cherry-picked
into the 4.14 branch, compared to the commits from the mainline branch.
(I have confirmed that the four commits are all in 4.19, 5.4, 5.10 and
mainline branches already).

Saying that, there will be still one merge conflict reported when
cherry picking the commit of
4f32b45c9a2c, it's easy to resolve though.
To avoid the merge conflict, it could be done like this as well:
1. revert the 327b6689898b commit from 4.14 first, so that the commits in step#2
    could be cherry-picked without any problem
        327b6689898b mmc: core: Default to generic_cmd6_time as
timeout in __mmc_switch()
2. git cherry-pick the following commits from 4.19 into the 4.14 branch
        4f32b45c9a2c mmc: core: Allow host controllers to require R1B for CMD6
        5fc615c1e3eb mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for
erase/trim/discard
        d091259b8d7a mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC
sleep command
        23161bed631a mmc: sdhci-omap: Fix busy detection by enabling
MMC_CAP_NEED_RSP_BUSY
        26c6f614cf02 mmc: mmc: core: Default to generic_cmd6_time as
timeout in __mmc_switch()
    The last commit of 26c6f614cf02 is for the revert in step#1.

I am not sure which way is more convenient for the maintenance work
here, so just list both of them here
for your information.
And please let me know if there is anything else I could help on this
cherry pick work here.

[1]: https://lore.kernel.org/lkml/16534624745741@kroah.com/T/
[2]: https://lore.kernel.org/lkml/CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com/
-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
