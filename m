Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A72C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 22:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D709465018
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 22:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhCDWsz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231736AbhCDWsy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Mar 2021 17:48:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D15E6501C;
        Thu,  4 Mar 2021 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614898134;
        bh=GrerDAoTAovyyWNYvvC+zs2BPxmDLs2XKLKb4mqZLDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fl2hoAYr4FyvTGzDjQer3murYeBpxPsKxixW9QAs3SiMjkbVs1F6FyKCasSDdBKDp
         zms401sqEExyK82KF2BP0C5B1QnWwF8GmIE9Rht6pQkWowXTn1Xp/S3LL6Oba5r0nQ
         fULHUIHs0N1ZDiSWS/9Zyac6uOLCmzYZvxglLV5bpA286cjBBokgvz4c8AJFxjB8+8
         ORBXxQ3v1FqOKOS7oGjPWBs5NziUFCirD/ZmwTFS5WzWJCCMITmC37DONZR5KN48R3
         e6ZhYA4UocjazvhXkVhggBXfwbffEMI3He5G+faTJl3AjHo03NKinnRCBxeqmKF4nP
         Hg7CymCsevq4g==
Received: by mail-ej1-f46.google.com with SMTP id w1so52703037ejf.11;
        Thu, 04 Mar 2021 14:48:53 -0800 (PST)
X-Gm-Message-State: AOAM532shjaGSfTJW3GVXYwzHU4fQjeVzgcy307Wk6xGu3GgzPg52dMO
        B/S9rGWEGcN73G4U1+Tcoq7lauTljwHNT175ng==
X-Google-Smtp-Source: ABdhPJwsSfTpWjPL+cZrEMvosQ1IPs0l8gQZ/vIA9NHMjVhs68GFDG/L9SRf5PtvlaFJJ8yVPqheQ48Al0kdk2WAF/c=
X-Received: by 2002:a17:906:380b:: with SMTP id v11mr6717737ejc.183.1614898132557;
 Thu, 04 Mar 2021 14:48:52 -0800 (PST)
MIME-Version: 1.0
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com> <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com>
In-Reply-To: <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 4 Mar 2021 16:48:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKAOUKnVLvu-VNeDVg0ShXPy56wxhCQv38+rO2k961v+g@mail.gmail.com>
Message-ID: <CAL_JsqKAOUKnVLvu-VNeDVg0ShXPy56wxhCQv38+rO2k961v+g@mail.gmail.com>
Subject: Re: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
To:     peng.fan@oss.nxp.com
Cc:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Feb 24, 2021 at 9:23 PM <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add clock bindings for fsl-imx-esdhc yaml
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Looks like this landed in linux-next and introduces warnings:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
mmc@5b010000: clock-names:1: 'ahb' was expected
 From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
mmc@5b010000: clock-names:2: 'per' was expected
 From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
