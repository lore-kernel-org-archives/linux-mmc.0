Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F7BC3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EC2221F4
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="id94JQDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTIL4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTILz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 04:11:55 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DF0C061A0C
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 01:11:55 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x9so641392vkd.4
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3fg3pI/+YBezGyEek7kiJUVGujcLuB0x+em9JNj68Mo=;
        b=id94JQDTnYpKTI5vCF0pMRHK7ivIzr8x28yf6Zi0zbU4ySFB6pMh6QBWtlbwp37bJC
         7qkpZQ2GIVgfLLptSnkpunHi5fR1c16LRm19Og2DbGYHyVOKI4+UQfhQ62KXc8GUjNP8
         MJB3r2rN1r9xv1uuOePwznM1D9ckNU6Rc5OZviPIyQOvlm/EK6s2xan6FoMgmU/O/tQO
         4O2NHMQV/PSprHxdNmhSmVmOx4bEfMrR4RygQx9R6rx/dpIynuOhl2MYU3FFpogn6cal
         gYIkdDV0gFM6+5+KGaoyeZaJTlCOuclITp4udKlA9hrlLl3Wk0mlKajIk6lrGfb45e65
         Wiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3fg3pI/+YBezGyEek7kiJUVGujcLuB0x+em9JNj68Mo=;
        b=nt9ZXawhk8LSoqNmVG34amW0PKVmVeBAUqOL40RVhU+JI1D+8ZQ36VhP+YuRey+c9I
         CTUiXt6BCFZegzGfwlJtY7eotdrnEDttJfVuvyK29SsmCLCZ/9D+6qrUKwq4+EtQumjU
         kbmb72E5w7v4L/It1Xf+uTSbHvxFSpWkHDi3f7NjM+5paRA/Vfm3eCpCmSt3MEvVdgVu
         Fg0/itng5FbaRPzl3NSS7ZXkJMQ2HLkeWPZFL3zXkFCQUjTBUoy840d7zlD2n/Bu7JjX
         PqUaCMCQapNkDZAvUGiRA2qtxcfLIy3PUZDOhOGT5nuB6ViWNtfc9in2J8I/og1FHXCy
         cm1g==
X-Gm-Message-State: AGi0PuY0xriWh4pe5BqfL+UpcS1A+DakOyGXFQ3oI4MWH4EuKnzaeF1p
        mS91or1K6ffkS/kPKvxzU59y1isI5O8lpy4Ja1h78g==
X-Google-Smtp-Source: APiQypJGMdljxUJA5IUPLCUEbJvsFKyKB/h0Abd6qYs7RRH9WCDpz8ckVA5/TM2znUKJHu/5Sf58Luf+74teUAP+s0A=
X-Received: by 2002:a1f:8ccf:: with SMTP id o198mr10161916vkd.53.1587370314588;
 Mon, 20 Apr 2020 01:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200420080444.25242-1-marek.behun@nic.cz>
In-Reply-To: <20200420080444.25242-1-marek.behun@nic.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 10:11:18 +0200
Message-ID: <CAPDyKFqAsvgAjfL-c9ukFNWeGJmufQosR2Eg9SKjXMVpNitdkA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: fix annoying 1.8V regulator warning
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Zhoujie Wu <zjwu@marvell.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Apr 2020 at 10:04, Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:
>
> For some reason the Host Control2 register of the Xenon SDHCI controller
> sometimes reports the bit representing 1.8V signaling as 0 when read
> after it was written as 1. Subsequent read reports 1.
>
> This causes the sdhci_start_signal_voltage_switch function to report
>   1.8V regulator output did not become stable
>
> When CONFIG_PM is enabled, the host is suspended and resumend many
> times, and in each resume the switch to 1.8V is called, and so the
> kernel log reports this message annoyingly often.
>
> Do an empty read of the Host Control2 register in Xenon's
> .voltage_switch method to circumvent this.
>
> This patch fixes this particular problem on Turris MOX.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Fixes: 8d876bf472db ("mmc: sdhci-xenon: wait 5ms after set 1.8V...")
> Cc: Zhoujie Wu <zjwu@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Konstantin Porotchkin <kostap@marvell.com>
> Cc: Tomasz Maciej Nowak <tmn505@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xeno=
n.c
> index 1dea1ba66f7b..4703cd540c7f 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -235,6 +235,16 @@ static void xenon_voltage_switch(struct sdhci_host *=
host)
>  {
>         /* Wait for 5ms after set 1.8V signal enable bit */
>         usleep_range(5000, 5500);
> +
> +       /*
> +        * For some reason the controller's Host Control2 register report=
s
> +        * the bit representing 1.8V signaling as 0 when read after it wa=
s
> +        * written as 1. Subsequent read reports 1.
> +        *
> +        * Since this may cause some issues, do an empty read of the Host
> +        * Control2 register here to circumvent this.
> +        */
> +       sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  }
>
>  static const struct sdhci_ops sdhci_xenon_ops =3D {
> --
> 2.24.1
>
