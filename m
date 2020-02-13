Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D2C2BA83
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 10:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05509218AC
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 10:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWucAaQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgBMKyF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:54:05 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:35067 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMKyF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 05:54:05 -0500
Received: by mail-lf1-f49.google.com with SMTP id z18so3947518lfe.2
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 02:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wL0bjYN1U3bZfVJrL/SniZD6DwbHHKtxnem8CZOKtGk=;
        b=JWucAaQjf6n2R/1TSCCRsqYWeQMJiipwREUnRsiCRThVRKXwMe1JGIJ+U/llae+Uz4
         TiqyY9BuTdlGnGLxnYxU0heqw81RBa53P4tFSfgFHuknKoeZO63Sw5gei8UfEXGSZASr
         DlWRrr+r8j3FUo9+8T6QrY3bj+t7pOAbYESCtCLcALO5wEC1y70H9TTXP1amnBi0WKFd
         WNAkHaHFyW/qW4MrGiYnRhZjP75oaVkpEq8qKeE/bnev7bcp7MTuYOlQwylmm7okfQsW
         vXkrmWin91f2xMSnmAer0tZk+XmlpRLDwEnFdU6SNsTAuqqNDmGvUU6NPutPt9jT8kpY
         qbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wL0bjYN1U3bZfVJrL/SniZD6DwbHHKtxnem8CZOKtGk=;
        b=YAb9YbiK4OSVMG2eOFPcS4PAoRN4u6FxhHevA3pP02BzUbNrdjVaFbs1cwYy6LBWfs
         EwZrjL4QIqdyq8cgFdcikijwT3n0nGoTJB6R5BmyHeVmONHE3hrlSQWvJML/QWHxdYB7
         9NtCVdfTNZ9n11sO1LvEGy8Bf+q2cP3aOdz5AabPNVimsgIpS+HeyJni59UQZGmeQxqd
         nlNRKgvE6P5vPhreFSrm27zy59ZbEemZZJIDZq4mz3RGrz4SVJKW36x/EBRvrDeX2FVZ
         IDqyTM+v8NOSWMkQtuZY8ZZBKp0f95PSYmdwZb73mvrXBeJBouFj2jQaZ+DcUT2piA2p
         izZA==
X-Gm-Message-State: APjAAAXth9Kw3tHykmgaX+0YkpNT/bGI78esJvX4/PvI87m2u5q/QjkX
        SXURDuXfanNUGqbKLn94HjLz+Z+4uyd0fZkKDms=
X-Google-Smtp-Source: APXvYqwSNBB2+D0KXNfmV+ovUFJYXdXU8EKGIo6CB+lmGfk2XFUOpz7aJvYvfcOiyUdCJpEzS1hmNELAhYa9adeWSTY=
X-Received: by 2002:a19:3f51:: with SMTP id m78mr8962803lfa.70.1581591243210;
 Thu, 13 Feb 2020 02:54:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org> <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 13 Feb 2020 07:53:53 -0300
Message-ID: <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
Subject: Re: sdhci timeout on imx8mq
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough,

On Wed, Feb 12, 2020 at 11:33 PM BOUGH CHEN <haibo.chen@nxp.com> wrote:

> The board I use is SCH-29615 REV B4.  This board use Sandisk eMMC chip. Maybe your board use Micron eMMC.

Mine is REV B3 with the Micron eMMC.

> I attach the bootloader I use. Please try this bootloader on your side.

I hope we don't have a bootloader dependency here.

Thanks
