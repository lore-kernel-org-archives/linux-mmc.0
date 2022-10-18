Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D769C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJRRUT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJRRUL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 13:20:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DBD73C28
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 10:20:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so14625487pjb.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHPcUIWFSjmCV4qi48lU7COtP6Gp8n3SproDlkYY/tc=;
        b=oAhCsLVT8kS6toOsQxW5bakcPdgds0iYsuOGq2BM2mxndVKtWtX/CkfrGOETFTGdHV
         Z/zBE6Oe1V5/Vj537iM4aee7/XQQMXOwUQ/CTyn8MUpavryXgByEBXKwwXy1pdPOn0UQ
         hvUkp/RuLmW6d7occ5JM169v2gUAAYDLrdzvpB3C3L8jtAOtIFHYJ6fI1jbSGKJaAdww
         5RD3g34NKRf6V1xkH7m26gnTf4irTDSrIctE6WUp0rmCE4jiUylVNDMeDZ3PLSMkdqG1
         xpPIXdGW7UiVz+vpX3qXvKjesvvEnaNFZGXGTGJwfW8y6J1qHNH0AvwFuiWD4nv5yQS7
         DV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHPcUIWFSjmCV4qi48lU7COtP6Gp8n3SproDlkYY/tc=;
        b=1ldQJISYzf8NGGekdhpUkw2TqMpvjlczAo5QbKnjcxpEDjMsjdNORGzYqi/qxlJ1PP
         1gtDfYR2Wf1aaSGmAfwmTIN0K771zCyhJbEH3DPL26G6EYq91ClAQ6RM76y+vT+xwS2s
         Hyi4yfGNQ+cuA+h+JaPSf8f0earchjnMgwzyCXmyCbgJU2dB5S9nR3k99++KIlrDb0be
         6vJ5kuJUdlh4tuHMPFtFFn8FE3VmccdUOpXm9QSHeqSnq3w51M/CKvNRcRmQvLrzbEhw
         rTyQbG6b8p+QSIpDF1ePUX3m3J3o9nd6Jcv9CxcE9E60yaWdoX16Azpb9KX93tgIQOgQ
         Ql+A==
X-Gm-Message-State: ACrzQf0ABd9r8wcCoMMSzoM8PSjnBOzskPz6+3cyWPpNBtPkhCGBf5hI
        vSRcpSZXMn+ToYxOoL9sofRhHTitL/Kr3jAjCnTwXJYIWUc=
X-Google-Smtp-Source: AMsMyM6zlbGjVJpsFxZ3KPIHjJil7uwjq4LgpftUNZ0vscPjLIj+OFWiOVnihGc5c+rDHyg7O/oYAcy9ucLZqH6GcHc=
X-Received: by 2002:a17:902:7b91:b0:185:4548:3a96 with SMTP id
 w17-20020a1709027b9100b0018545483a96mr4049358pll.130.1666113610084; Tue, 18
 Oct 2022 10:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
 <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <CAOMZO5Dmk_OWTZGEafTZO451Zo6W8UMUJAZguW85y0b2BmCpWA@mail.gmail.com> <CAOMZO5CYvbd3uTKxq6suyn5H0yNU1R7tsgbawNdwjEbKgdt6bg@mail.gmail.com>
In-Reply-To: <CAOMZO5CYvbd3uTKxq6suyn5H0yNU1R7tsgbawNdwjEbKgdt6bg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Oct 2022 14:20:01 -0300
Message-ID: <CAOMZO5C-5M8y=V1L6Qdqymhb-1oOpBszFwuWCxedUJ1oO7=ADw@mail.gmail.com>
Subject: Re: imx7d: Timeout waiting for hardware interrupt.
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough,

On Tue, Oct 18, 2022 at 9:29 AM Fabio Estevam <festevam@gmail.com> wrote:

> Would you have any other suggestions as to why this timeout happens?

Do you know if the following i.MX8M erratum applies to the imx7d as well?

e11232: USDHC: uSDHC setting requirement for IPG_CLK and AHB_BUS clocks
https://www.nxp.com/docs/en/errata/IMX8MDQLQ_1N14W.pdf

Thanks
