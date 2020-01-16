Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C2CC33CB6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02345207E0
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579183694;
	bh=ZxkxbPI6NB+qslqenM1VguIV+ka+agAz0tPoV5Dlv88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eEaczRTx8uBxjilf9/+3LBxyiN3oV14KcTwchI+QYb299C8L5e5TtVOBR4fsVrtkq
	 Pnu3iP21S50EvFHJ0OClEHAWoE7RJBcBn3CVe2Lq3qO8FzMSziiDaAtT9hgHzDhiNi
	 uyCwXdq7RA79KkFpWHMNvNuWtrByECPpj1qhsYho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPOIN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgAPOIN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jan 2020 09:08:13 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542042077B;
        Thu, 16 Jan 2020 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579183692;
        bh=ZxkxbPI6NB+qslqenM1VguIV+ka+agAz0tPoV5Dlv88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sbzl/C+9E3Romi6TePNREX+gQjoxYwdnxEMR5vQElQWkvqLhrESPM7k0bHWBgn+yU
         vyISsyebITJCQPzWBfQ5JvKfbuoe64kto7/6FeFhrlhLPKYtqMoaVu2nPuDGHJo/ZJ
         +RKjDnua8QaOG0KpT7pgHsA1qYXlXKt5d0POj8pY=
Received: by mail-qv1-f41.google.com with SMTP id p2so9081493qvo.10;
        Thu, 16 Jan 2020 06:08:12 -0800 (PST)
X-Gm-Message-State: APjAAAW10FJekrDLhMacg1cHGoNRmB59ZXurautAxIiyCU9lcd5UENZU
        x0FImTcTuvOO/vfnXPSDSFWt7ffi3E9CLTW6Dw==
X-Google-Smtp-Source: APXvYqx0fiWdQh99DDa9iyjEeQMVJwq4um15JGwrzKiS3meVyPIMlcnqQ5A6IgAke6Qr+dljfrbL0MMk6QxnsO93Q3k=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr2644594qvn.79.1579183691461;
 Thu, 16 Jan 2020 06:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20200114213809.27166-1-jbx6244@gmail.com> <20200114213809.27166-2-jbx6244@gmail.com>
 <CAL_JsqJ0QJ9uG9NY7vMGG00G4Jfk2mXS4OPdUzEaRVaCP++GzQ@mail.gmail.com> <203e9217-9aa8-b65e-4411-2d9b23c1362a@gmail.com>
In-Reply-To: <203e9217-9aa8-b65e-4411-2d9b23c1362a@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Jan 2020 08:07:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+cJd0Ht+4FNX9RjbZL2vHjF90+G-v05XuyxrT7Ng15sA@mail.gmail.com>
Message-ID: <CAL_Jsq+cJd0Ht+4FNX9RjbZL2vHjF90+G-v05XuyxrT7Ng15sA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/3] dt-bindings: mmc: convert synopsys dw-mshc
 bindings to yaml
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 16, 2020 at 6:00 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> See below.
>
> On 1/15/20 4:18 PM, Rob Herring wrote:
> > On Tue, Jan 14, 2020 at 3:38 PM Johan Jonker <jbx6244@gmail.com> wrote:
> >>
>
> > [...]
> >
> >> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> new file mode 100644
> >> index 000000000..6f85a21d0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> @@ -0,0 +1,88 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Synopsys Designware Mobile Storage Host Controller Binding
>
> [..]
>
> >> +examples:
> >> +  # The MSHC controller node can be split into two portions, SoC specific and
> >> +  # board specific portions as listed below.
> >
>
>
> > This split doesn't work because the examples are built and validated
> > now. It may happen to because all the props are optional, but the
> > board hunk goes unchecked. So please combine.
> >
>
> Hi,
>
> I have no knowledge about this particular hardware to give a realistic
> example. Could someone advise here? Or should I just use the first
> example for now?

Just combine the first part and one of the the 2 board hunks. I don't
think having 2 board examples with the only diff being the dma
properties adds much value.

Rob
