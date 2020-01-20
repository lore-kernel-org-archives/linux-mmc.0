Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC4BC2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE372087E
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dO4kN0c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATLTK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:19:10 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:35111 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATLTK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 06:19:10 -0500
Received: by mail-vs1-f47.google.com with SMTP id x123so18723596vsc.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxSL5xhOZst+pCmxYqXG3YKuQuTkwZHSeWZWlmDk2HQ=;
        b=dO4kN0c5Z35cMUG2zQrTTvrk7RGA1amnG3n9P90IImjqOjjDZjhvuNsBSQhiMMXNLE
         CDMzF/9s8uqA4Df+Ru+q/8o6Ouxz8CivtgQKiNcmW5hnOdZ8mnY280zn88iNKXHA4HHx
         v5zrMudqkmHMQsgJ+ZK6LDx/ugBBzSbxVlKmqeIoYtmGlsZNG3E1/Jp9qS/Vh+/O5REk
         e1cfWSdt0nlct528AyTTlNPiUtRbL7oq0VMka5yYnWJqaw9p9UgOFniXL16lo6h50H4c
         y7Ehogowgx0mQP8OD9KRCYSTcly0Uhmhx6kZVObbXxBKYt+GzA3udIsIzRADe0patW2A
         Dy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxSL5xhOZst+pCmxYqXG3YKuQuTkwZHSeWZWlmDk2HQ=;
        b=gGOJTZ+Fi6R65tnpQHuoLvdnWgiapO5uLSuhNKX56HxrILirOaKwn0DvI9dMrFII90
         rTkXlNz2L5F772L4PyEnoLCfLOQj7Qvs6TqePTymYgDcdgBtgT68g6I3+J9qdCXesr8/
         f/aVRi0ZwX/SBRIc24FgB5rc9WNALuB4UIsrKTJPcUc4TRWWF8wOXD8KYYObhEJpaUOV
         t+CG7pInXbiVoYFcBOg5SaBkqnFvPWaGnTITUaSgb47WC4zxlEojejL2E/L00QWnnyvG
         OBCsn+o3S25ylTGqZAeS0vU+DmzqxXG58MZPnu7tUA2eDQQ+ZxYBHFBUFMJ5oo/NXjoK
         HnAQ==
X-Gm-Message-State: APjAAAW/MKLfzWvw1bBxuICqDzC/Km/C49pdcCfbh0Rdqf1XIe9LMJj9
        572PNNpkCWVzUSyDXbeA6x8x8/M8MjL/r/etKNPquMazT88=
X-Google-Smtp-Source: APXvYqwEK7V8CGTKtpdB2cbeBf8HgalOPvhYLB27hK6pTw6dPNJlNxuuxk0NzlvlQGtXVEkoS9slrLYLBvgzGRuZTI8=
X-Received: by 2002:a67:6282:: with SMTP id w124mr11959722vsb.191.1579519149014;
 Mon, 20 Jan 2020 03:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20200108093903.57620-1-hdegoede@redhat.com> <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com> <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com> <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com> <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de>
 <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com> <fda179eb-df5f-ba87-aaf0-524fffca745b@xenosoft.de>
In-Reply-To: <fda179eb-df5f-ba87-aaf0-524fffca745b@xenosoft.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:18:32 +0100
Message-ID: <CAPDyKFoTuvrq8PYoXVaZoJN+zBUGVkQkYAhwber7rez32y3Sxg@mail.gmail.com>
Subject: Re: [FSL P5020 P5040 PPC] Onboard SD card doesn't work anymore after
 the 'mmc-v5.4-2' updates
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        "contact@a-eon.com" <contact@a-eon.com>,
        Julian Margetson <runaway@candw.ms>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jan 2020 at 10:17, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>
> Am 16.01.20 um 16:46 schrieb Ulf Hansson:
> > On Thu, 16 Jan 2020 at 12:18, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> >> Hi All,
> >>
> >> We still need the attached patch for our onboard SD card interface
> >> [1,2]. Could you please add this patch to the tree?
> > No, because according to previous discussion that isn't the correct
> > solution and more importantly it will break other archs (if I recall
> > correctly).
> >
> > Looks like someone from the ppc community needs to pick up the ball.
> I am not sure if the ppc community have to fix this issue because your
> updates (mmc-v5.4-2) are responsible for this issue. If nobody wants to
> fix this issue then we will lost the onboard SD card support in the
> future. PLEASE check the 'mmc-v5.4-2' updates again.

Applying your suggested fix breaks other archs/boards. It's really not
a good situation, but I will not take a step back when it's quite easy
to take a step forward instead.

Someone just need to care and send a patch, it doesn't look that hard
to me, but maybe I am wrong.

Apologies if this isn't the answer you wanted, but that's all I can do
for now, sorry.

Kind regards
Uffe
