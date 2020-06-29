Return-Path: <SRS0=XB32=AK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F13C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 22:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B6920760
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593469501;
	bh=VnP4m0EtyJxUC+vQZR97lDQy9T5H/x0feDk6sbrrSq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rneeBxIhjnght8F4TEXSzmSV+oDucmoBoJR4NyUP2pb98tZL5le/fmhs+Ny+CufMz
	 nGnXSctWWuxMz7eKrDFcSvTh32+z4ByMTAmbtRy5sHBDHI2Lv5wbsMtqeMc2Jh8EQ7
	 GkXX1OcmKhizmAe+SfA/TU6atsR2pU8QOh7owg9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgF2WZA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:25:00 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38782 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgF2WY6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jun 2020 18:24:58 -0400
Received: by mail-il1-f195.google.com with SMTP id s21so804052ilk.5;
        Mon, 29 Jun 2020 15:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h/TkSF612k78MXcnwxO/toAy1nyB4499O1P4vtisjPY=;
        b=F32c9pbIi9wiL+Pbwr1LbhbncCFSZPhv8AtEn4X3kc4swf/TfJR+dH9jXa2CBry7b+
         Mxl7htSfUb2Ueg6g0Fi7FG9mBzfg0oUtu7Z93K71KGCDOKRFqbVU7UF065ksmb5ssiZZ
         VsAak8byvan6Vx4VYiDvHNH7ao6LpOLBHEocEqXrzoJ68/hUVoZjexKFKhXftAummw9p
         2Pozj5USgRjuTgZFZvY0SNo7PKuEUGcR7Hlr6plFUC0afoIq+oazaEwsUgXf6Y+TvBaH
         6IV+kSZFXjobnU+sjhNRYE830w7RGmRiwz8445VXAtY+W4ooF3NnMtB+NVRdpkQq757f
         E0xg==
X-Gm-Message-State: AOAM531y3xneX5oE6p2VvlRWEfppWOoVjRkp0leJzDK2QQ8r1Cu0/vXw
        sE+O4pX+s5BYqEu7Q7mteQ==
X-Google-Smtp-Source: ABdhPJyTw/04qHUtxw+S7Dj15w7XOQKGIeSHqEFjBRF4VkzTFz9SCbiDlNR+455C0r8DcABEKZNzOQ==
X-Received: by 2002:a92:2a0c:: with SMTP id r12mr17552137ile.275.1593469496953;
        Mon, 29 Jun 2020 15:24:56 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id s12sm704524ilk.58.2020.06.29.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:24:56 -0700 (PDT)
Received: (nullmailer pid 3066572 invoked by uid 1000);
        Mon, 29 Jun 2020 22:24:53 -0000
Date:   Mon, 29 Jun 2020 16:24:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        kernel@pengutronix.de, robh+dt@kernel.org, Linux-imx@nxp.com,
        aisheng.dong@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        linux-mmc@vger.kernel.org, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 2/3] dt-bindings: clock: Correct mmc node name in
 i.MX35 binding
Message-ID: <20200629222453.GA3066490@bogus>
References: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
 <1592450578-30140-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592450578-30140-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Jun 2020 11:22:57 +0800, Anson Huang wrote:
> Nodename should be "mmc" instead of "esdhc" in i.MX35 clock binding
> to avoid below build error:
> 
> Documentation/devicetree/bindings/clock/imx35-clock.example.dt.yaml:
> esdhc@53fb4000: $nodename:0: 'esdhc@53fb4000' does not match '^mmc(@.*)?$'
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch, to fix build error when patch #1 is added.
> ---
>  Documentation/devicetree/bindings/clock/imx35-clock.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
